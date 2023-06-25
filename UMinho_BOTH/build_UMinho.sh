#!/bin/bash
echo 'Building UMinho MST'

echo 'UMinho'
git clone https://github.com/Beatgodes/BoruvkaUMinho.git
cd BoruvkaUMinho/

echo 'oneTBB requirement'
git clone https://github.com/oneapi-src/oneTBB.git
cd oneTBB/
cmake .
cmake --build .

echo 'Converting inputs to UMinho format'