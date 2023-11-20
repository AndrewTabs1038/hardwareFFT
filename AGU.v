module AGU #(parameter ADDR_WIDTH = 5, parameter DATA_WIDTH = 16)
//ADDR_WIDTH = log2(numofsamples)
(
    input start, clk, 
    output reg [ADDR_WIDTH - 1: 0]  addr_A_read, addr_B_read, 
	 output wire [ADDR_WIDTH - 1: 0] addr_A_write, addr_B_write,
	 output reg [DATA_WIDTH-1:0] addr_Twiddle,
    output reg roW,
	 output done
);
// r0W -> zero if read, one if write


//i is the level number --> 0 to log2(numOfSamples) - 1 or ADDR_WIDTH - 1
//j is the number of pairs -->  0 to (numOfSamples/2) - 1 


reg [ADDR_WIDTH-1:0] i, j, m, n; 
reg [2:0] counter;

assign done = (i == ADDR_WIDTH);


always @* begin
	m = j << 1; // Multiply j by 2
	m = (m << i) | (m >> (ADDR_WIDTH - i)); // Rotates

	n = (j << 1) + 1'b1; // Multiply j by 2 and add 1
	n = (n << i) | (n >> (ADDR_WIDTH - i)); //Rotates

	addr_A_read = m;
	addr_B_read = n;
	addr_Twiddle = j & ~((1'b1 << (ADDR_WIDTH - 1'b1 - i)) - 1'b1); //bit masking
end


 always @(posedge clk, negedge start) begin
// zero if read, one if write
	if(~start) begin
		//reads from memory 1 first
//		mem_one_WR<=0;
//		mem_two_WR<=1;
		roW <=0;
	
		i<=0;
		j<=0;
		
		counter <= 0;
	end
	
	else if(~done) begin
	
		if(j<((2**ADDR_WIDTH)/2)-1) begin
			i<=i;
			j<=j+1'b1;
			counter<=0;
		end
		
		else begin
			
			counter <= counter +1'b1;
			
			if (counter == 5) begin
			
				i<=i+1'b1;
				j<=0;
				
			//Switches read - write
				roW <= ~roW;
//				mem_one_WR<= ~mem_one_WR;
//				mem_two_WR<= ~mem_two_WR;
			end
		
		end
	end
 
 end
  
Delay 
#(.CLKCYCLES(5), .DATA_WIDTH(ADDR_WIDTH))
Addr_A_write_delay
(
.clk(clk), 
.clr(start),
.in(m),
.out(addr_A_write)

);
 
Delay 
#(.CLKCYCLES(5), .DATA_WIDTH(ADDR_WIDTH))
Addr_B_write_delay
(
.clk(clk), 
.clr(start),
.in(n),
.out(addr_B_write)
);

 
 
endmodule
