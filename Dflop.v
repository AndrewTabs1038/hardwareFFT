module Dflop 
#(parameter WIDTH = 16)
(
input clk,clr,
input [WIDTH-1:0] D,
output reg [WIDTH-1:0] Q
);


always @(posedge clk, negedge clr) begin
	
	if (~clr)begin
		Q <= {WIDTH{1'b0}};
	end
	else begin
		Q <= D;
	end
	

end


endmodule 