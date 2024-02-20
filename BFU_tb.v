module BFU_tb;

reg [15:0] Ar, Br, Ai, Bi, twiddler, twiddlei;
wire [15:0] arM, aiM, brM, biM;
reg clk;


BFU
#(.DATA_WIDTH(16))
Test
(
.clk(clk),
.A_in_r(Ar),
.B_in_r(Br),
.A_in_i(Ai),
.B_in_i(Bi),
.twiddleF_r(twiddler),
.twiddleF_i(twiddlei),
.A_out_r(arM),
.B_out_r(brM),
.A_out_i(aiM),
.B_out_i(biM)
);

initial begin 
	Ar = 16'h0000;
	Br = 16'h0000;
	
	Ai = 16'h0000;
	Bi = 16'h0000;
	
	twiddler = 16'h7fff;
	twiddlei = 16'h0000;

end

always begin
clk = 0;
#10;
clk = 1;
#10;

end 


endmodule
