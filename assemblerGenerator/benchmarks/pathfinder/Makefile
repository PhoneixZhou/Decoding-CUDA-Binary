CC := nvcc -I. -Xptxas -v -arch=sm_61

SRC = pathfinder.cu

EXE = pathfinder

pathfinder:
	$(CC) $(SRC) -o $(EXE)

clean:
	rm -f pathfinder