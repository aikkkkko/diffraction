# Record of useful functions in applying optics / wave optics
In functions res_x,res_y represent resolution in x,y directions (which usually be same) L0,L1 are the sample window width in two directions (also usually be same).\
     **shoud be mentiond**\
input should be **field** data if the input is a simple flat wave apply _sqrt(input_intense)_
## GPU version of functions
To fit the large data of diffraction calculation applying gpuArray() to functions. Which works on gpu equipped with CUDA.
