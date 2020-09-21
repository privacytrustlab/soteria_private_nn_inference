/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5-2
// Date      : Thu Sep 17 21:35:06 2020
/////////////////////////////////////////////////////////////


module dotproduct23 ( clk, rst, g_input, e_input, o );
  input [22:0] g_input;
  input [22:0] e_input;
  input clk, rst;
  output o;
  wire   N25, N26, N28, N29, N32, N33, \popcount[4] , \popcount[3] , N99, N98,
         N91, N90, N83, N82, N76, N75, N74, N68, N67, N66, N59, N58, N51, N50,
         N44, N43, N38, N37, N108, N107, N106, N100,
         \add_13_root_add_29_I23/carry[1] , \add_14_root_add_29_I23/carry[1] ,
         \add_14_root_add_29_I23/CI , \add_14_root_add_29_I23/A[0] ,
         \add_15_root_add_29_I23/CI , \add_15_root_add_29_I23/B[0] ,
         \add_15_root_add_29_I23/A[0] , \add_16_root_add_29_I23/CI ,
         \add_16_root_add_29_I23/B[0] , \add_16_root_add_29_I23/A[0] ,
         \add_17_root_add_29_I23/CI , \add_17_root_add_29_I23/B[0] ,
         \add_17_root_add_29_I23/A[0] , \add_18_root_add_29_I23/CI ,
         \add_18_root_add_29_I23/B[0] , \add_18_root_add_29_I23/A[0] , n65,
         n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79,
         n80, n81, n82, n83, n84, n85, n86, n87;
  wire   [6:1] \add_8_root_add_29_I23/carry ;
  wire   [6:1] \add_9_root_add_29_I23/carry ;
  wire   [6:1] \add_10_root_add_29_I23/carry ;
  wire   [6:1] \add_11_root_add_29_I23/carry ;
  wire   [6:1] \add_12_root_add_29_I23/carry ;

  FADDER \add_8_root_add_29_I23/U1_2  ( .CIN(N100), .IN0(N108), .IN1(
        \add_8_root_add_29_I23/carry [2]), .COUT(
        \add_8_root_add_29_I23/carry [3]), .SUM(\popcount[3] ) );
  FADDER \add_8_root_add_29_I23/U1_3  ( .CIN(\add_10_root_add_29_I23/carry [3]), .IN0(\add_9_root_add_29_I23/carry [3]), .IN1(
        \add_8_root_add_29_I23/carry [3]), .COUT(
        \add_8_root_add_29_I23/carry [4]), .SUM(\popcount[4] ) );
  FADDER \add_9_root_add_29_I23/U1_1  ( .CIN(N83), .IN0(N91), .IN1(
        \add_9_root_add_29_I23/carry [1]), .COUT(
        \add_9_root_add_29_I23/carry [2]), .SUM(N107) );
  FADDER \add_9_root_add_29_I23/U1_2  ( .CIN(\add_12_root_add_29_I23/carry [2]), .IN0(\add_11_root_add_29_I23/carry [2]), .IN1(
        \add_9_root_add_29_I23/carry [2]), .COUT(
        \add_9_root_add_29_I23/carry [3]), .SUM(N108) );
  FADDER \add_10_root_add_29_I23/U1_1  ( .CIN(N67), .IN0(N75), .IN1(
        \add_10_root_add_29_I23/carry [1]), .COUT(
        \add_10_root_add_29_I23/carry [2]), .SUM(N99) );
  FADDER \add_10_root_add_29_I23/U1_2  ( .CIN(N68), .IN0(N76), .IN1(
        \add_10_root_add_29_I23/carry [2]), .COUT(
        \add_10_root_add_29_I23/carry [3]), .SUM(N100) );
  FADDER \add_11_root_add_29_I23/U1_1  ( .CIN(N51), .IN0(N59), .IN1(
        \add_11_root_add_29_I23/carry [1]), .COUT(
        \add_11_root_add_29_I23/carry [2]), .SUM(N91) );
  FADDER \add_12_root_add_29_I23/U1_1  ( .CIN(N38), .IN0(N44), .IN1(
        \add_12_root_add_29_I23/carry [1]), .COUT(
        \add_12_root_add_29_I23/carry [2]), .SUM(N83) );
  FADDER \add_13_root_add_29_I23/U1_1  ( .CIN(N29), .IN0(N33), .IN1(
        \add_13_root_add_29_I23/carry[1] ), .COUT(N76), .SUM(N75) );
  FADDER \add_14_root_add_29_I23/U1_0  ( .CIN(\add_14_root_add_29_I23/A[0] ), 
        .IN0(N25), .IN1(\add_14_root_add_29_I23/CI ), .COUT(
        \add_14_root_add_29_I23/carry[1] ), .SUM(N66) );
  FADDER \add_15_root_add_29_I23/U1_0  ( .CIN(\add_15_root_add_29_I23/A[0] ), 
        .IN0(\add_15_root_add_29_I23/B[0] ), .IN1(\add_15_root_add_29_I23/CI ), 
        .COUT(N59), .SUM(N58) );
  FADDER \add_16_root_add_29_I23/U1_0  ( .CIN(\add_16_root_add_29_I23/A[0] ), 
        .IN0(\add_16_root_add_29_I23/B[0] ), .IN1(\add_16_root_add_29_I23/CI ), 
        .COUT(N51), .SUM(N50) );
  FADDER \add_17_root_add_29_I23/U1_0  ( .CIN(\add_17_root_add_29_I23/A[0] ), 
        .IN0(\add_17_root_add_29_I23/B[0] ), .IN1(\add_17_root_add_29_I23/CI ), 
        .COUT(N44), .SUM(N43) );
  FADDER \add_18_root_add_29_I23/U1_0  ( .CIN(\add_18_root_add_29_I23/A[0] ), 
        .IN0(\add_18_root_add_29_I23/B[0] ), .IN1(\add_18_root_add_29_I23/CI ), 
        .COUT(N38), .SUM(N37) );
  AND U73 ( .A(N90), .B(N82), .Z(\add_9_root_add_29_I23/carry [1]) );
  XOR U74 ( .A(N90), .B(N82), .Z(N106) );
  AND U75 ( .A(N74), .B(N66), .Z(\add_10_root_add_29_I23/carry [1]) );
  XOR U76 ( .A(N74), .B(N66), .Z(N98) );
  AND U77 ( .A(N58), .B(N50), .Z(\add_11_root_add_29_I23/carry [1]) );
  XOR U78 ( .A(N58), .B(N50), .Z(N90) );
  AND U79 ( .A(N43), .B(N37), .Z(\add_12_root_add_29_I23/carry [1]) );
  XOR U80 ( .A(N43), .B(N37), .Z(N82) );
  AND U81 ( .A(N32), .B(N28), .Z(\add_13_root_add_29_I23/carry[1] ) );
  XOR U82 ( .A(N32), .B(N28), .Z(N74) );
  AND U83 ( .A(N26), .B(\add_14_root_add_29_I23/carry[1] ), .Z(N68) );
  XOR U84 ( .A(N26), .B(\add_14_root_add_29_I23/carry[1] ), .Z(N67) );
  NANDN U85 ( .B(\add_8_root_add_29_I23/carry [4]), .A(n65), .Z(o) );
  NAND U86 ( .A(\popcount[4] ), .B(\popcount[3] ), .Z(n65) );
  NAND U87 ( .A(n66), .B(n67), .Z(\add_8_root_add_29_I23/carry [2]) );
  NAND U88 ( .A(n68), .B(N98), .Z(n67) );
  AND U89 ( .A(N106), .B(n69), .Z(n68) );
  OR U90 ( .A(N107), .B(N99), .Z(n69) );
  NAND U91 ( .A(N99), .B(N107), .Z(n66) );
  XNOR U92 ( .A(g_input[9]), .B(e_input[9]), .Z(\add_18_root_add_29_I23/CI )
         );
  XNOR U93 ( .A(g_input[11]), .B(e_input[11]), .Z(
        \add_18_root_add_29_I23/B[0] ) );
  XNOR U94 ( .A(g_input[10]), .B(e_input[10]), .Z(
        \add_18_root_add_29_I23/A[0] ) );
  XNOR U95 ( .A(g_input[12]), .B(e_input[12]), .Z(\add_17_root_add_29_I23/CI )
         );
  XNOR U96 ( .A(g_input[14]), .B(e_input[14]), .Z(
        \add_17_root_add_29_I23/B[0] ) );
  XNOR U97 ( .A(g_input[13]), .B(e_input[13]), .Z(
        \add_17_root_add_29_I23/A[0] ) );
  XNOR U98 ( .A(g_input[15]), .B(e_input[15]), .Z(\add_16_root_add_29_I23/CI )
         );
  XNOR U99 ( .A(g_input[17]), .B(e_input[17]), .Z(
        \add_16_root_add_29_I23/B[0] ) );
  XNOR U100 ( .A(g_input[16]), .B(e_input[16]), .Z(
        \add_16_root_add_29_I23/A[0] ) );
  XNOR U101 ( .A(g_input[18]), .B(e_input[18]), .Z(\add_15_root_add_29_I23/CI ) );
  XNOR U102 ( .A(g_input[20]), .B(e_input[20]), .Z(
        \add_15_root_add_29_I23/B[0] ) );
  XNOR U103 ( .A(g_input[19]), .B(e_input[19]), .Z(
        \add_15_root_add_29_I23/A[0] ) );
  XNOR U104 ( .A(g_input[21]), .B(e_input[21]), .Z(\add_14_root_add_29_I23/CI ) );
  XNOR U105 ( .A(g_input[22]), .B(e_input[22]), .Z(
        \add_14_root_add_29_I23/A[0] ) );
  NAND U106 ( .A(n70), .B(n71), .Z(N33) );
  OR U107 ( .A(n72), .B(n73), .Z(n71) );
  NANDN U108 ( .B(n74), .A(n75), .Z(n70) );
  XOR U109 ( .A(n73), .B(n72), .Z(N32) );
  XOR U110 ( .A(n74), .B(n75), .Z(n72) );
  XNOR U111 ( .A(g_input[7]), .B(e_input[7]), .Z(n75) );
  XOR U112 ( .A(g_input[8]), .B(e_input[8]), .Z(n74) );
  XOR U113 ( .A(g_input[6]), .B(e_input[6]), .Z(n73) );
  NAND U114 ( .A(n76), .B(n77), .Z(N29) );
  OR U115 ( .A(n78), .B(n79), .Z(n77) );
  NANDN U116 ( .B(n80), .A(n81), .Z(n76) );
  XOR U117 ( .A(n79), .B(n78), .Z(N28) );
  XOR U118 ( .A(n80), .B(n81), .Z(n78) );
  XNOR U119 ( .A(g_input[4]), .B(e_input[4]), .Z(n81) );
  XOR U120 ( .A(g_input[5]), .B(e_input[5]), .Z(n80) );
  XOR U121 ( .A(g_input[3]), .B(e_input[3]), .Z(n79) );
  NAND U122 ( .A(n82), .B(n83), .Z(N26) );
  OR U123 ( .A(n84), .B(n85), .Z(n83) );
  NANDN U124 ( .B(n86), .A(n87), .Z(n82) );
  XOR U125 ( .A(n85), .B(n84), .Z(N25) );
  XOR U126 ( .A(n86), .B(n87), .Z(n84) );
  XNOR U127 ( .A(g_input[1]), .B(e_input[1]), .Z(n87) );
  XOR U128 ( .A(g_input[2]), .B(e_input[2]), .Z(n86) );
  XOR U129 ( .A(g_input[0]), .B(e_input[0]), .Z(n85) );
endmodule

