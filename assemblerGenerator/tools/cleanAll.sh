#!/bin/bash

#This bash script runs make clean, and deletes files created by the other script.

#Delete files
make clean
rm -f ./persistent* ./.temp* ./generatedAssembler* tempExe tempKernel.txt tempBitFlip.txt

#Reset generated assembler code in src directory:
echo -e -n "//Placeholder for newly generated assembler code\nbool binary[64];\n" > ./src/binaryGen35.cpp
