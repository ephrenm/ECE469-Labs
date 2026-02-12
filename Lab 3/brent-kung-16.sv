//16-bit Brent-Kung PPA Adder

module brent_kung_16(
	input logic 	[15:0] 	A, B,
	output logic	[15:0] 	Sum,
	output logic 		Overflow
);

	logic [15:0] p0, g0;

	GPbit gp0_0  (A[0],  B[0],  g0[0],  p0[0]);
	GPbit gp0_1  (A[1],  B[1],  g0[1],  p0[1]);
	GPbit gp0_2  (A[2],  B[2],  g0[2],  p0[2]);
	GPbit gp0_3  (A[3],  B[3],  g0[3],  p0[3]);
	GPbit gp0_4  (A[4],  B[4],  g0[4],  p0[4]);
	GPbit gp0_5  (A[5],  B[5],  g0[5],  p0[5]);
	GPbit gp0_6  (A[6],  B[6],  g0[6],  p0[6]);
	GPbit gp0_7  (A[7],  B[7],  g0[7],  p0[7]);
	GPbit gp0_8  (A[8],  B[8],  g0[8],  p0[8]);
	GPbit gp0_9  (A[9],  B[9],  g0[9],  p0[9]);
	GPbit gp0_10 (A[10], B[10], g0[10], p0[10]);
	GPbit gp0_11 (A[11], B[11], g0[11], p0[11]);
	GPbit gp0_12 (A[12], B[12], g0[12], p0[12]);
	GPbit gp0_13 (A[13], B[13], g0[13], p0[13]);
	GPbit gp0_14 (A[14], B[14], g0[14], p0[14]);
	GPbit gp0_15 (A[15], B[15], g0[15], p0[15]);

	logic [7:0] p1, g1;

	GPblk gp1_0 (g0[1],  p0[1],  g0[0],  p0[0],  g1[0], p1[0]);
	GPblk gp1_1 (g0[3],  p0[3],  g0[2],  p0[2],  g1[1], p1[1]);
	GPblk gp1_2 (g0[5],  p0[5],  g0[4],  p0[4],  g1[2], p1[2]);
	GPblk gp1_3 (g0[7],  p0[7],  g0[6],  p0[6],  g1[3], p1[3]);
	GPblk gp1_4 (g0[9],  p0[9],  g0[8],  p0[8],  g1[4], p1[4]);
	GPblk gp1_5 (g0[11], p0[11], g0[10], p0[10], g1[5], p1[5]);
	GPblk gp1_6 (g0[13], p0[13], g0[12], p0[12], g1[6], p1[6]);
	GPblk gp1_7 (g0[15], p0[15], g0[14], p0[14], g1[7], p1[7]);

	logic [3:0] p2, g2;

	GPblk gpblk2_0(g1[1], p1[1], g1[0], p1[0], g2[0], p2[0]);
	GPblk gpblk2_1(g1[3], p1[3], g1[2], p1[2], g2[1], p2[1]);
	GPblk gpblk2_2(g1[5], p1[5], g1[4], p1[4], g2[2], p2[2]);
	GPblk gpblk2_3(g1[7], p1[7], g1[6], p1[6], g2[3], p2[3]);

	logic [1:0] p3, g3;

	GPblk gpblk3_0(g2[1], p2[1], g2[0], p2[0], g3[0], p3[0]);
	GPblk gpblk3_1(g2[3], p2[3], g2[2], p2[2], g3[1], p3[1]);

	logic  p4, g4;

	GPblk gpblk4_0(g3[1], p3[1], g3[0], p3[0], g4, p4);

	logic  p5, g5;

	GPblk gpblk5_0(g2[2], p2[2], g3[0], p3[0], g5, p5);

	logic [2:0] p6, g6;

	GPblk gpblk6_0(g1[2], p1[2], g2[0], p2[0], g6[0], p6[0]);
	GPblk gpblk6_1(g1[4], p1[4], g3[0], p3[0], g6[1], p6[1]);
	GPblk gpblk6_2(g1[6], p1[6], g5, p5, g6[2], p6[2]);

	logic [6:0] p7, g7;

	GPblk gpblk7_0(g0[2], p0[2], g1[0], p1[0], g7[0], p7[0]);
	GPblk gpblk7_1(g0[4], p0[4], g2[0], p2[0], g7[1], p7[1]);
	GPblk gpblk7_2(g0[6], p0[6], g6[0], p6[0], g7[2], p7[2]);
	GPblk gpblk7_3(g0[8], p0[8], g3[0], p3[0], g7[3], p7[3]);
	GPblk gpblk7_4(g0[10], p0[10], g6[1], p6[1], g7[4], p7[4]);
	GPblk gpblk7_5(g0[12], p0[12], g5, p5, g7[5], p7[5]);
	GPblk gpblk7_6(g0[14], p0[14], g6[2], p6[2], g7[6], p7[6]);

	assign Sum[0] = p0[0];
	SUMbit sum1(p0[1], g0[0], Sum[1]);
	SUMbit sum2(p0[2], g1[0], Sum[2]);
	SUMbit sum3(p0[3], g7[0], Sum[3]);
	SUMbit sum4(p0[4], g2[0], Sum[4]);
	SUMbit sum5(p0[5], g7[1], Sum[5]);
	SUMbit sum6(p0[6], g6[0], Sum[6]);
	SUMbit sum7(p0[7], g7[2], Sum[7]);
	SUMbit sum8(p0[8], g3[0], Sum[8]);
	SUMbit sum9(p0[9], g7[3], Sum[9]);
	SUMbit sum10(p0[10], g6[1], Sum[10]);
	SUMbit sum11(p0[11], g7[4], Sum[11]);
	SUMbit sum12(p0[12], g5, Sum[12]);
	SUMbit sum13(p0[13], g7[5], Sum[13]);
	SUMbit sum14(p0[14], g6[2], Sum[14]);
	SUMbit sum15(p0[15], g7[6], Sum[15]);

	assign Overflow = g4;

endmodule



module GPbit (
	input logic Ai, Bi,
	output logic Gii, Pii);

	assign Gii = Ai & Bi;
	assign Pii = Ai ^ Bi;

endmodule

// GPBlk core module
module GPblk (
	input logic Gik, Pik, Gkj, Pkj,
	output logic Gij, Pij);
	
	assign Pij = Pik & Pkj;
	assign Gij = Gik | (Pik & Gkj);

endmodule

// Sum bit core module
module SUMbit (
	input logic Pi, Gi,
	output logic Si);

	assign Si = Pi ^ Gi;

endmodule