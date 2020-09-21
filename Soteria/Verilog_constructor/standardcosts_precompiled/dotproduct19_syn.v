/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5-2
// Date      : Thu Sep 17 21:35:07 2020
/////////////////////////////////////////////////////////////


module dotproduct19 ( clk, rst, g_input, e_input, o );
  input [18:0] g_input;
  input [18:0] e_input;
  input clk, rst;
  output o;
  wire   N21, N22, N24, N25, N28, N29, \popcount[4] , \popcount[3] ,
         \popcount[2] , N80, N79, N78, N71, N70, N63, N62, N56, N55, N54, N47,
         N46, N40, N39, N34, N33, \add_11_root_add_29_I19/carry[1] ,
         \add_11_root_add_29_I19/CI , \add_12_root_add_29_I19/CI ,
         \add_12_root_add_29_I19/B[0] , \add_12_root_add_29_I19/A[0] ,
         \add_13_root_add_29_I19/CI , \add_13_root_add_29_I19/B[0] ,
         \add_13_root_add_29_I19/A[0] , \add_14_root_add_29_I19/CI ,
         \add_14_root_add_29_I19/B[0] , \add_14_root_add_29_I19/A[0] , n55,
         n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69,
         n70, n71, n72, n73, n74;
  wire   [6:1] \add_7_root_add_29_I19/carry ;
  wire   [6:1] \add_8_root_add_29_I19/carry ;
  wire   [6:1] \add_9_root_add_29_I19/carry ;
  wire   [6:1] \add_10_root_add_29_I19/carry ;

  FADDER \add_7_root_add_29_I19/U1_1  ( .CIN(N71), .IN0(N79), .IN1(
        \add_7_root_add_29_I19/carry [1]), .COUT(
        \add_7_root_add_29_I19/carry [2]), .SUM(\popcount[2] ) );
  FADDER \add_7_root_add_29_I19/U1_2  ( .CIN(\add_9_root_add_29_I19/carry [2]), 
        .IN0(N80), .IN1(\add_7_root_add_29_I19/carry [2]), .COUT(
        \add_7_root_add_29_I19/carry [3]), .SUM(\popcount[3] ) );
  FADDER \add_8_root_add_29_I19/U1_1  ( .CIN(N55), .IN0(N63), .IN1(
        \add_8_root_add_29_I19/carry [1]), .COUT(
        \add_8_root_add_29_I19/carry [2]), .SUM(N79) );
  FADDER \add_8_root_add_29_I19/U1_2  ( .CIN(N56), .IN0(
        \add_10_root_add_29_I19/carry [2]), .IN1(
        \add_8_root_add_29_I19/carry [2]), .COUT(
        \add_8_root_add_29_I19/carry [3]), .SUM(N80) );
  FADDER \add_9_root_add_29_I19/U1_1  ( .CIN(N40), .IN0(N47), .IN1(
        \add_9_root_add_29_I19/carry [1]), .COUT(
        \add_9_root_add_29_I19/carry [2]), .SUM(N71) );
  FADDER \add_10_root_add_29_I19/U1_1  ( .CIN(N29), .IN0(N34), .IN1(
        \add_10_root_add_29_I19/carry [1]), .COUT(
        \add_10_root_add_29_I19/carry [2]), .SUM(N63) );
  FADDER \add_11_root_add_29_I19/U1_0  ( .CIN(N21), .IN0(N24), .IN1(
        \add_11_root_add_29_I19/CI ), .COUT(\add_11_root_add_29_I19/carry[1] ), 
        .SUM(N54) );
  FADDER \add_11_root_add_29_I19/U1_1  ( .CIN(N22), .IN0(N25), .IN1(
        \add_11_root_add_29_I19/carry[1] ), .COUT(N56), .SUM(N55) );
  FADDER \add_12_root_add_29_I19/U1_0  ( .CIN(\add_12_root_add_29_I19/A[0] ), 
        .IN0(\add_12_root_add_29_I19/B[0] ), .IN1(\add_12_root_add_29_I19/CI ), 
        .COUT(N47), .SUM(N46) );
  FADDER \add_13_root_add_29_I19/U1_0  ( .CIN(\add_13_root_add_29_I19/A[0] ), 
        .IN0(\add_13_root_add_29_I19/B[0] ), .IN1(\add_13_root_add_29_I19/CI ), 
        .COUT(N40), .SUM(N39) );
  FADDER \add_14_root_add_29_I19/U1_0  ( .CIN(\add_14_root_add_29_I19/A[0] ), 
        .IN0(\add_14_root_add_29_I19/B[0] ), .IN1(\add_14_root_add_29_I19/CI ), 
        .COUT(N34), .SUM(N33) );
  AND U63 ( .A(N62), .B(N54), .Z(\add_8_root_add_29_I19/carry [1]) );
  XOR U64 ( .A(N62), .B(N54), .Z(N78) );
  AND U65 ( .A(N46), .B(N39), .Z(\add_9_root_add_29_I19/carry [1]) );
  XOR U66 ( .A(N46), .B(N39), .Z(N70) );
  AND U67 ( .A(N33), .B(N28), .Z(\add_10_root_add_29_I19/carry [1]) );
  XOR U68 ( .A(N33), .B(N28), .Z(N62) );
  AND U69 ( .A(\add_7_root_add_29_I19/carry [3]), .B(
        \add_8_root_add_29_I19/carry [3]), .Z(\add_7_root_add_29_I19/carry [4]) );
  XOR U70 ( .A(\add_8_root_add_29_I19/carry [3]), .B(
        \add_7_root_add_29_I19/carry [3]), .Z(\popcount[4] ) );
  NANDN U71 ( .B(\add_7_root_add_29_I19/carry [4]), .A(n55), .Z(o) );
  NAND U72 ( .A(n56), .B(\popcount[4] ), .Z(n55) );
  OR U73 ( .A(\popcount[3] ), .B(\popcount[2] ), .Z(n56) );
  AND U74 ( .A(N78), .B(N70), .Z(\add_7_root_add_29_I19/carry [1]) );
  XNOR U75 ( .A(g_input[9]), .B(e_input[9]), .Z(\add_14_root_add_29_I19/CI )
         );
  XNOR U76 ( .A(g_input[11]), .B(e_input[11]), .Z(
        \add_14_root_add_29_I19/B[0] ) );
  XNOR U77 ( .A(g_input[10]), .B(e_input[10]), .Z(
        \add_14_root_add_29_I19/A[0] ) );
  XNOR U78 ( .A(g_input[12]), .B(e_input[12]), .Z(\add_13_root_add_29_I19/CI )
         );
  XNOR U79 ( .A(g_input[14]), .B(e_input[14]), .Z(
        \add_13_root_add_29_I19/B[0] ) );
  XNOR U80 ( .A(g_input[13]), .B(e_input[13]), .Z(
        \add_13_root_add_29_I19/A[0] ) );
  XNOR U81 ( .A(g_input[15]), .B(e_input[15]), .Z(\add_12_root_add_29_I19/CI )
         );
  XNOR U82 ( .A(g_input[17]), .B(e_input[17]), .Z(
        \add_12_root_add_29_I19/B[0] ) );
  XNOR U83 ( .A(g_input[16]), .B(e_input[16]), .Z(
        \add_12_root_add_29_I19/A[0] ) );
  XNOR U84 ( .A(g_input[18]), .B(e_input[18]), .Z(\add_11_root_add_29_I19/CI )
         );
  NAND U85 ( .A(n57), .B(n58), .Z(N29) );
  OR U86 ( .A(n59), .B(n60), .Z(n58) );
  NANDN U87 ( .B(n61), .A(n62), .Z(n57) );
  XOR U88 ( .A(n60), .B(n59), .Z(N28) );
  XOR U89 ( .A(n61), .B(n62), .Z(n59) );
  XNOR U90 ( .A(g_input[7]), .B(e_input[7]), .Z(n62) );
  XOR U91 ( .A(g_input[8]), .B(e_input[8]), .Z(n61) );
  XOR U92 ( .A(g_input[6]), .B(e_input[6]), .Z(n60) );
  NAND U93 ( .A(n63), .B(n64), .Z(N25) );
  OR U94 ( .A(n65), .B(n66), .Z(n64) );
  NANDN U95 ( .B(n67), .A(n68), .Z(n63) );
  XOR U96 ( .A(n66), .B(n65), .Z(N24) );
  XOR U97 ( .A(n67), .B(n68), .Z(n65) );
  XNOR U98 ( .A(g_input[4]), .B(e_input[4]), .Z(n68) );
  XOR U99 ( .A(g_input[5]), .B(e_input[5]), .Z(n67) );
  XOR U100 ( .A(g_input[3]), .B(e_input[3]), .Z(n66) );
  NAND U101 ( .A(n69), .B(n70), .Z(N22) );
  OR U102 ( .A(n71), .B(n72), .Z(n70) );
  NANDN U103 ( .B(n73), .A(n74), .Z(n69) );
  XOR U104 ( .A(n72), .B(n71), .Z(N21) );
  XOR U105 ( .A(n73), .B(n74), .Z(n71) );
  XNOR U106 ( .A(g_input[1]), .B(e_input[1]), .Z(n74) );
  XOR U107 ( .A(g_input[2]), .B(e_input[2]), .Z(n73) );
  XOR U108 ( .A(g_input[0]), .B(e_input[0]), .Z(n72) );
endmodule

