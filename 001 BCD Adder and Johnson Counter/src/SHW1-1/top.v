module top(
	output[7:0] led,
	input clk,clr
	);
	
	reg Qd,Qc,Qb,Qa;
	reg ok;
	
	initial Qd = 1'b0;
	initial Qc = 1'b0;
	initial Qb = 1'b0;
	initial Qa = 1'b0;



	always @ (posedge clk or posedge clr)
	if (clr) begin
		Qa <= 1'b0;
		Qb <= 1'b0;
		Qc <= 1'b0;
		Qd <= 1'b0;
	end
	else begin
		Qa <= ~Qd;
		Qb <= Qa;
		Qc <= Qb;
		Qd <= Qc;
		ok <= 1'b1;
	end

	and(led[7],Qd,~Qc,~Qb,~Qa);
	and(led[6],Qd,Qc,~Qb,~Qa);
	and(led[5],Qd,Qc,Qb,~Qa);
	and(led[4],Qd,Qc,Qb,Qa);
	and(led[3],~Qd,Qc,Qb,Qa);
	and(led[2],~Qd,~Qc,Qb,Qa);
	and(led[1],~Qd,~Qc,~Qb,Qa);
	and(led[0],~Qd,~Qc,~Qb,~Qa);
endmodule