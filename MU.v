module MU 
#(parameter DATA_WIDTH = 16, ADDR_WIDTH = 5)
(
input clk, roW, singlewrite,
input [ADDR_WIDTH -1:0] A_addr, B_addr,
input [DATA_WIDTH -1:0] A_real_in, A_imag_in, B_real_in, B_imag_in,
output wire [DATA_WIDTH -1:0] A_real_out, A_imag_out, B_real_out, B_imag_out
);
// r0W -> zero if read, one if write

RAM
#(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH))
_real
(
.clk(clk),
.roW(roW),
.singlewrite(singlewrite),
.data_in_A(A_real_in),
.data_in_B(B_real_in),
.A_addr(A_addr),
.B_addr(B_addr),
.data_out_A(A_real_out),
.data_out_B(B_real_out)
);

RAM
#(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH))
_imag
(
.clk(clk),
.roW(roW),
.singlewrite(singlewrite),
.data_in_A(A_imag_in),
.data_in_B(B_imag_in),
.A_addr(A_addr),
.B_addr(B_addr),
.data_out_A(A_imag_out),
.data_out_B(B_imag_out)
);


endmodule 
