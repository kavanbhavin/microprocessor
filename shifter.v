module shifter(A, LA, LR, Y, C, V); // add all inputs and outputs inside parentheses

  // inputs
  input [7:0] A;
  input LA;
  input LR;
  
  // outputs
  output [7:0] Y;
  output C;
  output V;
  
  // reg and internal variable definitions
  reg [7:0] Y;
  reg C;
  
  // implement module here
  assign V = 1'b0;
  always @(*) begin
  if(~LR) begin
  //left direction so automatically we have to do logical shift left
		Y[0] = 1'b0;  
		Y[1] = A[0];
		Y[2] = A[1];
		Y[3] = A[2];
		Y[4] = A[3];
		Y[5] = A[4];
		Y[6] = A[5];
		Y[7] = A[6];
		C = A[7];
  end
  else if(LA) begin
  //arithmetic shift right
		Y[0] = A[1]; 
		Y[1] = A[2];
		Y[2] = A[3];
		Y[3] = A[4];
		Y[4] = A[5];
		Y[5] = A[6];
		Y[6] = A[7];
		Y[7] = A[7];
		C = A[0];
  end
  else begin
  // logical shift right
		Y[0] = A[1];   
		Y[1] = A[2];
		Y[2] = A[3];
		Y[3] = A[4];
		Y[4] = A[5];
		Y[5] = A[6];
		Y[6] = A[7];
		Y[7] = 1'b0;
		C = A[0];
  end
		
  end
  
endmodule