module controller(	input logic				clk, reset,
							input logic [15:0]	InstrD,
							output logic			RegWriteAD, RegWriteBD, ImmSrcD,
														IDMuxD, JMuxD,
														MemtoRegD,
							output logic [1:0]	ShowD,
							output logic 			FlagWriteD,
							output logic [3:0]	ALUControlD);

	logic [7:0]	controls;
	
	// Main Decoder
	always_comb
		casex(InstrD[15:6])
			10'b0000000001: controls = 8'b10000000;
			10'b0000000010: controls = 8'b10000000;
			10'b0000000011: controls = 8'b10000000;
			10'b0000000100: controls = 8'b10000000;
			10'b0000000101: controls = 8'b10000000;
			10'b0000000110: controls = 8'b10000000;
			10'b0000000111: controls = 8'b11000000;
			10'b0000001000: controls = 8'b10000000;
			10'b0000001001: controls = 8'b10100000;
			10'b0000001010: controls = 8'b10100000;
			10'b0000001011: controls = 8'b10100000;
			10'b0000001100: controls = 8'b10100000;
			10'b0000001101: controls = 8'b10100000;
			10'b0000001110: controls = 8'b10100000;
			10'b0000001111: controls = 8'b10110000;
			10'b0000010000: controls = 8'b10110000;
			10'b0000000000: controls = 8'b00000000;
			10'b0000010010: controls = 8'b00000001;
			10'b0000010011: controls = 8'b00000010;
			10'b0000010100: controls = 8'b00000000;
			10'b10000?????: controls = 8'b00100100;
			10'b10001?????: controls = 8'b00100100;
			10'b10010?????: controls = 8'b00100100;
			10'b10011?????: controls = 8'b00100100;
			10'b10100?????: controls = 8'b00100100;
			10'b10101?????: controls = 8'b00100100;
			10'b10110?????: controls = 8'b10100000;
			10'b10111?????: controls = 8'b10101000;
			default:		  controls = 8'bx;
		endcase
		
	assign {	RegWriteAD, RegWriteBD, ImmSrcD, IDMuxD, JMuxD,
				MemtoRegD, ShowD} = controls;

	always_comb
		if(InstrD[15]) begin
			ALUControlD = 4'b0101;
		end else begin
			casex(InstrD[10:6])
				5'b00000: ALUControlD = 4'b0000;
				5'b00001: ALUControlD = 4'b0000;
				5'b00010: ALUControlD = 4'b0001;
				5'b00011: ALUControlD = 4'b0010;
				5'b00100: ALUControlD = 4'b0011;
				5'b00101: ALUControlD = 4'b0100;
				5'b00110: ALUControlD = 4'b0101;
				5'b00111: ALUControlD = 4'b0110;
				5'b01000: ALUControlD = 4'b0111;
				5'b01001: ALUControlD = 4'b1000;
				5'b01010: ALUControlD = 4'b1001;
				5'b01011: ALUControlD = 4'b1010;
				5'b01100: ALUControlD = 4'b1011;
				5'b01101: ALUControlD = 4'b1100;
				5'b01110: ALUControlD = 4'b1101;
				5'b01111: ALUControlD = 4'b0000;
				5'b10000: ALUControlD = 4'b0010;
				5'b10100: ALUControlD = 4'b0010;
			default:	ALUControlD = 4'b0000;
			endcase
		end
		
	always_comb
		casex(InstrD[15:6])
			10'b0000000001: FlagWriteD = 1'b1;
			10'b0000000010: FlagWriteD = 1'b1;
			10'b0000000011: FlagWriteD = 1'b1;
			10'b0000000100: FlagWriteD = 1'b1;
			10'b0000000101: FlagWriteD = 1'b1;
			10'b0000000110: FlagWriteD = 1'b0;
			10'b0000000111: FlagWriteD = 1'b0;
			10'b0000001000: FlagWriteD = 1'b0;
			10'b0000001001: FlagWriteD = 1'b1;
			10'b0000001010: FlagWriteD = 1'b1;
			10'b0000001011: FlagWriteD = 1'b1;
			10'b0000001100: FlagWriteD = 1'b1;
			10'b0000001101: FlagWriteD = 1'b1;
			10'b0000001110: FlagWriteD = 1'b1;
			10'b0000001111: FlagWriteD = 1'b1;
			10'b0000010000: FlagWriteD = 1'b1;
			10'b0000000000: FlagWriteD = 1'b0;
			10'b0000010010: FlagWriteD = 1'b0;
			10'b0000010011: FlagWriteD = 1'b0;
			10'b0000010100: FlagWriteD = 1'b1;
			default:		  FlagWriteD = 1'bx;
		endcase
endmodule 