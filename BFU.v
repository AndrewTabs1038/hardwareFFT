module BFU 
#(parameter DATA_WIDTH = 16)
(
input clk,
input signed [DATA_WIDTH-1:0] A_in_r, B_in_r, A_in_i, B_in_i, twiddleF_r, twiddleF_i, // 2x[vector] real and imaginary inputs & outputs 
output reg signed [DATA_WIDTH-1:0] A_out_r, B_out_r, A_out_i, B_out_i
);

reg signed [(DATA_WIDTH*2)- 1:0] imagP_one, imagP_two;
reg signed [(DATA_WIDTH*2)- 1:0] realP_one, realP_two;

reg signed [DATA_WIDTH-1:0] imagS, realS;

wire signed [DATA_WIDTH-1:0] A_dout_r;
wire signed [DATA_WIDTH-1:0] A_dout_i;

//2 seperate delays for 2 seperate busses. Delay is set to 3 as during this clk
//cycle, it will be aligned with the complex multiplier

//Note that although the turtorial states 4 cycles, we will be using 3 instead. 

Delay
#(.CLKCYCLES(3),.DATA_WIDTH(DATA_WIDTH))
Ar //real value
(
.clk(clk),
.clr(1'b1),
.in(A_in_r),
.out(A_dout_r)
);

Delay 
#(.CLKCYCLES(3),.DATA_WIDTH(DATA_WIDTH))
Ai //imaginary value
(
.clk(clk),
.clr(1'b1),
.in(A_in_i),
.out(A_dout_i)
);


//Complex multiplication: where r1,r2 are real numbers i1,i2 are imaginary
//(r1 + i1)(r2 + i2) -> r1*r2(real) + r1*i2(imaginary) + i1*r2(imaginary) - i1*i2(real and opposite sign)


//Complex addition:
//(r1 + i1) + (r2 + i2) -> (r1 + r2) + (i1 + i2)


//The pipeline is as follows:
//Calculate products within complex multicplication ->
//Perform a turnincated within the complex mulplicaiton for correct magnitude ->
//addition with the now aligned A values 

always @(posedge clk) begin
	
	
	//Cycle 1 -> Calculates the products 
	imagP_one <= (B_in_r * twiddleF_i);
	imagP_two <= (B_in_i * twiddleF_r);
        realP_one <= (B_in_r * twiddleF_r);
	realP_two <= (B_in_i * twiddleF_i);
	
	//Cycle 2 -> Turnicated addition
	imagS <= imagP_one[(DATA_WIDTH*2) - 2:DATA_WIDTH-1] + imagP_two[(DATA_WIDTH*2) - 2:DATA_WIDTH-1];
	realS <= realP_one[(DATA_WIDTH*2) - 2:DATA_WIDTH-1]- realP_two[(DATA_WIDTH*2) - 2:DATA_WIDTH-1] ;
	
	//Cycle 3 -> Addition
	A_out_r <= A_dout_r + realS;
	A_out_i <= A_dout_i + imagS;
	B_out_r <= A_dout_r - realS;
	B_out_i <= A_dout_i - imagS;



end

endmodule 
