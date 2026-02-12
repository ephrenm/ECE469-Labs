//16-bit Subtractor Module
//Uses 16 chained full subtractors

module subtractor_16(
	input logic 	[15:0] 	A, B,
	output logic	[15:0] 	Difference,
	output logic 		Overflow
);

	logic [15:0] borrow;

	full_subtractor sub0_0 (A[0], B[0], 1'b0, Difference[0], borrow[0]);
	full_subtractor sub0_1  (A[1],  B[1],  borrow[0],  Difference[1],  borrow[1]);
	full_subtractor sub0_2  (A[2],  B[2],  borrow[1],  Difference[2],  borrow[2]);
	full_subtractor sub0_3  (A[3],  B[3],  borrow[2],  Difference[3],  borrow[3]);
	full_subtractor sub0_4  (A[4],  B[4],  borrow[3],  Difference[4],  borrow[4]);
	full_subtractor sub0_5  (A[5],  B[5],  borrow[4],  Difference[5],  borrow[5]);
	full_subtractor sub0_6  (A[6],  B[6],  borrow[5],  Difference[6],  borrow[6]);
	full_subtractor sub0_7  (A[7],  B[7],  borrow[6],  Difference[7],  borrow[7]);
	full_subtractor sub0_8  (A[8],  B[8],  borrow[7],  Difference[8],  borrow[8]);
	full_subtractor sub0_9  (A[9],  B[9],  borrow[8],  Difference[9],  borrow[9]);
	full_subtractor sub0_10 (A[10], B[10], borrow[9],  Difference[10], borrow[10]);
	full_subtractor sub0_11 (A[11], B[11], borrow[10], Difference[11], borrow[11]);
	full_subtractor sub0_12 (A[12], B[12], borrow[11], Difference[12], borrow[12]);
	full_subtractor sub0_13 (A[13], B[13], borrow[12], Difference[13], borrow[13]);
	full_subtractor sub0_14 (A[14], B[14], borrow[13], Difference[14], borrow[14]);
	full_subtractor sub0_15 (A[15], B[15], borrow[14], Difference[15], borrow[15]);

	assign Overflow = borrow[15];

endmodule

module full_subtractor(
	input logic 	a, b, borrow_in,
	output logic 	diff, borrow_out
);

	assign diff = a ^ b ^ borrow_in;

	assign borrow_out = (~a & b) | (~(a ^ b) & borrow_in);

endmodule
