module logical(A, B, OP, Y, C, V);
 

  // inputs
  input [7:0] A;
  input [7:0] B;
  input OP;
  
  // outputs
  output [7:0] Y;
  output C;
  output V;
  
  // reg and internal variable definitions
  
  // implement module here
  assign Y = OP ? A & B : A | B;
  assign C = 1'b0;
  assign V = 1'b0;
  
endmodule