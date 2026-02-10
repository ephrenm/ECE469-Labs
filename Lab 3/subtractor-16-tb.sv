`timescale 1ns / 1ps

module tb_subtractor_16;

    // -------------------------------------------------------------------------
    // 1. Signal Declarations
    // -------------------------------------------------------------------------
    // Inputs to DUT (Device Under Test)
    logic [15:0] A;
    logic [15:0] B;

    // Outputs from DUT
    logic [15:0] Difference;
    logic Overflow; // In unsigned arithmetic, this acts as "Borrow Out"

    // Testbench Variables
    int errors = 0;
    int i; // Loop iterator

    // -------------------------------------------------------------------------
    // 2. Instantiate the DUT
    // -------------------------------------------------------------------------
    subtractor_16 dut (
        .A(A),
        .B(B),
        .Difference(Difference),
        .Overflow(Overflow)
    );

    // -------------------------------------------------------------------------
    // 3. Verification Task
    // -------------------------------------------------------------------------
    // This task calculates the expected result and compares it to the DUT output.
    task check_result(input string test_name);
        logic [15:0] expected_diff;
        logic expected_borrow;
        
        // Behavioral model: What the answer SHOULD be
        expected_diff = A - B;
        
        // In unsigned subtraction, Borrow is high if A < B
        expected_borrow = (A < B) ? 1'b1 : 1'b0;

        // Allow time for logic to propagate through the ripple chain
        #10; 

        // Check outputs
        if ((Difference !== expected_diff) || (Overflow !== expected_borrow)) begin
            $error("FAIL: %s | A: %d, B: %d", test_name, A, B);
            $display("      Expected Diff: %h, Got: %h", expected_diff, Difference);
            $display("      Expected Borrow: %b, Got: %b", expected_borrow, Overflow);
            errors++;
        end else begin
            $display("PASS: %s | %d - %d = %d (Borrow: %b)", test_name, A, B, Difference, Overflow);
        end
    endtask

    // -------------------------------------------------------------------------
    // 4. Stimulus Generation
    // -------------------------------------------------------------------------
    initial begin
        $display("---------------------------------------------------");
        $display("Starting Testbench for 16-bit Unsigned Subtractor");
        $display("---------------------------------------------------");

        // Initialize Inputs
        A = 0; B = 0;
        #10;

        // --- Case 1: Simple Subtraction (No Borrow) ---
        A = 16'd50; B = 16'd20;
        check_result("Simple Sub");

        // --- Case 2: Zero Result ---
        A = 16'd100; B = 16'd100;
        check_result("Identity");

        // --- Case 3: Underflow (Borrow Generation) ---
        // 20 - 50 = -30. In 16-bit unsigned, this wraps around.
        // The Borrow/Overflow bit should be HIGH.
        A = 16'd20; B = 16'd50;
        check_result("Underflow");

        // --- Case 4: Maximum Value ---
        A = 16'hFFFF; B = 16'd1;
        check_result("Max Minus 1");

        // --- Case 5: Zero Inputs ---
        A = 0; B = 0;
        check_result("Zeros");

        // --- Case 6: Random Testing ---
        $display("--- Starting Random Tests ---");
        for (i = 0; i < 20; i++) begin
            A = $random;
            B = $random;
            check_result($sformatf("Rand #%0d", i));
        end

        // -------------------------------------------------------------------------
        // 5. Final Report
        // -------------------------------------------------------------------------
        $display("---------------------------------------------------");
        if (errors == 0)
            $display("SUCCESS: All tests passed.");
        else
            $display("FAILURE: %0d errors found.", errors);
        $display("---------------------------------------------------");
        
        $finish;
    end

endmodule
