module eight_to_one_mux(IN0, IN1, IN2, IN3, IN4, IN5, IN6, IN7, SELECT, OUT);
	input [7:0] IN0;
	input [7:0] IN1;
	input [7:0] IN2;
	input [7:0] IN3;
	input [7:0] IN4;
	input [7:0] IN5;
	input [7:0] IN6;
	input [7:0] IN7;
	input [2:0] SELECT;
	
	output [7:0] OUT;
	reg [7:0] OUT;
	always @(*) begin
		case(SELECT)
			3'd0: begin
				OUT = IN0;
			end
			3'd1: begin
				OUT = IN1;
			end
			3'd2: begin
				OUT = IN2;
			end
			3'd3: begin
				OUT = IN3;
			end
			3'd4: begin
				OUT = IN4;
			end
			3'd5: begin
				OUT = IN5;
			end
			3'd6: begin
				OUT = IN6;
			end
			3'd7: begin
				OUT = IN7;
			end
		endcase
	end
endmodule