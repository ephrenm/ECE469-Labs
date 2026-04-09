module top (
	input logic			clk, init, setD,
	input logic	[3:0] 	D_lookup, newD,
	
	output logic [2:0]	minAddr,
	output logic		found
);

	logic [7:0][3:0] CAM_reg;
	logic [7:0] match;
	
	match_check match0(D_lookup, CAM_reg[0], match[0]);
	match_check match1(D_lookup, CAM_reg[1], match[1]);
	match_check match2(D_lookup, CAM_reg[2], match[2]);
	match_check match3(D_lookup, CAM_reg[3], match[3]);
	match_check match4(D_lookup, CAM_reg[4], match[4]);
	match_check match5(D_lookup, CAM_reg[5], match[5]);
	match_check match6(D_lookup, CAM_reg[6], match[6]);
	match_check match7(D_lookup, CAM_reg[7], match[7]);
	
	always_ff @(posedge clk or posedge init) begin
		if (init) begin
			CAM_reg[0] <= 4'h8;
			CAM_reg[1] <= 4'h9;
			CAM_reg[2] <= 4'hA;
			CAM_reg[3] <= 4'hB;
			CAM_reg[4] <= 4'hC;
			CAM_reg[5] <= 4'hD;
			CAM_reg[6] <= 4'hE;
			CAM_reg[7] <= 4'hF;
		end else if (setD) begin
			if (match[0]) CAM_reg[0] <= newD;
			if (match[1]) CAM_reg[1] <= newD;
			if (match[2]) CAM_reg[2] <= newD;
			if (match[3]) CAM_reg[3] <= newD;
			if (match[4]) CAM_reg[4] <= newD;
			if (match[5]) CAM_reg[5] <= newD;
			if (match[6]) CAM_reg[6] <= newD;
			if (match[7]) CAM_reg[7] <= newD;
		end
	end
	
	assign found = |(match[7:0]);
	
	always_comb begin
		if      (match[0]) minAddr = 3'd0;
		else if (match[1]) minAddr = 3'd1;
		else if (match[2]) minAddr = 3'd2;
		else if (match[3]) minAddr = 3'd3;
		else if (match[4]) minAddr = 3'd4;
		else if (match[5]) minAddr = 3'd5;
		else if (match[6]) minAddr = 3'd6;
		else if (match[7]) minAddr = 3'd7;
		else begin
			minAddr = 3'd0;
		end
	end
	
endmodule



module match_check (
	input logic [3:0] 	D_lookup, Q,
	
	output logic 		found
);

	assign found = &(~(D_lookup ^ Q));
	
endmodule