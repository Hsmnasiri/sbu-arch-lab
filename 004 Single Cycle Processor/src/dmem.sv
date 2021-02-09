module dmem(input logic				clk,
				input logic [7:0]		a,
				output logic [7:0]	rd);
	logic [7:0]	RAM[255:0];
	
	assign rd = RAM[a[7:2]]; //word alligned
endmodule 