#import numpy as np
#import matplotlib.pyplot as plt
import statistics

print('Reading comparison output files and creating a table and figure')
outputs = { 'ecl_mst_out.csv',
            'UMinho_gpu_out.csv',
            'UMinho_omp_out.csv',
            'cugraph_mst_out.csv',
            'gunrock_mst_out.csv',
            'jucele_mst_out.csv',
            'pbbs_par_out.csv',
            'pbbs_ser_out.csv',
            'lonestar_mst_out.csv'
            }
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

# All inputs
with open('ecl_mst_out.csv', 'r') as r:
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

# MST only
with open('UMinho_gpu_out.csv', 'r') as r:
    curr_input = 0
    
    file_runtimes = []
    file_throughputs = []
    
    line = r.readline()
    # Iterate the read file line by line
    while line:
        # If the line starts with an input
        if line.startswith('inputs/'):
            this_input = inputs[curr_input]
            while line.replace('.egr.bu', '').replace('inputs/', '').strip() != this_input.strip():
                file_runtimes.append('NC')
                file_throughputs.append('NC')
                curr_input = curr_input + 1
                this_input = inputs[curr_input]
            edges = input_sizes[inputs[curr_input]]
            curr_input = curr_input + 1
            line = r.readline()
            values = []
            # Read the next 9 lines
            for i in range(9):
                values.append(float(line.replace('eclruntime  ', '').replace('s', '')))
                line = r.readline()
            file_runtimes.append(statistics.median(values))
            file_throughputs.append((edges / statistics.median(values)) / 1000000)
        else:
            line = r.readline()
    runtime_table.append(file_runtimes)
    throughput_table.append(file_throughputs)
    
# MST only
with open('UMinho_omp_out.csv', 'r') as r:
    curr_input = 0
    
    file_runtimes = []
    file_throughputs = []
    
    line = r.readline()
    # Iterate the read file line by line
    while line:
        # If the line starts with an input
        if line.startswith('inputs/'):
            this_input = inputs[curr_input]
            while line.replace('.egr.bu', '').replace('inputs/', '').strip() != this_input.strip():
                file_runtimes.append('NC')
                file_throughputs.append('NC')
                curr_input = curr_input + 1
                this_input = inputs[curr_input]
            edges = input_sizes[inputs[curr_input]]
            curr_input = curr_input + 1
            line = r.readline()
            values = []
            # Read the next 9 lines
            for i in range(9):
                values.append(float(line.replace('eclruntime  ', '').replace('s', '')))
                line = r.readline()
            file_runtimes.append(statistics.median(values))
            file_throughputs.append((edges / statistics.median(values)) / 1000000)
        else:
            line = r.readline()
    runtime_table.append(file_runtimes)
    throughput_table.append(file_throughputs)
    
# All inputs
with open('cugraph_mst_out.csv', 'r') as r:
    curr_input = 0
    
    file_runtimes = []
    file_throughputs = []
    
    line = r.readline()
    # Iterate the read file line by line
    while line:
        # If the line starts with an input
        if line.startswith('inputs/'):
            edges = input_sizes[inputs[curr_input]]
            curr_input = curr_input + 1
            line = r.readline()
            # Read the next line
            file_runtimes.append(float(line.split(',')[0]))
            file_throughputs.append(edges / float(line.split(',')[0]) / 1000000)
        else:
            line = r.readline()
    runtime_table.append(file_runtimes)
    throughput_table.append(file_throughputs)
    
# MST only
with open('gunrock_mst_out.csv', 'r') as r:
    curr_input = 0
    
    file_runtimes = []
    file_throughputs = []
    
    line = r.readline()
    # Iterate the read file line by line
    while line:
        # If the line starts with an input
        if line.startswith('inputs/'):
            this_input = inputs[curr_input]
            while line.replace('.egr.mtx', '').replace('inputs/', '').strip() != this_input.strip():
                file_runtimes.append('NC')
                file_throughputs.append('NC')
                curr_input = curr_input + 1
                this_input = inputs[curr_input]
            edges = input_sizes[inputs[curr_input]]
            curr_input = curr_input + 1
            line = r.readline()
            values = []
            # Read the next 9 lines
            for i in range(9):
                values.append(float(line.replace('eclruntime  ', '').replace('s', '')))
                line = r.readline()
            file_runtimes.append(statistics.median(values))
            file_throughputs.append((edges / statistics.median(values)) / 1000000)
        else:
            line = r.readline()
    runtime_table.append(file_runtimes)
    throughput_table.append(file_throughputs)
    
# MST only
with open('gunrock_mst_out.csv', 'r') as r:
    curr_input = 0
    
    file_runtimes = []
    file_throughputs = []
    
    line = r.readline()
    # Iterate the read file line by line
    while line:
        # If the line starts with an input
        if line.startswith('inputs/'):
            this_input = inputs[curr_input]
            while line.replace('.egr.jmst', '').replace('inputs/', '').strip() != this_input.strip():
                file_runtimes.append('NC')
                file_throughputs.append('NC')
                curr_input = curr_input + 1
                this_input = inputs[curr_input]
            edges = input_sizes[inputs[curr_input]]
            curr_input = curr_input + 1
            line = r.readline()
            values = []
            # Read the next 9 lines
            for i in range(9):
                values.append(float(line.replace('eclruntime  ', '').replace('s', '')))
                line = r.readline()
            file_runtimes.append(statistics.median(values))
            file_throughputs.append((edges / statistics.median(values)) / 1000000)
        else:
            line = r.readline()
    runtime_table.append(file_runtimes)
    throughput_table.append(file_throughputs)
    print(file_throughputs)