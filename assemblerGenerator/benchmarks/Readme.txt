======================
====THIS DIRECTORY====
======================

This directory contains a selection of benchmarks from the Rodinia benchmark suite.
These benchmarks were selected primarily for ease of compilation.
The compiled executables can be used as input for our Assembler Generator tool.
For more info about Rodinia, see https://rodinia.cs.virginia.edu/doku.php

======================
=====REQUIREMENTS=====
======================

Most or all of these benchmarks will only compile on Linux systems.
These benchmarks all require the CUDA Toolkit to be installed, such that nvcc can be invoked from the command line.
These are compatible with several versions of the CUDA Toolkit, including but not limited to v6.5.

======================
=====COMPILATION======
======================

The bash script makeExes.sh can be invoked to compile all of the benchmarks, placing their executables in the bin subdirectory.
Optionally, the bash script cleanAll.sh can be invoked to delete all compiled files in all subdirectories.

======================
=====ARCHITECTURE=====
======================

These benchmarks are set up to target CUDA devices of Compute Capability 3.5.
To change the target architecture, locate and modify the "-arch=sm_35" flag in each Makefile.
E.g., to compile for Compute Capability 5.0, change the above flag to "-arch=sm_50".
