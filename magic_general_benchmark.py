from sys import argv
from subprocess import run

if len(argv) >= 2:
    entree = argv[1]
else:
    entree = "exemples_graphes/graphe_petersen.txt"
if len(argv) >= 3:
    q = int(argv[2])
else:
    q = 3
ml = "magic_coloring_tail_general.ml"
cnf = "clauses.cnf"

with open(entree, "r") as f:
    s = f.readline()
    n, p = map(int, s.split())
    adjacence = []
    for _ in range(p):
        s = f.readline()
        i, j = map(int, s.split())
        adjacence.append([i, j])

run(["ocaml", ml, entree, str(q)])
run(["glucose_static", "-model", cnf])
