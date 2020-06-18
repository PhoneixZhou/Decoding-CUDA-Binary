NVCC_OPTS = -arch=sm_61 -Xptxas -v

all: heartwall

# link objects(binaries) together
heartwall: main.o ./AVI/avilib.o ./AVI/avimod.o
	nvcc $(NVCC_OPTS) main.o ./AVI/avilib.o ./AVI/avimod.o -lm -o heartwall

# compile main function file into object (binary)
main.o: main.cu kernel.cu define.c
	nvcc $(NVCC_OPTS) main.cu -I./AVI -c -O3

./AVI/avilib.o ./AVI/avimod.o:
	cd AVI; make;

# delete all object files
clean:
	rm -f *.o AVI/*.o heartwall *.linkinfo
