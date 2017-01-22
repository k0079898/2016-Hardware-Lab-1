module Mux_1bit(F, Sel, A, B);
    output F;
    input Sel, A, B;
    // Happy coding!
    wire n_Sel, w1, w2;
    not not1(n_Sel, Sel);
    and and1(w1, Sel, A);
    and and2(w2, n_Sel, B);
    or or1(F, w1, w2);

endmodule

module Mux_8bits(F, Sel, A, B);
    output [7:0] F;
    input  [7:0] A, B;
    input Sel;
    // Happy coding!
    Mux_1bit Mux7(F[7], Sel, A[7], B[7]);
    Mux_1bit Mux6(F[6], Sel, A[6], B[6]);
    Mux_1bit Mux5(F[5], Sel, A[5], B[5]);
    Mux_1bit Mux4(F[4], Sel, A[4], B[4]);
    Mux_1bit Mux3(F[3], Sel, A[3], B[3]);
    Mux_1bit Mux2(F[2], Sel, A[2], B[2]);
    Mux_1bit Mux1(F[1], Sel, A[1], B[1]);
    Mux_1bit Mux0(F[0], Sel, A[0], B[0]);
 
endmodule

module Decoder(Dout, Din);
    output [15:0] Dout;
    input  [3:0]  Din;
    // Your code is welcomed here!
    wire n_b3, n_b2, n_b1, n_b0;
    not not3(n_b3, Din[3]);
    not not2(n_b2, Din[2]);
    not not1(n_b1, Din[1]);
    not not0(n_b0, Din[0]);
    and and15(Dout[15], n_b3, n_b2, n_b1, n_b0);
    and and14(Dout[14], n_b3, n_b2, n_b1, Din[0]);
    and and13(Dout[13], n_b3, n_b2, Din[1], n_b0);
    and and12(Dout[12], n_b3, n_b2, Din[1], Din[0]);
    and and11(Dout[11], n_b3, Din[2], n_b1, n_b0);
    and and10(Dout[10], n_b3, Din[2], n_b1, Din[0]);
    and and9(Dout[9], n_b3, Din[2], Din[1], n_b0);
    and and8(Dout[8], n_b3, Din[2], Din[1], Din[0]);
    and and7(Dout[7], Din[3], n_b2, n_b1, n_b0);
    and and6(Dout[6], Din[3], n_b2, n_b1, Din[0]);
    and and5(Dout[5], Din[3], n_b2, Din[1], n_b0);
    and and4(Dout[4], Din[3], n_b2, Din[1], Din[0]);
    and and3(Dout[3], Din[3], Din[2], n_b1, n_b0);
    and and2(Dout[2], Din[3], Din[2], n_b1, Din[0]);
    and and1(Dout[1], Din[3], Din[2], Din[1], n_b0);
    and and0(Dout[0], Din[3], Din[2], Din[1], Din[0]);
    
endmodule

module Xor(out, A, B);    //Create an XOR module
    input   A, B;
    output  out;
    wire    nA, nB, w1, w2;
    not nota(nA, A);
    not notb(nB, B);
    and and1(w1, nA, B);
    and and2(w2, A, nB);
    or or1(out, w1, w2);
endmodule

module FullAdder(Sum, C_out, C_in, A, B);
    output Sum, C_out;
    input  C_in, A, B;
    // Your code is welcomed here!
    wire xor_w, w1, w2;
    Xor xor1(xor_w, A, B);
    Xor xor2(Sum, xor_w, C_in);
    and and1(w1, C_in, xor_w);
    and and2(w2, A, B);
    or or1(C_out, w1, w2);

endmodule

module RippleCarryAdder(Sum, C_out, C_in, A, B);
    output [3:0] Sum;
    output C_out;
    input  C_in;
    input  [3:0] A, B;
    // Write your code here!
    wire [2:0]  w;
    FullAdder Fa0(Sum[0], w[0], C_in, A[0], B[0]);
    FullAdder Fa1(Sum[1], w[1], w[0], A[1], B[1]);
    FullAdder Fa2(Sum[2], w[2], w[1], A[2], B[2]);
    FullAdder Fa3(Sum[3], C_out, w[2], A[3], B[3]); 

