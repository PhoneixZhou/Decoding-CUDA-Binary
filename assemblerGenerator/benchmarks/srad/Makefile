CC := nvcc -Xptxas -v -arch=sm_61

SRC = srad.cu

EXE = srad

srad: $(SRC)
	$(CC) $(SRC) -I. -o $(EXE)

clean: $(SRC)
	rm -f $(EXE) $(EXE).linkinfo result.txt
