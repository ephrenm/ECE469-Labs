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
	
	always #5 clk = ~clk;
	
	initial begin
		$display("Initializing");
	
		clk = 0;
        init = 0;
        swapnow = 0;
        x = 0;
        y = 0;
		
		//test 1:
		#10; //wait for next negative edge
		init = 1;
		#10; init = 0; swapnow = 1; x = 4'd0; y = 4'd7;
		#10; swapnow = 1; x = 4'd1; y = 4'd6;
		#10; swapnow = 1; x = 4'd2; y = 4'd5;
		#10; swapnow = 1; x = 4'd3; y = 4'd4;
		#10; swapnow = 0;
		#20;
		
		init = 1;
		#10; init = 0; swapnow = 1; x = 4'd0; y = 4'd1;
		#10; swapnow = 1; x = 4'd1; y = 4'd2;
		#10; swapnow = 1; x = 4'd2; y = 4'd3;
		#10; swapnow = 1; x = 4'd3; y = 4'd4;
		#10; swapnow = 1; x = 4'd4; y = 4'd5;
		#10; swapnow = 1; x = 4'd5; y = 4'd6;
		#10; swapnow = 1; x = 4'd6; y = 4'd7;
		#10; swapnow = 0;
		#20;
		
		init = 1;
		#10; init = 0; swapnow = 1; x = 4'd0; y = 4'd3;
		#10; swapnow = 1; x = 4'd2; y = 4'd5;
		#10; swapnow = 1; x = 4'd3; y = 4'd6;
		#10; swapnow = 1; x = 4'd4; y = 4'd6;
		#10; swapnow = 1; x = 4'd5; y = 4'd7;
		#10; swapnow = 0;
		#20;
		
		$display("Finished");
		$stop;
		
	end
	
endmodule
		