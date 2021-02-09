module datapath(	input logic				clk, reset,
						input logic [15:0]	Instr,
						output logic [3:0]	ALUFlags,
						input logic 			RegWriteA, RegWriteB, ImmSrc,
													IDmux, JMux,
													MemtoReg,
						output logic [7:0]	ShowData,
						input logic [7:0]		ReadData,
						output logic [7:0]	PC, ALUResult,
						input logic [3:0]		ALUControl);

	logic [7:0]	PCPlus4, PCNext;
	logic [2:0]	RA3;
	logic [7:0]	RD2;
	logic [7:0] Result, SrcA, SrcB;
	logic [7:0] idtemp, Imm;
	
	//assign ShowData = RD1;

	//	next PC logic
	mux2 #(8)	pcmux(PCPlus4, Instr[7:0], JMux, PCNext);
	flopr #(8)	pcreg(clk, reset, PCNext, PC);
	adder #(8)	pcadd(PC, 8'b100, PCPlus4);

	// register file logic
	mux2 #(3)	ra3mux(Instr[5:3], Instr[10:8], Instr[15], RA3);
	regfile		rf(clk, RegWriteA, RegWriteB,
						Instr[5:3], Instr[2:0],
						RA3, Instr[2:0],
						Result,
						ShowData, RD2);
	mux2 #(8)	resmux(ALUResult, ReadData, MemtoReg, Result);
	
	// ALU Logic
	mux2 #(8)	srcamux(ShowData, 8'b0, Instr[15], SrcA);
	mux2 #(8)	idmux({5'b0,Instr[2:0]}, 8'b1, IDmux, idtemp);
	mux2 #(8)	immmux(idtemp, Instr[7:0], Instr[15], Imm);
	mux2 #(8)	srcbmux(RD2, Imm, ImmSrc, SrcB);
	alu 			alu(SrcA, SrcB, ALUControl, ALUResult, ALUFlags);

endmodule 