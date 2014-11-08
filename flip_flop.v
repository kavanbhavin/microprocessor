module flip_flop(RESET, LD, D, CLK, OUT);
	input RESET;
	input LD;
	input [7:0] D;
	input CLK;
	output [7:0] OUT;
	reg [7:0] OUT;
	always @(posedge CLK) begin
		if(RESET) OUT <= 8'd0;
		else if(LD) OUT <= D;
		else OUT <= OUT;
	end
endmodule