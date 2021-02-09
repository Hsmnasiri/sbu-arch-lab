module datapath(	input logic	clk, reset,
						input logic [15:0]InstrF,
						output logic [15:0]	InstrD, InstrE,
						output logic [3:0]	FlagsE, ALUFlags,
						input logic [3:0]	Flags_prim,
						input logic			CondExE,
												RegWriteAD, RegWriteBD,
						output logic			RegWriteAW, RegWriteAM,
													RegWriteBW, RegWriteBM,
						input logic			ImmSrcD,
												IDmuxD, JMuxD,
						output logic			JMuxTakenE,
						input logic			MemtoRegD, 
						output logic 			MemtoRegE,
						input logic 		FlagWriteD,
						output logic			FlagWriteE,
						input logic [1:0]	ShowD,
						output logic [1:0]	ShowE,
						output logic [7:0]	ShowDataE,
						input logic [7:0]	ReadDataM,
						output logic [7:0]	PCF,
						output logic [7:0]	ALUResultM,
						input logic [3:0]	ALUControlD,
						output logic [7:0]	Match,
						input logic [2:0]		ForwardAE, ForwardBE,
						input logic 			FlushE, FlushD,
													StallD, StallF);

	// Fetch Logics
	logic [7:0]		PCprime, PCPlus4;
	// Decode Logics
	logic [2:0]	RA1, RA2, WA3, WA4;
	logic [7:0]	RD1, RD2, idtemp, ImmD;
	//Execute Logics
	logic [7:0]	RD2temp, ImmE, SrcA, SrcB, ALUResultE, RD1E, RD2E;
	logic 		ImmSrcE, RegWriteAE, RegWriteBE, RegWriteAE_temp, RegWriteBE_temp;
	logic [3:0] ALUControlE;
	logic [2:0]	RA1E, RA2E, WA3E, WA4E;
	// Memory Logics
	logic [7:0]	RD1M;
	logic 		MemtoRegM;
	logic [2:0]	WA3M, WA4M;
	// Writeback Logics
	logic [7:0] ALUResultW, ResultW, ReadDataW, RD1W;
	logic [2:0] WA3W, WA4W;
	logic 		MemtoRegW;
	// Match Logics
	logic Match_1E_M_3, Match_1E_W_3, Match_2E_M_3, Match_2E_W_3,
			Match_1E_M_4, Match_1E_W_4, Match_2E_M_4, Match_2E_W_4;
	
	// Fetch Stage
	mux2 #(8)		pcmux(	PCPlus4, ImmE, JMuxTakenE, PCprime);
	flopenr #(8)	PCreg(	clk, reset, ~StallF, PCprime, PCF);
	adder	#(8)		pcadd(	PCF, 8'b100, PCPlus4);
	
	//	Decode Stage
	assign RA1 = InstrD[5:3];
	assign RA2 = InstrD[2:0];
	assign WA4 = InstrD[2:0];
	PipeD piped(	clk, StallD, FlushD, InstrF, InstrD);
	mux2 #(3)	wa3mux(InstrD[5:3], InstrD[10:8], InstrD[15], WA3);
	regfile		rf(clk, RegWriteAW, RegWriteBW,
						RA1, RA2,
						WA3W, WA4W,
						ResultW, RD1W,
						RD1, RD2);
	mux2 #(8)	idmux({5'b0,InstrD[2:0]}, 8'b1, IDmuxD, idtemp);
	mux2 #(8)	immmux(idtemp, InstrD[7:0], InstrD[15], ImmD);
	
	// Execute Stage
	PipeE pipee(	clk, FlushE,
					RA1, RA1E,
					RA2, RA2E,
					RD1, RD1E,
					RD2, RD2E,
					WA3, WA3E,
					WA4, WA4E,
					ImmD, ImmE,
					ImmSrcD, ImmSrcE,
					ALUControlD, ALUControlE,
					Flags_prim, FlagsE,
					FlagWriteD, FlagWriteE,
					RegWriteAD, RegWriteAE,
					RegWriteBD, RegWriteBE,
					MemtoRegD, MemtoRegE,
					ShowD, ShowE,
					InstrD, InstrE);
	assign ShowDataE = RD1E;
	mux5 #(8)	srcamux(RD1E, ALUResultM, ResultW, RD1M, RD1W, ForwardAE, SrcA);
	mux5 #(8)	rd2mux(RD2E, ALUResultM, ResultW, RD1M, RD1W, ForwardBE, RD2temp);
	mux2 #(8)	srcbmux(RD2temp, ImmE, ImmSrcE, SrcB);
	alu 			alu(SrcA, SrcB, ALUControlE, ALUResultE, ALUFlags);
	assign RegWriteAE_temp = RegWriteAE & CondExE;
	assign RegWriteBE_temp = RegWriteBE & CondExE;
	assign JMuxTakenE = JMuxD & CondExE;

	//	Memory Stage
	PipeM	pipem(clk, RD1E, RD1M,
					ALUResultE, ALUResultM,
					WA3E, WA3M,
					WA4E, WA4M,
					RegWriteAE_temp, RegWriteAM,
					RegWriteBE_temp, RegWriteBM,
					MemtoRegE, MemtoRegM);

	// Writeback Stage
	PipeW pipew(clk, RD1M, RD1W,
					ALUResultM, ALUResultW,
					WA3M, WA3W,
					WA4M, WA4W,
					RegWriteAM, RegWriteAW,
					RegWriteBM, RegWriteBW,
					MemtoRegM, MemtoRegW,
					ReadDataM, ReadDataW);
	mux2 #(8)	resmux(ALUResultW, ReadDataW, MemtoRegW, ResultW);

	//	Match Hazardunit Logic
	always_comb begin
		Match_1E_M_3 = (RA1E == WA3M);
		Match_1E_W_3 = (RA1E == WA3W);
		Match_2E_M_3 = (RA2E == WA3M);
		Match_2E_W_3 = (RA2E == WA3W);
		Match_1E_M_4 = (RA1E == WA4M);
		Match_1E_W_4 = (RA1E == WA4W);
		Match_2E_M_4 = (RA2E == WA3M);
		Match_2E_W_4 = (RA2E == WA3W);
	end
	assign Match = {	Match_1E_M_3, Match_1E_W_3, Match_2E_M_3, Match_2E_W_3,
							Match_1E_M_4, Match_1E_W_4, Match_2E_M_4, Match_2E_W_4};

endmodule 