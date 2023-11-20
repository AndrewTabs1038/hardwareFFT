module sample_access_tb;


wire [15:0] _real, _imag;

reg clk, reset;
wire [2:0] addr;

//module samples 
//(
//input clk, reset,
//output reg [2:0] addr,
//output reg [15:0] _real, _imag
//);

samples Test
(
.clk(clk),
.reset(reset),
.addr(addr),
._real(_real),
._imag(_imag)
);

initial begin
clk = 0;
reset = 1;
end

always begin
clk = 0;
#10;
clk = 1;
#10;
end

always begin
reset = 1;
#5;
reset = 0;
#1000;
end 


endmodule 