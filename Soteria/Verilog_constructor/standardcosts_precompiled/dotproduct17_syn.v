/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5-2
// Date      : Thu Sep 17 21:35:13 2020
/////////////////////////////////////////////////////////////


module dotproduct17 ( clk, rst, g_input, e_input, o );
  input [16:0] g_input;
  input [16:0] e_input;
  input clk, rst;
  output o;
  wire   N19, N20, N22, N23, N26, N27, \popcount[4] , \popcount[3] ,
         \popcount[2] , \popcount[1] , N70, N69, N68, N61, N60, N54, N53, N52,
         N46, N45, N44, N38, N37, N32, N31, \add_9_root_add_29_I17/carry[1] ,
         \add_10_root_add_29_I17/carry[1] , \add_10_root_add_29_I17/CI ,
         \add_10_root_add_29_I17/A[0] , \add_11_root_add_29_I17/CI ,
         \add_11_root_add_29_I17/B[0] , \add_11_root_add_29_I17/A[0] ,
         \add_12_root_add_29_I17/CI , \add_12_root_add_29_I17/B[0] ,
         \add_12_root_add_29_I17/A[0] , n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71;
  wire   [6:1] \add_6_root_add_29_I17/carry ;
  wire   [6:1] \add_7_root_add_29_I17/carry ;
  wire   [6:1] \add_8_root_add_29_I17/carry ;

  FADDER \add_6_root_add_29_I17/U1_1  ( .CIN(N61), .IN0(N69), .IN1(
        \add_6_root_add_29_I17/carry [1]), .COUT(
        \add_6_root_add_29_I17/carry [2]), .SUM(\popcount[2] ) );
  FADDER \add_6_root_add_29_I17/U1_2  ( .CIN(\add_8_root_add_29_I17/carry [2]), 
        .IN0(N70), .IN1(\add_6_root_add_29_I17/carry [2]), .COUT(
        \add_6_root_add_29_I17/carry [3]), .SUM(\popcount[3] ) );
  FADDER \add_7_root_add_29_I17/U1_1  ( .CIN(N45), .IN0(N53), .IN1(
        \add_7_root_add_29_I17/carry [1]), .COUT(
        \add_7_root_add_29_I17/carry [2]), .SUM(N69) );
  FADDER \add_7_root_add_29_I17/U1_2  ( .CIN(N46), .IN0(N54), .IN1(
        \add_7_root_add_29_I17/carry [2]), .COUT(
        \add_7_root_add_29_I17/carry [3]), .SUM(N70) );
  FADDER \add_8_root_add_29_I17/U1_1  ( .CIN(N32), .IN0(N38), .IN1(
        \add_8_root_add_29_I17/carry [1]), .COUT(
        \add_8_root_add_29_I17/carry [2]), .SUM(N61) );
  FADDER \add_9_root_add_29_I17/U1_1  ( .CIN(N23), .IN0(N27), .IN1(
        \add_9_root_add_29_I17/carry[1] ), .COUT(N54), .SUM(N53) );
  FADDER \add_10_root_add_29_I17/U1_0  ( .CIN(\add_10_root_add_29_I17/A[0] ), 
        .IN0(N19), .IN1(\add_10_root_add_29_I17/CI ), .COUT(
        \add_10_root_add_29_I17/carry[1] ), .SUM(N44) );
  FADDER \add_11_root_add_29_I17/U1_0  ( .CIN(\add_11_root_add_29_I17/A[0] ), 
        .IN0(\add_11_root_add_29_I17/B[0] ), .IN1(\add_11_root_add_29_I17/CI ), 
        .COUT(N38), .SUM(N37) );
  FADDER \add_12_root_add_29_I17/U1_0  ( .CIN(\add_12_root_add_29_I17/A[0] ), 
        .IN0(\add_12_root_add_29_I17/B[0] ), .IN1(\add_12_root_add_29_I17/CI ), 
        .COUT(N32), .SUM(N31) );
  AND U59 ( .A(N60), .B(N68), .Z(\add_6_root_add_29_I17/carry [1]) );
  XOR U60 ( .A(N68), .B(N60), .Z(\popcount[1] ) );
  AND U61 ( .A(N52), .B(N44), .Z(\add_7_root_add_29_I17/carry [1]) );
  XOR U62 ( .A(N52), .B(N44), .Z(N68) );
  AND U63 ( .A(N37), .B(N31), .Z(\add_8_root_add_29_I17/carry [1]) );
  XOR U64 ( .A(N37), .B(N31), .Z(N60) );
  AND U65 ( .A(N26), .B(N22), .Z(\add_9_root_add_29_I17/carry[1] ) );
  XOR U66 ( .A(N26), .B(N22), .Z(N52) );
  AND U67 ( .A(N20), .B(\add_10_root_add_29_I17/carry[1] ), .Z(N46) );
  XOR U68 ( .A(N20), .B(\add_10_root_add_29_I17/carry[1] ), .Z(N45) );
  AND U69 ( .A(\add_6_root_add_29_I17/carry [3]), .B(
        \add_7_root_add_29_I17/carry [3]), .Z(\add_6_root_add_29_I17/carry [4]) );
  XOR U70 ( .A(\add_7_root_add_29_I17/carry [3]), .B(
        \add_6_root_add_29_I17/carry [3]), .Z(\popcount[4] ) );
  NANDN U71 ( .B(\add_6_root_add_29_I17/carry [4]), .A(n51), .Z(o) );
  NAND U72 ( .A(n52), .B(\popcount[4] ), .Z(n51) );
  NANDN U73 ( .B(\popcount[1] ), .A(n53), .Z(n52) );
  NOR U74 ( .A(\popcount[3] ), .B(\popcount[2] ), .Z(n53) );
  XNOR U75 ( .A(g_input[9]), .B(e_input[9]), .Z(\add_12_root_add_29_I17/CI )
         );
  XNOR U76 ( .A(g_input[11]), .B(e_input[11]), .Z(
        \add_12_root_add_29_I17/B[0] ) );
  XNOR U77 ( .A(g_input[10]), .B(e_input[10]), .Z(
        \add_12_root_add_29_I17/A[0] ) );
  XNOR U78 ( .A(g_input[12]), .B(e_input[12]), .Z(\add_11_root_add_29_I17/CI )
         );
  XNOR U79 ( .A(g_input[14]), .B(e_input[14]), .Z(
        \add_11_root_add_29_I17/B[0] ) );
  XNOR U80 ( .A(g_input[13]), .B(e_input[13]), .Z(
        \add_11_root_add_29_I17/A[0] ) );
  XNOR U81 ( .A(g_input[15]), .B(e_input[15]), .Z(\add_10_root_add_29_I17/CI )
         );
  XNOR U82 ( .A(g_input[16]), .B(e_input[16]), .Z(
        \add_10_root_add_29_I17/A[0] ) );
  NAND U83 ( .A(n54), .B(n55), .Z(N27) );
  OR U84 ( .A(n56), .B(n57), .Z(n55) );
  NANDN U85 ( .B(n58), .A(n59), .Z(n54) );
  XOR U86 ( .A(n57), .B(n56), .Z(N26) );
  XOR U87 ( .A(n58), .B(n59), .Z(n56) );
  XNOR U88 ( .A(g_input[7]), .B(e_input[7]), .Z(n59) );
  XOR U89 ( .A(g_input[8]), .B(e_input[8]), .Z(n58) );
  XOR U90 ( .A(g_input[6]), .B(e_input[6]), .Z(n57) );
  NAND U91 ( .A(n60), .B(n61), .Z(N23) );
  OR U92 ( .A(n62), .B(n63), .Z(n61) );
  NANDN U93 ( .B(n64), .A(n65), .Z(n60) );
  XOR U94 ( .A(n63), .B(n62), .Z(N22) );
  XOR U95 ( .A(n64), .B(n65), .Z(n62) );
  XNOR U96 ( .A(g_input[4]), .B(e_input[4]), .Z(n65) );
  XOR U97 ( .A(g_input[5]), .B(e_input[5]), .Z(n64) );
  XOR U98 ( .A(g_input[3]), .B(e_input[3]), .Z(n63) );
  NAND U99 ( .A(n66), .B(n67), .Z(N20) );
  OR U100 ( .A(n68), .B(n69), .Z(n67) );
  NANDN U101 ( .B(n70), .A(n71), .Z(n66) );
  XOR U102 ( .A(n69), .B(n68), .Z(N19) );
  XOR U103 ( .A(n70), .B(n71), .Z(n68) );
  XNOR U104 ( .A(g_input[1]), .B(e_input[1]), .Z(n71) );
  XOR U105 ( .A(g_input[2]), .B(e_input[2]), .Z(n70) );
  XOR U106 ( .A(g_input[0]), .B(e_input[0]), .Z(n69) );
endmodule

