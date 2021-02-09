module PipeD(	input logic	clk, StallD, FlushD,
					input logic [15:0]	InstrF,
					output logic [15:0]	InstrD);
	always_ff @(posedge clk)
		if (FlushD) InstrD <= 16'b0;	//NOP
		else if (~StallD)	InstrD <= InstrF;
endmodule 