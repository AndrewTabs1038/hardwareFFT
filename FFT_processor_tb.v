module FFT_processor_tb;

reg clk, start_FFT;
wire done_FFT;



FFT_processor Test
(
.clk(clk),
.start_FFT(start_FFT),
.done_FFT(done_FFT)
);

initial begin
clk =0;
start_FFT = 0;
end

always begin
start_FFT = 0;
#10;
start_FFT = 1;
#10000;
end

always begin
clk = 0;
#10;
clk = 1;
#10;



end



endmodule 








