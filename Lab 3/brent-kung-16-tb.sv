`timescale 1ns/1ps

module tb_brent_kung_16;

    // -------------------------------------------------------------------------
    // 1. Signal Declarations
    // -------------------------------------------------------------------------
    logic [15:0] A, B;
    logic [15:0] Sum;
    logic        C_out; // Mapping 'Overflow' to Carry Out

    // Variables for verification
    logic [16:0] expected_result;
    int          error_count = 0;
    int          test_count = 0;
    int          i; // Loop variable

    // -------------------------------------------------------------------------
    // 2. DUT Instantiation
    // -------------------------------------------------------------------------
    brent_kung_16 dut (
        .A(A),
        .B(B),
        .Sum(Sum),
        .Overflow(C_out) 
    );

    // -------------------------------------------------------------------------
    // 3. Verification Task
    // -------------------------------------------------------------------------
    task check_result;
        input string test_name;
        begin
            // Calculate expected result using behavioral addition
            // We cast A and B to 17 bits to capture the carry out behaviorally
            expected_result = {1'b0, A} + {1'b0, B};

            #1; // Small delay for logic settling

            if ({C_out, Sum} !== expected_result) begin
                $display("FAIL: %s | A: %h + B: %h", test_name, A, B);
                $display("      Expected: %h | Got: %h (C_out: %b Sum: %h)", 
                       expected_result, {C_out, Sum}, C_out, Sum);
                error_count = error_count + 1;
            end 
            test_count = test_count + 1;
        end
    endtask

    // -------------------------------------------------------------------------
    // 4. Test Stimulus
    // -------------------------------------------------------------------------
    initial begin
        $display("---------------------------------------------------");
        $display("Starting Verification of 16-bit Brent-Kung Adder");
        $display("---------------------------------------------------");

        // --- DIRECTED TESTS (Corner Cases) ---
        
        // Test 1: Zero + Zero
        A = 16'h0000; B = 16'h0000;
        check_result("Zero Check");

        // Test 2: Max Value + 0
        A = 16'hFFFF; B = 16'h0000;
        check_result("Max Value Check");

        // Test 3: Max Value + 1 (Trigger Carry Out)
        A = 16'hFFFF; B = 16'h0001;
        check_result("Carry Out Trigger");

        // Test 4: Alternating Bits (0xAAAA + 0x5555) -> Should result in 0xFFFF
        A = 16'hAAAA; B = 16'h5555;
        check_result("Alternating Bits 1");

        // Test 5: Inverse Alternating (0x5555 + 0xAAAA)
        A = 16'h5555; B = 16'hAAAA;
        check_result("Alternating Bits 2");

        // Test 6: Mid-range Carry Propagation
        // 0000 0000 1111 1111 + 0000 0000 0000 0001 = 0000 0001 0000 0000
        A = 16'h00FF; B = 16'h0001;
        check_result("Mid-Carry Prop");

        // --- RANDOMIZED TESTS (Replaced std::randomize with $random) ---
        $display("Running 10,000 randomized test vectors...");
        
        for (i = 0; i < 10000; i = i + 1) begin
            // $random returns a 32-bit signed integer. 
            // We assign it to 16-bit regs, which automatically truncates it.
            A = $random; 
            B = $random;
            check_result("Random");
        end

        // --- FINAL REPORT ---
        $display("---------------------------------------------------");
        if (error_count == 0) begin
            $display("VERIFICATION SUCCESS: All %0d tests passed.", test_count);
        end else begin
            $display("VERIFICATION FAILED: Found %0d errors in %0d tests.", error_count, test_count);
        end
        $display("---------------------------------------------------");
        
        $finish;
    end

endmodule
