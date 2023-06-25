#!/bin/csh
setenv TBBROOT "/data/home/alex/mst/BoruvkaUMinho/oneTBB" #
setenv tbb_bin "/data/home/alex/mst/BoruvkaUMinho/oneTBB/build/linux_intel64_gcc_cc11_libc2.33_kernel5.17.8_release" #
if (! $?CPATH) then #
    setenv CPATH "${TBBROOT}/include" #
else #
    setenv CPATH "${TBBROOT}/include:$CPATH" #
endif #
if (! $?LIBRARY_PATH) then #
    setenv LIBRARY_PATH "${tbb_bin}" #
else #
    setenv LIBRARY_PATH "${tbb_bin}:$LIBRARY_PATH" #
endif #
if (! $?LD_LIBRARY_PATH) then #
    setenv LD_LIBRARY_PATH "${tbb_bin}" #
else #
    setenv LD_LIBRARY_PATH "${tbb_bin}:$LD_LIBRARY_PATH" #
endif #
 #
