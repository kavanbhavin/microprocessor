module flip_flop(LD, D, CLK, OUT);
	input LD;
	input [7:0] D;
	input CLK;
	output [7:0] OUT;
	reg [7:0] OUT;
	always @(posedge CLK) begin
		if(LD) OUT <= D;
		else OUT <= OUT;
	end
endmodule