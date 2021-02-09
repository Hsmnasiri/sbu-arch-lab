module top (input logic clk, reset,
				output logic [15:0] Instr);
	logic [7:0] PC, DataAdr, ReadData, ShowData;
	logic [1:0] ShowEn;
	//logic [15:0] Instr;

	cpu cpu(	clk, reset, PC, Instr,
				DataAdr, ReadData,
				ShowEn, ShowData);

	imem imem(PC, Instr);
	dmem dmem(clk, DataAdr, ReadData);

	BCD bcd(ShowEn[0], ShowData);
	SevenSeg ss(ShowEn[1], ShowData);

endmodule 