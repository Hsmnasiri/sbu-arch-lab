module bcd_one(
	output[3:0] sum,
	output cN,
	input[3:0] a,
	input[3:0] b,
	input cin
);
	wire[3:0] sumprime ;
	wire[3:0] temp;
	wire junk;
	supply0 gnd;


	wire carry_out;
	full_adder_four full_adder_four0(sumprime[3:0],cout,a[3:0],b[3:0],cin);
	
	assign cN = (sumprime[3]&sumprime[2])|(sumprime[3]&sumprime[1])|cout;

	assign temp[0] = 1'b0;
	assign temp[3] = 1'b0;
	assign temp[1] = cN;
	assign temp[2] = cN;
	 
	
	full_adder_four full_adder_four1(sum[3:0],junk,sumprime[3:0],temp[3:0],gnd);	


	
endmodule
