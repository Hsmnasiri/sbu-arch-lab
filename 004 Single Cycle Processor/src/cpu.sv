module cpu(	input logic 				clk, reset,
				output logic	[7:0] 	PC,
				input logic 	[15:0] 	Instr,
				output logic 	[7:0] 	ALUResult,
				input logic 	[7:0] 	ReadData,
				output logic 	[1:0] 	Show,
				output logic	[7:0]		ShowData);

	logic [3:0] ALUFlags, ALUControl;
	logic RegWriteA, RegWriteB, ImmSrc,
			IDmux, JMux,
			MemtoReg;
	
	controller c(	clk, reset, Instr, ALUFlags,
						RegWriteA, RegWriteB, ImmSrc,
						IDmux, JMux,
						MemtoReg, Show, ALUControl);
	datapath dp(	clk, reset, Instr, ALUFlags,
						RegWriteA, RegWriteB, ImmSrc,
						IDmux, JMux,
						MemtoReg, ShowData,
						ReadData, PC, ALUResult,
						ALUControl);
endmodule 