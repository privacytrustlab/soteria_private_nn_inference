/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5-2
// Date      : Thu Sep 17 21:35:05 2020
/////////////////////////////////////////////////////////////


module dotproduct4 ( clk, rst, g_input, e_input, o );
  input [3:0] g_input;
  input [3:0] e_input;
  input clk, rst;
  output o;
  wire   N13, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22;
  assign o = N13;

  NAND U13 ( .A(n12), .B(n13), .Z(N13) );
  NANDN U14 ( .B(n14), .A(n15), .Z(n13) );
  AND U15 ( .A(n16), .B(n17), .Z(n12) );
  NANDN U16 ( .B(n18), .A(n19), .Z(n17) );
  NAND U17 ( .A(n20), .B(n21), .Z(n16) );
  OR U18 ( .A(n15), .B(n22), .Z(n21) );
  IV U19 ( .A(n14), .Z(n22) );
  XOR U20 ( .A(g_input[0]), .B(e_input[0]), .Z(n14) );
  NANDN U21 ( .B(n19), .A(n18), .Z(n15) );
  XOR U22 ( .A(g_input[1]), .B(e_input[1]), .Z(n18) );
  XNOR U23 ( .A(g_input[2]), .B(e_input[2]), .Z(n19) );
  XNOR U24 ( .A(g_input[3]), .B(e_input[3]), .Z(n20) );
endmodule

