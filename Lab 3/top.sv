//top

module top (

	input 	logic	[16:0] 	A, B,

	output 	logic	[16:0]	S, D,
	output	logic		OF_S, OF_D
);

	logic 		A_lt_B;	

	comparator comp0 (A[15:0], B[15:0], A_lt_B);

	logic [15:0] 	adder_sum; //intermediate adder output
	logic 		adder_OF;

	brent_kung_16 adder0 (A[15:0], B[15:0], adder_sum[15:0], adder_OF);

	logic [15:0]	sub_A, sub_B, sub_diff; //intermediate sub output
	logic 		sub_OF;

	subtractor_16 sub0 (sub_A[15:0], sub_B[15:0], sub_diff[15:0], sub_OF);

	logic		sign_xor; //detects when A & B have same sign

	assign sign_xor = A[16] ^ B[16]; //0 when same sign

	assign S[15:0] = sign_xor ? sub_diff[15:0] : adder_sum[15:0]; //Sum should come from adder when A[16] = B[16]
	assign OF_S = sign_xor ? sub_OF : adder_OF;

	assign D[15:0] = sign_xor ? adder_sum[15:0] : sub_diff[15:0];
	assign OF_D = sign_xor ? adder_OF : sub_OF;

	assign sub_A[15:0] = A_lt_B ? B[15:0] : A[15:0];	//A and B should be flipped on subtractor when A < B
	assign sub_B[15:0] = A_lt_B ? A[15:0] : B[15:0];

	assign S[16] = (A_lt_B & B[16]) | (~A_lt_B & A[16]) | (A[16] & B[16]);	//sum of minterms determining where sum should come from
	assign D[16] = (~A_lt_B & A[16]) | (A_lt_B & ~B[16]) | (A[16] & ~B[16]);

endmodule


module comparator (
	
	input 	logic	[15:0]	A, B,
	output	logic		A_lt_B
);

	assign A_lt_B = (A < B);

endmodule
