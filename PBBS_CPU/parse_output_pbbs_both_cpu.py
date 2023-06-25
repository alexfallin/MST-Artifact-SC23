print('PARSING pbbs_ser_out.txt')

# Open the files for reading and writing
with open('pbbs_ser_out.txt', 'r') as r, open('pbbs_ser_out.csv', 'w') as w:

    # Read all the lines of the file
    lines = r.readlines()

    # Iterate the read file line by line
    for line in lines:

        # If the line starts with the graph name...
        if line.startswith('Parlay'):
            w.write(line.replace("Parlay time: ", ''))

# You're done!
print('DONE writing pbbs_ser_out.csv')

r.close()
w.close()

print('PARSING pbbs_par_out.txt')
with open('pbbs_par_out.txt', 'r') as r, open('pbbs_par_out.csv', 'w') as w:

    # Read all the lines of the file
    lines = r.readlines()

    # Iterate the read file line by line
    for line in lines:

        # If the line starts with the graph name...
        if line.startswith('Parlay'):
            w.write(line.replace("Parlay time: ", ''))

# You're done!
print('DONE writing pbbs_par_out.csv')
