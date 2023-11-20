module readWrite_tb;


reg clk ,start;
wire done, roW;


reg [2:0] A_real_in, A_imag_in, B_real_in, B_imag_in;

wire [2:0] A_real, A_imag, B_real, B_imag;


wire [2:0] addr_A_write, addr_B_write, addr_A_read, addr_B_read, addr_Twiddle;
wire [2:0] A_real_out, A_imag_out, B_real_out, B_imag_out;


initial begin
	A_real_in = 1;
	A_imag_in = 2;
	B_real_in = 3;
	B_imag_in = 4;

end

always begin

	clk = 0;
	#10;
	A_real_in = A_real_in +1'b1;
	A_imag_in = A_imag_in +1'b1;
	B_real_in = B_real_in +1'b1;
	B_imag_in = B_imag_in +1'b1;
	clk = 1;
	#10;
end

always begin

	start = 0;
	#10;
	start = 1;
	#1000;
end

//always begin
//
////	#160;
////	A_real_in = A_real_in +1'b1;
////	A_imag_in = A_imag_in +1'b1;
////	B_real_in = B_real_in +1'b1;
////	B_imag_in = B_imag_in +1'b1;
////	#300;
//	
//end

//A_real, A_imag, B_real, B_imag

memory 
#(.DATA_WIDTH(3), .ADDR_WIDTH(3))
Test_mem
(
.clk(clk),
.roW(roW),
.addr_A_write(addr_A_write), 
.addr_B_write(addr_B_write),
.addr_A_read(addr_A_read),
.addr_B_read(addr_B_read),
.A_real_in(A_real),
.A_imag_in(A_imag),
.B_real_in(B_real),
.B_imag_in(B_imag),
.A_real_out(A_real_out),
.A_imag_out(A_imag_out),
.B_real_out(B_real_out),
.B_imag_out(B_imag_out)
);


AGU 
#(.ADDR_WIDTH(3))
Test_AGU
(
.start(start), 
.clk(clk), 
.addr_A_read(addr_A_read),
.addr_B_read(addr_B_read),
.addr_Twiddle(addr_Twiddle),
.addr_A_write(addr_A_write),
.addr_B_write(addr_B_write),
.roW(roW),
.done(done)
);

// r0W -> zero if read, one if write

//input clk, clr,
//input [DATA_WIDTH-1:0] in,
//output wire [DATA_WIDTH-1:0] out

Delay 
#(.CLKCYCLES(4), .DATA_WIDTH(3))
A_r_d
(
.clk(clk),
.clr(1'b1),
.in(A_real_in),
.out(A_real)
);

//A_real_in, A_imag_in, B_real_in, B_imag_in
//A_real, A_imag, B_real, B_imag
Delay 
#(.CLKCYCLES(4), .DATA_WIDTH(3))
A_i_d
(
.clk(clk),
.clr(1'b1),
.in(A_imag_in),
.out(A_imag)
);

Delay 
#(.CLKCYCLES(4), .DATA_WIDTH(3))
B_r_d
(
.clk(clk),
.clr(1'b1),
.in(B_real_in),
.out(B_real)
);

Delay 
#(.CLKCYCLES(4), .DATA_WIDTH(3))
B_i_d
(
.clk(clk),
.clr(1'b1),
.in(B_imag_in),
.out(B_imag)
);

                   
endmodule 