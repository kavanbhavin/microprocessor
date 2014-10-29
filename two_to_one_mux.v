module two_to_one_mux(I0, I1, SELECT, DATA);
	parameter DATA_WIDTH = 4;
	input [DATA_WIDTH-1:0] I0;
	input [DATA_WIDTH-1:0] I1;
	input SELECT;
	output [DATA_WIDTH-1:0] DATA;
	
	assign DATA = SELECT ? I1 : I0;
endmodule