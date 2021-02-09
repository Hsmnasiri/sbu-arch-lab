module alu(	input logic [7:0]	SrcA, SrcB,
				input logic [3:0]	ALUControl,
				output logic [7:0]	ALUResult,
				output logic [3:0]	ALUFlags);

	logic [7:0] res[1:0];
	logic	[3:0]	flags[1:0];
	initial begin 
		flags[0] = 4'b0;
		flags[1] = 4'b0;
	end
	
	mainAlu	ma(SrcA, SrcB, ALUControl[2:0],
					res[0], flags[0]);
	ShiftRotate	sr(SrcA, SrcB, ALUControl[2:0],
					res[1], flags[1]);

	mux2 #(4)	FlagsMux(flags[0], flags[1], ALUControl[3], ALUFlags);
	mux2 #(8)	ResMux(res[0], res[1], ALUControl[3], ALUResult);

endmodule

module mainAlu(input logic [7:0]	A, B,
					input logic [2:0]	control,
					output logic [7:0] 	res,
					output logic [3:0]	flags);

	logic cf, zf, sf, of;

	always_comb
		casex(control)
			3'b000: {cf, res} = {1'b0, A} + {1'b0, B};
			3'b001: {cf, res} = {1'b0, A & B};
			3'b010: {cf, res} = {1'b0, A} - {1'b0, B};
			3'b011: {cf, res} = {1'b0, A | B};
			3'b100: {cf, res} = {1'b0, A ^ B};
			3'b101: {cf, res} = {1'bx, B};
			3'b110:	{cf, res} = {1'bx, B};
			3'b111:	{cf, res} = {1'bx, ~A};
			default: {cf, res} = 9'bx;
		endcase
	assign of = (~A[7] & ~B[7] & res[7]) | (A[7] & B[7] & ~res[7]);
	assign zf = (res === 0);
	assign sf = res[7];
	
	assign flags = {cf, zf, sf, of};

endmodule 