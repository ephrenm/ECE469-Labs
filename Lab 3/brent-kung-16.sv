//16-bit Brent-Kung PPA Adder

module brent_kung_16(
	input logic 	[15:0] 	A, B,
	output logic	[15:0] 	Sum,
	output logic 		Overflow
);

	logic [16:0] c_out;

	logic [15:0] p0, g0;

	genvar i;

	generate
	    for (i=0; i < 15; i = i + 1) begin
	    	GPbit gp0 (A[i], B[i], g0[i], p0[i]);
	    end
	endgenerate

	logic [7:0] p1, g1;

	generate
	    for (i=0; i < 7; i = i + 1) begin
	    	GPblk gp1 (g0[(2*i)+1], p0[(2*i)+1], g0[(2*i)], p0[(2*i)], g1[i], p1[i]);
	    end
	endgenerate

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
	assign Pii = Ai | Bi;

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