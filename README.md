# Overview
This is a hardware implemented Fast Fourier Transform (FFT) done in verilog. It is currently a work in progress as many operations are working as intended, however it is still not outputing correct results. The architure for this project is disscused [in this paper](http://web.mit.edu/6.111/www/f2017/handouts/FFTtutorial121102.pdf). This project was given to me from a unversity professor as part of the university's honors college program. The purpose was to better understand popular DSP algorithms. 

# How it works 
Once the program is finished and working as intended, I will give a more detailed discription but for now, I will summerize the architecture of processing going on that is described in the previously mentioned paper. I will be refrencing several images taken from the same paper. I hope that for anyone wishing to implement the FFT in hardware will benifit from my summerization, even though the program is not currently working at your time of reading this. I will not discuss in detail about of the mathematical theory behind the FFT, only what is required to implement this in hardware.  

![image](https://github.com/AndrewTabs1038/hardwareFFT/assets/135442448/23695727-6b1a-48c1-822e-75d0facd90cc)

The above signal flow representation of an 8-point FFT, starting from all the way on the left, you will noticed 8 nodes that are listed as x(0-7). This refers to the individual signal samples taken from some given signal, x(0) would refer to the signed quantity of sample number 0. Each node has an address assigned to it, the addresses will range from 0-(numberOfSamples - 1), in this case the addresses will range from 0-7. 

The actual data being delt with will have a real and imaginary poritons, making them complex numbers. Since we are dealing with complex numbers throughout the calculation, we will need to have 2 seperate data busses to represent the real and imaginary poritons for each complex number. 

You will also notice the variable "w" held to some power. These refer to the "twiddle factors", I will discuss how you can generate these twiddle factors in it's own seperate section at a future time. I have developed a python script to help generate these values using the discription mentioned in the paper. The actual function for the twiddle factors is simply a cos funciton for the real portion of the twiddle factor, and a sin funciton for the imaginary poriton. The program converts these values into mantissa bit approximations as discribed in the paper.

![image](https://github.com/AndrewTabs1038/hardwareFFT/assets/135442448/b55f8572-12fd-4643-b748-b61eda50dfb9)

Coming back to the addressing. In red, I have highlighted which each address is refering to. You might already notice that the sample number does not align with the address it is associated with. There is actually a simple way we can find which address is associated to which sample number, all we need to do is take the bit reverse order of the sample number, and we can link the quantity this sample to an address. For example, we can see that sample number 4 (x(4)) corresponds to address 1, this is because the bit reversed order of 4 (in binary: 100) is 1 (001). 

Now let's look at a single butterfly operation and discussing what is happening. Remeber that all the quantities we are dealing with will be complex, so there will always be two busses refering the real and imaginary poritonsk, but when discribing the actual workings, I will discuss complex numbers as a single quantity to aviod confusion. 

![image](https://github.com/AndrewTabs1038/hardwareFFT/assets/135442448/9bdcccfe-3cd1-4c43-bb0e-7776227f7b4a)

The arrows drawn from the left two nodes show how the right two nodes are calculated, when two arrows meet at a node, the values that are entering are added together to form the node. The -1 you see means that to calculate the bottem left node, we must multiply it by -1 before adding it to the upper left node, or simiply means we subtract this top node form the bottem node. 

In hardware, this operation would look like this:

![image](https://github.com/AndrewTabs1038/hardwareFFT/assets/135442448/fb2cf132-770b-4bb8-ad22-1471f6b5ec23)

Where the inputs are A, B, and w, A and B would correspond to a node and w would correspond to a twiddle factor. These inputs have real and imaginary components, thus the 2x[15:0] is stateing that there is 2 buses for each. The complex multiplier output would have a length of 32 bits, we direct [30:15] to the adders.  A' and B' would be the two right nodes. 

Now, I will run through an example of the calculation using the addresses associated to each node so you can see how this is meant to work. 

![image](https://github.com/AndrewTabs1038/hardwareFFT/assets/135442448/7e4b944b-3878-4345-a365-6409dffecc16)

The red and the green butterfly operations are displayed, note that the addresses assigned to these new values are of the same addressing scheme we discussed previously, the addresses are highlited in blue. Now, looking at the previous image displaying the first addresses in red, you can see that we needed addresses 0, 1, 2, 3 to generate the new 0, 1, 2, 3 address values. 

The program works by first performing all the butterfly operations you see here, so the first round of calculations would pair {0,1}, {2,3}, {4,5}, {6,7} addresses to perform the 4 seperate butterfly calculations, each round of butterfly calculations is refered to as a level. In this example there are 3 levels, to generate the values of a level, we must calculate the previous values. Now lets look at a smaple from the next calculation. 

![image](https://github.com/AndrewTabs1038/hardwareFFT/assets/135442448/23013424-c74b-42f7-9999-3e2aa02465fe)

You can see thtat the new address pairs for this calculation are {0,2}, {1,3}, {4,6}, {5,7}. 

So, to calculate each level, we must find the address pairs to perform each calculation. You may have already noticed a pattern, that the two addresses in a pair for the first level were seperated by 1, the next level it was by 2, and in the 3rd level, they are seperated by 4. 

Our hardware example will have the following job: select the address from to perform each butterfly calculation along with the associated twiddle factor for said operation. Below you can see the top level design for the hardware FFT. 

![image](https://github.com/AndrewTabs1038/hardwareFFT/assets/135442448/2a718506-57d6-4c12-9905-a528a8d378a7)

The Address Generation Unit (AGU) calculates these address pairs based on the level that is being calculated, it will need to calculate 4 addresses for each level in our 8 point FFT example. It would also need to calculate the address for the seperate twiddle factors for each calculation. 

The program begins by first loads the the input data in bit reversed order, as prevously disscussed, in the top RAM. Then the AGU will decide which addreess it wants to take take from the RAM and input them into the BFU. Each calulation is stored within the bottem RAM. Once the level is completed, the bottem RAM will be filled, the next level will take form the bottem RAM this time and input values to the top RAM accordingly. This will occur until all the levels are completed and the RAM that recived the last set of calculations is where the actual Fourier coefficients will reside. 

