#include <stdio.h>

__global__ void vectorAdditionKernel(float * A , float * B , float * C){
    int index = threadIdx.x;
    C[i] = A[i] + B[i];
}

int main(){
    int dataCount = 100;
    float h_A[dataCount];
    float h_B[dataCount];
    float h_C[dataCount];

    float * d_A;
    cudaMalloc(&d_A , dataCount * sizeof(float));
    float * d_B;
    cudaMalloc(&d_B , dataCount * sizeof(float));
    float * d_C;
    cudaMalloc(&d_C , dataCount * sizeof(float));

    
}