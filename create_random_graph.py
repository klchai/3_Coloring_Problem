import sys
import random

nb_sommets = int(sys.argv[1])
nb_arcs = int(sys.argv[2])
nb_colors = int(sys.argv[3])

output_file = open("exemples_graphes/automated_graph.txt","w")
output_file.write(sys.argv[1] + " " + sys.argv[2] + " " + sys.argv[3] + "\n")

list_arcs = []

sommet1 = random.randint(1,nb_sommets)
sommet2 = sommet1
while(sommet2==sommet1):
	sommet2 = random.randint(1,nb_sommets)

list_arcs.append([sommet1,sommet2])
output_file.write(str(sommet1) + " " + str(sommet2) + "\n")

for i in range(nb_arcs-1):
	isAlreadyInList = True
	while(isAlreadyInList):
		sommet1 = random.randint(1,nb_sommets)
		sommet2 = sommet1
		while(sommet2==sommet1):
			sommet2 = random.randint(1,nb_sommets)
		if([sommet1,sommet2] in list_arcs or [sommet2,sommet1] in list_arcs):
			isAlreadyInList = True
		else:
			isAlreadyInList = False
	list_arcs.append([sommet1,sommet2])
	output_file.write(str(sommet1) + " " + str(sommet2) + "\n")

output_file.close()