module SevenSeg(	input 		en,
						input [7:0]	ShowData);
	always@ (en)
		$display("%d",ShowData);
endmodule 