module reverse
#(parameter ADDR_WIDTH = 5)
(
input [ADDR_WIDTH -1: 0] addr_in,
output reg [ADDR_WIDTH -1: 0]  addr_out
);


integer i;
always @* begin
	for (i = 0; i < ADDR_WIDTH; i = i + 1) begin
		addr_out [i] = addr_in[ADDR_WIDTH - 1 - i];
	end
end


endmodule 