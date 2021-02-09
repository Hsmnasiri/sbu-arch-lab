module testbench();

reg[11:0] inputA,inputB;
reg cin;
wire[11:0] result;
wire cout;

top top0(result,cout,inputA,inputB,cin);

initial
	begin
	
	//inputA = 346 = 0011 0100 0110
	//inputB = 159	= 0001 0101 1001
	
	//Result = 505 = 0101 0000 0101
	
	cin = 0;
	inputA[11] = 0;
	inputA[10] = 0;
	inputA[9] = 1;
	inputA[8] = 1;
	inputA[7] = 0;
	inputA[6] = 1;
	inputA[5] = 0;
	inputA[4] = 0;
	inputA[3] = 0;
	inputA[2] = 1;
	inputA[1] = 1;
	inputA[0] = 0;
	
	
	inputB[11] = 0;
	inputB[10] = 0;
	inputB[9] = 0;
	inputB[8] = 1;
	inputB[7] = 0;
	inputB[6] = 1;
	inputB[5] = 0;
	inputB[4] = 1;
	inputB[3] = 1;
	inputB[2] = 0;
	inputB[1] = 0;
	inputB[0] = 1;
	#15;

	
	//inputA = 505 = 0101 0000 0101
	//inputB = 519 = 0101 0001 1001
	//Result = 1024 = 0001 0000 0010 0100 (Truth)
	//					 = (Cout=1) 0000 0010 0100 (Expected)
	
	cin = 0;
	inputA[11] = 0;
	inputA[10] = 1;
	inputA[9] = 0;
	inputA[8] = 1;
	inputA[7] = 0;
	inputA[6] = 0;
	inputA[5] = 0;
	inputA[4] = 0;
	inputA[3] = 0;
	inputA[2] = 1;
	inputA[1] = 0;
	inputA[0] = 1;
	
	
	inputB[11] = 0;
	inputB[10] = 1;
	inputB[9] = 0;
	inputB[8] = 1;
	inputB[7] = 0;
	inputB[6] = 0;
	inputB[5] = 0;
	inputB[4] = 1;
	inputB[3] = 1;
	inputB[2] = 0;
	inputB[1] = 0;
	inputB[0] = 1;
	#15;
	
	


	$finish;
end
endmodule