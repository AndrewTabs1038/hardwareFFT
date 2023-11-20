# Overview
This is a hardware implemented Fast Fourier Transform (FFT) done in verilog. It is currently a work in progress as many operations are working as intended, however it is still not outputing correct results. The architure for this project is disscused [in this paper] (http://web.mit.edu/6.111/www/f2017/handouts/FFTtutorial121102.pdf). This project was given to me from a unversity professor as part of the university's honors college program. The purpose was to better understand popular DSP algorithms. 

# How it works 
Once the program is finished and working as intended, I will give a more detailed discription but for now, I will summerize the architecture of processing going on that is described in the previously mentioned paper. I will be refrencing several images taken from the same paper. I hope that for anyone wishing to implement the FFT in hardware will benifit from my summerization, even though the program is not currently working at your time of reading this. I will not discuss in detail about of the mathematical theory behind the FFT, only what is required to implement this in hardware.  

![image](https://github.com/AndrewTabs1038/hardwareFFT/assets/135442448/23695727-6b1a-48c1-822e-75d0facd90cc)

The above signal flow representation of an 8-point FFT, starting from all the way on the left, you will noticed 8 nodes that are listed as x(0-7). This refers to the individual signal samples taken from some given signal, x(0) would refer to the signed quantity of sample number 0. Each node has an address assigned to it, the addresses will range from 0-(numberOfSamples - 1), in this case the addresses will range from 0-7. 

The actual data being delt with will have a real and imaginary poritons, making them complex numbers. Since we are dealing with complex numbers throughout the calculation, we will need to have 2 seperate data busses to represent the real and imaginary poritons for each complex number. 

You will also notice the variable "w" held to some power. These refer to the "twiddle factors", I will discuss how you can generate these twiddle factors in it's own seperate section at a future time. I have developed a python script to help generate these values using the discription mentioned in the paper. The actual function for the twiddle factors is simply a cos funciton for the real portion of the twiddle factor, and a sin funciton for the imaginary poriton. The program converts these values into mantissa bit approximations as discribed in the paper.

![image](https://github.com/AndrewTabs1038/hardwareFFT/assets/135442448/b55f8572-12fd-4643-b748-b61eda50dfb9)

Coming back to the addressing. In red, I have highlighted which each address is refering to. You might already notice that the sample number does not align with the address it is associated with. There is actually a simple way we can find which address is associated to which sample number, all we need to do is take the bit reverse order of the sample number, and we can link the quantity this sample to an address. For example, we can see that sample number 4 (x(4)) corresponds to address 1, this is because the bit reversed order of 4 (in binary: 100) is 1 (001). 

Now let's look at a single butterfly operation and discussing what is happening. Remeber that all the quantities we are dealing with will be complex, so there will always be two busses refering the real and imaginary poritonsk, but when discribing the actual workings, I will discuss complex numbers as a single quantity to aviod confusion. 
