module control(OP, CISEL); // add other inputs and outputs here

  // inputs (add others here)
  input  [2:0]  OP;
  
  // outputs (add others here)
  output        CISEL;

  // reg and internal variable definitions
  
  
  // implement module here (add other control signals below)
  assign CISEL = (OP == 3'b001) ? 1'b1 : 1'b0;
  
endmodule