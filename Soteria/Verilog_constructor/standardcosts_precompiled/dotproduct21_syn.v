/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5-2
// Date      : Thu Sep 17 21:35:14 2020
/////////////////////////////////////////////////////////////


module dotproduct21 ( clk, rst, g_input, e_input, o );
  input [20:0] g_input;
  input [20:0] e_input;
  input clk, rst;
  output o;
  wire   N23, N24, N26, N27, N30, N31, \popcount[4] , \popcount[3] ,
         \popcount[2] , \popcount[1] , N98, N97, N96, N90, N89, N88, N81, N80,
         N73, N72, N66, N65, N64, N57, N56, N49, N48, N42, N41, N36, N35,
         \add_12_root_add_29_I21/carry[1] , \add_13_root_add_29_I21/CI ,
         \add_13_root_add_29_I21/B[0] , \add_13_root_add_29_I21/A[0] ,
         \add_14_root_add_29_I21/CI , \add_14_root_add_29_I21/B[0] ,
         \add_14_root_add_29_I21/A[0] , \add_15_root_add_29_I21/CI ,
         \add_15_root_add_29_I21/B[0] , \add_15_root_add_29_I21/A[0] ,
         \add_16_root_add_29_I21/CI , \add_16_root_add_29_I21/B[0] ,
         \add_16_root_add_29_I21/A[0] , n61, n62, n63, n64, n65, n66, n67, n68,
         n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81;
  wire   [6:1] \add_7_root_add_29_I21/carry ;
  wire   [6:1] \add_8_root_add_29_I21/carry ;
  wire   [6:1] \add_9_root_add_29_I21/carry ;
  wire   [6:1] \add_10_root_add_29_I21/carry ;
  wire   [6:1] \add_11_root_add_29_I21/carry ;

  FADDER \add_7_root_add_29_I21/U1_1  ( .CIN(N89), .IN0(N97), .IN1(
        \add_7_root_add_29_I21/carry [1]), .COUT(
        \add_7_root_add_29_I21/carry [2]), .SUM(\popcount[2] ) );
  FADDER \add_7_root_add_29_I21/U1_2  ( .CIN(N90), .IN0(N98), .IN1(
        \add_7_root_add_29_I21/carry [2]), .COUT(
        \add_7_root_add_29_I21/carry [3]), .SUM(\popcount[3] ) );
  FADDER \add_7_root_add_29_I21/U1_3  ( .CIN(\add_9_root_add_29_I21/carry [3]), 
        .IN0(\add_8_root_add_29_I21/carry [3]), .IN1(
        \add_7_root_add_29_I21/carry [3]), .COUT(
        \add_7_root_add_29_I21/carry [4]), .SUM(\popcount[4] ) );
  FADDER \add_8_root_add_29_I21/U1_1  ( .CIN(N73), .IN0(N81), .IN1(
        \add_8_root_add_29_I21/carry [1]), .COUT(
        \add_8_root_add_29_I21/carry [2]), .SUM(N97) );
  FADDER \add_8_root_add_29_I21/U1_2  ( .CIN(\add_11_root_add_29_I21/carry [2]), .IN0(\add_10_root_add_29_I21/carry [2]), .IN1(
        \add_8_root_add_29_I21/carry [2]), .COUT(
        \add_8_root_add_29_I21/carry [3]), .SUM(N98) );
  FADDER \add_9_root_add_29_I21/U1_1  ( .CIN(N57), .IN0(N65), .IN1(
        \add_9_root_add_29_I21/carry [1]), .COUT(
        \add_9_root_add_29_I21/carry [2]), .SUM(N89) );
  FADDER \add_10_root_add_29_I21/U1_1  ( .CIN(N42), .IN0(N49), .IN1(
        \add_10_root_add_29_I21/carry [1]), .COUT(
        \add_10_root_add_29_I21/carry [2]), .SUM(N81) );
  FADDER \add_11_root_add_29_I21/U1_1  ( .CIN(N31), .IN0(N36), .IN1(
        \add_11_root_add_29_I21/carry [1]), .COUT(
        \add_11_root_add_29_I21/carry [2]), .SUM(N73) );
  FADDER \add_12_root_add_29_I21/U1_1  ( .CIN(N24), .IN0(N27), .IN1(
        \add_12_root_add_29_I21/carry[1] ), .COUT(N66), .SUM(N65) );
  FADDER \add_13_root_add_29_I21/U1_0  ( .CIN(\add_13_root_add_29_I21/A[0] ), 
        .IN0(\add_13_root_add_29_I21/B[0] ), .IN1(\add_13_root_add_29_I21/CI ), 
        .COUT(N57), .SUM(N56) );
  FADDER \add_14_root_add_29_I21/U1_0  ( .CIN(\add_14_root_add_29_I21/A[0] ), 
        .IN0(\add_14_root_add_29_I21/B[0] ), .IN1(\add_14_root_add_29_I21/CI ), 
        .COUT(N49), .SUM(N48) );
  FADDER \add_15_root_add_29_I21/U1_0  ( .CIN(\add_15_root_add_29_I21/A[0] ), 
        .IN0(\add_15_root_add_29_I21/B[0] ), .IN1(\add_15_root_add_29_I21/CI ), 
        .COUT(N42), .SUM(N41) );
  FADDER \add_16_root_add_29_I21/U1_0  ( .CIN(\add_16_root_add_29_I21/A[0] ), 
        .IN0(\add_16_root_add_29_I21/B[0] ), .IN1(\add_16_root_add_29_I21/CI ), 
        .COUT(N36), .SUM(N35) );
  AND U69 ( .A(N88), .B(N96), .Z(\add_7_root_add_29_I21/carry [1]) );
  XOR U70 ( .A(N96), .B(N88), .Z(\popcount[1] ) );
  AND U71 ( .A(N80), .B(N72), .Z(\add_8_root_add_29_I21/carry [1]) );
  XOR U72 ( .A(N80), .B(N72), .Z(N96) );
  AND U73 ( .A(N64), .B(N56), .Z(\add_9_root_add_29_I21/carry [1]) );
  XOR U74 ( .A(N64), .B(N56), .Z(N88) );
  AND U75 ( .A(N48), .B(N41), .Z(\add_10_root_add_29_I21/carry [1]) );
  XOR U76 ( .A(N48), .B(N41), .Z(N80) );
  AND U77 ( .A(N35), .B(N30), .Z(\add_11_root_add_29_I21/carry [1]) );
  XOR U78 ( .A(N35), .B(N30), .Z(N72) );
  AND U79 ( .A(N26), .B(N23), .Z(\add_12_root_add_29_I21/carry[1] ) );
  XOR U80 ( .A(N26), .B(N23), .Z(N64) );
  AND U81 ( .A(N66), .B(\add_9_root_add_29_I21/carry [2]), .Z(
        \add_9_root_add_29_I21/carry [3]) );
  XOR U82 ( .A(N66), .B(\add_9_root_add_29_I21/carry [2]), .Z(N90) );
  NANDN U83 ( .B(\add_7_root_add_29_I21/carry [4]), .A(n61), .Z(o) );
  NAND U84 ( .A(n62), .B(\popcount[4] ), .Z(n61) );
  NANDN U85 ( .B(\popcount[3] ), .A(n63), .Z(n62) );
  NAND U86 ( .A(\popcount[2] ), .B(\popcount[1] ), .Z(n63) );
  XNOR U87 ( .A(g_input[9]), .B(e_input[9]), .Z(\add_16_root_add_29_I21/CI )
         );
  XNOR U88 ( .A(g_input[11]), .B(e_input[11]), .Z(
        \add_16_root_add_29_I21/B[0] ) );
  XNOR U89 ( .A(g_input[10]), .B(e_input[10]), .Z(
        \add_16_root_add_29_I21/A[0] ) );
  XNOR U90 ( .A(g_input[12]), .B(e_input[12]), .Z(\add_15_root_add_29_I21/CI )
         );
  XNOR U91 ( .A(g_input[14]), .B(e_input[14]), .Z(
        \add_15_root_add_29_I21/B[0] ) );
  XNOR U92 ( .A(g_input[13]), .B(e_input[13]), .Z(
        \add_15_root_add_29_I21/A[0] ) );
  XNOR U93 ( .A(g_input[15]), .B(e_input[15]), .Z(\add_14_root_add_29_I21/CI )
         );
  XNOR U94 ( .A(g_input[17]), .B(e_input[17]), .Z(
        \add_14_root_add_29_I21/B[0] ) );
  XNOR U95 ( .A(g_input[16]), .B(e_input[16]), .Z(
        \add_14_root_add_29_I21/A[0] ) );
  XNOR U96 ( .A(g_input[18]), .B(e_input[18]), .Z(\add_13_root_add_29_I21/CI )
         );
  XNOR U97 ( .A(g_input[20]), .B(e_input[20]), .Z(
        \add_13_root_add_29_I21/B[0] ) );
  XNOR U98 ( .A(g_input[19]), .B(e_input[19]), .Z(
        \add_13_root_add_29_I21/A[0] ) );
  NAND U99 ( .A(n64), .B(n65), .Z(N31) );
  OR U100 ( .A(n66), .B(n67), .Z(n65) );
  NANDN U101 ( .B(n68), .A(n69), .Z(n64) );
  XOR U102 ( .A(n67), .B(n66), .Z(N30) );
  XOR U103 ( .A(n68), .B(n69), .Z(n66) );
  XNOR U104 ( .A(g_input[7]), .B(e_input[7]), .Z(n69) );
  XOR U105 ( .A(g_input[8]), .B(e_input[8]), .Z(n68) );
  XOR U106 ( .A(g_input[6]), .B(e_input[6]), .Z(n67) );
  NAND U107 ( .A(n70), .B(n71), .Z(N27) );
  OR U108 ( .A(n72), .B(n73), .Z(n71) );
  NANDN U109 ( .B(n74), .A(n75), .Z(n70) );
  XOR U110 ( .A(n73), .B(n72), .Z(N26) );
  XOR U111 ( .A(n74), .B(n75), .Z(n72) );
  XNOR U112 ( .A(g_input[4]), .B(e_input[4]), .Z(n75) );
  XOR U113 ( .A(g_input[5]), .B(e_input[5]), .Z(n74) );
  XOR U114 ( .A(g_input[3]), .B(e_input[3]), .Z(n73) );
  NAND U115 ( .A(n76), .B(n77), .Z(N24) );
  OR U116 ( .A(n78), .B(n79), .Z(n77) );
  NANDN U117 ( .B(n80), .A(n81), .Z(n76) );
  XOR U118 ( .A(n79), .B(n78), .Z(N23) );
  XOR U119 ( .A(n80), .B(n81), .Z(n78) );
  XNOR U120 ( .A(g_input[1]), .B(e_input[1]), .Z(n81) );
  XOR U121 ( .A(g_input[2]), .B(e_input[2]), .Z(n80) );
  XOR U122 ( .A(g_input[0]), .B(e_input[0]), .Z(n79) );
endmodule

