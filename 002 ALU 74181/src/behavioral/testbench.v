module testbench();

reg[3:0] S;
reg[3:0] A;
reg[3:0] B;
reg M;
reg Cn;

wire[3:0] F;
wire AeB;
wire G;
wire Cn4;
wire P;



ALU alu0(
			F,AeB,G,Cn4,P,
			S,A,B,M,Cn
			);

initial
	begin
		S = 4'b0000;
		A = 4'b0010;
		B = 4'b0110;
		M = 1'b0;
		Cn = 1'b1;

		
		#15;
		S = 4'b0001;
		A = 4'b1010;
		B = 4'b0110;
		M = 1'b0;
		Cn = 1'b0;

	
		#15;
		S = 4'b0010;
		A = 4'b1110;
		B = 4'b1010;
		M = 1'b0;
		Cn = 1'b0;
		
		
		
		#15;
		S = 4'b0011;
		A = 4'b1110;
		B = 4'b0001;
		M = 1'b1;
		Cn = 1'b1;
		
		
		
		#15;
		S = 4'b0100;
		A = 4'b0110;
		B = 4'b1000;
		M = 1'b1;
		Cn = 1'b0;
		
		
		
		#15;
		S = 4'b0101;
		A = 4'b1111;
		B = 4'b1111;
		M = 1'b0;
		Cn = 1'b1;
		
		
		
		#15;
		S = 4'b0110;
		A = 4'b0110;
		B = 4'b0101;
		M = 1'b0;
		Cn = 1'b1;
		
		
		
		
		#15;
		S = 4'b0111;
		A = 4'b1111;
		B = 4'b1111;
		M = 1'b0;
		Cn = 1'b0;
		
		
		
		
		#15;
		S = 4'b1000;
		A = 4'b1111;
		B = 4'b0111;
		M = 1'b0;
		Cn = 1'b0;
		
		
		
		
		#15;
		S = 4'b1001;
		A = 4'b1010;
		B = 4'b0110;
		M = 1'b1;
		Cn = 1'b1;
		
		
		
		
		
		#15;
		S = 4'b1010;
		A = 4'b0111;
		B = 4'b1000;
		M = 1'b0;
		Cn = 1'b1;
		
		
		
		
		#15;
		S = 4'b1011;
		A = 4'b0001;
		B = 4'b0111;
		M = 1'b0;
		Cn = 1'b1;
		
		
		
		
		
		
		#15;
		S = 4'b1100;
		A = 4'b1111;
		B = 4'b1111;
		M = 1'b0;
		Cn = 1'b1;
		
		
		
		
		
		
	   #15;
		S = 4'b1101;
		A = 4'b0110;
		B = 4'b1010;
		M = 1'b1;
		Cn = 1'b1;
		
		
		
		
		
		
		
		
		#15;
		S = 4'b1110;
		A = 4'b0010;
		B = 4'b0111;
		M = 1'b0;
		Cn = 1'b0;
		
		
		
		
		
		
		
		
		
		#15;
		S = 4'b1111;
		A = 4'b0001;
		B = 4'b1110;
		M = 1'b0;
		Cn = 1'b1;


	$finish;
end
endmodule