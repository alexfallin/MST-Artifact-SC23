This is the code used for testing against the others, it has the same kernels and optimizations as version 48 but is lacking the verbose printing and verification so it can be run quickly.

The "with_memcpy_included" code moves the memcpy to and from device into the timed code section to be comprable to a CPU code where the rest of the work using the MST needs to be done on the CPU. We used cudaMallocHost to allocate solid blocks of memory to allow for good performance. This code uses the ECLgraph.cuh header instead of the .h header.

Both codes are compiled the same was as the regular MST code from the root directory

run_all.sh is used to run and the python parser is used to get usable data from the output files