endmodule

module Comparator_3bits(A_lt_B, A_gt_B, A_eq_B, A, B);
    output A_lt_B, A_gt_B, A_eq_B;
    input [2:0] A, B;
    // To write, or not to write ...
    wire [2:0] nA, nB, w_lt, w_gt, w_eq;
    wire w_lt1, w_gt1, w_lt0, w_gt0;
    not not1(nA[2], A[2]);
    not not2(nA[1], A[1]);
    not not3(nA[0], A[0]);
    not not4(nB[2], B[2]);
    not not5(nB[1], B[1]);
    not not6(nB[0], B[0]);
    and and21(w_lt[2], nA[2], B[2]);
    and and22(w_gt[2], A[2], nB[2]);
    and and11(w_lt[1], nA[1], B[1]);
    and and12(w_gt[1], A[1], nB[1]);
    and and01(w_lt[0], nA[0], B[0]);
    and and02(w_gt[0], A[0], nB[0]);
    nor nor2(w_eq[2], w_lt[2], w_gt[2]);
    nor nor1(w_eq[1], w_lt[1], w_gt[1]);
    nor nor0(w_eq[0], w_lt[0], w_gt[0]);
    and and1(A_eq_B, w_eq[2], w_eq[1], w_eq[0]);
    and and2(w_lt1, w_eq[2], w_lt[1]);
    and and3(w_gt1, w_eq[2], w_gt[1]);
    and and4(w_lt0, w_eq[2], w_eq[1], w_lt[0]);
    and and5(w_gt0, w_eq[2], w_eq[1], w_gt[0]);
    or or1(A_lt_B, w_lt[2], w_lt1, w_lt0);
    or or2(A_gt_B, w_gt[2], w_gt1, w_gt0);
endmodule

module Comparator_4bits(A_lt_B, A_gt_B, A_eq_B, A, B);
    output A_lt_B, A_gt_B, A_eq_B;
    input [3:0] A, B;
    // To write, or not to write ...
    wire [3:0] nA, nB, w_lt, w_gt, w_eq;
    wire w_lt2, w_gt2,  w_lt1, w_gt1, w_lt0, w_gt0;
    not not1(nA[3], A[3]);
    not not2(nA[2], A[2]);
    not not3(nA[1], A[1]);
    not not4(nA[0], A[0]);
    not not5(nB[3], B[3]);
    not not6(nB[2], B[2]);
    not not7(nB[1], B[1]);
    not not8(nB[0], B[0]);
    and and31(w_lt[3], nA[3], B[3]);
    and and32(w_gt[3], A[3], nB[3]);
    and and21(w_lt[2], nA[2], B[2]);
    and and22(w_gt[2], A[2], nB[2]);
    and and11(w_lt[1], nA[1], B[1]);
    and and12(w_gt[1], A[1], nB[1]);
    and and01(w_lt[0], nA[0], B[0]);
    and and02(w_gt[0], A[0], nB[0]);
    nor nor3(w_eq[3], w_lt[3], w_gt[3]);
    nor nor2(w_eq[2], w_lt[2], w_gt[2]);
    nor nor1(w_eq[1], w_lt[1], w_gt[1]);
    nor nor0(w_eq[0], w_lt[0], w_gt[0]);
    and and1(A_eq_B, w_eq[3], w_eq[2], w_eq[1], w_eq[0]);
    and and2(w_lt2, w_eq[3], w_lt[2]);
    and and3(w_gt2, w_eq[3], w_gt[2]);
    and and4(w_lt1, w_eq[3], w_eq[2], w_lt[1]);
    and and5(w_gt1, w_eq[3], w_eq[2], w_gt[1]);
    and and6(w_lt0, w_eq[3], w_eq[2], w_eq[1], w_lt[0]);
    and and7(w_gt0, w_eq[3], w_eq[2], w_eq[1], w_gt[0]);
    or or1(A_lt_B, w_lt[3], w_lt2, w_lt1, w_lt0);
    or or2(A_gt_B, w_gt[3], w_gt2, w_gt1, w_gt0);

endmodule


