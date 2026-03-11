module top(
	input 	logic clk, init, swapnow,
	input 	logic [2:0] x, y,
	
	output 	logic [7:0][3:0] r
);

	always_ff @(posedge clk) begin
		if (init) begin
			r[0] = 4'd0;            //for loop also works here:
			r[1] = 4'd1;			//for (int i = 0; i<8; i++) begin
			r[2] = 4'd2;			//	r[i] = i[3:0]
			r[3] = 4'd3;			//end
			r[4] = 4'd4;
			r[5] = 4'd5;			//is this method allowed?
			r[6] = 4'd6;
			r[7] = 4'd7;
		end
		else if (swapnow) begin
			r[x] <= r[y];
			r[y] <= r[x];
		end
	end

endmodule	
	