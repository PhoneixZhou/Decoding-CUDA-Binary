#!/bin/bash

#This bash script runs make clean in each benchmark, and deletes the executables.

rm -r ./bin

cd gaussian
make clean
cd ..

cd heartwall
make clean
cd ..

cd hotspot
make clean
cd ..

cd pathfinder
make clean
cd ..

cd srad
make clean
cd ..

cd streamcluster
make clean
cd ..

echo "Done."
