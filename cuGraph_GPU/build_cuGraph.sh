#!/bin/bash
echo 'Building cuGraph'

git clone https://github.com/rapidsai/cugraph.git
cd cugraph/
git checkout origin/branch-22.10
conda env create --name cugraph_dev --file conda/environments/cugraph_dev_cuda11.0.yml
conda env update --name cugraph_dev --file conda/environments/cugraph_dev_cuda11.0.yml