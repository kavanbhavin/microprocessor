module lab5(CLK50, RESET, CLK_SEL, IOA, IOB, EN_L, CLK, PC, NextPC, Iin, DataA, DataB, DataC, DataD, Din, MW, IOC, IOD, IOE, IOF, IOG, IOH, LEDARRAYRED, LEDARRAYGREEN, HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
  input         CLK50;
  input         RESET;
  input         CLK_SEL;
  input  [7:0]  IOA;
  input  [7:0]  IOB;
  input         EN_L;
  
  output        CLK;
  output [7:0]  PC;
  output [7:0]  NextPC;
  output [15:0] Iin;
  output [7:0]  DataA;
  output [7:0]  DataB;
  output [7:0]  DataC;
  output [7:0]  DataD;
  output [7:0]  Din;
  output        MW;
  output [7:0]  IOC;
  output [7:0]  IOD;
  output [7:0]  IOE;
  output [7:0]  IOF;
  output [7:0]  IOG;
  output [7:0]  IOH;
  output [17:0] LEDARRAYRED;
  output [8:0]  LEDARRAYGREEN;
  output [6:0]  HEX7;
  output [6:0]  HEX6;
  output [6:0]  HEX5;
  output [6:0]  HEX4;
  output [6:0]  HEX3;
  output [6:0]  HEX2;
  output [6:0]  HEX1;
  output [6:0]  HEX0;
  
  
  
  cpu aRealProcessorOMGZ(
    .CLK(CLK),
    .RESET(RESET),
    .PC(PC),
    .NextPC(NextPC),
    .Iin(Iin),
    .DataA(DataA),
    .DataB(DataB),
    .DataC(DataC),
    .DataD(DataD),
    .Din(Din),
    .MW(MW),
    .EN_L(EN_L)
  );
    
  // BELOW IS THE ONLY LINE YOU SHOULD HAVE TO MODIFY IN THIS FILE
  lab5iram leProgramToRun(
    .CLK(CLK),
    .RESET(RESET),
    .ADDR(PC),
    .Q(Iin)
  );

  lab5dram memoriesPressedBetweenThePagesOfMyMind(
    .CLK(CLK),
    .RESET(RESET),
    .ADDR(DataD),
    .DATA(DataB),
    .MW(MW),
    .Q(Din),
    .IOA(IOA),
    .IOB(IOB),
    .IOC(IOC),
    .IOD(IOD),
    .IOE(IOE),
    .IOF(IOF),
    .IOG(IOG),
    .IOH(IOH)
  );



  // VARIABLE CLOCK MODULE
  var_clk clockGenerator(
    .clock_50MHz(CLK50),
    .clock_sel({CLK_SEL, CLK_SEL, CLK_SEL}),
    .var_clock(CLK)
  );
  
  // LED ARRAY LOGIC
  assign LEDARRAYRED[17]    = CLK;
  assign LEDARRAYRED[16:8]  = 10'b0;
  assign LEDARRAYRED[7:0]   = IOC;
  assign LEDARRAYGREEN[8]   = 1'b0;
  assign LEDARRAYGREEN[7:0] = IOD;
  
  // SEVEN-SEGMENT DISPLAY DRIVERS

  hex_to_seven_seg upperIOH(
    .B(IOH[7:4]),
    .SSEG_L(HEX7)
  );
  
  hex_to_seven_seg lowerIOH(
    .B(IOH[3:0]),
    .SSEG_L(HEX6)
  );
  
  hex_to_seven_seg upperIOG(
    .B(IOG[7:4]),
    .SSEG_L(HEX5)
  );
  
  hex_to_seven_seg lowerIOG(
    .B(IOG[3:0]),
    .SSEG_L(HEX4)
  );
  
  hex_to_seven_seg upperIOF(
    .B(IOF[7:4]),
    .SSEG_L(HEX3)
  );
  
  hex_to_seven_seg lowerIOF(
    .B(IOF[3:0]),
    .SSEG_L(HEX2)
  );
  
  hex_to_seven_seg upperIOE(
    .B(IOE[7:4]),
    .SSEG_L(HEX1)
  );
  
  hex_to_seven_seg lowerIOE(
    .B(IOE[3:0]),
    .SSEG_L(HEX0)
  );

endmodule