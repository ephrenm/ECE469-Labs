module CLA (
	input 	logic[15:0] 	A, B,
	output 	logic[15:0] 	Sum, Diff,
	output 	logic		OF_S, OF_D, LessThan);

	logic g0, g1, g2, g3, g4, g5, g6, g7, g8, g9, g10, g11, g12, g13, g14, g15;
	logic p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15;

	GPbit gpbit0(A[0], B[0], g0, p0);
	GPbit gpbit1(A[1], B[1], g1, p1);
	GPbit gpbit2(A[2], B[2], g2, p2);
	GPbit gpbit3(A[3], B[3], g3, p3);
	GPbit gpbit4(A[4], B[4], g4, p4);
	GPbit gpbit5(A[5], B[5], g5, p5);
	GPbit gpbit6(A[6], B[6], g6, p6);
	GPbit gpbit7(A[7], B[7], g7, p7);
	GPbit gpbit8(A[8], B[8], g8, p8);
	GPbit gpbit9(A[9], B[9], g9, p9);
	GPbit gpbit10(A[10], B[10], g10, p10);
	GPbit gpbit11(A[11], B[11], g11, p11);
	GPbit gpbit12(A[12], B[12], g12, p12);
	GPbit gpbit13(A[13], B[13], g13, p13);
	GPbit gpbit14(A[14], B[14], g14, p14);
	GPbit gpbit15(A[15], B[15], g15, p15);

	logic g1_0, g3_2, g5_4, g7_6, g9_8, g11_10, g13_12, g15_14;
	logic p1_0, p3_2, p5_4, p7_6, p9_8, p11_10, p13_12, p15_14;

	GPblk gpblk1_0(g1, p1, g0, p0, g1_0, p1_0);
	GPblk gpblk3_2(g3, p3, g2, p2, g3_2, p3_2);
	GPblk gpblk5_4(g5, p5, g4, p4, g5_4, p5_4);
	GPblk gpblk7_6(g7, p7, g6, p6, g7_6, p7_6);
	GPblk gpblk9_8(g9, p9, g8, p8, g9_8, p9_8);
	GPblk gpblk11_10(g11, p11, g10, p10, g11_10, p11_10);
	GPblk gpblk13_12(g13, p13, g12, p12, g13_12, p13_12);
	GPblk gpblk15_14(g15, p15, g14, p14, g15_14, p15_14);

	logic g3_0, g7_4, g11_8, g15_12;
	logic p3_0, p7_4, p11_8, p15_12;
	
	GPblk gpblk3_0(g3_2, p3_2, g1_0, p1_0, g3_0, p3_0);
	GPblk gpblk7_4(g7_6, p7_6, g5_4, p5_4, g7_4, p7_4);
	GPblk gpblk11_8(g11_10, p11_10, g9_8, p9_8, g11_8, p11_8);
	GPblk gpblk15_12(g15_14, p15_14, g13_12, p13_12, g15_12, p15_12);

	logic g7_0, g15_8;
	logic p7_0, p15_8;

	GPblk gpblk7_0(g7_4, p7_4, g3_0, p3_0, g7_0, p7_0);
	GPblk gpblk15_8(g15_12, p15_12, g11_8, p11_8, g15_8, p15_8);

	logic g15_0;
	logic p15_0;

	GPblk gpblk15_0(g15_8, p15_8, g7_0, p7_0, g15_0, p15_0);

	logic c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16;
	
	assign c0 = 1'b0;

	CARRY carry1(g0, p0, c0, c1);
	CARRY carry2(g1_0, p1_0, c1, c2);
	CARRY carry3(g2, p2, c2, c3);
	CARRY carry4(g3_0, p3_0, c0, c4);
	CARRY carry5(g4, p4, c4, c5);
	CARRY carry6(g5_4, p5_4, c4, c6);
	CARRY carry7(g6, p6, c6, c7);
	CARRY carry8(g7_0, p7_0, c0, c8);
	CARRY carry9(g8, p8, c8, c9);
	CARRY carry10(g9_8, p9_8, c8, c10);
	CARRY carry11(g10, p10, c10, c11);
	CARRY carry12(g11_8, p11_8, c8, c12);
	CARRY carry13(g12, p12, c12, c13);
	CARRY carry14(g13_12, p13_12, c12, c14);
	CARRY carry15(g14, p14, c14, c15);
	CARRY carry16(g15_0, p15_0, c0, c16);	

	SUMbit sum0(A[0], B[0], c0, Sum[0]);
	SUMbit sum1(A[1], B[1], c1, Sum[1]);
	SUMbit sum2(A[2], B[2], c2, Sum[2]);
	SUMbit sum3(A[3], B[3], c3, Sum[3]);
	SUMbit sum4(A[4], B[4], c4, Sum[4]);
	SUMbit sum5(A[5], B[5], c5, Sum[5]);
	SUMbit sum6(A[6], B[6], c6, Sum[6]);
	SUMbit sum7(A[7], B[7], c7, Sum[7]);
	SUMbit sum8(A[8], B[8], c8, Sum[8]);
	SUMbit sum9(A[9], B[9], c9, Sum[9]);
	SUMbit sum10(A[10], B[10], c10, Sum[10]);
	SUMbit sum11(A[11], B[11], c11, Sum[11]);
	SUMbit sum12(A[12], B[12], c12, Sum[12]);
	SUMbit sum13(A[13], B[13], c13, Sum[13]);
	SUMbit sum14(A[14], B[14], c14, Sum[14]);
	SUMbit sum15(A[15], B[15], c15, Sum[15]);

	assign OF_S = c16;

endmodule

module GPbit (
	input logic Ai, Bi,
	output logic Gii, Pii);

	assign Gii = Ai & Bi;
	assign Pii = Ai | Bi;

endmodule

module GPblk (
	input logic Gik, Pik, Gkj, Pkj,
	output logic Gij, Pij);
	
	assign Pij = Pik & Pkj;
	assign Gij = Gik | (Pik & Gkj);

endmodule

module SUMbit (
	input logic Ai, Bi, Cin,
	output logic Si);

	assign Si = Ai ^ Bi ^ Cin;

endmodule

module CARRY (
	input logic Gij, Pij, Cj,
	output logic Cii);

	assign Cii = Gij | (Pij & Cj);

endmodule