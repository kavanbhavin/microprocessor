module register_decoder(DR, LD, Y);
	input [2:0] DR;
	input LD;
	output reg [7:0] Y;
	always @ (*) begin
	if (LD) begin 
		case(DR)
			3'd0: begin
				Y <= 8'd1;
			end
			3'd1: begin
				Y <= 8'd2;
			end
			3'd2: begin
				Y <= 8'd4;
			end
			3'd3: begin
				Y <= 8'd8;
			end
			3'd4: begin
				Y <= 8'd16;
			end
			3'd5: begin
				Y <= 8'd32;
			end
			3'd6: begin
				Y <= 8'd64;
			end
			3'd7: begin
				Y <= 8'd128;
			end
			default: begin
				Y <= 8'd0;
			end
		endcase
		end
	else Y<= 8'd0;
	end 
	
endmodule