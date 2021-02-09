module decoder(	input logic [15:0]	Instr,
						output logic 			RegWA, RegWB, ImmSrc,
													IDMux, JM, MemtoReg,
						output logic [1:0]	Show,
						output logic 			FlagW,
						output logic [3:0]	ALUControl);

	logic [7:0]	controls;
	
	// Main Decoder
	always_comb
		casex(Instr[15:6])
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
		
	assign {	RegWA, RegWB, ImmSrc, IDMux,
				MemtoReg,JM,Show} = controls;

	always_comb
		if(Instr[15]) begin
			ALUControl = 4'b0101;
		end else begin
			casex(Instr[10:6])
				5'b00000: ALUControl = 4'b0000;
				5'b00001: ALUControl = 4'b0000;
				5'b00010: ALUControl = 4'b0001;
				5'b00011: ALUControl = 4'b0010;
				5'b00100: ALUControl = 4'b0011;
				5'b00101: ALUControl = 4'b0100;
				5'b00110: ALUControl = 4'b0101;
				5'b00111: ALUControl = 4'b0110;
				5'b01000: ALUControl = 4'b0111;
				5'b01001: ALUControl = 4'b1000;
				5'b01010: ALUControl = 4'b1001;
				5'b01011: ALUControl = 4'b1010;
				5'b01100: ALUControl = 4'b1011;
				5'b01101: ALUControl = 4'b1100;
				5'b01110: ALUControl = 4'b1101;
				5'b01111: ALUControl = 4'b0000;
				5'b10000: ALUControl = 4'b0010;
				5'b10100: ALUControl = 4'b0010;
			default:	ALUControl = 4'b0000;
			endcase
		end
		
	always_comb
		casex(Instr[15:6])
			10'b0000000001: FlagW = 1'b1;
			10'b0000000010: FlagW = 1'b1;
			10'b0000000011: FlagW = 1'b1;
			10'b0000000100: FlagW = 1'b1;
			10'b0000000101: FlagW = 1'b1;
			10'b0000000110: FlagW = 1'b0;
			10'b0000000111: FlagW = 1'b0;
			10'b0000001000: FlagW = 1'b0;
			10'b0000001001: FlagW = 1'b1;
			10'b0000001010: FlagW = 1'b1;
			10'b0000001011: FlagW = 1'b1;
			10'b0000001100: FlagW = 1'b1;
			10'b0000001101: FlagW = 1'b1;
			10'b0000001110: FlagW = 1'b1;
			10'b0000001111: FlagW = 1'b1;
			10'b0000010000: FlagW = 1'b1;
			10'b0000000000: FlagW = 1'b0;
			10'b0000010010: FlagW = 1'b0;
			10'b0000010011: FlagW = 1'b0;
			10'b0000010100: FlagW = 1'b1;
			default:		  FlagW = 1'bx;
		endcase
endmodule 
	