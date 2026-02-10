//16-bit Subtractor Module
//Uses 16 chained full subtractors

module subtractor_16(
	input logic 	[15:0] 	A, B,
	output logic	[15:0] 	Difference,
	output logic 		Overflow
);

	logic [15:0] borrow;

	full_subtractor sub0 (A[0], B[0], 1'b0, Difference[0], borrow[0]);

	genvar i;

	generate
	    for (i=1; i < 16; i = i + 1) begin : sub
	    	full_subtractor sub0 (A[i], B[i], borrow[i-1], Difference[i], borrow[i]);
	    end
	endgenerate

	assign Overflow = borrow[15];

endmodule

module full_subtractor(
	input logic 	a, b, borrow_in,
	output logic 	diff, borrow_out
);

	assign diff = a ^ b ^ borrow_in;

	assign borrow_out = (~a & b) | (~(a ^ b) & borrow_in);

endmodule
