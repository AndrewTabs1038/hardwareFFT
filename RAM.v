module RAM 
#(parameter DATA_WIDTH = 16, ADDR_WIDTH = 5)
(
input clk, roW, singlewrite, // roW -> zero if read, one if write
input [DATA_WIDTH - 1:0] data_in_A, data_in_B,
input [ADDR_WIDTH-1:0] A_addr,B_addr,
output reg [DATA_WIDTH - 1:0] data_out_A, data_out_B
);

//(2^x-1) -> This calculates the max value of a x-bit number

reg [DATA_WIDTH-1:0] memory [(2**ADDR_WIDTH)- 1:0];

always @(posedge clk) begin

	if (singlewrite) begin
		memory[A_addr] <= data_in_A;
		data_out_A <= 16'hdead;
		data_out_B <= 16'hdead;
	end
	else if(roW) begin
		//writes
		memory[A_addr] <= data_in_A;
		memory[B_addr] <= data_in_B;
		data_out_A <= 16'hdead;
		data_out_B <= 16'hdead;	
	end
	
	else begin
		//reads 
		data_out_A <= memory[A_addr];
		data_out_B <= memory[B_addr];
	
	end



end 




endmodule 
