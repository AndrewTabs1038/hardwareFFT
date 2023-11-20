module FFT_processor
#(parameter DATA_WIDTH = 16, ADDR_WIDTH = 5) 
(
input clk, start_FFT,
output done_FFT
//output signed [DATA_WIDTH-1:0] A_out
);

wire [ADDR_WIDTH-1:0] addr_A_write, addr_B_write, addr_A_read, addr_B_read;
wire [DATA_WIDTH-1:0] A_real_out, A_imag_out, B_real_out, B_imag_out, twiddleF_r,twiddleF_i, addr_Twiddle;
wire done, roW;

wire [DATA_WIDTH-1:0] A_real_in, A_imag_in, B_real_in, B_imag_in;

wire [DATA_WIDTH-1:0] _real,_imag, real_selected, imag_selected;

wire [ADDR_WIDTH-1:0] init_addr, addr_selected;

ROM 
#(.DATA_WIDTH(DATA_WIDTH))
twiddle_imag
(
.imag(1'b1),
.k(addr_Twiddle),
.twiddle_out(twiddleF_i)
);

ROM 
#(.DATA_WIDTH(DATA_WIDTH))
twiddle_real
(
.imag(1'b0),
.k(addr_Twiddle),
.twiddle_out(twiddleF_r)
);

BFU 
#(.DATA_WIDTH(DATA_WIDTH))
BFU_inst
(
.clk(clk),
.A_in_r(A_real_out),
.B_in_r(A_imag_out),
.A_in_i(B_real_out),
.B_in_i(B_imag_out),
.twiddleF_r(twiddleF_r),
.twiddleF_i(twiddleF_i),  
.A_out_r(A_real_in),
.B_out_r(B_real_in),
.A_out_i(A_imag_in),
.B_out_i(B_imag_in)
);

samples samples_inst
(
.clk(clk), 
.reset(~start_FFT),
.addr(init_addr),
._real(_real),
._imag(_imag),
.done(done)
);

//init data select
memory_MUX
#(.DATA_WIDTH(DATA_WIDTH))
real_in
(
.select(done),
.data_zero(_real),
.data_one(A_real_in),
.data_out(real_selected)
);
memory_MUX
#(.DATA_WIDTH(DATA_WIDTH))
imag_in
(
.select(done),
.data_zero(_imag),
.data_one(A_imag_in),
.data_out(imag_selected)
);

//init addr select
memory_MUX
#(.DATA_WIDTH(ADDR_WIDTH))
addr_in
(
.select(done),
.data_zero(init_addr),
.data_one(addr_A_write),
.data_out(addr_selected)
);

//addr_selected

memory 
#(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH))
mem_inst
(
.clk(clk),
.roW(roW),
.init(done),
.addr_A_write(addr_selected), 
.addr_B_write(addr_B_write),
.addr_A_read(addr_A_read),
.addr_B_read(addr_B_read),
.A_real_in(real_selected),
.A_imag_in(imag_selected),
.B_real_in(B_real_in),
.B_imag_in(B_imag_in),
.A_real_out(A_real_out),
.A_imag_out(A_imag_out),
.B_real_out(B_real_out),
.B_imag_out(B_imag_out)
);

AGU 
#(.ADDR_WIDTH(ADDR_WIDTH))
AGU_inst
(
.start(done), 
.clk(clk), 
.addr_A_read(addr_A_read),
.addr_B_read(addr_B_read),
.addr_Twiddle(addr_Twiddle),
.addr_A_write(addr_A_write),
.addr_B_write(addr_B_write),
.roW(roW),
.done(done_FFT)
);



endmodule
