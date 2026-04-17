module datapath (
	input 	logic 			clk, reset,
	input 	logic 			pcen, irwrite, regwrite,
	input 	logic 			alusrca, iord, memtoreg, regdst,
	input 	logic [1:0] 	alusrcb, pcsrc,
	input 	logic [2:0] 	alucontrol,
	output 	logic [5:0] 	op, funct,
	output 	logic 			zero,
	output 	logic [31:0] 	adr, writedata,
	input 	logic [31:0] 	readdata
);

	// Below are the internal signals of the datapath module.
	logic [4:0] writereg;
	logic [31:0] pcnext, pc;
	logic [31:0] instr, data, srca, srcb;
	logic [31:0] a;
	logic [31:0] aluresult, aluout;
	logic [31:0] signimm; // the sign-extended immediate
	logic [31:0] signimmsh; // the sign-extended immediate shifted left by 2
	logic [31:0] wd3, rd1, rd2;
	
	// op and funct fields to controller
	assign op = instr[31:26];
	assign funct = instr[5:0];
	
	// Your datapath hardware goes below. Instantiate each of the submodules
	// that you need. Remember that alu's, mux's and various other
	// versions of parameterizable modules are available in textbook 7.6
	
	// Here, parameterizable 3:1 and 4:1 muxes are provided below for your use.
	
	// Remember to give your instantiated modules applicable names
	// such as pcreg (PC register), wdmux (Write Data Mux), etc.
	// so it's easier to understand.
	
	// ADD CODE HERE
	
	// datapath
	
endmodule

module mux3 #(parameter WIDTH = 8)
		     (input logic [WIDTH-1:0] d0, d1, d2,
			  input logic [1:0] s,
			  output logic [WIDTH-1:0] y);
			  
	assign #1 y = s[1] ? d2 : (s[0] ? d1 : d0);
	
endmodule


module mux4 #(parameter WIDTH = 8)
			 (input logic [WIDTH-1:0] d0, d1, d2, d3,
			  input logic [1:0] s,
			  output logic [WIDTH-1:0] y);
			  
	always_comb
		case(s)
			2'b00: y = d0;
			2'b01: y = d1;
			2'b10: y = d2;
			2'b11: y = d3;
		endcase

endmodule