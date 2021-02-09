module imem(input logic [7:0]	a,
				output logic [15:0]	rd);
	logic	[15:0]	RAM[255:0];

	initial
		$readmemh("memfile.dat",RAM);

	assign rd = RAM[a[7:2]]; // word alligned
endmodule 