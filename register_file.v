module register_file(SA, SB, LD, CLK, DR, D_in, DATA_A, DATA_B);

	input LD;
	input [2:0] SA;
	input [2:0] SB;
	input [2:0] DR;
	input CLK;
	input [7:0] D_in;
	
	output DATA_A;
	output DATA_B;
	wire [7:0] OUTS;
	wire [7:0] Y;
	
	eight_to_one_mux dat_a(
		.IN0(OUTS[0]),
		.IN1(OUTS[1]),
		.IN2(OUTS[2]),
		.IN3(OUTS[3]),
		.IN4(OUTS[4]),
		.IN5(OUTS[5]),
		.IN6(OUTS[6]),
		.IN7(OUTS[7]),
		.SELECT(SA),
		.OUT(DATA_A)
	);
	
	eight_to_one_mux dat_b(
		.IN0(OUTS[0]),
		.IN1(OUTS[1]),
		.IN2(OUTS[2]),
		.IN3(OUTS[3]),
		.IN4(OUTS[4]),
		.IN5(OUTS[5]),
		.IN6(OUTS[6]),
		.IN7(OUTS[7]),
		.SELECT(SB),
		.OUT(DATA_A)
	);
	
	decoder register_decoder(
		.DR(DR),
		.LD(LD),
		.Y(Y)
	);
	
	flip_flop f0(
		.LD(Y[0]), 
		.D(D_in), 
		.CLK(CLK), 
		.OUT(OUTS[0])
	);

	flip_flop f1(
		.LD(Y[1]), 
		.D(D_in), 
		.CLK(CLK), 
		.OUT(OUTS[1])
	);

	flip_flop f2(
		.LD(Y[2]), 
		.D(D_in), 
		.CLK(CLK), 
		.OUT(OUTS[2])
	);

	flip_flop f3(
		.LD(Y[3]), 
		.D(D_in), 
		.CLK(CLK), 
		.OUT(OUTS[3])
	);

	flip_flop f4(
		.LD(Y[4]), 
		.D(D_in), 
		.CLK(CLK), 
		.OUT(OUTS[4])
	);

	flip_flop f5(
		.LD(Y[5]), 
		.D(D_in), 
		.CLK(CLK), 
		.OUT(OUTS[5])
	);

	flip_flop f6(
		.LD(Y[6]), 
		.D(D_in), 
		.CLK(CLK), 
		.OUT(OUTS[6])
	);
	
	flip_flop f7(
		.LD(Y[7]), 
		.D(D_in), 
		.CLK(CLK), 
		.OUT(OUTS[7])
	);

	endmodule
	