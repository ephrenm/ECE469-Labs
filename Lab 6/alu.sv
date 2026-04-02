//Code for ALU
module alu(
  input logic [31:0] a, b,
  input logic [2:0] f,
  output logic [31:0] y,
  output logic zero, OF
);
  
  logic [31:0] invB, BB, or_out, and_out, zext_out, S;
  logic		   Cout;

  //Mux1
  assign invB=~b;
  assign BB=(f[2]) ? invB : b;

  //Gate logic using Mux result and a
  assign or_out = BB | a;
  assign and_out = BB & a;
  
  //adder/subtractor
  assign {Cout, S} = a + BB + f[2];

  assign OF = (~a[31] & ~BB[31] & S[31]) | (a[31] & BB[31] & ~S[31]);
  
  //zero extender for both SLT and SLTI
  assign zext_out = {31'b0, (S[31] ^ OF)};

  //Mux2
  always_comb
    begin
      case(f[1:0])
        2'b00: y=and_out;
        2'b01: y=or_out;
        2'b10: y=S;
        2'b11: y=zext_out;
        default: y=32'b0;
      endcase
    end

  //Zero identifier
  assign zero = ~|y;
  
endmodule

    
  
  
  
  
