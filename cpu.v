module cpu(CLK, RESET, EN_L, Iin, Din, PC, NextPC, DataA, DataB, DataC, DataD, MW);
  input         CLK;
  input         RESET;
  input         EN_L;
  input  [15:0] Iin;
  input  [7:0]  Din;
  
  output [7:0]  PC;
  output [7:0]  NextPC;
  output [7:0]  DataA;
  output [7:0]  DataB;
  output [7:0]  DataC;
  output [7:0]  DataD;
  output        MW;
  
  // comment the two lines out below if you use a submodule to generate PC/NextPC
  reg [7:0] PC;
  reg [7:0] NextPC;
  
  reg MW;
  
  // ADD YOUR CODE BELOW THIS LINE
  wire Z;
  wire N;
  wire HALT;
  wire H;
  assign HALT = ((Iin[15:12]==4'd0) && (Iin[2:0]==3'b001)) ? 1'b1 : 1'b0;
  reg MB;
  reg MD;
  wire MP;
  reg [2:0] BS;
  wire [7:0] B_in;
  wire [7:0] SIGN_EXTEND;
  reg [5:0] IMM;
  reg [2:0] SA;
  reg [2:0] SB;
  reg LD;
  reg [2:0] DR;
  reg [3:0] FS;
  wire [7:0] INCREMENT_SUM;
  
  always @ (posedge CLK) begin
		if(RESET) PC <= 8'd0;
		else if(H) PC <=PC;
		else PC <= NextPC;
  end
  
  always @ (*) begin
  		if(MP) NextPC = INCREMENT_SUM;
  		else NextPC = PC +8'd2;
  end

  adder fa(
  	.A(PC+8'd2),
  	.B({SIGN_EXTEND[6:0], 1'b0}),
  	.CI(1'b0),
  	.Y(INCREMENT_SUM)
  	);

  halt_logic kandisa(
	.EN_L(EN_L),
	.HALT(HALT),
	.H(H),
	.CLK(CLK)
  );
  
  register_file rfile(
  .SA(SA), 
  .SB(SB), 
  .LD(LD), 
  .CLK(CLK), 
  .DR(DR), 
  .D_in(DataC), 
  .DATA_A(DataA), 
  .RESET(RESET),
  .DATA_B(DataB)
  ); 
  
  two_to_one_mux zardoz(
  .I0(DataB), 
  .I1(SIGN_EXTEND), 
  .SELECT(MB), 
  .DATA(B_in)
  );
  
  two_to_one_mux whoareu(
	.I0(DataD),
	.I1(Din),
	.SELECT(MD),
	.DATA(DataC)
  );
  
  alu aloo(
  .A(DataA), 
  .B(B_in), 
  .OP(FS), 
  .Y(DataD),
  .Z(Z),
  .N(N)
  );
  
  sign_extend sine(
	.IMM(IMM),
	.OUTPUT(SIGN_EXTEND)
  );
  
  mp branch(
   .Z(Z), 
	.NZ(~Z), 
	.N(N), 
	.NN(~N), 
	.BS(BS), 
	.MP(MP)
  );
  
  always@(*) begin
		case(Iin[15:12])
			4'd0: begin
			//NOP
				DR = Iin[5:3];
				SA = Iin[11:9];
				SB = Iin[8:6];
				IMM = 6'd0;
				MB = 1'b0;
				FS = Iin[2:0];
				MD = 1'b0;
				LD = 1'b0;
				MW = 1'b0;
				BS = 3'd4;
			end
			4'b1111: begin
				BS = 3'd4;
				DR = Iin[5:3];
				SA = Iin[11:9];
				SB = Iin[8:6];
				IMM = 6'd0;
				MB = 1'b0;
				FS = Iin[2:0];
				MD = 1'b0;
				LD = 1'b1;
				MW = 1'b0;
			end
			4'b0010: begin
				BS = 3'd4;
				DR = Iin[8:6];
				SA = Iin[11:9];
				SB = 2'd0;
				IMM = Iin[5:0];
				MB = 1'b1;
				FS = 3'd0;
				MD = 1'b1;
				LD = 1'b1;
				MW = 1'b0;
			end
			4'b0100: begin
				BS = 3'd4;
				DR = 3'd0;
				SA = Iin[11:9];
				SB = Iin[8:6];
				IMM = Iin[5:0];
				MB = 1'b1;
				FS = 3'd0;
				MD = 1'b0;
				LD = 1'b0;
				MW = 1'b1;
			end
			4'b0101: begin
				BS = 3'd4;
				DR = Iin[8:6];
				SA = Iin[11:9];
				SB = Iin[8:6];
				IMM = Iin[5:0];
				MB = 1'b1;
				FS = 3'd0;
				MD = 1'b0;
				LD = 1'b1;
				MW = 1'b0;
			end
			4'b0110: begin
				BS = 3'd4;
				DR = Iin[8:6];
				SA = Iin[11:9];
				SB = Iin[8:6];
				IMM = Iin[5:0];
				MB = 1'b1;
				FS = 3'b101;
				MD = 1'b0;
				LD = 1'b1;
				MW = 1'b0;
			end
			4'b0111: begin
				BS = 3'd4;
				DR = Iin[8:6];
				SA = Iin[11:9];
				SB = Iin[8:6];
				IMM = Iin[5:0];
				MB = 1'b1;
				FS = 3'b110;
				MD = 1'b0;
				LD = 1'b1;
				MW = 1'b0;
			end
			4'b1000: begin
				//BEQ
				BS = 3'd0;
				DR=Iin[8:6];
				SA = Iin[11:9];
				SB = Iin[8:6];
				IMM = Iin[5:0];
				MB = 1'b0;
				FS = 3'b001;
				MD = 1'b0;
				LD = 1'b0;
				MW = 1'b0;
			end
			4'b1001: begin
				//BNE
				BS = 3'd1;
				DR=Iin[8:6];
				SA = Iin[11:9];
				SB = Iin[8:6];
				IMM = Iin[5:0];
				MB = 1'b0;
				FS = 3'b001;
				MD = 1'b0;
				LD = 1'b0;
				MW = 1'b0;
			end
			4'b1010: begin
				//BGEZ
				BS = 3'd3;
				DR= Iin[8:6];
				SA = Iin[11:9];
				SB = Iin[8:6];
				IMM = Iin[5:0];
				MB = 1'b0;
				FS = 3'b010;
				MD = 1'b0;
				LD = 1'b0;
				MW = 1'b0;
			end
			4'b1011: begin
				//BLTZ
				BS = 3'd2;
				DR=Iin[8:6];
				SA = Iin[11:9];
				SB = Iin[8:6];
				IMM = Iin[5:0];
				MB = 1'b0;
				FS = 3'b010;
				MD = 1'b0;
				LD = 1'b0;
				MW = 1'b0;
			end
			default: begin
				BS = 3'd4;
				DR = Iin[5:3];
				SA = Iin[11:9];
				SB = Iin[8:6];
				IMM = 6'd0;
				MB = 1'b0;
				FS = Iin[2:0];
				MD = 1'b0;
				LD = 1'b0;
				MW = 1'b0;
			end
		endcase
  end
  
  
  
  
  
  // ADD YOUR CODE ABOVE THIS LINE

endmodule