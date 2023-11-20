module samples 
(
input clk, reset,
output [4:0] addr,
output reg [15:0] _real, _imag,
output reg done
);




reg [4:0] counter;
wire [15:0] initial_values [31:0];



assign initial_values[0] = 16'h03ff;
assign initial_values[1] = 16'h03ff;
assign initial_values[2] = 16'h03ff; 
assign initial_values[3] = 16'h03ff;
assign initial_values[4] = 16'h03ff;
assign initial_values[5] = 16'h03ff;
assign initial_values[6] = 16'h03ff;
assign initial_values[7] = 16'h03ff;


assign initial_values[8] = 16'h03ff;
assign initial_values[9] = 16'h03ff;
assign initial_values[10] = 16'h03ff; 
assign initial_values[11] = 16'h03ff;
assign initial_values[12] = 16'h03ff;
assign initial_values[13] = 16'h03ff;
assign initial_values[14] = 16'h03ff;
assign initial_values[15] = 16'h03ff;

assign initial_values[16] = 16'hfc01;
assign initial_values[17] = 16'hfc01;
assign initial_values[18] = 16'hfc01; 
assign initial_values[19] = 16'hfc01;
assign initial_values[20] = 16'hfc01;
assign initial_values[21] = 16'hfc01;
assign initial_values[22] = 16'hfc01;
assign initial_values[23] = 16'hfc01;

assign initial_values[24] = 16'hfc01;
assign initial_values[25] = 16'hfc01;
assign initial_values[26] = 16'hfc01; 
assign initial_values[27] = 16'hfc01;
assign initial_values[28] = 16'hfc01;
assign initial_values[29] = 16'hfc01;
assign initial_values[30] = 16'hfc01;
assign initial_values[31] = 16'hfc01;



//assign initial_values[0] = 16'h03ff;
//assign initial_values[1] = 16'h03ff;
//assign initial_values[2] = 16'h03ff; 
//assign initial_values[3] = 16'h03ff;
//assign initial_values[4] = 16'h03ff;
//assign initial_values[5] = 16'h03ff;
//assign initial_values[6] = 16'h03ff;
//assign initial_values[7] = 16'h03ff;
//
//assign initial_values[8] = 16'h03ff;
//assign initial_values[9] = 16'h03ff;
//assign initial_values[10] = 16'h03ff; 
//assign initial_values[11] = 16'h03ff;
//assign initial_values[12] = 16'h03ff;
//assign initial_values[13] = 16'h03ff;
//assign initial_values[14] = 16'h03ff;
//assign initial_values[15] = 16'h03ff;
//
//assign initial_values[16] = 16'h03ff;
//assign initial_values[17] = 16'h03ff;
//assign initial_values[18] = 16'h03ff; 
//assign initial_values[19] = 16'h03ff;
//assign initial_values[20] = 16'h03ff;
//assign initial_values[21] = 16'h03ff;
//assign initial_values[22] = 16'h03ff;
//assign initial_values[23] = 16'h03ff;
//
//assign initial_values[24] = 16'h03ff;
//assign initial_values[25] = 16'h03ff;
//assign initial_values[26] = 16'h03ff; 
//assign initial_values[27] = 16'h03ff;
//assign initial_values[28] = 16'h03ff;
//assign initial_values[29] = 16'h03ff;
//assign initial_values[30] = 16'h03ff;
//assign initial_values[31] = 16'h03ff;


always @(posedge clk, posedge reset) begin

	if (reset) begin
		counter <= 0;
		done <= 0;
	end
	
	else if (counter <31)  begin
		counter <= counter +1'b1;
		done <=0;
	end 
	else begin
		done <=1;
	end


end


always @(*) begin
_real = initial_values[counter];
_imag = 16'b0;
end

reverse
#(.ADDR_WIDTH(5))
reverse_inst
(
.addr_in(counter),
.addr_out(addr)
);



endmodule 