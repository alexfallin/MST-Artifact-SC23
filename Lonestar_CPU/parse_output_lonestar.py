import sys
from statistics import median

iteration = 0
runtimes = []
mst_weight = 0

# Open the files for reading and writing
with open('output_ls_mst_cpu.txt', 'r') as r, open('parsed_output_ls_mst_cpu.csv', 'w') as w:

    # Read all the lines of the file
    lines = r.readlines()

    # Iterate the read file line by line
    for index, line in enumerate(lines):

        # If the line starts with the graph name...
        if line.startswith('PARAM, (NULL), Input, SINGLE, lonestar_graphs/'):
            # Get the name of the graph and the iteration
            name = lines[index].replace('PARAM, (NULL), Input, SINGLE, lonestar_graphs/', '').replace('\n', '')
            iteration += 1
        if line.startswith('STAT, (NULL), TimerTotal, TMAX, '):
            # Get the runtimes
            runtimes.append(float(lines[index].strip('\n').replace('STAT, (NULL), TimerTotal, TMAX, ', '').replace('\n', '')))
        if mst_weight == 0 and line.startswith('MST weight: '):
            # Get MST weight
            mst_weight = lines[index].strip('\n').replace('MST weight: ', '')
        
        if iteration > 8:
            w.write(name + ', ')
            w.write(str(float(median(runtimes) / 1000)))
            w.write(', ')
            w.write(str(mst_weight))
            w.write('\n')
            iteration = 0
            #efind_times = []
            runtimes = []
            mst_weight = 0

# You're done!
print('DONE writing parse')