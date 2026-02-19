//Code for ALU
module alu(
  input logic [31:0] A, B,
  input logic [2:0] F,
  output logic [31:0] Y,
  output logic zero
);
  
  logic [31:0] invB, BB, adder, or1, and1, zext;
  
  assign invB=~B;
  assign BB=(F[2]) ? invB : B;

  assign or1 = BB | A;
  assign and1 = BB & A;
  assign 
  
  
  
  
  
