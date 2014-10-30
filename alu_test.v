/*  alu_test.v
    ECE/ENGRD 2300, Spring 2014
    
    Author: Saugata Ghose
    Last modified: March 28, 2014
    
    Description: Skeleton test bench for ALU circuit.
*/

// sets the granularity at which we simulate
`timescale 1 ns / 1 ps


// name of the top-level module; for us it should always be <module name>_test
// this top-level module should have no inputs or outputs; only internal signals are needed
module alu_test();
	 localparam ADD = 3'd0;
	 localparam SUB = 3'd1;
	 localparam SRA = 3'd2;
	 localparam SRL = 3'd3;
	 localparam SLL = 3'd4;
	 localparam AND = 3'd5;
	 localparam OR = 3'd6;
  // for all of your input pins, declare them as type reg, and name them identically to the pins
  reg  [7:0]  A;
  reg  [7:0]  B;
  reg  [2:0]  OP;

  // for all of your output pins, declare them as type wire so ModelSim can display them
  wire [7:0]  Y;
  wire        C;
  wire        V;
  wire        N;
  wire        Z;

  
  // declare a sub-circuit instance (Unit Under Test) of the circuit that you designed
  // make sure to include all ports you want to see, and connect them to the variables above
  alu UUT(
    .A(A),
    .B(B),
    .OP(OP),
    .Y(Y),
    .C(C),
    .V(V),
    .N(N),
    .Z(Z) // remember - no comma after the last port          
  );

  // ALL of the initial and always blocks below will work in parallel.
  //   Starting at time t = 0, they will all start counting the number
  //   of ticks.

  
  // TEST CASES: add your test cases in the block here
  // REMEMBER: separate each test case by delays that are multiples of #100, so we can see
  //    the output for at least one cycle (since we chose a 10 MHz clock)
  initial
  begin
    // Initial values
    A  = 8'h0;
    B  = 8'h0;
    OP = 3'b000;
     
    // wait at the beginning to make sure that we don't start on a rising clock edge -
    //    this guarantees that we give the flip-flops enough setup time
    #50;
    
    
    // EXAMPLE TEST CASE: this is the beginning of the first test case
    
    // it includes input values...
    A  = 8'h01;
    B  = 8'hff;
    OP = 3'b011;  // SRL
    
    // ... it includes a wait...
    #100;  // wait for input signals to propagate through circuit
    
    // ... and it includes a statement that checks all of the outputs against the values we expect, and prints whether the operation was correct
    $display("MSIM>");
    if(Y == 8'h0 && C == 1'b1 && V == 1'b0 && N == 1'b0 && Z == 1'b1) begin
      $display("MSIM> SRL (OP = %3b) is correct for A = %2h, B = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", OP, A, B, Y, C, V, N, Z);
    end
    else begin
      // note that we have to fill in the expected values by hand here, so we can make sure what our outputs should have been
      $display("MSIM> ERROR: SRL (OP = %3b) is incorrect for A = %2h, B = %2h: Y = %2h (should be 0), C = %1b (should be 1), V = %1b (should be 0), N = %1b (should be 0), Z = %1b (should be 1)", OP, A, B, Y, C, V, N, Z);
    end
    $display("MSIM>");
    
    // EXAMPLE TEST CASE: this is the end of the first test case

    
    A  = 8'haa;
    B  = 8'hc3;
    OP = 3'b101;  // AND
    
    #100;  // wait for input signals to propagate through circuit
    
    $display("MSIM>");
    if(Y == 8'h82 && C == 1'b0 && V == 1'b0 && N == 1'b1 && Z == 1'b0) begin
      $display("MSIM> AND (OP = %3b) is correct for A = %2h, B = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", OP, A, B, Y, C, V, N, Z);
    end
    else begin
      $display("MSIM> ERROR: AND (OP = %3b) is incorrect for A = %2h, B = %2h: Y = %2h (should be 82), C = %1b (should be 0), V = %1b (should be 0), N = %1b (should be 1), Z = %1b (should be 0)", OP, A, B, Y, C, V, N, Z);
    end
    $display("MSIM>");
    
    
    // ADD YOUR TEST CASES BELOW THIS LINE
    //following local parameters should simplify writing test cases
   
	 OP = AND;
	 for(A = 8'd0; A < 8'd8; A = A + 8'd1) begin
		for (B = 8'd0; B < 8'd8; B = B + 8'd1) begin
			#100
			 $display("MSIM>");
    if(Y == (A & B) && C == 1'b0 && V == 1'b0 && Z == (Y == 8'b0)) begin
      $display("MSIM> AND (OP = %3b) is correct for A = %2h, B = %2h: Y = %2h, C = %1b, V = %1b, N = %1b, Z = %1b", OP, A, B, Y, C, V, N, Z);
    end
    else begin
      $display("MSIM> ERROR: AND (OP = %3b) is incorrect for A = %2h, B = %2h: Y = %2h (should be 82), C = %1b (should be 0), V = %1b (should be 0), N = %1b (should be 1), Z = %1b (should be 0)", OP, A, B, Y, C, V, N, Z);
    end
    $display("MSIM>");
		end
	 end
	 
    
    // ADD YOUR TEST CASES ABOVE THIS LINE
    

    // Once our tests are done, we need to tell ModelSim to explicitly stop once we are
    // done with all of our test cases.
    $stop;
  end 

endmodule
