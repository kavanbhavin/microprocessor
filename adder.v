module adder(A,B,CI,Y,C,V); // add all inputs and outputs inside parentheses

  // inputs
  input [7:0] A;
  input [7:0] B;
  input 		  CI;
  
  // outputs
  output [7:0] Y;
  output 		C;
  output			V;
  
  // reg and internal variable definitions
  
  wire [6:0] CARRY;

  // implement module here
  
  assign V = (CARRY[6]&(~C))|((~CARRY[6])&C);
  
  // helper modules
  
  fulladder S0(
  .X(A[0]),
  .Y(B[0]),
  .CIN(CI),
  .S(Y[0]),
  .COUT(CARRY[0])
  );
  
  fulladder S1(
  .X(A[1]),
  .Y(B[1]),
  .CIN(CARRY[0]),
  .S(Y[1]),
  .COUT(CARRY[1])
  );

  fulladder S2(
  .X(A[2]),
  .Y(B[2]),
  .CIN(CARRY[1]),
  .S(Y[2]),
  .COUT(CARRY[2])
  );

   fulladder S3(
  .X(A[3]),
  .Y(B[3]),
  .CIN(CARRY[2]),
  .S(Y[3]),
  .COUT(CARRY[3])
  );
 
  fulladder S4(
  .X(A[4]),
  .Y(B[4]),
  .CIN(CARRY[3]),
  .S(Y[4]),
  .COUT(CARRY[4])
  );
 
  fulladder S5(
  .X(A[5]),
  .Y(B[5]),
  .CIN(CARRY[4]),
  .S(Y[5]),
  .COUT(CARRY[5])
  );
 
  fulladder S6(
  .X(A[6]),
  .Y(B[6]),
  .CIN(CARRY[5]),
  .S(Y[6]),
  .COUT(CARRY[6])
  );
 
  fulladder S7(
  .X(A[7]),
  .Y(B[7]),
  .CIN(CARRY[6]),
  .S(Y[7]),
  .COUT(C)
  ); 
  
  
endmodule