module regfile(input logic 		clk,
					input logic 		we3, we4,
					input logic [2:0]	ra1, ra2,
											wa3, wa4,
					input logic	[7:0]	wd3, wd4,
					output logic [7:0]	rd1, rd2);

 logic [7:0] rf[7:0];

 // four ported register file
 // read two ports combinationally
 // write third & fourth port on rising edge of clock

	always_ff @(posedge clk)begin
		if (we3) rf[wa3] <= wd3;
		if (we4) rf[wa4] <= wd4;
	end
	
	always_comb begin
		if(we3 & (wa3==ra1)) rd1 = wd3;
		else if(we4 & (wa4==ra1)) rd1 = wd4;
		else rd1 = rf[ra1];

		if(we3 & (wa3==ra2)) rd2 = wd3;
		else if(we4 & (wa4==ra2)) rd2 = wd4;
		else rd2 = rf[ra2];
	end
//	assign	rd1 = rf[ra1];
//	assign	rd2 = rf[ra2];
endmodule 