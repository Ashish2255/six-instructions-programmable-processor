module MUX_16to1(
    input [15:0] I0,  // Inputs
    input [15:0] I1,
    input S,       // Select input
  output [15:0] w1   // Output
);

    // Creating 16 2-to-1 multiplexers
    MUX_2to1 mux0(I0[0], I1[0], S, w1[0]);
    MUX_2to1 mux1(I0[1], I1[1], S, w1[1]);
    MUX_2to1 mux2(I0[2], I1[2], S, w1[2]);
    MUX_2to1 mux3(I0[3], I1[3], S, w1[3]);
    MUX_2to1 mux4(I0[4], I1[4], S, w1[4]);
    MUX_2to1 mux5(I0[5], I1[5], S, w1[5]);
    MUX_2to1 mux6(I0[6], I1[6], S, w1[6]);
    MUX_2to1 mux7(I0[7], I1[7], S, w1[7]);
    MUX_2to1 mux8(I0[8], I1[8], S, w1[8]);
    MUX_2to1 mux9(I0[9], I1[9], S, w1[9]);
    MUX_2to1 mux10(I0[10], I1[10], S, w1[10]);
    MUX_2to1 mux11(I0[11], I1[11], S, w1[11]);
    MUX_2to1 mux12(I0[12], I1[12], S, w1[12]);
    MUX_2to1 mux13(I0[13], I1[13], S, w1[13]);
    MUX_2to1 mux14(I0[14], I1[14], S, w1[14]);
    MUX_2to1 mux15(I0[15], I1[15], S, w1[15]);


endmodule

module MUX_2to1(
    input I0, I1,  // Inputs
    input S,       // Select input
    output  O   // Output
);

    wire w1, w2, w3;

    // AND gates
    and gate1(w1, ~S, I0);   // (S' * I0)
    and gate2(w2, S, I1);    // (S * I1)

    // OR gate
    or gate3(O, w1, w2);     // (S' * I0) + (S * I1)

endmodule
