/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5-2
// Date      : Thu Sep 17 21:35:18 2020
/////////////////////////////////////////////////////////////


module dotproduct5 ( clk, rst, g_input, e_input, o );
  input [4:0] g_input;
  input [4:0] e_input;
  input clk, rst;
  output o;
  wire   N7, N8, \popcount[3] , \popcount[2] , \popcount[1] ,
         \add_2_root_add_29_I5/carry[1] , \add_2_root_add_29_I5/CI ,
         \add_2_root_add_29_I5/A[0] , n17, n18, n19, n20, n21, n22, n23;

  FADDER \add_2_root_add_29_I5/U1_0  ( .CIN(\add_2_root_add_29_I5/A[0] ), 
        .IN0(N7), .IN1(\add_2_root_add_29_I5/CI ), .COUT(
        \add_2_root_add_29_I5/carry[1] ), .SUM(\popcount[1] ) );
  FADDER \add_2_root_add_29_I5/U1_1  ( .CIN(1'b0), .IN0(N8), .IN1(
        \add_2_root_add_29_I5/carry[1] ), .COUT(\popcount[3] ), .SUM(
        \popcount[2] ) );
  NANDN U21 ( .B(\popcount[3] ), .A(n17), .Z(o) );
  NAND U22 ( .A(\popcount[2] ), .B(\popcount[1] ), .Z(n17) );
  XNOR U23 ( .A(g_input[3]), .B(e_input[3]), .Z(\add_2_root_add_29_I5/CI ) );
  XNOR U24 ( .A(g_input[4]), .B(e_input[4]), .Z(\add_2_root_add_29_I5/A[0] )
         );
  NAND U25 ( .A(n18), .B(n19), .Z(N8) );
  OR U26 ( .A(n20), .B(n21), .Z(n19) );
  NANDN U27 ( .B(n22), .A(n23), .Z(n18) );
  XOR U28 ( .A(n21), .B(n20), .Z(N7) );
  XOR U29 ( .A(n22), .B(n23), .Z(n20) );
  XNOR U30 ( .A(g_input[1]), .B(e_input[1]), .Z(n23) );
  XOR U31 ( .A(g_input[2]), .B(e_input[2]), .Z(n22) );
  XOR U32 ( .A(g_input[0]), .B(e_input[0]), .Z(n21) );
endmodule

