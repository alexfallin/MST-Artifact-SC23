import sys
from statistics import median

iteration = 0
#efind_times = []
runtimes = []

file = sys.argv[1]

# Open the files for reading and writing
with open(file, 'r') as r, open('parsed_' + file.replace('.txt', '.csv'), 'w') as w:

    # Read all the lines of the file
    lines = r.readlines()

    # Iterate the read file line by line
    for index, line in enumerate(lines):

        # If the line starts with the graph name...
        if line.startswith('inputs/'):

            # Get the name of the graph and the iteration
            name = lines[index].replace('inputs/', '').replace('\n', '')
            iteration += 1
            if iteration > 8:
                w.write(name + ', ')
                w.write(str(median(runtimes)))
                #w.write(', ')
                #w.write(str(median(efind_times)))
                w.write('\n')
                iteration = 0
                #efind_times = []
                runtimes = []
            
            # Get the runtimes
            #times = lines[index + 1].split(',')
            #efind_times.append(float(times[0].strip('\n')))
            runtimes.append(float(lines[index + 1].strip('\n').replace(' s', '')))
            
            

# You're done!
print('DONE writing parse')