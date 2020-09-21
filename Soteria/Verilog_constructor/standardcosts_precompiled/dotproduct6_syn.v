/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5-2
// Date      : Thu Sep 17 21:35:14 2020
/////////////////////////////////////////////////////////////


module dotproduct6 ( clk, rst, g_input, e_input, o );
  input [5:0] g_input;
  input [5:0] e_input;
  input clk, rst;
  output o;
  wire   N8, N9, N11, N12, \popcount[3] , \popcount[2] , \popcount[1] ,
         \add_2_root_add_29_I6/carry[1] , n23, n24, n25, n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n35;

  FADDER \add_2_root_add_29_I6/U1_0  ( .CIN(N8), .IN0(N11), .IN1(1'b0), .COUT(
        \add_2_root_add_29_I6/carry[1] ), .SUM(\popcount[1] ) );
  FADDER \add_2_root_add_29_I6/U1_1  ( .CIN(N9), .IN0(N12), .IN1(
        \add_2_root_add_29_I6/carry[1] ), .COUT(\popcount[3] ), .SUM(
        \popcount[2] ) );
  NANDN U29 ( .B(\popcount[3] ), .A(n23), .Z(o) );
  NAND U30 ( .A(\popcount[2] ), .B(\popcount[1] ), .Z(n23) );
  NAND U31 ( .A(n24), .B(n25), .Z(N9) );
  OR U32 ( .A(n26), .B(n27), .Z(n25) );
  NANDN U33 ( .B(n28), .A(n29), .Z(n24) );
  XOR U34 ( .A(n27), .B(n26), .Z(N8) );
  XOR U35 ( .A(n28), .B(n29), .Z(n26) );
  XNOR U36 ( .A(g_input[1]), .B(e_input[1]), .Z(n29) );
  XOR U37 ( .A(g_input[2]), .B(e_input[2]), .Z(n28) );
  XOR U38 ( .A(g_input[0]), .B(e_input[0]), .Z(n27) );
  NAND U39 ( .A(n30), .B(n31), .Z(N12) );
  OR U40 ( .A(n32), .B(n33), .Z(n31) );
  NANDN U41 ( .B(n34), .A(n35), .Z(n30) );
  XOR U42 ( .A(n33), .B(n32), .Z(N11) );
  XOR U43 ( .A(n34), .B(n35), .Z(n32) );
  XNOR U44 ( .A(g_input[4]), .B(e_input[4]), .Z(n35) );
  XOR U45 ( .A(g_input[5]), .B(e_input[5]), .Z(n34) );
  XOR U46 ( .A(g_input[3]), .B(e_input[3]), .Z(n33) );
endmodule

