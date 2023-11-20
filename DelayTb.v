 
module DelayTb;

reg [10:0] din;
wire [10:0]dout;
reg clk, clr;

Delay
#(4,11)
Test
(
.clk(clk),
.clr(clr),
.in(din),
.out(dout)
);

initial begin 

clr = 0;
din = 11'b10101010101;

end


always begin
clk = 0;
#10;
clk = 1;
#10;

end

always begin

clr = 0;
#10;
clr = 1;
#100;

end



endmodule 