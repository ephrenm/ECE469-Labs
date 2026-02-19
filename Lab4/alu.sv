//Code for ALU
module alu(
  input logic [31:0] A, B,
  input logic [2:0] F,
  output logic [31:0] Y,
  output logic zero
);
  
  logic [31:0] invB, BB, adder_out, or_out, and_out, zext_out;
  
  assign invB=~B;
  assign BB=(F[2]) ? invB : B;

  assign or_out = BB | A;
  assign and_out = BB & A;
  //needs adder/subtractor
  
  //needs zero extender

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
endmodule

    
  
  
  
  
