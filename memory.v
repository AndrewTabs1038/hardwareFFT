module memory 
#(parameter DATA_WIDTH = 16, ADDR_WIDTH = 5)
(
input clk, roW, init,
input [ADDR_WIDTH -1:0] addr_A_write, addr_B_write, addr_A_read, addr_B_read,
input [DATA_WIDTH -1:0] A_real_in, A_imag_in, B_real_in, B_imag_in,
output [DATA_WIDTH -1:0] A_real_out, A_imag_out, B_real_out, B_imag_out
);

reg read_one;

//When init is zero we want read_one to be 1, else it is roW
always @(*) begin
	if(~init) begin
		read_one = 1;
	end
	else begin
		read_one = roW;
	end

end



// roW -> zero if read, one if write

//read_one -> 0 when if reading from memory_one
//reg [ADDR_WIDTH - 1:0] Mask;
wire [DATA_WIDTH - 1:0] temp_one_r_A, temp_one_r_B, temp_one_i_A, temp_one_i_B; // High if reading from A
wire [DATA_WIDTH - 1:0] temp_two_r_A, temp_two_r_B, temp_two_i_A, temp_two_i_B;

wire [DATA_WIDTH - 1:0] one_r_A, one_r_B, one_i_A, one_i_B;
wire [DATA_WIDTH - 1:0] two_r_A, two_r_B, two_i_A, two_i_B;

wire [ADDR_WIDTH - 1:0] read_write_A_one, read_write_B_one;
wire [ADDR_WIDTH - 1:0] read_write_A_two, read_write_B_two;


memory_MUX
#(.DATA_WIDTH(DATA_WIDTH))
mux_out_r_A
(
.select(read_one),
.data_zero(temp_one_r_A),
.data_one(temp_two_r_A),
.data_out(A_real_out)
);

memory_MUX
#(.DATA_WIDTH(DATA_WIDTH))
mux_out_i_A
(
.select(read_one),
.data_zero(temp_one_i_A),
.data_one(temp_two_i_A),
.data_out(A_imag_out)
);

memory_MUX
#(.DATA_WIDTH(DATA_WIDTH))
mux_out_r_B
(
.select(read_one),
.data_zero(temp_one_r_B),
.data_one(temp_two_r_B),
.data_out(B_real_out)
);

memory_MUX
#(.DATA_WIDTH(DATA_WIDTH))
mux_out_i_B
(
.select(read_one),
.data_zero(temp_one_i_B),
.data_one(temp_two_i_B),
.data_out(B_imag_out)
);


//Selects input
memory_DeMUX
#(.DATA_WIDTH(DATA_WIDTH))
demux_A_r
(
.select(read_one),
.data_in(A_real_in),
.data_zero(two_r_A),
.data_one(one_r_A)
);

memory_DeMUX
#(.DATA_WIDTH(DATA_WIDTH))
demux_A_i
(
.select(read_one),
.data_in(A_imag_in),
.data_zero(two_i_A),
.data_one(one_i_A)
);

memory_DeMUX
#(.DATA_WIDTH(DATA_WIDTH))
demux_B_r
(
.select(read_one),
.data_in(B_real_in),
.data_zero(two_r_B),
.data_one(one_r_B)
);

memory_DeMUX
#(.DATA_WIDTH(DATA_WIDTH))
demux_B_i
(
.select(read_one),
.data_in(B_imag_in),
.data_zero(two_i_B),
.data_one(one_i_B)
);


//Selects read and write addrs
memory_MUX
#(.DATA_WIDTH(ADDR_WIDTH))
mux_addr_A_one
(
.select(read_one),
.data_zero(addr_A_read),
.data_one(addr_A_write),
.data_out(read_write_A_one)
);

memory_MUX
#(.DATA_WIDTH(ADDR_WIDTH))
mux_addr_B_one 
(
.select(read_one),
.data_zero(addr_B_read),
.data_one(addr_B_write),
.data_out(read_write_B_one)
);

memory_MUX
#(.DATA_WIDTH(ADDR_WIDTH))
mux_addr_A_two
(
.select(read_one),
.data_zero(addr_A_write),
.data_one(addr_A_read),
.data_out(read_write_A_two)
);

memory_MUX
#(.DATA_WIDTH(ADDR_WIDTH))
mux_addr_B_two
(
.select(read_one),
.data_zero(addr_B_write),
.data_one(addr_B_read),
.data_out(read_write_B_two)
);


MU 
#(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH))
memory_one
(
.clk(clk),
.roW(read_one),
.singlewrite(~init),
.A_addr(read_write_A_one), 
.B_addr(read_write_B_one),
.A_real_in(one_r_A),
.A_imag_in(one_i_A),
.B_real_in(one_r_B),
.B_imag_in(one_i_B),
.A_real_out(temp_one_r_A),
.A_imag_out(temp_one_i_A), 
.B_real_out(temp_one_r_B), 
.B_imag_out(temp_one_i_B)
);

MU 
#(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH))
memory_two
(
.clk(clk),
.roW(~read_one),
.singlewrite(1'b0),
.A_addr(read_write_A_two), 
.B_addr(read_write_B_two),
.A_real_in(two_r_A),
.A_imag_in(two_i_A),
.B_real_in(two_r_B),
.B_imag_in(two_i_B),
.A_real_out(temp_two_r_A),
.A_imag_out(temp_two_i_A), 
.B_real_out(temp_two_r_B), 
.B_imag_out(temp_two_i_B)
);





endmodule 