/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5-2
// Date      : Thu Sep 17 21:35:12 2020
/////////////////////////////////////////////////////////////


module dotproduct24 ( clk, rst, g_input, e_input, o );
  input [23:0] g_input;
  input [23:0] e_input;
  input clk, rst;
  output o;
  wire   N26, N27, N29, N30, N33, N34, \popcount[4] , \popcount[3] , N99, N92,
         N91, N84, N83, N77, N76, N75, N68, N67, N60, N59, N52, N51, N45, N44,
         N39, N38, N117, N116, N115, N109, N108, N107, N100,
         \add_14_root_add_29_I24/carry[1] , \add_15_root_add_29_I24/CI ,
         \add_15_root_add_29_I24/B[0] , \add_15_root_add_29_I24/A[0] ,
         \add_16_root_add_29_I24/CI , \add_16_root_add_29_I24/B[0] ,
         \add_16_root_add_29_I24/A[0] , \add_17_root_add_29_I24/CI ,
         \add_17_root_add_29_I24/B[0] , \add_17_root_add_29_I24/A[0] ,
         \add_18_root_add_29_I24/CI , \add_18_root_add_29_I24/B[0] ,
         \add_18_root_add_29_I24/A[0] , \add_19_root_add_29_I24/CI ,
         \add_19_root_add_29_I24/B[0] , \add_19_root_add_29_I24/A[0] , n68,
         n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82,
         n83, n84, n85, n86, n87, n88, n89, n90;
  wire   [6:1] \add_8_root_add_29_I24/carry ;
  wire   [6:1] \add_9_root_add_29_I24/carry ;
  wire   [6:1] \add_10_root_add_29_I24/carry ;
  wire   [6:1] \add_11_root_add_29_I24/carry ;
  wire   [6:1] \add_12_root_add_29_I24/carry ;
  wire   [6:1] \add_13_root_add_29_I24/carry ;

  FADDER \add_8_root_add_29_I24/U1_2  ( .CIN(N109), .IN0(N117), .IN1(
        \add_8_root_add_29_I24/carry [2]), .COUT(
        \add_8_root_add_29_I24/carry [3]), .SUM(\popcount[3] ) );
  FADDER \add_8_root_add_29_I24/U1_3  ( .CIN(\add_10_root_add_29_I24/carry [3]), .IN0(\add_9_root_add_29_I24/carry [3]), .IN1(
        \add_8_root_add_29_I24/carry [3]), .COUT(
        \add_8_root_add_29_I24/carry [4]), .SUM(\popcount[4] ) );
  FADDER \add_9_root_add_29_I24/U1_1  ( .CIN(N92), .IN0(N100), .IN1(
        \add_9_root_add_29_I24/carry [1]), .COUT(
        \add_9_root_add_29_I24/carry [2]), .SUM(N116) );
  FADDER \add_9_root_add_29_I24/U1_2  ( .CIN(\add_12_root_add_29_I24/carry [2]), .IN0(\add_11_root_add_29_I24/carry [2]), .IN1(
        \add_9_root_add_29_I24/carry [2]), .COUT(
        \add_9_root_add_29_I24/carry [3]), .SUM(N117) );
  FADDER \add_10_root_add_29_I24/U1_1  ( .CIN(N76), .IN0(N84), .IN1(
        \add_10_root_add_29_I24/carry [1]), .COUT(
        \add_10_root_add_29_I24/carry [2]), .SUM(N108) );
  FADDER \add_10_root_add_29_I24/U1_2  ( .CIN(N77), .IN0(
        \add_13_root_add_29_I24/carry [2]), .IN1(
        \add_10_root_add_29_I24/carry [2]), .COUT(
        \add_10_root_add_29_I24/carry [3]), .SUM(N109) );
  FADDER \add_11_root_add_29_I24/U1_1  ( .CIN(N60), .IN0(N68), .IN1(
        \add_11_root_add_29_I24/carry [1]), .COUT(
        \add_11_root_add_29_I24/carry [2]), .SUM(N100) );
  FADDER \add_12_root_add_29_I24/U1_1  ( .CIN(N45), .IN0(N52), .IN1(
        \add_12_root_add_29_I24/carry [1]), .COUT(
        \add_12_root_add_29_I24/carry [2]), .SUM(N92) );
  FADDER \add_13_root_add_29_I24/U1_1  ( .CIN(N34), .IN0(N39), .IN1(
        \add_13_root_add_29_I24/carry [1]), .COUT(
        \add_13_root_add_29_I24/carry [2]), .SUM(N84) );
  FADDER \add_14_root_add_29_I24/U1_1  ( .CIN(N27), .IN0(N30), .IN1(
        \add_14_root_add_29_I24/carry[1] ), .COUT(N77), .SUM(N76) );
  FADDER \add_15_root_add_29_I24/U1_0  ( .CIN(\add_15_root_add_29_I24/A[0] ), 
        .IN0(\add_15_root_add_29_I24/B[0] ), .IN1(\add_15_root_add_29_I24/CI ), 
        .COUT(N68), .SUM(N67) );
  FADDER \add_16_root_add_29_I24/U1_0  ( .CIN(\add_16_root_add_29_I24/A[0] ), 
        .IN0(\add_16_root_add_29_I24/B[0] ), .IN1(\add_16_root_add_29_I24/CI ), 
        .COUT(N60), .SUM(N59) );
  FADDER \add_17_root_add_29_I24/U1_0  ( .CIN(\add_17_root_add_29_I24/A[0] ), 
        .IN0(\add_17_root_add_29_I24/B[0] ), .IN1(\add_17_root_add_29_I24/CI ), 
        .COUT(N52), .SUM(N51) );
  FADDER \add_18_root_add_29_I24/U1_0  ( .CIN(\add_18_root_add_29_I24/A[0] ), 
        .IN0(\add_18_root_add_29_I24/B[0] ), .IN1(\add_18_root_add_29_I24/CI ), 
        .COUT(N45), .SUM(N44) );
  FADDER \add_19_root_add_29_I24/U1_0  ( .CIN(\add_19_root_add_29_I24/A[0] ), 
        .IN0(\add_19_root_add_29_I24/B[0] ), .IN1(\add_19_root_add_29_I24/CI ), 
        .COUT(N39), .SUM(N38) );
  AND U76 ( .A(N99), .B(N91), .Z(\add_9_root_add_29_I24/carry [1]) );
  XOR U77 ( .A(N99), .B(N91), .Z(N115) );
  AND U78 ( .A(N83), .B(N75), .Z(\add_10_root_add_29_I24/carry [1]) );
  XOR U79 ( .A(N83), .B(N75), .Z(N107) );
  AND U80 ( .A(N67), .B(N59), .Z(\add_11_root_add_29_I24/carry [1]) );
  XOR U81 ( .A(N67), .B(N59), .Z(N99) );
  AND U82 ( .A(N51), .B(N44), .Z(\add_12_root_add_29_I24/carry [1]) );
  XOR U83 ( .A(N51), .B(N44), .Z(N91) );
  AND U84 ( .A(N38), .B(N33), .Z(\add_13_root_add_29_I24/carry [1]) );
  XOR U85 ( .A(N38), .B(N33), .Z(N83) );
  AND U86 ( .A(N29), .B(N26), .Z(\add_14_root_add_29_I24/carry[1] ) );
  XOR U87 ( .A(N29), .B(N26), .Z(N75) );
  NANDN U88 ( .B(\add_8_root_add_29_I24/carry [4]), .A(n68), .Z(o) );
  NAND U89 ( .A(\popcount[4] ), .B(\popcount[3] ), .Z(n68) );
  NAND U90 ( .A(n69), .B(n70), .Z(\add_8_root_add_29_I24/carry [2]) );
  NAND U91 ( .A(n71), .B(N115), .Z(n70) );
  AND U92 ( .A(N107), .B(n72), .Z(n71) );
  OR U93 ( .A(N116), .B(N108), .Z(n72) );
  NAND U94 ( .A(N116), .B(N108), .Z(n69) );
  XNOR U95 ( .A(g_input[9]), .B(e_input[9]), .Z(\add_19_root_add_29_I24/CI )
         );
  XNOR U96 ( .A(g_input[11]), .B(e_input[11]), .Z(
        \add_19_root_add_29_I24/B[0] ) );
  XNOR U97 ( .A(g_input[10]), .B(e_input[10]), .Z(
        \add_19_root_add_29_I24/A[0] ) );
  XNOR U98 ( .A(g_input[12]), .B(e_input[12]), .Z(\add_18_root_add_29_I24/CI )
         );
  XNOR U99 ( .A(g_input[14]), .B(e_input[14]), .Z(
        \add_18_root_add_29_I24/B[0] ) );
  XNOR U100 ( .A(g_input[13]), .B(e_input[13]), .Z(
        \add_18_root_add_29_I24/A[0] ) );
  XNOR U101 ( .A(g_input[15]), .B(e_input[15]), .Z(\add_17_root_add_29_I24/CI ) );
  XNOR U102 ( .A(g_input[17]), .B(e_input[17]), .Z(
        \add_17_root_add_29_I24/B[0] ) );
  XNOR U103 ( .A(g_input[16]), .B(e_input[16]), .Z(
        \add_17_root_add_29_I24/A[0] ) );
  XNOR U104 ( .A(g_input[18]), .B(e_input[18]), .Z(\add_16_root_add_29_I24/CI ) );
  XNOR U105 ( .A(g_input[20]), .B(e_input[20]), .Z(
        \add_16_root_add_29_I24/B[0] ) );
  XNOR U106 ( .A(g_input[19]), .B(e_input[19]), .Z(
        \add_16_root_add_29_I24/A[0] ) );
  XNOR U107 ( .A(g_input[21]), .B(e_input[21]), .Z(\add_15_root_add_29_I24/CI ) );
  XNOR U108 ( .A(g_input[23]), .B(e_input[23]), .Z(
        \add_15_root_add_29_I24/B[0] ) );
  XNOR U109 ( .A(g_input[22]), .B(e_input[22]), .Z(
        \add_15_root_add_29_I24/A[0] ) );
  NAND U110 ( .A(n73), .B(n74), .Z(N34) );
  OR U111 ( .A(n75), .B(n76), .Z(n74) );
  NANDN U112 ( .B(n77), .A(n78), .Z(n73) );
  XOR U113 ( .A(n76), .B(n75), .Z(N33) );
  XOR U114 ( .A(n77), .B(n78), .Z(n75) );
  XNOR U115 ( .A(g_input[7]), .B(e_input[7]), .Z(n78) );
  XOR U116 ( .A(g_input[8]), .B(e_input[8]), .Z(n77) );
  XOR U117 ( .A(g_input[6]), .B(e_input[6]), .Z(n76) );
  NAND U118 ( .A(n79), .B(n80), .Z(N30) );
  OR U119 ( .A(n81), .B(n82), .Z(n80) );
  NANDN U120 ( .B(n83), .A(n84), .Z(n79) );
  XOR U121 ( .A(n82), .B(n81), .Z(N29) );
  XOR U122 ( .A(n83), .B(n84), .Z(n81) );
  XNOR U123 ( .A(g_input[4]), .B(e_input[4]), .Z(n84) );
  XOR U124 ( .A(g_input[5]), .B(e_input[5]), .Z(n83) );
  XOR U125 ( .A(g_input[3]), .B(e_input[3]), .Z(n82) );
  NAND U126 ( .A(n85), .B(n86), .Z(N27) );
  OR U127 ( .A(n87), .B(n88), .Z(n86) );
  NANDN U128 ( .B(n89), .A(n90), .Z(n85) );
  XOR U129 ( .A(n88), .B(n87), .Z(N26) );
  XOR U130 ( .A(n89), .B(n90), .Z(n87) );
  XNOR U131 ( .A(g_input[1]), .B(e_input[1]), .Z(n90) );
  XOR U132 ( .A(g_input[2]), .B(e_input[2]), .Z(n89) );
  XOR U133 ( .A(g_input[0]), .B(e_input[0]), .Z(n88) );
endmodule

