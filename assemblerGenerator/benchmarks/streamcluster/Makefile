NVCC = nvcc

NVCC_FLAGS = -I. -Xptxas -v -arch=sm_61

TARGET_G = sc_gpu

$(TARGET_G): streamcluster_cuda_cpu.cpp streamcluster_cuda.cu streamcluster_header.cu
	$(NVCC) $(NVCC_FLAGS) streamcluster_cuda_cpu.cpp streamcluster_cuda.cu streamcluster_header.cu -o $(TARGET_G) -lcuda

clean:
	rm -f *.o *~ *.txt $(TARGET_G) *.linkinfo
	
