import subprocess
import sys
from time import time

exec_time_list = []
benchmark_file = open("benchmark_file.txt","w")
benchmark_file.write("Sommets,Arcs,Temps d'execution\n")

for i in range(4,int(sys.argv[1])+1):
	for j in range(i,int(i*(i-1)/2)+1):
		for k in range(2):
			subprocess.run(["python3","create_random_graph.py",str(i),str(j)])
			start = time()
			subprocess.run(["python3","magic_benchmark.py","exemples_graphes/automated_graph.txt"])
			end = time()
			exec_time = end - start
			exec_time_list.append(exec_time)
		exec_time_moy = 0
		for h in range(2):
			exec_time_moy += exec_time_list[h]
		exec_time_moy = exec_time_moy / 2
		benchmark_file.write(str(i)+ "," + str(j) + "," + str(exec_time_moy) + "\n")
		exec_time_list = []

benchmark_file.close()
