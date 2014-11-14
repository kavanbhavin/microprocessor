module halt_logic(CLK, HALT, EN_L, H);
	input HALT;
	input EN_L;
	input CLK;
	output H;
	reg H;
	reg prev_enable;
	always@(posedge CLK)begin
	prev_enable <= EN_L;
		if(~HALT) H<=1'b0;
		else if(~EN_L) begin
			if(prev_enable) H <= 1'b0;
			else H<= 1'b1;
		end
		else H <= 1'b1;
	end
endmodule