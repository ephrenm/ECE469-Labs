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
		case (state)
			4'b1100: begin
				rec_C = 1'b1; 
				rec_6 = 1'b0; 
				rec_E = 1'b0; 
				rec_4 = 1'b1; 
				rec_9 = 1'b0;
				end
			
			4'b0100: begin
				rec_C = 1'b0; 
				rec_6 = 1'b0; 
				rec_E = 1'b0; 
				rec_4 = 1'b1; 
				rec_9 = 1'b0;
				end
				
			4'b1110: begin
				rec_C = 1'b0; 
				rec_6 = 1'b1; 
				rec_E = 1'b1; 
				rec_4 = 1'b0; 
				rec_9 = 1'b0;
				end
				
			4'b0110: begin
				rec_C = 1'b0; 
				rec_6 = 1'b1; 
				rec_E = 1'b0; 
				rec_4 = 1'b0; 
				rec_9 = 1'b0;
				end
				
			4'b1001: begin
				rec_C = 1'b0; 
				rec_6 = 1'b0; 
				rec_E = 1'b0; 
				rec_4 = 1'b0; 
				rec_9 = 1'b1;
				end
				
			default: begin
				rec_C = 1'b0; 
				rec_6 = 1'b0; 
				rec_E = 1'b0; 
				rec_4 = 1'b0; 
				rec_9 = 1'b0;
				end
				
		endcase
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