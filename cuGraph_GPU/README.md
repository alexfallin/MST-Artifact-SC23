Source: https://github.com/rapidsai/cugraph branch 22.10

Hard to get compiled and running, followed their compile from souce directions on Goliath.

Included code is modified to run nicely. You need to place into the cpp test directory, when 'make' is run it will recompile. Converter only converts in one direction, makes the runtimes slightly faster. Code has a 'double' version and a 'float' version. Float is faster but will not run all inputs, double runs all inputs but is slower
