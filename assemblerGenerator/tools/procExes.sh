#!/bin/bash

#This bash script applies our assembler generator to each file in the exes directory.

#List of architecture versions with which our tools should be compatible:
#validArchitectures=(20 21 30 32 35 37 50 52 53 60 61 62)
#validArchitectures=(32 35 37 50 52 53 60 61 62)
validArchitectures=(61)
minValid=32
maxValid=62

#Reset persistent data:
#rm -f ./persistent*

#Reset generated assembler code in src directory:
#echo -e -n "//Placeholder for newly generated assembler code\nbool binary[64];\n" > ./src/binaryGen35.cpp
echo "//Placeholder for newly generated assembler code\nbool binary[64];\n" > ./src/binaryGen61.cpp

#Compile tools:
echo "Building tools..."
#make clean

make

echo "Processing CUDA executables..."

for exe in ./exes/*; do
    echo "exe $exe"
	#Get number of CUDA kernel functions in exe:
    numKernels=`./bin2asm $exe 2>/dev/null | wc -l`

	echo "numKernels $numKernels"

	if [ $numKernels -eq 0 ]; then
		echo "WARNING: Could not find kernel functions in $exe"
		echo "  Make sure that cuobjdump is in your PATH, and that bin2asm was compiled."
		continue
	fi
	
	for kernel in $(seq 1 $numKernels); do

	    echo "kernel $kernel"
		#Extract side-by-side assembly and binary for this kernel function:
		./bin2asm -hex $exe $kernel 2>/dev/null 1>tempKernel.txt
		
		#Determine architecture version of kernel function:
		arch=`grep "//Arch:" tempKernel.txt | awk '{print $2}' | sed 's/sm_//'`

		echo $arch 
		echo $minValid
		
		#Skip this kernel if it's not for an architecture that decode can currently handle:
		if [ "$arch" -le "$minValid" ]; then
			continue;
		fi
		if [ "$arch" -ge "$maxValid" ]; then
			continue;
		fi
		
		#Remember this exe and kernel, so we can overwrite a copy of it later, to do bit-flipping:
		archExe[$arch]="$exe"
		archKernelID[$arch]="$kernel"
		kernelname=`grep "//Name: " tempKernel.txt | awk '{print $2}'`
		archKernel[$arch]="$kernelname"

		echo "exe: $exe,archKernelID: $kernel,archKernel: $kernelname";
		
		#If necessary, initialize persistent data for architecture:
		if [ ! -f ./persistent${arch}.txt ]; then
			echo "-1" > persistent${arch}.txt
		fi
		
		#Analyze kernel function and update persistent data:
		cp persistent${arch}.txt tempPersistent.txt
		#./decode tempKernel.txt < tempPersistent.txt > persistent${arch}.txt
		
		#Delete temporary data:
		#rm tempPersistent.txt
		#rm tempKernel.txt
	done
done

numRounds=1
echo
#echo "Performing $numRounds rounds of bit flip analysis..."

# for arch in ${validArchitectures[@]}; do
# 	#Make sure this is an architecture we saw in previous loop:
# 	if [ "${archExe[$arch]}" != "" ]; then
# 		echo "Performing $numRounds rounds of bit flip analysis for architecture version $arch"
		
# 		for((x=0;x<numRounds;x++)); do
# 			#Grab original kernel so we can get its metadata before overwrite:
# 			echo "archExe :${archExe[$arch]}"
# 			cp ${archExe[$arch]} tempExe
			
# 			echo "begin bin2asm";
# 			./bin2asm -hex tempExe ${archKernelID[$arch]} > tempKernel.txt
# 			echo "end of bin2asm";


# 			echo "begin decode";
# 			#Generate bit flip code:
# 			./decode -probe tempKernel.txt < persistent${arch}.txt > tempBitFlip.txt
# 			echo "end of decode";
			
# 			#Overwrite executable with bit flip code:
# 			echo "begin asm2bin 1";
# 			./asm2bin -overrideName ${archKernel[$arch]} -write tempExe tempBitFlip.txt
# 			echo "begin asm2bin 2";
# 			./asm2bin -write tempExe tempBitFlip.txt
			
# 			#Extract bit flip assembly and binary
# 			echo "begin bin2asm";
# 			./bin2asm -hex tempExe ${archKernelID[$arch]} > tempBitFlip.txt
			
# 			# #Process bit flip assembly and binary:
# 			cp persistent${arch}.txt tempPersistent.txt
# 			echo "begin decode";
# 			./decode tempBitFlip.txt < tempPersistent.txt > persistent${arch}.txt
			
# 			#Remove temporary files:
# 			rm tempBitFlip.txt
# 			rm tempKernel.txt
# 			rm tempPersistent.txt
# 			rm tempExe
# 		done
# 	fi
# done

echo
echo "Generating assembler code..."

# for arch in ${validArchitectures[@]}; do
# 	#Make sure this is an architecture we saw in previous loop:
# 	if [ "${archExe[$arch]}" != "" ]; then
	
# 		echo "Generating assembler code for architecture version ${arch}..."
		
# 		./decode -final < persistent${arch}.txt > generatedAssembler${arch}.txt
# 	fi
# done

#Add newly generated Compute Capability 3.5 assembler to asm2bin and test it:
# if [ "${archExe[61]}" != "" ]; then
# 	echo "Placing generated 6.1 assembler code into asm2bin source..."
	
# 	#Inform asm2bin that it should use this version of the assembler:
# 	echo "#define USE_GENERATED_CODE" > ./src/binaryGen61.cpp
	
# 	#Add the actual assembler code:
# 	cat generatedAssembler61.txt >> ./src/binaryGen61.cpp
	
# 	echo "Compiling asm2bin..."
# 	make asm2bin
	
# 	for exe in ./exes/*; do
# 		#Make copy of this executable, in which we'll reproduce kernel binary:
# 		cp $exe tempExe
		
# 		#Get number of CUDA kernel functions in exe:
# 		numKernels=`./bin2asm $exe 2>/dev/null | wc -l`
# 		if [ $numKernels -eq 0 ]; then
# 			continue
# 		fi
		
# 		#Reproduce every architecture 3.5 kernel function in this exe:
# 		hasArch61=0
# 		for kernel in $(seq 1 $numKernels); do
# 			#Grab assembly code from kernel:
# 			./bin2asm tempExe ${archKernelID[61]} > tempKernel.txt
			
# 			#Determine architecture version of kernel function:
# 			arch=`grep "//Arch:" tempKernel.txt | awk '{print $2}' | sed 's/sm_//'`
			
# 			#Skip this kernel if it's not for architecture 35
# 			if [ "$arch" != "61" ]; then
# 				continue;
# 			fi
# 			hasArch61=1
			
# 			#Overwrite temporary executable's kernel, using newly generated assembler:
# 			./asm2bin -write tempExe tempKernel.txt
# 		done
		
# 		#If we tried reproducing any kernels, confirm the executable is 100% the same as before:
# 		if [ "$hasArch61" == "1" ]; then
# 			echo "Verifying new assembler reproduced executable ${exe}..."
			
# 			#Compare files
# 			if cmp -s "tempExe" "$exe" ; then
# 			   echo "Files match"
# 			else
# 			   echo "Error: asm2bin was unable to perfectly match the original code."
# 			fi
# 		fi
# 	done
# fi

echo "Done."
