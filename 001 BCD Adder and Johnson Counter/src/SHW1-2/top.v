//module top();
//
//reg[2:0] a[3:0];
//reg[2:0] b[3:0];
//reg[2:0] res[3:0];
//reg cin;
//reg cout;
//
//wire c0,c1;
//
//bcd_one bcd_one0(res[0],c0,a[0],b[0],cin);
//bcd_one bcd_one1(res[1],c1,a[1],b[1],c0);
//bcd_one bcd_one2(res[0],cout,a[2],b[2],c1);
//
//endmodule

module top(output[11:0] s,output cout, input[11:0] a, input[11:0] b , input cin);
	wire x0 , x1;
	
	bcd_one bcd_one0(s[3:0],x0,a[3:0],b[3:0],cin);
	bcd_one bcd_one1(s[7:4],x1,a[7:4],b[7:4],x0);
	bcd_one bcd_one2(s[11:8],cout,a[11:8],b[11:8],x1);

endmodule
