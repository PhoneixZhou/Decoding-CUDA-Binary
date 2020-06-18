#!/bin/bash

#This bash script compiles the benchmarks, placing executables in the bin subdirectory.

mkdir -p bin

#Compile gaussian:
cd gaussian
make
cp gaussian ../bin/
cd ..


#Compile heartwall:
cd heartwall
make
cp heartwall ../bin/
cd ..

#Compile hotspot:
cd hotspot
make
cp hotspot ../bin/
cd ..

#Compile pathfinder:
cd pathfinder
make
cp pathfinder ../bin/
cd ..

#Compile srad:
cd srad
make
cp srad ../bin/
cd ..

#Compile streamcluster
cd streamcluster
make
cp sc_gpu ../bin/streamcluster
cd ..

echo "Done. Executables are in the bin subdirectory."
