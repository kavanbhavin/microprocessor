module mp(Z, NZ, N, NN, BS, MP);
	input Z;
	input NZ;
	input N;
	input NN;
	input [2:0] BS;
	output MP;
	
	always@(*) begin
		case(BS)
			3'd0: begin
				MP = Z;
			end
			3'd1: begin
				MP = NZ;
			end
			3'd2: begin
				MP = N;
			end
			3'd3: begin
				NP = NN;
			end
			default: begin
				NP = 1'b0;
			end
	end