module control(OP, CISEL, BISEL, OSEL, SHIFT_LA, SHIFT_LR, LOGICAL_OP); // add other inputs and outputs here

  // inputs (add others here)
  input  [2:0]  OP;
  
  // outputs (add others here)
  output        CISEL;
  output			 BISEL;
  output	[1:0]	 OSEL;
  output SHIFT_LA;
  output SHIFT_LR;
  output LOGICAL_OP;
	
  // reg and internal variable definitions
  reg [1:0] OSEL;
  
  // implement module here (add other control signals below)
  assign CISEL = (OP == 3'b001) ? 1'b1 : 1'b0;
  assign BISEL = (OP == 3'b001) ? 1'b1 : 1'b0;
  assign SHIFT_LA = (OP == 3'b010) ? 1'b1: 1'b0;
  assign SHIFT_LR = (OP == 3'b100) ? 1'b0: 1'b1;
  assign LOGICAL_OP = (OP == 3'b101) ? 1'b1 : 1'b0;
  always@(*) begin
		case(OP)
			3'd0: begin
				OSEL = 2'd0;
			end
			3'd1: begin
				OSEL = 2'd0;
			end
			3'd2: begin
				OSEL = 2'd1;
			end
			3'd3: begin
				OSEL = 2'd1;
			end
			3'd4: begin
				OSEL = 2'd1;
			end
			3'd5: begin
				OSEL = 2'd2;
			end
			3'd6: begin
				OSEL = 2'd2;
			end
			default: begin
				OSEL = 2'dX;
			end
		endcase
	
  end
endmodule