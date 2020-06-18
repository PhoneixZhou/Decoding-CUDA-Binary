CC := nvcc

NVCC_FLAGS	:= -O3 -Xptxas -v -arch=sm_61

SRC = hotspot.cu

EXE = hotspot

hotspot: $(SRC)
	$(CC) $(NVCC_FLAGS) $(SRC) -o $(EXE) -I.

clean: $(SRC)
	rm -f $(EXE) $(EXE).linkinfo result.txt
