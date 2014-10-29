module alu(A, B, OP, Y, C, V, N, Z, HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
  input  [7:0]  A;
  input  [7:0]  B;
  input  [2:0]  OP;

  output [7:0]  Y;
  output        C;
  output        V;
  output        N;
  output        Z;
  output [6:0]  HEX7;
  output [6:0]  HEX6;
  output [6:0]  HEX5;
  output [6:0]  HEX4;
  output [6:0]  HEX3;
  output [6:0]  HEX2;
  output [6:0]  HEX1;
  output [6:0]  HEX0;



  // ADD YOUR CODE BELOW THIS LINE
  
  control freak(
    // port mappings go here
  );

  logical paradox(
    // port mappings go here
  );  
  
  shifter iDontGiveAShift(
    // port mappings go here
  );

  // ADD YOUR CODE ABOVE THIS LINE



  // SEVEN-SEGMENT DISPLAY DRIVERS

  // replace unused segments with code to disable display
  assign HEX5 = 7'b1111111;
  assign HEX4 = 7'b1111111;
  assign HEX3 = 7'b1111111;
  assign HEX2 = 7'b1111111;
  assign HEX1 = 7'b1111111;
  assign HEX0 = 7'b1111111;

  hex_to_seven_seg upperBitsOfY(
    .B(Y[7:4]),
    .SSEG_L(HEX7)
  );

  hex_to_seven_seg lowerBitsOfY(
    .B(Y[3:0]),
    .SSEG_L(HEX6)
  );

endmodule