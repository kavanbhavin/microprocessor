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
  wire LA;
  wire LR;
  wire LOP;
  wire BSEL;
  wire [7:0] B_IN;
  wire CSEL;
  wire CARRY_IN;
  wire [7:0] logic_out;
  wire [7:0] shifter_out;
  wire [1:0] OSEL;
  wire logic_c;
  wire shifter_c;
  wire logic_v;
  wire shifter_v;
  assign N = Y[7] ? 1'b1 : 1'b0;
  assign Z = (Y == 8'd0) ? 1'b1 : 1'b0;
  
  two_to_one_mux #(.DATA_WIDTH(8)) bselect(
		.I0(B),
		.I1(~B),
		.SELECT(BSEL),
		.DATA(B_IN)
  );
  
  two_to_one_mux #(.DATA_WIDTH(1)) ciselect(
		.I0(1'b0),
		.I1(1'b0),
		.SELECT(CSEL),
		.DATA(CARRY_IN)
  );
  
  three_to_one_mux #(.DATA_WIDTH(8)) outselect(
		.I0(),
		.I1(shifter_out),
		.I2(logic_out),
		.SELECT(OSEL),
		.OUT(Y)
  );
  
  three_to_one_mux #(.DATA_WIDTH(1)) coutselect(
		.I0(),
		.I1(shifter_c),
		.I2(logic_c),
		.SELECT(OSEL),
		.OUT(C)
  );
  
  three_to_one_mux #(.DATA_WIDTH(1)) voutselect(
		.I0(),
		.I1(shifter_v),
		.I2(logic_v),
		.SELECT(OSEL),
		.OUT(V)
  );
  
  control freak(
    .OP(OP), 
	 .CISEL(CSEL), 
	 .BISEL(BSEL), 
	 .OSEL(OSEL),
	 .SHIFT_LA(LA), 
	 .SHIFT_LR(LR), 
	 .LOGICAL_OP(LOP)
  );
	
  logical paradox(
    .A(A), 
	 .B(B_IN),
	 .OP(LOP),
	 .Y(logic_out),
	 .C(logic_c),
	 .V(logic_v)
  );  
  
  shifter iDontGiveAShift(
    .A(A), 
	 .LA(LA), 
	 .LR(LR), 
	 .Y(shifter_out), 
	 .C(shifter_c),
	 .V(shifter_v)
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