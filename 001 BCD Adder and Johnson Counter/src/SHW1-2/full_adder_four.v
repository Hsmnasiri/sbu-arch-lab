module full_adder_four(
	output[3:0] sum,
	output cout,
	input[3:0] a,
	input[3:0] b,
	input cin
);
	wire c0,c1,c2;

	full_adder_one full_adder_one0(sum[0],c0,a[0],b[0],cin);
	full_adder_one full_adder_one1(sum[1],c1,a[1],b[1],c0);
	full_adder_one full_adder_one2(sum[2],c2,a[2],b[2],c1);
	full_adder_one full_adder_one3(sum[3],cout,a[3],b[3],c2);
endmodule

