module cpu(	input logic 				clk, reset,
				output logic	[7:0] 	PCF,
				input logic 	[15:0] 	InstrF,
				output logic 	[7:0] 	ALUResultM,
				input logic 	[7:0] 	ReadDataM,
				output logic 	[1:0] 	ShowE,
				output logic	[7:0]		ShowDataE);

	logic [3:0] ALUFlags, ALUControlD, FlagsE, Flags_prim;
	logic RegWriteAD, RegWriteBD,
			RegWriteAM, RegWriteBM,
			RegWriteAW, RegWriteBW,
			ImmSrcD, MemtoRegD,
			IDmuxD, JMuxD, JMuxTakenE,
			FlagWriteD, FlagWriteE,
			CondExE,
			MemtoRegE,
			FlushE, FlushD,
			StallD, StallF;
	logic [15:0] InstrD, InstrE;
	logic [1:0] ShowD;
	logic [7:0] Match;
	logic [2:0]	ForwardAE, ForwardBE;
	
	controller c(	clk, reset, InstrD,
						RegWriteAD, RegWriteBD, ImmSrcD,
						IDmuxD, JMuxD,
						MemtoRegD, ShowD,
						FlagWriteD ,ALUControlD);		//✔
	condunit	cu(	clk, reset, InstrE,
						FlagWriteE, FlagsE, ALUFlags,
						Flags_prim, CondExE);					//✔
	hazardunit	hu(clk, reset, MemtoRegE, JMuxTakenE,
						RegWriteAW, RegWriteAM,
						RegWriteBW, RegWriteBM,
						Match, ForwardAE, ForwardBE,
						FlushE, FlushD,
						StallD, StallF);					//✔
	datapath dp(	clk, reset,
						InstrF, InstrD, InstrE,
						FlagsE, ALUFlags, Flags_prim, CondExE,
						RegWriteAD, RegWriteBD,
						RegWriteAW, RegWriteAM,
						RegWriteBW, RegWriteBM,
						ImmSrcD,
						IDmuxD, JMuxD, JMuxTakenE,
						MemtoRegD, MemtoRegE,
						FlagWriteD, FlagWriteE,
						ShowD, ShowE, ShowDataE,
						ReadDataM, PCF, ALUResultM,
						ALUControlD,
						Match, ForwardAE, ForwardBE,
						FlushE, FlushD,
						StallD, StallF);
endmodule 