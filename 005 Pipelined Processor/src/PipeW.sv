module 	PipeW (	input logic clk,
						input logic [7:0]	RD1M,
						output logic[7:0]	RD1W,
						input logic [7:0]	ALUResultM, 
						output logic [7:0]ALUResultW,
						input logic [2:0]	WA3M,
						output logic[2:0] WA3W,
						input logic	[2:0]	WA4M,
						output logic[2:0] WA4W,
						input logic RegWriteAM,
						output logic RegWriteAW,
						input logic RegWriteBM,
						output logic RegWriteBW,
						input logic MemtoRegM,
						output logic MemtoRegW,
						input logic [7:0]	ReadDataM,
						output logic[7:0]	ReadDataW);
	logic [32:0] inputs, outputs;
	assign inputs = {RD1M, ALUResultM, WA3M, WA4M, RegWriteAM, RegWriteBM, MemtoRegM, ReadDataM};
	assign {RD1W, ALUResultW, WA3W, WA4W, RegWriteAW, RegWriteBW, MemtoRegW, ReadDataW} = outputs;
	always_ff @(posedge clk)
		outputs <= inputs;
endmodule 