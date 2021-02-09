module condunit(	input logic 			clk, reset,
						input logic [15:0]	InstrE,
						input logic				FlagWriteE,
						input logic [3:0]		FlagsE, ALUFlags,
						output logic [3:0]	Flags_prim,
						output logic			CondExE);
	logic CF, ZF, SF, OF;

	assign {CF, ZF, SF, OF} = FlagsE;
	
	always_comb
		if(FlagWriteE)	Flags_prim = ALUFlags;
		else Flags_prim = FlagsE;
	
	always_comb
		casex(InstrE[15:11])
			5'b0????: CondExE = 1'b1;
			5'b10000: CondExE = ZF;
			5'b10001: CondExE = CF;
			5'b10010: CondExE = ~(CF | ZF);
			5'b10011: CondExE = (SF !== OF);
			5'b10100: CondExE = (SF === OF) & ~ZF;
			5'b10101: CondExE = 1'b1;
			5'b10110: CondExE = 1'b1;
			5'b10111: CondExE = 1'b1;
			default:		  CondExE = 1'bx;
		endcase
endmodule 