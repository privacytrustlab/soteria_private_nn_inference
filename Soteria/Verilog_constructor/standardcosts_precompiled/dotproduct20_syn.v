/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5-2
// Date      : Thu Sep 17 21:35:15 2020
/////////////////////////////////////////////////////////////


module dotproduct20 ( clk, rst, g_input, e_input, o );
  input [19:0] g_input;
  input [19:0] e_input;
  input clk, rst;
  output o;
  wire   N22, N23, N25, N26, N29, N30, \popcount[4] , \popcount[3] ,
         \popcount[2] , N89, N88, N87, N81, N80, N79, N72, N71, N65, N64, N63,
         N57, N56, N55, N48, N47, N41, N40, N35, N34,
         \add_11_root_add_29_I20/carry[1] , \add_12_root_add_29_I20/carry[1] ,
         \add_12_root_add_29_I20/CI , \add_12_root_add_29_I20/A[0] ,
         \add_13_root_add_29_I20/CI , \add_13_root_add_29_I20/B[0] ,
         \add_13_root_add_29_I20/A[0] , \add_14_root_add_29_I20/CI ,
         \add_14_root_add_29_I20/B[0] , \add_14_root_add_29_I20/A[0] ,
         \add_15_root_add_29_I20/CI , \add_15_root_add_29_I20/B[0] ,
         \add_15_root_add_29_I20/A[0] , n58, n59, n60, n61, n62, n63, n64, n65,
         n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77;
  wire   [6:1] \add_7_root_add_29_I20/carry ;
  wire   [6:1] \add_8_root_add_29_I20/carry ;
  wire   [6:1] \add_9_root_add_29_I20/carry ;
  wire   [6:1] \add_10_root_add_29_I20/carry ;

  FADDER \add_7_root_add_29_I20/U1_1  ( .CIN(N80), .IN0(N88), .IN1(
        \add_7_root_add_29_I20/carry [1]), .COUT(
        \add_7_root_add_29_I20/carry [2]), .SUM(\popcount[2] ) );
  FADDER \add_7_root_add_29_I20/U1_2  ( .CIN(N81), .IN0(N89), .IN1(
        \add_7_root_add_29_I20/carry [2]), .COUT(
        \add_7_root_add_29_I20/carry [3]), .SUM(\popcount[3] ) );
  FADDER \add_7_root_add_29_I20/U1_3  ( .CIN(\add_9_root_add_29_I20/carry [3]), 
        .IN0(\add_8_root_add_29_I20/carry [3]), .IN1(
        \add_7_root_add_29_I20/carry [3]), .COUT(
        \add_7_root_add_29_I20/carry [4]), .SUM(\popcount[4] ) );
  FADDER \add_8_root_add_29_I20/U1_1  ( .CIN(N64), .IN0(N72), .IN1(
        \add_8_root_add_29_I20/carry [1]), .COUT(
        \add_8_root_add_29_I20/carry [2]), .SUM(N88) );
  FADDER \add_8_root_add_29_I20/U1_2  ( .CIN(N65), .IN0(
        \add_10_root_add_29_I20/carry [2]), .IN1(
        \add_8_root_add_29_I20/carry [2]), .COUT(
        \add_8_root_add_29_I20/carry [3]), .SUM(N89) );
  FADDER \add_9_root_add_29_I20/U1_1  ( .CIN(N48), .IN0(N56), .IN1(
        \add_9_root_add_29_I20/carry [1]), .COUT(
        \add_9_root_add_29_I20/carry [2]), .SUM(N80) );
  FADDER \add_10_root_add_29_I20/U1_1  ( .CIN(N35), .IN0(N41), .IN1(
        \add_10_root_add_29_I20/carry [1]), .COUT(
        \add_10_root_add_29_I20/carry [2]), .SUM(N72) );
  FADDER \add_11_root_add_29_I20/U1_1  ( .CIN(N26), .IN0(N30), .IN1(
        \add_11_root_add_29_I20/carry[1] ), .COUT(N65), .SUM(N64) );
  FADDER \add_12_root_add_29_I20/U1_0  ( .CIN(\add_12_root_add_29_I20/A[0] ), 
        .IN0(N22), .IN1(\add_12_root_add_29_I20/CI ), .COUT(
        \add_12_root_add_29_I20/carry[1] ), .SUM(N55) );
  FADDER \add_13_root_add_29_I20/U1_0  ( .CIN(\add_13_root_add_29_I20/A[0] ), 
        .IN0(\add_13_root_add_29_I20/B[0] ), .IN1(\add_13_root_add_29_I20/CI ), 
        .COUT(N48), .SUM(N47) );
  FADDER \add_14_root_add_29_I20/U1_0  ( .CIN(\add_14_root_add_29_I20/A[0] ), 
        .IN0(\add_14_root_add_29_I20/B[0] ), .IN1(\add_14_root_add_29_I20/CI ), 
        .COUT(N41), .SUM(N40) );
  FADDER \add_15_root_add_29_I20/U1_0  ( .CIN(\add_15_root_add_29_I20/A[0] ), 
        .IN0(\add_15_root_add_29_I20/B[0] ), .IN1(\add_15_root_add_29_I20/CI ), 
        .COUT(N35), .SUM(N34) );
  AND U66 ( .A(N71), .B(N63), .Z(\add_8_root_add_29_I20/carry [1]) );
  XOR U67 ( .A(N71), .B(N63), .Z(N87) );
  AND U68 ( .A(N55), .B(N47), .Z(\add_9_root_add_29_I20/carry [1]) );
  XOR U69 ( .A(N55), .B(N47), .Z(N79) );
  AND U70 ( .A(N40), .B(N34), .Z(\add_10_root_add_29_I20/carry [1]) );
  XOR U71 ( .A(N40), .B(N34), .Z(N71) );
  AND U72 ( .A(N29), .B(N25), .Z(\add_11_root_add_29_I20/carry[1] ) );
  XOR U73 ( .A(N29), .B(N25), .Z(N63) );
  AND U74 ( .A(N23), .B(\add_12_root_add_29_I20/carry[1] ), .Z(N57) );
  XOR U75 ( .A(N23), .B(\add_12_root_add_29_I20/carry[1] ), .Z(N56) );
  AND U76 ( .A(N57), .B(\add_9_root_add_29_I20/carry [2]), .Z(
        \add_9_root_add_29_I20/carry [3]) );
  XOR U77 ( .A(N57), .B(\add_9_root_add_29_I20/carry [2]), .Z(N81) );
  NANDN U78 ( .B(\add_7_root_add_29_I20/carry [4]), .A(n58), .Z(o) );
  NAND U79 ( .A(n59), .B(\popcount[4] ), .Z(n58) );
  OR U80 ( .A(\popcount[3] ), .B(\popcount[2] ), .Z(n59) );
  AND U81 ( .A(N87), .B(N79), .Z(\add_7_root_add_29_I20/carry [1]) );
  XNOR U82 ( .A(g_input[9]), .B(e_input[9]), .Z(\add_15_root_add_29_I20/CI )
         );
  XNOR U83 ( .A(g_input[11]), .B(e_input[11]), .Z(
        \add_15_root_add_29_I20/B[0] ) );
  XNOR U84 ( .A(g_input[10]), .B(e_input[10]), .Z(
        \add_15_root_add_29_I20/A[0] ) );
  XNOR U85 ( .A(g_input[12]), .B(e_input[12]), .Z(\add_14_root_add_29_I20/CI )
         );
  XNOR U86 ( .A(g_input[14]), .B(e_input[14]), .Z(
        \add_14_root_add_29_I20/B[0] ) );
  XNOR U87 ( .A(g_input[13]), .B(e_input[13]), .Z(
        \add_14_root_add_29_I20/A[0] ) );
  XNOR U88 ( .A(g_input[15]), .B(e_input[15]), .Z(\add_13_root_add_29_I20/CI )
         );
  XNOR U89 ( .A(g_input[17]), .B(e_input[17]), .Z(
        \add_13_root_add_29_I20/B[0] ) );
  XNOR U90 ( .A(g_input[16]), .B(e_input[16]), .Z(
        \add_13_root_add_29_I20/A[0] ) );
  XNOR U91 ( .A(g_input[18]), .B(e_input[18]), .Z(\add_12_root_add_29_I20/CI )
         );
  XNOR U92 ( .A(g_input[19]), .B(e_input[19]), .Z(
        \add_12_root_add_29_I20/A[0] ) );
  NAND U93 ( .A(n60), .B(n61), .Z(N30) );
  OR U94 ( .A(n62), .B(n63), .Z(n61) );
  NANDN U95 ( .B(n64), .A(n65), .Z(n60) );
  XOR U96 ( .A(n63), .B(n62), .Z(N29) );
  XOR U97 ( .A(n64), .B(n65), .Z(n62) );
  XNOR U98 ( .A(g_input[7]), .B(e_input[7]), .Z(n65) );
  XOR U99 ( .A(g_input[8]), .B(e_input[8]), .Z(n64) );
  XOR U100 ( .A(g_input[6]), .B(e_input[6]), .Z(n63) );
  NAND U101 ( .A(n66), .B(n67), .Z(N26) );
  OR U102 ( .A(n68), .B(n69), .Z(n67) );
  NANDN U103 ( .B(n70), .A(n71), .Z(n66) );
  XOR U104 ( .A(n69), .B(n68), .Z(N25) );
  XOR U105 ( .A(n70), .B(n71), .Z(n68) );
  XNOR U106 ( .A(g_input[4]), .B(e_input[4]), .Z(n71) );
  XOR U107 ( .A(g_input[5]), .B(e_input[5]), .Z(n70) );
  XOR U108 ( .A(g_input[3]), .B(e_input[3]), .Z(n69) );
  NAND U109 ( .A(n72), .B(n73), .Z(N23) );
  OR U110 ( .A(n74), .B(n75), .Z(n73) );
  NANDN U111 ( .B(n76), .A(n77), .Z(n72) );
  XOR U112 ( .A(n75), .B(n74), .Z(N22) );
  XOR U113 ( .A(n76), .B(n77), .Z(n74) );
  XNOR U114 ( .A(g_input[1]), .B(e_input[1]), .Z(n77) );
  XOR U115 ( .A(g_input[2]), .B(e_input[2]), .Z(n76) );
  XOR U116 ( .A(g_input[0]), .B(e_input[0]), .Z(n75) );
endmodule

