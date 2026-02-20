//Code for ALU
module alu(
  input logic [31:0] A, B,
  input logic [2:0] F,
  output logic [31:0] Y,
  output logic zero
);
  
  logic [31:0] invB, BB, adder_out, or_out, and_out, zext_out;

  //code for Mux1
  assign invB=~B;
  assign BB=(F[2]) ? invB : B;

  //Gate logic using Mux result and A
  assign or_out = BB | A;
  assign and_out = BB & A;
  
  //adder/subtractor
  assign {Cout, S} = A + BB + F[2];
  
  //zero extender
  assign zext_out = {31'b0, adder_out[31]}

  always_comb
    begin
      case(F[1:0])
        2'b00: Y=and_out;
        2'b01: Y=or_out;
        2'b10: Y=S;
        2'b11: Y=slt_res;
        default: Y=32'b0;
      endcase
    end

  assign zero = ~|Y;
  
endmodule

    
  
  
  
  
