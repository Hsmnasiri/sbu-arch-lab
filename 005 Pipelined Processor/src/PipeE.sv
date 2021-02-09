module PipeE(	input logic clk, FlushE,
							input logic [2:0]	RA1,
							output logic[2:0]	RA1E,
							input logic [2:0]	RA2,
							output logic[2:0]	RA2E,
							input logic [7:0] RD1,
							output logic [7:0]RD1E,
							input logic [7:0] RD2,
							output logic [7:0]RD2E,
							input logic [2:0]	WA3,
							output logic[2:0]	WA3E,
							input logic [2:0]	WA4,
							output logic [2:0]WA4E,
							input logic [7:0]	Imm,
							output logic [7:0]ImmE,
							input logic 		ImmSrcD,
							output logic		ImmSrcE,
							input logic [3:0]	ALUControlD,
							output logic [3:0]ALUControlE,
							input logic [3:0]	Flags_prim,
							output logic [3:0]FlagsE,
							input logic 		FlagWriteD,
							output logic 		FlagWriteE,
							input logic			RegWriteAD,
							output logic		RegWriteAE,
							input logic 		RegWriteBD, 
							output logic		RegWriteBE,
							input logic 		MemtoRegD,
							output logic		MemtoRegE,
							input logic [1:0]	ShowD,
							output logic[1:0]	ShowE,
							input logic [15:0]InstrD,
							output logic[15:0]InstrE);
	logic[50:0] inputs, outputs;
	assign inputs = 	{RA1, RA2, RD1, RD2, WA3, WA4, Imm, ImmSrcD, ALUControlD, Flags_prim, FlagWriteD, RegWriteAD, RegWriteBD, MemtoRegD, ShowD};
	assign {RA1E, RA2E, RD1E, RD2E, WA3E, WA4E, ImmE, ImmSrcE, ALUControlE, FlagsE, FlagWriteE, RegWriteAE, RegWriteBE, MemtoRegE, ShowE} = outputs;
	always_ff @(posedge clk) begin
		if (FlushE) {outputs, InstrE} <= {inputs, 16'b0};	//NOP
		else	{outputs, InstrE} <= {inputs, InstrD};
	end
endmodule 