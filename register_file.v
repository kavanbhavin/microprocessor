module register_file(RESET, SA, SB, LD, CLK, DR, D_in, DATA_A, DATA_B);

	input LD;
	input [2:0] SA;
	input [2:0] SB;
	input [2:0] DR;
	input CLK;
	input [7:0] D_in;
	input RESET;
	output [7:0] DATA_A;
	output [7:0] DATA_B;
	wire [7:0] OUTS_0;
	wire [7:0] OUTS_1;
	wire [7:0] OUTS_2;
	wire [7:0] OUTS_3;
	wire [7:0] OUTS_4;
	wire [7:0] OUTS_5;
	wire [7:0] OUTS_6;
	wire [7:0] OUTS_7;
	
	wire [7:0] Y;
	
	eight_to_one_mux dat_a(
		.IN0(OUTS_0),
		.IN1(OUTS_1),
		.IN2(OUTS_2),
		.IN3(OUTS_3),
		.IN4(OUTS_4),
		.IN5(OUTS_5),
		.IN6(OUTS_6),
		.IN7(OUTS_7),
		.SELECT(SA),
		.OUT(DATA_A)
	);
	
	eight_to_one_mux dat_b(
		.IN0(OUTS_0),
		.IN1(OUTS_1),
		.IN2(OUTS_2),
		.IN3(OUTS_3),
		.IN4(OUTS_4),
		.IN5(OUTS_5),
		.IN6(OUTS_6),
		.IN7(OUTS_7),
		.SELECT(SB),
		.OUT(DATA_B)
	);	
	
	flip_flop f0(
		.LD((DR == 3'd0) & LD ), 
		.D(D_in), 
		.CLK(CLK), 
		.RESET(RESET),
		.OUT(OUTS_0)
	);

	flip_flop f1(
		.LD((DR == 3'd1) & LD ), 
		.D(D_in), 
		.CLK(CLK),
		.RESET(RESET),
		.OUT(OUTS_1)
	);

	flip_flop f2(
		.LD((DR == 3'd2) & LD ), 
		.D(D_in), 
		.CLK(CLK),
		.RESET(RESET),
		.OUT(OUTS_2)
	);

	flip_flop f3(
		.LD((DR == 3'd3) & LD ), 
		.D(D_in), 
		.CLK(CLK),
		.RESET(RESET),
		.OUT(OUTS_3)
	);

	flip_flop f4(
		.LD((DR == 3'd4) & LD ), 
		.D(D_in), 
		.CLK(CLK),
		.RESET(RESET),
		.OUT(OUTS_4)
	);

	flip_flop f5(
		.LD((DR == 3'd5) & LD ), 
		.D(D_in), 
		.CLK(CLK), 
		.RESET(RESET),
		.OUT(OUTS_5)
	);

	flip_flop f6(
		.LD((DR == 3'd6) & LD ), 
		.D(D_in), 
		.CLK(CLK),
		.RESET(RESET),
		.OUT(OUTS_6)
	);
	
	flip_flop f7(
		.LD((DR == 3'd7) & LD ), 
		.D(D_in), 
		.CLK(CLK),
		.RESET(RESET),
		.OUT(OUTS_7)
	);

	endmodule
	