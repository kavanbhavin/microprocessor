module halt_logic(CLK, HALT, EN_L, H);
	input HALT;
	input EN_L;
	input CLK;
	output H;
	reg prev_enable;
	reg H;
	
	always@(*)begin
		if(~HALT) H =1'b0;
		else if(~EN_L) begin
			if(prev_enable) H = 1'b0;
			else H = 1'b1;
		end
		else H = 1'b1;
	end
	
	always@(posedge CLK)begin
	prev_enable <= EN_L;
	end
endmodule