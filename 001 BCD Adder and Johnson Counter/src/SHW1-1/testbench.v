 module testbench();
 
 reg clk , clear;
 wire[7:0] out;
 
 top jj(out,clk,clear);
 
 initial 
   begin 
     clk = 0; 
     clear = 0; 
	#80;
	clear = 1;
	#20;
	clear = 0;

   end

   always 
     #20  clk =  ! clk; 
	  
	
 
 endmodule
 