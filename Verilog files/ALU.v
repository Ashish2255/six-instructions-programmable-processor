module ALU
(
input [15:0] A,
input [15:0] B,

input s1,
input s0,
output [15:0] C
) ;

wire sel ;  
assign sel = ~s0;  // sel is the negation of s0

wire c1,c2,c3,c4,c5,c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, cout;
wire [15:0] temp;

// XOR gates to compute complement if sel is 1 i.e. substraction instruction
//xor x1(temp[0],B[0],sel);
xor x0(temp[0], B[0], sel);
xor x1(temp[1], B[1], sel);
xor x2(temp[2], B[2], sel);
xor x3(temp[3], B[3], sel);
xor x4(temp[4], B[4], sel);
xor x5(temp[5], B[5], sel);
xor x6(temp[6], B[6], sel);
xor x7(temp[7], B[7], sel);
xor x8(temp[8], B[8], sel);
xor x9(temp[9], B[9], sel);
xor x10(temp[10], B[10], sel);
xor x11(temp[11], B[11], sel);
xor x12(temp[12], B[12], sel);
xor x13(temp[13], B[13], sel);
xor x14(temp[14], B[14], sel);
xor x15(temp[15], B[15], sel);

// Full Adder instances to compute C
FullAdder f1 ( .a(A[0]) , .b(temp[0]) , .cin(sel) , .s(C[0]) , .cout(c1) ) ;
FullAdder f2 ( .a(A[1]) , .b(temp[1]) , .cin(c1) , .s(C[1]) , .cout(c2) ) ;
FullAdder f3 ( .a(A[2]) , .b(temp[2]) , .cin(c2) , .s(C[2]) , .cout(c3) ) ;
FullAdder f4 ( .a(A[3]) , .b(temp[3]) , .cin(c3) , .s(C[3]) , .cout(c4) ) ;
FullAdder f5 ( .a(A[4]) , .b(temp[4]) , .cin(c4) , .s(C[4]) , .cout(c5) ) ;
FullAdder f6 ( .a(A[5]) , .b(temp[5]) , .cin(c5) , .s(C[5]) , .cout(c6) ) ;
FullAdder f7 ( .a(A[6]) , .b(temp[6]) , .cin(c6) , .s(C[6]) , .cout(c7) ) ;
FullAdder f8 ( .a(A[7]) , .b(temp[7]) , .cin(c7) , .s(C[7]) , .cout(c8) ) ;
FullAdder f9 ( .a(A[8]) , .b(temp[8]) , .cin(c8) , .s(C[8]) , .cout(c9) ) ;
FullAdder f10 ( .a(A[9]) , .b(temp[9]) , .cin(c9) , .s(C[9]) , .cout(c10) ) ;
FullAdder f11 ( .a(A[10]) , .b(temp[10]) , .cin(c10) , .s(C[10]) , .cout(c11) ) ;
FullAdder f12 ( .a(A[11]) , .b(temp[11]) , .cin(c11) , .s(C[11]) , .cout(c12) ) ;
FullAdder f13 ( .a(A[12]) , .b(temp[12]) , .cin(c12) , .s(C[12]) , .cout(c13) ) ;
FullAdder f14 ( .a(A[13]) , .b(temp[13]) , .cin(c13) , .s(C[13]) , .cout(c14) ) ;
FullAdder f15 ( .a(A[14]) , .b(temp[14]) , .cin(c14) , .s(C[14]) , .cout(c15) ) ;
FullAdder f16 ( .a(A[15]) , .b(temp[15]) , .cin(c15) , .s(C[15]) , .cout(cout) ) ;

endmodule


// full adder module for one bit addition
module FullAdder( a,b,cin,s,cout );


input wire a,b,cin ;
output wire s,cout ;


wire w1,w2,w3;

xor(s,cin,a,b); 
and(w1,b,cin);
and(w2,a,cin);
and(w3,a,b);
or(cout,w1,w2,w3);


endmodule