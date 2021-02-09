module BCD(	input 		en,
				input [7:0]	ShowData);
	always@(en)
		$display("%b",ShowData);
endmodule 