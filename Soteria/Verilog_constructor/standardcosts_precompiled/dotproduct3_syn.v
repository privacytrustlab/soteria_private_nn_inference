/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5-2
// Date      : Thu Sep 17 21:35:19 2020
/////////////////////////////////////////////////////////////


module dotproduct3 ( clk, rst, g_input, e_input, o );
  input [2:0] g_input;
  input [2:0] e_input;
  input clk, rst;
  output o;
  wire   N8, n8, n9, n10, n11, n12, n13, n14;
  assign o = N8;

  NAND U11 ( .A(n8), .B(n9), .Z(N8) );
  OR U12 ( .A(n10), .B(n11), .Z(n9) );
  AND U13 ( .A(n12), .B(n13), .Z(n8) );
  OR U14 ( .A(n14), .B(n11), .Z(n13) );
  XOR U15 ( .A(g_input[2]), .B(e_input[2]), .Z(n11) );
  OR U16 ( .A(n10), .B(n14), .Z(n12) );
  XOR U17 ( .A(g_input[1]), .B(e_input[1]), .Z(n14) );
  XOR U18 ( .A(g_input[0]), .B(e_input[0]), .Z(n10) );
endmodule

