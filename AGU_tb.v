module AGU_tb;


reg clk;

wire [2:0] addr_A_write, addr_B_write, addr_A_read, addr_B_read, addr_Twiddle;
reg start;
wire r0W, done;

//module AGU #(parameter ADDR_WIDTH = 5)
////ADDR_WIDTH = log2(numofsamples)
//(
//    input start, clk, 
//    output reg [ADDR_WIDTH - 1: 0] addr_A, addr_B, addr_Twiddle,
//    output mem_one_WR, mem_two_WR 
//);

//module AGU #(parameter ADDR_WIDTH = 5)
////ADDR_WIDTH = log2(numofsamples)
//(
//    input start, clk, 
//    output reg [ADDR_WIDTH - 1: 0] addr_A_write, addr_B_write, addr_A_read, addr_B_read, addr_Twiddle,
//    output reg r0W,
//	 output done
//);

AGU
#(.ADDR_WIDTH(3))
Test
(
.start(start),
.clk(clk), 
.addr_A_write(addr_A_write), 
.addr_B_write(addr_B_write),
.addr_A_read(addr_A_read), 
.addr_B_read(addr_B_read), 
.addr_Twiddle(addr_Twiddle),
.r0W(r0W),
.done(done)
);


initial begin
start = 0;
clk =0;

end

always begin

clk = 0;
#10;
clk = 1;
#10;

end



always begin
start = 0;
#10;
start = 1;
#1000;
end





endmodule 