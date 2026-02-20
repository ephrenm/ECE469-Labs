//testbench code
module testbench();
 logic clk, reset;
 logic [31:0] a, b, y, y_expected;
 logic [2:0] f;
 logic zero, zero_expected;
 logic [31:0] vectornum, errors; 
 logic [3:0] testvectors[10000:0]; 

alu dut(a, b, f, y, zero);

 always 
   begin
     clk = 1; #5; clk = 0; #5;
   end

initial
  begin
    $readmemb("alu.tv", testvectors);
    vectornum = 0; errors = 0;
    reset = 1; #27; reset = 0; //reset for a few cycles
  end

 always @(posedge clk)
  begin
    #1; {f, a, b, y_expected, zero_expected} = testvectors[vectornum];
  end

 always @(negedge clk) begin
  if (~reset) begin 
    if (y !== y_expected) begin
      $display("Error: inputs = %b", {a, b, c});
      $display(" outputs = %b (%b expected)",y,y_expected);
      errors = errors + 1;
    end

    vectornum = vectornum + 1;
    if (testvectors[vectornum] === 4'bx) begin
      $display("%d tests completed with %d errors",
      vectornum, errors);
     $finish;
    end
   end
  end

endmodule
