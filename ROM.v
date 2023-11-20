module ROM 
#(parameter DATA_WIDTH = 16)
(
input imag,
input [DATA_WIDTH - 1:0] k,
output reg [DATA_WIDTH -1:0] twiddle_out
);

//Use python file to assist in generateing the LUT.



always @(*) begin

	if(imag) begin
		case(k) 
			0: twiddle_out <= 16'h0;

			1: twiddle_out <= 16'h18f8;

			2: twiddle_out <= 16'h30fb;

			3: twiddle_out <= 16'h471c;

			4: twiddle_out <= 16'h5a82;

			5: twiddle_out <= 16'h6a6d;

			7: twiddle_out <= 16'h7d8a;

			8: twiddle_out <= 16'h7fff;

			9: twiddle_out <= 16'h7d8a;

			10: twiddle_out <= 16'h7641;

			11: twiddle_out <= 16'h6a6d;

			12: twiddle_out <= 16'h5a82;

			13: twiddle_out <= 16'h471c;

			14: twiddle_out <= 16'h30fb;

			15: twiddle_out <= 16'h18f8;
			
			default: twiddle_out <= 16'h0000;
		endcase	
	
	end
	
	else begin
		case(k)
			0: twiddle_out <= 16'h7fff;

			1: twiddle_out <= 16'h7d8a;

			2: twiddle_out <= 16'h7641;

			3: twiddle_out <= 16'h6a6d;

			4: twiddle_out <= 16'h5a82;

			5: twiddle_out <= 16'h471c;

			6: twiddle_out <= 16'h30fb;

			7: twiddle_out <= 16'h18f8;

			8: twiddle_out <= 16'h0;

			9: twiddle_out <= 16'he708;

			10: twiddle_out <= 16'hcf05;

			11: twiddle_out <= 16'hb8e4;

			12: twiddle_out <= 16'ha57e;

			13: twiddle_out <= 16'h9593;

			14: twiddle_out <= 16'h89bf;

			15: twiddle_out <= 16'h8276;
			
			default: twiddle_out <= 16'h0000;

		endcase 
	
	end

end





endmodule 