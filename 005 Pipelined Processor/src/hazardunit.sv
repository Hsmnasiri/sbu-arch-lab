module hazardunit(	input logic		clk, reset,
												MemtoRegE, JMuxTakenE,
												RegWriteAW, RegWriteAM,
												RegWriteBW, RegWriteBM,
							input logic [7:0]	Match,
							output logic[2:0] ForwardAE, ForwardBE,
							output logic 		FlushE, FlushD,
													StallD, StallF);
	logic LDRstall;
	assign LDRstall = (|Match) & MemtoRegE;
	assign StallF = LDRstall;
	assign StallD = LDRstall;
	assign FlushE = LDRstall | JMuxTakenE;
	assign FlushD = JMuxTakenE;
	
	logic Match_1E_M_3, Match_1E_W_3, Match_1E_M_4, Match_1E_W_4,
			Match_2E_M_3, Match_2E_W_3, Match_2E_M_4, Match_2E_W_4;
	assign {	Match_1E_M_3, Match_1E_W_3, Match_1E_M_4, Match_1E_W_4,
				Match_2E_M_3, Match_2E_W_3, Match_2E_M_4, Match_2E_W_4} = Match;
	
	always_comb begin
		if(Match_1E_M_3 & RegWriteAM) begin
			ForwardAE = 3'b001;	// SrcAE = ALUOutM
		end else if(Match_1E_W_3 & RegWriteAW) begin
			ForwardAE = 3'b010;	//	SrcAE = ResultW
		end else if(Match_1E_M_4 & RegWriteBM) begin
			ForwardAE = 3'b011;	// SrcAE = RD1_M
		end else if(Match_1E_W_4 & RegWriteBW) begin
			ForwardAE = 3'b100;	// SrcAE = RD1_W
		end else begin
			ForwardAE =	3'b000;	//SrcAE form regfile
		end

		if(Match_2E_M_3 & RegWriteAM) begin
			ForwardBE = 3'b001;	// SrcBE = ALUOutM
		end else if(Match_2E_W_3 & RegWriteAW) begin
			ForwardBE = 3'b010;	//	SrcBE = ResultW
		end else if(Match_2E_M_4 & RegWriteBM) begin
			ForwardBE = 3'b011;	// SrcBE = RD1_M
		end else if(Match_2E_W_4 & RegWriteBW) begin
			ForwardBE = 3'b100;	// SrcBE = RD1_W
		end else begin
			ForwardBE = 3'b000;	//SrcBE form regfile
		end
	end
endmodule 