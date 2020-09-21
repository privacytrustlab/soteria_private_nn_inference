/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5-2
// Date      : Thu Sep 17 21:35:08 2020
/////////////////////////////////////////////////////////////


module dotproduct2 ( clk, rst, g_input, e_input, o );
  input [1:0] g_input;
  input [1:0] e_input;
  input clk, rst;
  output o;
  wire   N4, n3, n4;
  assign o = N4;

  NAND U4 ( .A(n3), .B(n4), .Z(N4) );
  XOR U5 ( .A(g_input[0]), .B(e_input[0]), .Z(n4) );
  XOR U6 ( .A(g_input[1]), .B(e_input[1]), .Z(n3) );
endmodule

