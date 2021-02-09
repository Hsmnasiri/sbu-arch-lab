module PipeM(	input logic clk,
					input logic [7:0] RD1E,
					output logic [7:0]RD1M,
					input logic [7:0] ALUResultE,
					output logic [7:0]ALUResultM,
					input logic [2:0]	WA3E,
					output logic[2:0]	WA3M,
					input logic [2:0]	WA4E,
					output logic[2:0]	WA4M,
					input logic RegWriteAE_temp,
					output logic RegWriteAM,
					input logic RegWriteBE_temp,
					output logic RegWriteBM,
					input logic MemtoRegE,
					output logic MemtoRegM);
	logic [24:0] inputs, outputs;
	assign inputs = {RD1E, ALUResultE, WA3E, WA4E, RegWriteAE_temp, RegWriteBE_temp, MemtoRegE};
	assign {RD1M, ALUResultM, WA3M, WA4M, RegWriteAM, RegWriteBM, MemtoRegM} = outputs;
	always_ff @(posedge clk)
		outputs <= inputs;
endmodule 