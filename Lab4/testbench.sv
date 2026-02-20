module testbench();
  logic        clk;
  logic [2:0]  F;
  logic [31:0] A, B;
  logic [31:0] Y, Y_expected;
  logic        zero, zero_expected;
  
  logic [31:0] vector_num, errors;
  logic [103:0] testvectors[1000:0]; 
  
  logic [3:0] F_pad;
  logic [3:0] zero_pad;

  alu dut (
    .A(A), 
    .B(B), 
    .F(F), 
    .Y(Y), 
    .zero(zero)
  );

  always begin
    clk = 1; #5; clk = 0; #5;
  end

  initial begin
    $readmemh("alu.tv", testvectors);
    vector_num = 0;
    errors = 0;
  end

  always @(posedge clk) begin
    #1; 
    {F_pad, A, B, Y_expected, zero_pad} = testvectors[vector_num];
    
    F = F_pad[2:0];
    zero_expected = zero_pad[0];
  end

  always @(negedge clk) begin
    if (testvectors[vector_num] === 104'bx) begin
      $display("Simulation completed with %d errors.", errors);
      $stop; 
    end
    else begin
      if (Y !== Y_expected || zero !== zero_expected) begin
        $display("Error at vector %d: F=%h, A=%h, B=%h", vector_num, F, A, B);
        $display("  Outputs : Y=%h, zero=%b", Y, zero);
        $display("  Expected: Y=%h, zero=%b", Y_expected, zero_expected);
        errors = errors + 1;
      end
      vector_num = vector_num + 1;
    end
  end
endmodule