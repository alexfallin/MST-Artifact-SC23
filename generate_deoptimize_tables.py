#import numpy as np
#import matplotlib.pyplot as plt
import statistics

print('Reading deoptimization output files and creating a tables')
outputs = [ 'ecl_mst_out.csv',
            'ecl_mst_NAG_out.csv',
            'ecl_mst_NAG_NW_NF_out.csv',
            'ecl_mst_NAG_NW_NF_NIPC_out.csv',
            'ecl_mst_NAG_NW_NF_NIPC_NOD_out.csv',
            'ecl_mst_NAG_NW_NF_NIPC_NOD_NT_out.csv',
            'ecl_mst_NAG_NW_NF_NIPC_NOD_NT_NDD_out.csv',
            'ecl_mst_NAG_NW_NF_NIPC_NOD_NT_NDD_NEB_out.csv'
            ]
input_sizes = { '2d-2e20.sym':4190208,
                'amazon0601':4886816,
                'as-skitter':22190596,
                'citationCiteseer':2313294,
                'cit-Patents':33037894,
                'coPapersDBLP':30491458,
                'delaunay_n24':100663202,
                'europe_osm':108109320,
                'in-2004':27182946,
                'internet':387240,
                'kron_g500-logn21':182081864,
                'r4-2e23.sym':67108846,
                'rmat16.sym':967866,
                'rmat22.sym':65660814,
                'soc-LiveJournal1':85702474 ,
                'USA-road-d.NY':730100,
                'USA-road-d.USA':57708624
                }
inputs = list(input_sizes.keys())
runtime_table = []
throughput_table = []

for output_file in outputs:
  with open(output_file, 'r') as r:
      curr_input = 0
      
      file_runtimes = []
      file_throughputs = []
      
      line = r.readline()
      # Iterate the read file line by line
      while line:
          # If the line starts with an input
          if line.startswith('input:'):
              edges = input_sizes[inputs[curr_input]]
              curr_input = curr_input + 1
              line = r.readline()
              values = []
              # Read the next 9 lines
              for i in range(9):
                  values.append(float(line))
                  line = r.readline()
              file_runtimes.append(statistics.median(values))
              file_throughputs.append((edges / statistics.median(values)) / 1000000)
          else:
              line = r.readline()
      runtime_table.append(file_runtimes)
      throughput_table.append(file_throughputs)

with open("deopt_runtimes.csv", 'w') as w:
  w.write(',')
  for output_file in outputs:
    w.write(output_file.replace('_out.csv', ', '))
  for row in range(len(inputs)):
    w.write("\n")
    w.write(inputs[row])
    for algo_runtimes in runtime_table:
      w.write(",")
      w.write(str(algo_runtimes[row]))
      
with open("deopt_throughputs.csv", 'w') as w:
  w.write(',')
  for output_file in outputs:
    w.write(output_file.replace('_out.csv', ', '))
  for row in range(len(inputs)):
    w.write("\n")
    w.write(inputs[row])
    for algo_throughputs in throughput_table:
      w.write(",")
      w.write(str(algo_throughputs[row]))
      
print("DONE\nGenerated runtime (deopt_runtimes.csv) and throughput (deopt_throughputs.csv) tables")