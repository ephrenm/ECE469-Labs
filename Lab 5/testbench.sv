`timescale 1ns/100ps

module testbench();
	
	logic			clk, init, swapnow;
	logic 	[2:0]	x, y;
	logic	[7:0][3:0]	r;

	top dut (	
		.clk(clk),
		.init(init),
		.swapnow(swapnow),
		.x(x),
		.y(y),
		.r(r)
	);
	
	initial begin
		
		$display("Initializing");
	
		clk = 0; init = 0; swapnow = 0;
		#1;
		init = 1;
		#1;
		clk = 1;
		#5
		
		$display("Finished");
		$stop;
		
	end
	
endmodule
		