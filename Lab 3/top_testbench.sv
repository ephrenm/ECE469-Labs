//Code for the cases from the testbench table
module top_testbench();
	//Initiates logic
  logic [16:0] a, b;
  logic [16:0] sum, diff;
  logic of_s, of_d;

	//calls CLA_Arithetic_Module
    top dut(a,b,sum,diff,of_s,of_d);

	//start of test
    initial begin 

		$display ("Simulation begin.");
		//prints out results for each variable for every case
		$monitor("a=%s%0d | b=%s%0d | sum=%s%0d | of_s=%b | diff=%s%0d | of_d=%b", 
    			(a[16] ? "-" : "+"), a[15:0], 
    			(b[16] ? "-" : "+"), b[15:0], 
    			(sum[16] ? "-" : "+"), sum[15:0], 
   			of_s, 
    			(diff[16] ? "-" : "+"), diff[15:0], 
    			of_d);

		//Case 1 
		a=17'b0_0000_0000_0000_0011 ; b=17'b0_0000_0000_0000_0001  ; #10;

		//Case 2 
		a=17'b0_0000_0000_0000_0001 ; b=17'b0_1111_1111_1111_1111 ; #10;

		//Case 3 
		a=17'b0_1111_1111_1111_1111 ; b=17'b1_0000_0000_0000_0001 ; #10;

		//Case 4 
		a=17'b0_0000_0000_0000_0100 ; b=17'b1_0111_1111_1111_1111 ; #10;

		//Case 5 
		a=17'b1_0000_0000_0000_0100 ; b=17'b0_0111_1111_1111_1111 ; #10;

		//Case 6 
		a=17'b1_1111_1111_1111_1111 ; b=17'b0_0000_0000_0000_0001 ; #10;

		//Case 7 
		a=17'b1_0000_0000_0000_0001 ; b=17'b1_1111_1111_1111_1111 ; #10;

		//Case 8 
		a=17'b1_0000_0000_0110_0100 ; b=17'b1_0000_0000_0011_0010; ; #10;

		//end of test
		$display ("Simulation end.");
		
    end
endmodule
