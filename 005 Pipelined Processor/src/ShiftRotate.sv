module ShiftRotate(	input logic [7:0]	A, B,
							input logic	[2:0]	control,
							output logic [7:0]	SRRes,
							output logic [3:0]	SRFlags);

	logic Select;
	logic [7:0]	res[1:0];
	logic [3:0]	flags[1:0];

	assign Select = control[2];

	Shift	s(A, B, control[1:0], res[0], flags[0]);
	Rotate r(A, B, control, res[1], flags[1]);

	mux2 #(4)	FlagsMux(flags[0], flags[1], Select, SRFlags);
	mux2 #(8)	ResMux(res[0], res[1], Select, SRRes);

endmodule

module Shift(	input logic [7:0]	A, B,
					input logic [1:0] control,
					output logic [7:0] res,
					output logic [3:0] flags);

	logic cf, zf, sf, of;
	
	always_comb
		casex(control)
			2'b00: {res, cf} = {A, 1'b0} >>> B;
			2'b01: {res, cf} = {A, 1'b0} >> B;
			2'b10: {cf, res} = {1'b0, A} <<< B;
			2'b11: {cf, res} = {1'b0, A} << B;
			default: {cf, res} = 9'bx;
		endcase

	assign of = ~(A[7] === res[7]);
	assign zf = (res === 0);
	assign sf = res[7];
	
	assign flags = {cf, zf, sf, of};
endmodule

module Rotate(input logic [7:0]	A, B,
					input logic [2:0] control,
					output logic [7:0] res,
					output logic [3:0] flags);

	logic cf, zf, sf, of;

	always_comb
		if(control[0]) begin
			casex(B[2:0])
				3'b000: res = A;
				3'b001: res = {A[0], A[7:1]};
				3'b010: res = {A[1:0], A[7:2]};
				3'b011: res = {A[2:0], A[7:3]};
				3'b100: res = {A[3:0], A[7:4]};
				3'b101: res = {A[4:0], A[7:5]};
				3'b110: res = {A[5:0], A[7:6]};
				3'b111: res = {A[6:0], A[7]};
				default: res = 8'bx;
			endcase
		end else begin
			casex(B[2:0])
				3'b000: res = A;
				3'b001: res = {A[6:0], A[7]};
				3'b010: res = {A[5:0], A[7:6]};
				3'b011: res = {A[4:0], A[7:5]};
				3'b100: res = {A[3:0], A[7:4]};
				3'b101: res = {A[2:0], A[7:3]};
				3'b110: res = {A[1:0], A[7:2]};
				3'b111: res = {A[0], A[7:1]};
				default: res = 8'bx;
			endcase
		end

	assign cf = 1'b0; // nemidounam chetore :|
	assign of = 1'b0;	// inam nmidounam :/
	assign zf = (res === 0);
	assign sf = res[7];

	assign flags = {cf, zf, sf, of};
endmodule 