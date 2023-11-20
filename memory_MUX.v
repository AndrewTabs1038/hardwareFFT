module memory_MUX
#(parameter DATA_WIDTH = 16)
(
input select,
input [DATA_WIDTH -1:0] data_zero, data_one,
output reg [DATA_WIDTH - 1:0] data_out
);

always @(*) begin

	if(select) begin
		data_out = data_one;
	end
	else begin
		data_out = data_zero;
	end


end



endmodule 