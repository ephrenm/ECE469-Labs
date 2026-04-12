module top (
	input logic 	reset, clk, d,
	
	output logic 	rec_C, rec_E, rec_4, rec_6, rec_9
);

	logic [3:0] state;
	logic [3:0] next_state;

	always_comb begin
		//next state logic:
		next_state = {state[2:0], d};
		
		//output logic:	
		rec_C = ~state[0] & ~state[1] & state[2] & state[3];
		rec_E = ~state[0] & state[1] & state[2] & state[3];
		rec_4 = ~state[0] & ~state[1] & state[2];
		rec_6 = ~state[0] & state[1] & state[2];
		rec_9 = state[0] & ~state[1] & ~state[2] & state[3];
	end
	
	always_ff @(posedge clk) begin
		//state FF:
		if(reset) begin
			state <= 4'h0;
		end else begin
			state <= next_state;
		end
	end

endmodule