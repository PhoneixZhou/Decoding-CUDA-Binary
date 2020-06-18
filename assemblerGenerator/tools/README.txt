========================
=====THIS DIRECTORY=====
========================
This directory contains source code for our assembler generator tool, plus related tools.
We hope to continue updating this, such as to add support for the Volta generation of NVIDIA devices.

========================
=======OUR TOOLS========
========================
The bin2asm tool extract kernel functions' assembly code from nvcc-generated executables.
The asm2bin tool can assemble assembly code for several architectures, overwriting binary in an executable.
The decode tool can generate assembler code for use with the asm2bin tool.

If writing functions to analyze/modify GPU code, we recommend calling them in asm2bin.
There's a line in asm2bin.ypp that says "//This is where we might call functions to modify or optimize the GPU code."

========================
======DEPENDENCIES======
========================
Our tools are all compiled with g++.
The asm2bin and decode tools are dependent on flex and bison.
The bin2asm tool expects that the CUDA Toolkit be installed and part of your PATH.

========================
=====COMPATIBILITY======
========================
The asm2bin and decode tools should be run on a Linux machine for full compatibility.
The decode tool has been tested with compute capabilities between 3.2 and 6.2, inclusive.

========================
======COMPILATION=======
========================
Our tools can be compiled by running make in this directory.

========================
===RUNNING VIA SCRIPT===
========================
We provide a bash script, procExes.sh, which will go through the steps of generating assembler code.
Before running procExes.sh, place CUDA executables directly inside the exes subdirectory.
The generated code will have filenames of the format "generatedAssemblerXX.txt" for some value XX.
The procExes.sh will also insert the generated assembler for Compute Capability 3.5 into asm2bin, and test it.

========================
========OUTPUT==========
========================
The generated assembler code is designed to fit into the source code for asm2bin.
Our already-generated assemblers are in the binary35.cpp and binary50.cpp files in the src directory.

========================
=COMMAND LINE ARGUMENTS=
========================
Run any of the three tools with the -h flag for details on runtime arguments.
