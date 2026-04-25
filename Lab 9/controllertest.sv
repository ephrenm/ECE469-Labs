module controllertest();

    logic       clk, reset;
    logic [5:0] op, funct;
    logic       zero;

    logic       pcen, memwrite, irwrite, regwrite;
    logic       alusrca, iord, memtoreg, regdst;
    logic [1:0] alusrcb, pcsrc;
    logic [2:0] alucontrol;

    controller dut (
        .clk(clk), .reset(reset),
        .op(op), .funct(funct), .zero(zero),
        .pcen(pcen), .memwrite(memwrite), .irwrite(irwrite), .regwrite(regwrite),
        .alusrca(alusrca), .iord(iord), .memtoreg(memtoreg), .regdst(regdst),
        .alusrcb(alusrcb), .pcsrc(pcsrc), .alucontrol(alucontrol)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0; 
        reset = 1; 
        op = 6'b0; 
        funct = 6'b0; 
        zero = 0;

        @(negedge clk);
        reset = 0;

        // Test 1: ADD (R-Type) - 4 Cycles
        @(negedge clk);
        op = 6'b000000; funct = 6'b100000; zero = 0;
        repeat(4) @(negedge clk);

        // Test 2: SUB (R-Type) - 4 Cycles
        op = 6'b000000; funct = 6'b100010; zero = 0;
        repeat(4) @(negedge clk);

        // Test 3: AND (R-Type) - 4 Cycles
        op = 6'b000000; funct = 6'b100100; zero = 0;
        repeat(4) @(negedge clk);

        // Test 4: OR (R-Type) - 4 Cycles
        op = 6'b000000; funct = 6'b100101; zero = 0;
        repeat(4) @(negedge clk);

        // Test 5: SLT (R-Type) - 4 Cycles
        op = 6'b000000; funct = 6'b101010; zero = 0;
        repeat(4) @(negedge clk);

        // Test 6: LW - 5 Cycles
        op = 6'b100011; funct = 6'bxxxxxx; zero = 0;
        repeat(5) @(negedge clk);

        // Test 7: SW - 4 Cycles
        op = 6'b101011; funct = 6'bxxxxxx; zero = 0;
        repeat(4) @(negedge clk);

        // Test 8: BEQ (Not Taken) - 3 Cycles
        op = 6'b000100; funct = 6'bxxxxxx; zero = 0;
        repeat(3) @(negedge clk);

        // Test 9: BEQ (Taken) - 3 Cycles
        op = 6'b000100; funct = 6'bxxxxxx; zero = 1;
        repeat(3) @(negedge clk);

        // Test 10: ADDI - 4 Cycles
        op = 6'b001000; funct = 6'bxxxxxx; zero = 0;
        repeat(4) @(negedge clk);

        // Test 11: J - 3 Cycles
        op = 6'b000010; funct = 6'bxxxxxx; zero = 0;
        repeat(3) @(negedge clk);

        $stop;
    end
endmodule