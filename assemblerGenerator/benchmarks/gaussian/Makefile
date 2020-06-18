CC := nvcc -I. -arch=sm_61

SRC = gaussian.cu
EXE = gaussian

gaussian: $(SRC)
	$(CC) -Xptxas -v -O3 $(SRC) -o $(EXE)

clean:
	rm -f gaussian
