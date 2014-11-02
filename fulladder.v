module fulladder(X,Y,CIN,S,COUT);
	input X;
	input Y;
	input CIN;
	output S;
	output COUT;
	
	assign COUT = (X&Y)|(Y&CIN)|(CIN&X);
	assign S = (X&Y&CIN)|(X&(~Y)&(~CIN))|((~X)&Y&(~CIN))|((~X)&(~Y)&CIN);

endmodule