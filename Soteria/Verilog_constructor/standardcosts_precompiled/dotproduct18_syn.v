/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5-2
// Date      : Thu Sep 17 21:35:11 2020
/////////////////////////////////////////////////////////////


module dotproduct18 ( clk, rst, g_input, e_input, o );
  input [17:0] g_input;
  input [17:0] e_input;
  input clk, rst;
  output o;
  wire   N20, N21, N23, N24, N27, N28, \popcount[4] , \popcount[3] ,
         \popcount[2] , \popcount[1] , N79, N78, N77, N70, N69, N62, N61, N55,
         N54, N53, N46, N45, N39, N38, N33, N32,
         \add_10_root_add_29_I18/carry[1] , \add_11_root_add_29_I18/CI ,
         \add_11_root_add_29_I18/B[0] , \add_11_root_add_29_I18/A[0] ,
         \add_12_root_add_29_I18/CI , \add_12_root_add_29_I18/B[0] ,
         \add_12_root_add_29_I18/A[0] , \add_13_root_add_29_I18/CI ,
         \add_13_root_add_29_I18/B[0] , \add_13_root_add_29_I18/A[0] , n54,
         n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68,
         n69, n70, n71, n72, n73, n74;
  wire   [6:1] \add_6_root_add_29_I18/carry ;
  wire   [6:1] \add_7_root_add_29_I18/carry ;
  wire   [6:1] \add_8_root_add_29_I18/carry ;
  wire   [6:1] \add_9_root_add_29_I18/carry ;

  FADDER \add_6_root_add_29_I18/U1_1  ( .CIN(N70), .IN0(N78), .IN1(
        \add_6_root_add_29_I18/carry [1]), .COUT(
        \add_6_root_add_29_I18/carry [2]), .SUM(\popcount[2] ) );
  FADDER \add_6_root_add_29_I18/U1_2  ( .CIN(\add_8_root_add_29_I18/carry [2]), 
        .IN0(N79), .IN1(\add_6_root_add_29_I18/carry [2]), .COUT(
        \add_6_root_add_29_I18/carry [3]), .SUM(\popcount[3] ) );
  FADDER \add_7_root_add_29_I18/U1_1  ( .CIN(N54), .IN0(N62), .IN1(
        \add_7_root_add_29_I18/carry [1]), .COUT(
        \add_7_root_add_29_I18/carry [2]), .SUM(N78) );
  FADDER \add_7_root_add_29_I18/U1_2  ( .CIN(N55), .IN0(
        \add_9_root_add_29_I18/carry [2]), .IN1(
        \add_7_root_add_29_I18/carry [2]), .COUT(
        \add_7_root_add_29_I18/carry [3]), .SUM(N79) );
  FADDER \add_8_root_add_29_I18/U1_1  ( .CIN(N39), .IN0(N46), .IN1(
        \add_8_root_add_29_I18/carry [1]), .COUT(
        \add_8_root_add_29_I18/carry [2]), .SUM(N70) );
  FADDER \add_9_root_add_29_I18/U1_1  ( .CIN(N28), .IN0(N33), .IN1(
        \add_9_root_add_29_I18/carry [1]), .COUT(
        \add_9_root_add_29_I18/carry [2]), .SUM(N62) );
  FADDER \add_10_root_add_29_I18/U1_1  ( .CIN(N21), .IN0(N24), .IN1(
        \add_10_root_add_29_I18/carry[1] ), .COUT(N55), .SUM(N54) );
  FADDER \add_11_root_add_29_I18/U1_0  ( .CIN(\add_11_root_add_29_I18/A[0] ), 
        .IN0(\add_11_root_add_29_I18/B[0] ), .IN1(\add_11_root_add_29_I18/CI ), 
        .COUT(N46), .SUM(N45) );
  FADDER \add_12_root_add_29_I18/U1_0  ( .CIN(\add_12_root_add_29_I18/A[0] ), 
        .IN0(\add_12_root_add_29_I18/B[0] ), .IN1(\add_12_root_add_29_I18/CI ), 
        .COUT(N39), .SUM(N38) );
  FADDER \add_13_root_add_29_I18/U1_0  ( .CIN(\add_13_root_add_29_I18/A[0] ), 
        .IN0(\add_13_root_add_29_I18/B[0] ), .IN1(\add_13_root_add_29_I18/CI ), 
        .COUT(N33), .SUM(N32) );
  AND U62 ( .A(N69), .B(N77), .Z(\add_6_root_add_29_I18/carry [1]) );
  XOR U63 ( .A(N77), .B(N69), .Z(\popcount[1] ) );
  AND U64 ( .A(N61), .B(N53), .Z(\add_7_root_add_29_I18/carry [1]) );
  XOR U65 ( .A(N61), .B(N53), .Z(N77) );
  AND U66 ( .A(N45), .B(N38), .Z(\add_8_root_add_29_I18/carry [1]) );
  XOR U67 ( .A(N45), .B(N38), .Z(N69) );
  AND U68 ( .A(N32), .B(N27), .Z(\add_9_root_add_29_I18/carry [1]) );
  XOR U69 ( .A(N32), .B(N27), .Z(N61) );
  AND U70 ( .A(N23), .B(N20), .Z(\add_10_root_add_29_I18/carry[1] ) );
  XOR U71 ( .A(N23), .B(N20), .Z(N53) );
  AND U72 ( .A(\add_6_root_add_29_I18/carry [3]), .B(
        \add_7_root_add_29_I18/carry [3]), .Z(\add_6_root_add_29_I18/carry [4]) );
  XOR U73 ( .A(\add_7_root_add_29_I18/carry [3]), .B(
        \add_6_root_add_29_I18/carry [3]), .Z(\popcount[4] ) );
  NANDN U74 ( .B(\add_6_root_add_29_I18/carry [4]), .A(n54), .Z(o) );
  NAND U75 ( .A(n55), .B(\popcount[4] ), .Z(n54) );
  NANDN U76 ( .B(\popcount[1] ), .A(n56), .Z(n55) );
  NOR U77 ( .A(\popcount[3] ), .B(\popcount[2] ), .Z(n56) );
  XNOR U78 ( .A(g_input[9]), .B(e_input[9]), .Z(\add_13_root_add_29_I18/CI )
         );
  XNOR U79 ( .A(g_input[11]), .B(e_input[11]), .Z(
        \add_13_root_add_29_I18/B[0] ) );
  XNOR U80 ( .A(g_input[10]), .B(e_input[10]), .Z(
        \add_13_root_add_29_I18/A[0] ) );
  XNOR U81 ( .A(g_input[12]), .B(e_input[12]), .Z(\add_12_root_add_29_I18/CI )
         );
  XNOR U82 ( .A(g_input[14]), .B(e_input[14]), .Z(
        \add_12_root_add_29_I18/B[0] ) );
  XNOR U83 ( .A(g_input[13]), .B(e_input[13]), .Z(
        \add_12_root_add_29_I18/A[0] ) );
  XNOR U84 ( .A(g_input[15]), .B(e_input[15]), .Z(\add_11_root_add_29_I18/CI )
         );
  XNOR U85 ( .A(g_input[17]), .B(e_input[17]), .Z(
        \add_11_root_add_29_I18/B[0] ) );
  XNOR U86 ( .A(g_input[16]), .B(e_input[16]), .Z(
        \add_11_root_add_29_I18/A[0] ) );
  NAND U87 ( .A(n57), .B(n58), .Z(N28) );
  OR U88 ( .A(n59), .B(n60), .Z(n58) );
  NANDN U89 ( .B(n61), .A(n62), .Z(n57) );
  XOR U90 ( .A(n60), .B(n59), .Z(N27) );
  XOR U91 ( .A(n61), .B(n62), .Z(n59) );
  XNOR U92 ( .A(g_input[7]), .B(e_input[7]), .Z(n62) );
  XOR U93 ( .A(g_input[8]), .B(e_input[8]), .Z(n61) );
  XOR U94 ( .A(g_input[6]), .B(e_input[6]), .Z(n60) );
  NAND U95 ( .A(n63), .B(n64), .Z(N24) );
  OR U96 ( .A(n65), .B(n66), .Z(n64) );
  NANDN U97 ( .B(n67), .A(n68), .Z(n63) );
  XOR U98 ( .A(n66), .B(n65), .Z(N23) );
  XOR U99 ( .A(n67), .B(n68), .Z(n65) );
  XNOR U100 ( .A(g_input[4]), .B(e_input[4]), .Z(n68) );
  XOR U101 ( .A(g_input[5]), .B(e_input[5]), .Z(n67) );
  XOR U102 ( .A(g_input[3]), .B(e_input[3]), .Z(n66) );
  NAND U103 ( .A(n69), .B(n70), .Z(N21) );
  OR U104 ( .A(n71), .B(n72), .Z(n70) );
  NANDN U105 ( .B(n73), .A(n74), .Z(n69) );
  XOR U106 ( .A(n72), .B(n71), .Z(N20) );
  XOR U107 ( .A(n73), .B(n74), .Z(n71) );
  XNOR U108 ( .A(g_input[1]), .B(e_input[1]), .Z(n74) );
  XOR U109 ( .A(g_input[2]), .B(e_input[2]), .Z(n73) );
  XOR U110 ( .A(g_input[0]), .B(e_input[0]), .Z(n72) );
endmodule

