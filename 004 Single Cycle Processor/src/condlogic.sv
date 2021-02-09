module condlogic(	input 					clk, reset,
						input logic [15:0]	Instr,
						input logic	[3:0]		ALUFlags,
						input logic 			FlagW,
						input logic				RegWA, RegWB, JM,
						output logic			RegWriteA, RegWriteB, JMux);
	
	logic 		FlagWrite;
	logic [3:0]	Flags;
	logic			CondEx;
	
	flopenr #(4)flagreg1(clk, reset, FlagWrite,
								ALUFlags, Flags);

	condcheck cc(Instr, Flags, CondEx);
	
	assign FlagWrite = FlagW & CondEx;
	assign RegWriteA = RegWA & CondEx;
	assign RegWriteB = RegWB & CondEx;
	assign JMux = JM & CondEx;
endmodule 


module condcheck(	input logic [15:0]	Instr,
						input logic [3:0]		Flags,
						output logic 			CondEx);

	logic CF, ZF, SF, OF;

	assign {CF, ZF, SF, OF} = Flags;
	
	always_comb
		casex(Instr[15:11])
			5'b0????: CondEx = 1'b1;
			5'b10000: CondEx = ZF;
			5'b10001: CondEx = CF;
			5'b10010: CondEx = ~(CF | ZF);
			5'b10011: CondEx = (SF !== OF);
			5'b10100: CondEx = (SF === OF) & ~ZF;
			5'b10101: CondEx = 1'b1;
			5'b10110: CondEx = 1'b1;
			5'b10111: CondEx = 1'b1;
			default:		  CondEx = 1'bx;
		endcase
endmodule 
		