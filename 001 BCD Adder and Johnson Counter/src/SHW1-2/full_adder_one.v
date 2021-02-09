module full_adder_one(
	output sum, cout,
	input in1, in2, cin
);
	wire w1,w2,w3;

	xor(w1,in1,in2);
	and(w2,w1,cin);
	and(w3,in1,in2);
	xor(sum,w1,cin);
	or(cout,w2,w3);
endmodule

