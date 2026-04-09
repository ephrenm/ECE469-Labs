module testbench();

    logic       clk;
    logic [3:0] D_lookup;
    logic       setD;
    logic [3:0] newD;
    logic       init;
    logic [2:0] minAddr;
    logic       found;

    top dut (
        .clk(clk),
        .D_lookup(D_lookup),
        .setD(setD),
        .newD(newD),
        .init(init),
        .minAddr(minAddr),
        .found(found)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        init = 1;
        D_lookup = 4'b0000;
        setD = 0;
        newD = 4'b0000;
        #10; 
        init = 0;
        #10; 

        D_lookup = 4'b1011; 
        setD = 0;
        #10;

        D_lookup = 4'b1011;
        setD = 1;
        newD = 4'b1110;    
        #10;

        D_lookup = 4'b1110;
        setD = 0;
        #10;

        D_lookup = 4'b1011;
        setD = 0;
        #10;

        D_lookup = 4'b1110;
        setD = 1;
        newD = 4'b1010;     
        #10;

        D_lookup = 4'b1010; 
        setD = 0;
        #10;
    end

endmodule
