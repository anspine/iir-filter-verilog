module baugh_wooley (
input signed [3:0] A, 
input signed [3:0] B,
output signed [7:0] P
);


wire p00 = A[0] & B[0];
wire p10 = A[1] & B[0];
wire p20 = A[2] & B[0];
wire p30 = ~(A[3] & B[0]);

wire p01 = A[0] & B[1];
wire p11 = A[1] & B[1];
wire p21 = A[2] & B[1];
wire p31 = ~(A[3] & B[1]);

wire p02 = A[0] & B[2];
wire p12 = A[1] & B[2];
wire p22 = A[2] & B[2];
wire p32 = ~(A[3] & B[2]);

wire p03 = ~(A[0] & B[3]);
wire p13 = ~(A[1] & B[3]);
wire p23 = ~(A[2] & B[3]);
wire p33 = A[3] & B[3];


wire s11, s12, s13, s14;
wire c11, c12, c13, c14;

wire s22, s23, s24, s25;
wire c22, c23, c24, c25;

wire s33, s34, s35, s36;
wire c33, c34, c35, c36;

wire rc4, rc5, rc6, rc7;

assign P[0] = p00;

adder U1_1 (.S(P[1]), .C(c11), .a(p10), .b(p01), .c(1'b0));

adder U1_2 (.S(s11), .C(c12), .a(p20), .b(p11), .c(1'b0));

adder U1_3 (.S(s12), .C(c13), .a(p30), .b(p21), .c(1'b0));

adder U1_4 (.S(s13), .C(c14), .a(1'b0), .b(p31), .c(1'b0));


adder U2_1 (.S(P[2]), .C(c22), .a(s11), .b(p02), .c(c11));

adder U2_2 (.S(s22), .C(c23), .a(s12), .b(p12), .c(c12));

adder U2_3 (.S(s23), .C(c24), .a(s13), .b(p22), .c(c13));

adder U2_4 (.S(s24), .C(c25), .a(c14), .b(p32), .c(1'b0));


adder U3_1 (.S(P[3]), .C(c33), .a(s22), .b(p03), .c(c22));

adder U3_2 (.S(s33), .C(c34), .a(s23), .b(p13), .c(1'b1)); 

adder U3_3 (.S(s34), .C(c35), .a(s24), .b(p23), .c(c24));

adder U3_4 (.S(s35), .C(c36), .a(c25), .b(p33), .c(1'b0));


adder F_4 (.S(P[4]), .C(rc4), .a(s33), .b(c23), .c(c33));

adder F_5 (.S(P[5]), .C(rc5), .a(s34), .b(c34), .c(rc4));

adder F_6 (.S(P[6]), .C(rc6), .a(s35), .b(c35), .c(rc5));


adder F_7 (.S(P[7]), .C(rc7), .a(c36), .b(1'b1), .c(rc6)); 

endmodule
