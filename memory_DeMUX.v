module memory_DeMUX
#(parameter DATA_WIDTH = 16)
(
input select,
input [DATA_WIDTH -1:0] data_in,
output reg [DATA_WIDTH - 1:0] data_zero, data_one
);


always @(*) begin

	if(select) begin
		data_one = data_in;
		data_zero = 0;
	end
	else begin
		data_zero = data_in;
		data_one = 0;
	end


end



endmodule 