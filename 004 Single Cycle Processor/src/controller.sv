module controller(	input logic 			clk, reset,
							input logic [15:0]	Instr,
							input logic [3:0]		ALUFlags,
							output logic			RegWriteA, RegWriteB, ImmSrc,
														IDmux, JMux,
														MemtoReg,
							output logic [1:0]	Show,
							output logic [3:0]	ALUControl);
	logic 		FlagW;
	logic 		RegWA, RegWB, JM;

	decoder dec(	Instr,
						RegWA, RegWB, ImmSrc,
						IDmux, JM,
						MemtoReg, Show, FlagW,
						ALUControl);
	condlogic cl(	clk, reset, 
						Instr, ALUFlags, FlagW,
						RegWA, RegWB, JM,
						RegWriteA, RegWriteB, JMux);
endmodule 