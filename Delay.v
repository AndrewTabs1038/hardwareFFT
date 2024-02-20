module Delay
#(parameter DATA_WIDTH = 16, CLKCYCLES = 4)
(
input clk, clr,
input [DATA_WIDTH-1:0] in,
output [DATA_WIDTH-1:0] out
);

wire [DATA_WIDTH-1:0] temp [CLKCYCLES-1:0];

genvar i;

generate

		Dflop 
		#(DATA_WIDTH) 
		first
		(
			 .clk(clk),
			 .clr(clr),
			 .D(in),
			 .Q(temp[0])
		);

    for (i = 1; i < CLKCYCLES; i = i + 1) begin : SHIFT_REGISTER_LOOP
        Dflop
		  #(DATA_WIDTH)
		  loops (
            .clk(clk),
            .clr(clr),
            .D(temp[i-1]),
            .Q(temp[i])
        );
    end
	 
	 assign out = temp[CLKCYCLES-1];

 
endgenerate

//out = temp[CLKCYCLES-1];

endmodule
