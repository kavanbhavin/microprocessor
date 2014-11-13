module halt_logic(CLK, HALT, EN_L, H);
	input HALT;
	input EN_L;
	input CLK;
	output H;
	reg H;
	reg prev_enable;
	always@(posedge CLK)begin
		if(~EN_L) begin
			if(prev_enable) begin
				H <= 1'b1;
				prev_enable <= EN_L;
			end
			else begin
				H<= 1'b0;
				prev_enable <= EN_L;
			end
		end
		else begin
			prev_enable <= EN_L;
			H <= 1'b0;
		end
	end
endmodule