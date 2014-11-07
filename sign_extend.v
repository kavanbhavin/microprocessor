module sign_extend(IMM, OUTPUT);
	input [5:0] IMM;
	output [7:0] OUTPUT;
	
	assign OUTPUT = IMM[5] ? {2'b11, IMM} : {2'b00, IMM};
	
endmodule