module BFU_tb;

reg [7:0] Ar, Br, Ai, Bi, twiddler, twiddlei;
wire [7:0] arM, aiM, brM, biM;
reg clk;


BFU
#(.WIDTH(8))
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
	Ar = 8'haa;
	Br = 8'hbb;
	
	Ai = 8'h11;
	Bi = 8'h22;
	
	twiddler = 8'h33;
	twiddlei = 8'h44;

end

always begin
clk = 0;
#10;
clk = 1;
#10;

end 


endmodule
