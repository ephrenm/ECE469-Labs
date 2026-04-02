// Example testbench for MIPS processor

module testbench();

  logic        clk;
  logic        reset;

  logic [31:0] writedata, dataadr;
  logic        memwrite;

  // instantiate device to be tested
  top dut(clk, reset, writedata, dataadr, memwrite);
  
  // initialize test
  initial
    begin
      reset <= 1; # 22; reset <= 0;
    end

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end

  // check that 7 gets written to address 84
  always@(negedge clk)
    begin
      if(memwrite) begin
        if(dataadr === 20 & writedata === 28) begin
          $display("Simulation succeeded");
          $stop;
        end else if (dataadr !== 52 & dataadr !== 32 & dataadr !== 28 & dataadr !== 24) begin //dataadr 52, 32, 28 and 24 will be written during normal operation
          $display("Simulation failed");
          $stop;
        end
      end
    end
endmodule



