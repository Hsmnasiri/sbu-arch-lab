module ALU(
				output[3:0] F,
				output AeB,
				output G,
				output Cn4,
				output P,
				
				
				input[3:0] S,
				input[3:0] A,
				input[3:0] B,
				input M,
				input Cn
				
				);
				
reg[3:0] Result;
wire GM0,GM1,GM2,GM3;
wire PM0,PM1,PM2,PM3;

assign F = Result; 


//assign Cn4 = OutRipple;


always @(*)
    begin
        case(S)
        4'b0000:
           Result = M ? ~A : (Cn ? A : A + 1) ; 
        4'b0001:
           Result = M ? ~(A | B) : (Cn ? A | B : (A | B) + 1) ; 
        4'b0010:
           Result = M ? ~A & B : (Cn ? A | ~B : (A | ~B) + 1) ; 
        4'b0011:
           Result = M ? 0 : (Cn ? -1 : 0) ; 
        4'b0100:
           Result = M ? ~(A & B) : (Cn ? A + (A & ~B) : (A + (A & ~B)) + 1) ; 
         4'b0101:
           Result = M ? ~B : (Cn ? (A | B) + (A & ~B) : ((A | B) + (A & ~B)) + 1) ; 
         4'b0110:
           Result = M ? ~(A & B) & (A | B) : (Cn ? A - B - 1 : A - B) ; 
         4'b0111:
           Result = M ? A & ~B : (Cn ? (A & ~B) - 1 : A & ~B) ; 
          4'b1000:
           Result = M ? ~A | B: (Cn ? A + (A & B): (A + (A & B)) + 1) ; 
          4'b1001: 
           Result = M ? ~(~(A & B) & (A | B)) : (Cn ? A + B : (A + B) + 1) ; 
          4'b1010: 
           Result = M ? B : (Cn ? (A | ~B) + (A & B) : ((A | ~B) + (A & B)) + 1) ; 
          4'b1011: 
           Result = M ? A & B : (Cn ? (A & B) - 1 : A & B) ; 
          4'b1100:
           Result = M ? 1 : (Cn ? A + A : (A + A) + 1) ; 
          4'b1101:
           Result = M ? A | ~B : (Cn ? (A | B) + A : ((A | B) + A) + 1) ; 
          4'b1110:
           Result = M ? A | B : (Cn ? (A | ~B) + A : ((A | ~B) + A) + 1) ; 
          4'b1111:
           Result = M ? A : (Cn ? A - 1 : A) ; 
          default: Result = A + B ; 
        endcase
    end	
//	 
//always @(*)
//		begin
//			case(S)
//        4'b0000:
//           OutRipple = M ? 0 : (Cn ? 0 : A + 1) ; 
//        4'b0001:
//           OutRipple = M ? 0 : (Cn ? 0 : (A | B) + 1) ; 
//        4'b0010:
//           OutRipple = M ? 0 : (Cn ? 0 : (A | ~B) + 1) ; 
//        4'b0011:
//           OutRipple = M ? 0 : (Cn ? 0 : 0) ; 
//        4'b0100:
//           OutRipple = M ? 0 : (Cn ? A + (A & ~B) : (A + (A & ~B)) + 1) ; 
//         4'b0101:
//           OutRipple = M ? 0 : (Cn ? (A | B) + (A & ~B) : ((A | B) + (A & ~B)) + 1) ; 
//         4'b0110:
//           OutRipple = M ? 0 : (Cn ? A - B - 1 : A - B) ; 
//         4'b0111:
//           OutRipple = M ? 0 : (Cn ? (A & ~B) - 1 : 0) ; 
//          4'b1000:
//           OutRipple = M ? 0 : (Cn ? A + (A & B): (A + (A & B)) + 1) ; 
//          4'b1001: 
//           OutRipple = M ? 0 : (Cn ? A + B : (A + B) + 1) ; 
//          4'b1010: 
//           OutRipple = M ? 0 : (Cn ? (A | ~B) + (A & B) : ((A | ~B) + (A & B)) + 1) ; 
//          4'b1011: 
//           OutRipple = M ? 0 : (Cn ? (A & B) - 1 : 0) ; 
//          4'b1100:
//           OutRipple = M ? 0 : (Cn ? A + A : (A + A) + 1) ; 
//          4'b1101:
//           OutRipple = M ? 0 : (Cn ? (A | B) + A : ((A | B) + A) + 1) ; 
//          4'b1110:
//           OutRipple = M ? 0 : (Cn ? (A | ~B) + A : ((A | ~B) + A) + 1) ; 
//          4'b1111:
//           OutRipple = M ? 0 : (Cn ? A - 1 : A) ; 
//          default: Result = 0 ; 
//		endcase
//		end
		



			 assign GM0 = M ? 0 : (A[0] ? ( B[0] ? S[3] : S[2] ) : 0);
			 assign GM1 = M ? 0 : (A[1] ? ( B[1] ? S[3] : S[2] ) : 0);
			 assign GM2 = M ? 0 : (A[2] ? ( B[2] ? S[3] : S[2] ) : 0);
			 assign GM3 = M ? 0 : (A[3] ? ( B[3] ? S[3] : S[2] ) : 0);
				
				
			assign PM0 =  M ? 0 : (A[0] ? 1 : ( B[0] ? S[0] : S[1] ));
			assign PM1 =  M ? 0 : (A[1] ? 1 : ( B[1] ? S[0] : S[1] ));
			assign PM2 =  M ? 0 : (A[2] ? 1 : ( B[2] ? S[0] : S[1] ));
			assign PM3 =  M ? 0 : (A[3] ? 1 : ( B[3] ? S[0] : S[1] ));
			
			assign G = GM0 & GM1 & GM2 & GM3;
			assign P = PM0 & PM1 & PM2 & PM3;
			
			
			
			assign AeB = (F[3] & F[2] & F[1] & F[0]);	
	
endmodule				




