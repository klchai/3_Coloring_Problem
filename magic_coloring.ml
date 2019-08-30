#load "str.cma";;
open Printf;;

let entree = Sys.argv.(1);;
let sortie = "clauses.cnf";;

(* Formules logiques *)

type formule =
  |Var of int
  |Non of formule
  |Et of formule * formule
  |Ou of formule * formule;;

let imp f g = Ou (Non f, g);;

let equiv f g = Et (imp f g, imp g f);;

(* Simplification en FNC *)

let rec depl_non = function
  |Var n -> Var n
  |Et (f, g) -> Et (depl_non f, depl_non g)
  |Ou (f, g) -> Ou (depl_non f, depl_non g)
  |Non (x) -> match x with
    |Var n -> Non (Var n)
    |Non f -> depl_non f
    |Et (f, g) -> Ou (depl_non (Non f), depl_non (Non g))
    |Ou (f, g) -> Et (depl_non (Non f), depl_non (Non g));;

let rec concat x = function
  |[] -> []
  |h::t -> (h @ x) :: (concat x t);;

let rec produit_concat l = function
  |[] -> []
  |h::t -> (concat h l) @ (produit_concat l t);;

let rec fnc = function
  |Var n -> [[n]]
  |Et (f, g) -> (fnc f) @ (fnc g)
  |Ou (f, g) -> produit_concat (fnc f) (fnc g)
  |Non f -> match f with
    |Var n -> [[-n]]
    |_ -> fnc (depl_non (Non f));;

(* Entrée des paramètres *)

let ic = open_in entree;;

let str_to_couple s =
  let l = List.map int_of_string (Str.split (Str.regexp " ") s) in
  List.nth l 0, List.nth l 1;;

let param = input_line ic;;
let n,p = str_to_couple param;;

let rec add_edges l = function
  |0 -> l
  |k -> let s = input_line ic in
    let i,j = str_to_couple s in
    add_edges ((i,j)::l) (k-1);;

let edges = add_edges [] p;;

close_in ic;;

(* Unicité des couleurs *)

let c i k = 3 * (i - 1) + k;;

let couleur_1 i = Et (Et (Var (c i 1), Non (Var (c i 2))), Non (Var (c i 3)));;
let couleur_2 i = Et (Et (Non (Var (c i 1)), Var (c i 2)), Non (Var (c i 3)));;
let couleur_3 i = Et (Et (Non (Var (c i 1)), Non (Var (c i 2))), Var (c i 3));;

let couleur_unique i = Ou (Ou (couleur_1 i, couleur_2 i), couleur_3 i);;

let rec tous_couleur_unique = function
  |1 -> couleur_unique 1
  |k -> Et (tous_couleur_unique (k-1), couleur_unique k);;

(* Couleurs des voisins différentes *)

let meme_couleur i j = Et (Et (equiv (Var (c i 1)) (Var (c j 1)), equiv (Var (c i 2)) (Var (c j 2))), equiv (Var (c i 3)) (Var (c j 3)));;

let rec couleurs_differentes = function
  |[(i,j)] -> Non (meme_couleur i j)
  |(i,j)::t -> Et (couleurs_differentes t, Non (meme_couleur i j))
  |_ -> failwith "wtf";;

let conditions = Et (tous_couleur_unique n, couleurs_differentes edges);;

let clauses = fnc conditions;;

let longueur = List.length clauses;;

(* Sortie CNF *)

let oc = open_out sortie;;

let rec ligne = function
  |[] -> "0"
  |h::t -> (string_of_int h) ^ " " ^ (ligne t);;

let ecrire_ligne s = fprintf oc "%s\n" s;;

let rec ecrire_cnf = function
  |[] -> ecrire_ligne ("p cnf " ^ (string_of_int (3*n)) ^ " " ^ (string_of_int longueur))
  |h::t -> ecrire_cnf t; ecrire_ligne (ligne h);;

let () = ecrire_cnf clauses;;

close_out oc;;
