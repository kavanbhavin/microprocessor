module halt_logic(HALT, EN_L, H);
	input HALT;
	input EN_L;
	output H;
	reg H;
	reg prev_enable;
	always@(*) begin
		if(EN_L) begin
			if(~prev_enable) begin
				H = 1'b1;
				prev_enable = EN_L;
			end
			else begin 
				prev_enable = 1'b1; 
				H = 1'b0;
			end
		end
		else begin
			prev_enable = EN_L;
			H = 1'b0;
		end
	end
endmodule