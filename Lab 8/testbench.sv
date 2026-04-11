module testbench;
    logic reset;
    logic clk;
    logic d; 

    logic rec_C, rec_E, rec_4, rec_6, rec_9;

    top dut (
        .reset(reset),
        .clk(clk),
        .d(d),
        .rec_C(rec_C),
        .rec_E(rec_E),
        .rec_4(rec_4),
        .rec_6(rec_6),
        .rec_9(rec_9)
    );

    always #5 clk = ~clk;

    logic [0:19] test_seq = 20'b01100011110011011101; 
    integer i;

    initial begin
        clk = 0;
        reset = 1;
        d = 0;

        #15;
        reset = 0;

        for (i = 0; i < 20; i = i + 1) begin
            @(negedge clk);
            d = test_seq[i];
        end

        #20;
        
        $display("Example testbench simulation complete.");
        $stop; 
    end

endmodule