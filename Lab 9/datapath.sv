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
	
	
	flopenr #(32) pc_reg(clk, reset, pcen, pcnext, pc); 					//pc_reg
	mux2  #(32) adr_mux(pc, aluout, iord, adr); 							//adr select mux
	
	flopenr #(32) instr_reg(clk, reset, irwrite, readdata, instr);			//instr reg
	flopr	#(32) data_reg(clk, reset, readdata, data);						//data reg
	
	mux2 #(5) a3_mux(instr[20:16], instr[15:11], regdst, writereg); 		//a3 mux
	mux2 #(32) wd3_mux(aluout, data, memtoreg, wd3);						//wd3 mux
	
	regfile register_file(clk, regwrite, instr[25:21], instr[20:16],		//reg file
							writereg, wd3, rd1, rd2);
							
	flopr #(32) a_reg(clk, reset, rd1, a);									//A reg
	flopr #(32) b_reg(clk, reset, rd2, writedata);							//B reg
	
	mux2 #(32) srcA_mux(pc, a, alusrca, srca); 								//srcA select mux
							
	signext sign_extender(instr[15:0], signimm); 							//signext
	
	sl2 immext_shifter(signimm, signimmsh);									//sign extend left shift
	
	mux4 #(32) srcB_mux(writedata, 32'd4, signimm, signimmsh, alusrcb, srcb); //srcB select mux
	
	alu alu(srca, srcb, alucontrol, aluresult, zero);						 //ALU
	
	flopr #(32) alu_reg(clk, reset, aluresult, aluout);						//aluout reg
	
	mux3 #(32) pcnext_mux(aluresult, aluout, {pc[31:28], instr[25:0], 2'b00}, pcsrc, pcnext); //PC' mux
	
	
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

//regfile from lab 6
module regfile(input  logic        clk, we3, 
               input  logic [4:0]  ra1, ra2, wa3, 
               input  logic [31:0] wd3, 
               output logic [31:0] rd1, rd2);

  logic [31:0] rf[31:0];

  // three ported register file with register 0 hardwired to 0
  // read two ports combinationally; write third port on rising edge of clock

  always_ff @(posedge clk)
    if (we3) rf[wa3] <= wd3;	

  assign rd1 = (ra1 != 0) ? rf[ra1] : 0;
  assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
endmodule

//signext from lab 6
module signext(input  logic [15:0] a,
               output logic [31:0] y);
              
  assign y = {{16{a[15]}}, a};
endmodule

//mux2 from lab6
module mux2 #(parameter WIDTH = 8)
             (input  logic [WIDTH-1:0] d0, d1, 
              input  logic             s, 
              output logic [WIDTH-1:0] y);

  assign y = s ? d1 : d0; 
endmodule

//shift left by 2 from lab 6
module sl2(input  logic [31:0] a,
           output logic [31:0] y);

  assign y = {a[29:0], 2'b00}; 		// shift left by 2
endmodule

//flop w/ reset from lab 6
module flopr #(parameter WIDTH = 8)
              (input  logic             clk, reset,
               input  logic [WIDTH-1:0] d, 
               output logic [WIDTH-1:0] q);

  always_ff @(posedge clk, posedge reset)
    if (reset) q <= 0;
    else       q <= d;
endmodule

//flop w/ reset & enab;e from lab 6
module flopenr #(parameter WIDTH = 8)
                (input  logic             clk, reset, en,
                 input  logic [WIDTH-1:0] d, 
                 output logic [WIDTH-1:0] q);
 
  always_ff @(posedge clk, posedge reset)
    if      (reset) q <= 0;
    else if (en)    q <= d;
endmodule