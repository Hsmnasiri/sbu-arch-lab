module testbench();

	logic 			clk, reset;
	logic [15:0]	Instr;
// instantiate device to be tested
	top dut(clk, reset, Instr);
// initialize test
	initial begin
		reset <= 1; # 22; reset <= 0;
	end
// generate clock to sequence tests
	always begin
		clk <= 1; # 5; clk <= 0; # 5;
	end
	
	always @(negedge clk)
	begin
		$display("Instr: %h", Instr);
		if(Instr === 4'b0) begin
			$stop;
		end
	end
endmodule