module three_to_one_mux(I0, I1, I2, SELECT, OUT);
	parameter DATA_WIDTH = 3;
	input [DATA_WIDTH-1:0] I0;
	input [DATA_WIDTH-1:0] I1;
	input [DATA_WIDTH-1:0] I2;
	input [1:0] SELECT;
	output [DATA_WIDTH-1:0] OUT;
	
	assign OUT = (SELECT == 2'd0) ? I0 : (SELECT == 2'd1) ? I1 : I2;
endmodule