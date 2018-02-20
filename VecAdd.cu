#include <stdio.h>
#include <time.h>
#include <stdlib.h>

enum {
    grid_count=16
};
__global__ void vectorAdditionKernel(float * A , float * B , float * C ,int dataCount){
    int index = blockIdx.x *blockDim.x + threadIdx.x;
    if(index < dataCount) 
        C[index] = A[index] + B[index];
}

int main(){
    int dataCount = 2100;
    float h_A[dataCount];
    float h_B[dataCount];
    float h_C[dataCount];

// initialize the values 

    for(int i = 0 ; i < dataCount ; i++){

        h_A[i] = (float) i ;
        h_B[i] = (float) i ;
    }

    float * d_A;
    cudaMalloc(&d_A , dataCount * sizeof(float));
    cudaMemcpy(d_A ,h_A ,sizeof(float) * dataCount ,  cudaMemcpyHostToDevice );

    float * d_B;
    cudaMalloc(&d_B , dataCount * sizeof(float));
    cudaMemcpy(d_B , h_B , sizeof(float) * dataCount , cudaMemcpyHostToDevice);

    float * d_C;
    cudaMalloc(&d_C , dataCount * sizeof(float));
    cudaMemcpy(d_C , h_C , dataCount * sizeof(float) , cudaMemcpyHostToDevice);

    // call the kernel
    int threadPerBlock = dataCount/grid_count;
    vectorAdditionKernel<<<grid_count,threadPerBlock>>> (d_A, d_B , d_C, dataCount);

    // get the data
    cudaMemcpy(h_C , d_C , dataCount * sizeof(float) , cudaMemcpyDeviceToHost);

    for(int i = 0 ; i < dataCount ;i++){
        printf("%f \n" , h_C[i]);

    }
    return 0 ;
    
}