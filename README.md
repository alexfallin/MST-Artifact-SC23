### Artifact Identification
1. Main contributions of the paper
    - The paper presents a high-speed Minimum Spanning Tree (MST) implementation for GPUs
    - The paper describes the optimizations that make the implementation fast, and provides empirical evidence to demonstrate the benefit of these optimizations
    - The paper evaluates the resulting implementation on 2 GPUs and 2 CPUs using 17 input graphs from various domains to compare with state-of-the-art GPU-parallel, CPU-parallel, and CPU-serial MST
    implementations
2. Role of the computation artifacts
    - The computational artifact can run the described MST implementation as well as the codes from the related work with the 17 input graphs and compute the median runtimes
    - It can also run various de-optimized versions of our MST code and compute the median runtimes
3. Software architecture
    - The URL for the DOI is: 10.5281/zenodo.8214364
    - The URL for the Git repository is: https://github.com/alexfallin/MST-Artifact-SC23/
    - The codes from the related work, our MST code, the de-optimized codes, and the input files each have a dedicated directory
    - Each directory contains a build and run script that installs and runs the code in that directory, respectively
    - The “set up.sh” script downloads the 17 inputs, converts them into the various needed formats, and runs each build script to install the codes
    - The “run all compare.sh” script executes the timed experiments for each code and writes the results to [code] out.csv files that are placed in the root folder
    - The “run all deoptimize.sh” script runs the de-optimization experiments and writes the results to ecl mst [deopts] out.csv file
    - The “generate compare tables.py” script reads the output files and converts them into CSV tables similar to those shown in the paper
    - The “generate deopt tables.py” script reads the output files and con verts them into CSV tables similar to those shown in the paper
4. Extent of reproducibility
    - The computational artifacts can run our code, the codes from the literature we used for the performance comparison, and our de-optimized codes and can reproduce the result figures from the paper
### Reproducibility of Experiments
1. Experiment workflow
    - Install all the codes and input files using “set up.sh” script
    - Run the “run all compare.sh” and “run all deoptimize.sh” scripts to produce the result CSV files
    - Run the “generate * tables.py” scripts to generate the tables that show the results of the above experiments
2. Execution time
    - About 48 hours to run the related work comparisons
    - About 2 hours to run the de-optimization experiments
3. Expected results
    - The CSV files that contain the runtimes for each code
    - Combined CSV tables for both throughput and runtime
4. How the results relate to the paper results
    - The results should show similar runtime and throughput relationships between the different implementations as in the paper
    - The results will differ based on the CPU and GPU that is used
### Artifact Dependencies and Requirements
1. Hardware resources
    - We used a 3.5 GHz Ryzen Threadripper 2950X CPU, a 2.9 GHz Xeon Gold 6226R CPU, a 1.2 GHz TITAN V GPU, and a 1.67 GHz RTX 3080 Ti GPU for the experiments
    - The minimum hardware requirement is a multi-core CPU and a
    CUDA-capable GPU with a Compute Capability of at least 7.0
2. Operating system
    - We used Fedora Linux 34 and 36. No specific operating system is required to run the experiments
3. Software libraries needed
    - We used GCC 11.3.1 and 12.2.1 with the “-O3 -march=native” flags to compile the codes and NVCC 11.7 and 12.0 with the “-arch=sm 70 and -arch=sm 86” flags for the CUDA codes
    - The related works require:
        - Boost library 1.58+
        - libllvm 7.0+
        - libfmt 4.0+
        - gcc version 9.3+
        - cmake version 3.26+
        - CUDA 11.0+
        - NVIDIA driver 450.80.02+
        - Anaconda 23.5+
        - Python 3.0+
        - Matplotlib
        - NumPy
4. Input datasets needed
    - We used 17 inputs for the experiments. They can be downloaded using either set up.sh in the root directory of the artifact or download inputs.sh in the Inputs folder
    - The only constraints on inputs are that they must be in binary 32-bit CSR format1 and they must fit in the selected GPU’s memory
### Artifact Installation and Deployment Process
1. Process to install and compile the codes
    - The “set up.sh” script will download the inputs, convert them to the various required formats, and will also download and build the related works
2. Process to deploy the codes
    - Use the “run all compare.sh” script to run each code to compare their run times. The estimated time to complete these runs is 48 hours, subject to system speed
    - Use the “run all deoptimize.sh” script to run the de-optimization experiments from the paper. The estimated run time of these experiments is 2 hours, subject to system speed
