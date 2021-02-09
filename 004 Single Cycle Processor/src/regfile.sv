module regfile(input logic 		clk,
					input logic 		we3, we4,
					input logic [2:0]	ra1, ra2,
											wa3, wa4,
					input logic	[7:0]	wd3,
					output logic [7:0]	rd1, rd2);

 logic [7:0] rf[7:0];

 // four ported register file
 // read two ports combinationally
 // write third & fourth port on rising edge of clock

  always_ff @(posedge clk) begin
      if (we3) rf[wa3] <= wd3;
		if (we4) rf[wa4] <= rd1;
	end
  
  assign rd1 = rf[ra1];
  assign rd2 = rf[ra2];

endmodule 