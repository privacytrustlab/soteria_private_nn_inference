/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5-2
// Date      : Thu Sep 17 21:35:17 2020
/////////////////////////////////////////////////////////////


module dotproduct25 ( clk, rst, g_input, e_input, o );
  input [24:0] g_input;
  input [24:0] e_input;
  input clk, rst;
  output o;
  wire   N27, N28, N30, N31, N34, N35, \popcount[4] , \popcount[3] ,
         \popcount[2] , \popcount[1] , N93, N92, N85, N84, N78, N77, N76, N69,
         N68, N61, N60, N53, N52, N46, N45, N40, N39, N118, N117, N116, N110,
         N109, N108, N101, N100, \add_15_root_add_29_I25/carry[1] ,
         \add_15_root_add_29_I25/CI , \add_16_root_add_29_I25/CI ,
         \add_16_root_add_29_I25/B[0] , \add_16_root_add_29_I25/A[0] ,
         \add_17_root_add_29_I25/CI , \add_17_root_add_29_I25/B[0] ,
         \add_17_root_add_29_I25/A[0] , \add_18_root_add_29_I25/CI ,
         \add_18_root_add_29_I25/B[0] , \add_18_root_add_29_I25/A[0] ,
         \add_19_root_add_29_I25/CI , \add_19_root_add_29_I25/B[0] ,
         \add_19_root_add_29_I25/A[0] , \add_20_root_add_29_I25/CI ,
         \add_20_root_add_29_I25/B[0] , \add_20_root_add_29_I25/A[0] , n69,
         n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83,
         n84, n85, n86, n87, n88, n89;
  wire   [6:1] \add_9_root_add_29_I25/carry ;
  wire   [6:1] \add_10_root_add_29_I25/carry ;
  wire   [6:1] \add_11_root_add_29_I25/carry ;
  wire   [6:1] \add_12_root_add_29_I25/carry ;
  wire   [6:1] \add_13_root_add_29_I25/carry ;
  wire   [6:1] \add_14_root_add_29_I25/carry ;

  FADDER \add_9_root_add_29_I25/U1_1  ( .CIN(N109), .IN0(N117), .IN1(
        \add_9_root_add_29_I25/carry [1]), .COUT(
        \add_9_root_add_29_I25/carry [2]), .SUM(\popcount[2] ) );
  FADDER \add_9_root_add_29_I25/U1_2  ( .CIN(N110), .IN0(N118), .IN1(
        \add_9_root_add_29_I25/carry [2]), .COUT(
        \add_9_root_add_29_I25/carry [3]), .SUM(\popcount[3] ) );
  FADDER \add_9_root_add_29_I25/U1_3  ( .CIN(\add_11_root_add_29_I25/carry [3]), .IN0(\add_10_root_add_29_I25/carry [3]), .IN1(
        \add_9_root_add_29_I25/carry [3]), .COUT(
        \add_9_root_add_29_I25/carry [4]), .SUM(\popcount[4] ) );
  FADDER \add_10_root_add_29_I25/U1_1  ( .CIN(N93), .IN0(N101), .IN1(
        \add_10_root_add_29_I25/carry [1]), .COUT(
        \add_10_root_add_29_I25/carry [2]), .SUM(N117) );
  FADDER \add_10_root_add_29_I25/U1_2  ( .CIN(
        \add_13_root_add_29_I25/carry [2]), .IN0(
        \add_12_root_add_29_I25/carry [2]), .IN1(
        \add_10_root_add_29_I25/carry [2]), .COUT(
        \add_10_root_add_29_I25/carry [3]), .SUM(N118) );
  FADDER \add_11_root_add_29_I25/U1_1  ( .CIN(N77), .IN0(N85), .IN1(
        \add_11_root_add_29_I25/carry [1]), .COUT(
        \add_11_root_add_29_I25/carry [2]), .SUM(N109) );
  FADDER \add_11_root_add_29_I25/U1_2  ( .CIN(N78), .IN0(
        \add_14_root_add_29_I25/carry [2]), .IN1(
        \add_11_root_add_29_I25/carry [2]), .COUT(
        \add_11_root_add_29_I25/carry [3]), .SUM(N110) );
  FADDER \add_12_root_add_29_I25/U1_1  ( .CIN(N61), .IN0(N69), .IN1(
        \add_12_root_add_29_I25/carry [1]), .COUT(
        \add_12_root_add_29_I25/carry [2]), .SUM(N101) );
  FADDER \add_13_root_add_29_I25/U1_1  ( .CIN(N46), .IN0(N53), .IN1(
        \add_13_root_add_29_I25/carry [1]), .COUT(
        \add_13_root_add_29_I25/carry [2]), .SUM(N93) );
  FADDER \add_14_root_add_29_I25/U1_1  ( .CIN(N35), .IN0(N40), .IN1(
        \add_14_root_add_29_I25/carry [1]), .COUT(
        \add_14_root_add_29_I25/carry [2]), .SUM(N85) );
  FADDER \add_15_root_add_29_I25/U1_0  ( .CIN(N27), .IN0(N30), .IN1(
        \add_15_root_add_29_I25/CI ), .COUT(\add_15_root_add_29_I25/carry[1] ), 
        .SUM(N76) );
  FADDER \add_15_root_add_29_I25/U1_1  ( .CIN(N28), .IN0(N31), .IN1(
        \add_15_root_add_29_I25/carry[1] ), .COUT(N78), .SUM(N77) );
  FADDER \add_16_root_add_29_I25/U1_0  ( .CIN(\add_16_root_add_29_I25/A[0] ), 
        .IN0(\add_16_root_add_29_I25/B[0] ), .IN1(\add_16_root_add_29_I25/CI ), 
        .COUT(N69), .SUM(N68) );
  FADDER \add_17_root_add_29_I25/U1_0  ( .CIN(\add_17_root_add_29_I25/A[0] ), 
        .IN0(\add_17_root_add_29_I25/B[0] ), .IN1(\add_17_root_add_29_I25/CI ), 
        .COUT(N61), .SUM(N60) );
  FADDER \add_18_root_add_29_I25/U1_0  ( .CIN(\add_18_root_add_29_I25/A[0] ), 
        .IN0(\add_18_root_add_29_I25/B[0] ), .IN1(\add_18_root_add_29_I25/CI ), 
        .COUT(N53), .SUM(N52) );
  FADDER \add_19_root_add_29_I25/U1_0  ( .CIN(\add_19_root_add_29_I25/A[0] ), 
        .IN0(\add_19_root_add_29_I25/B[0] ), .IN1(\add_19_root_add_29_I25/CI ), 
        .COUT(N46), .SUM(N45) );
  FADDER \add_20_root_add_29_I25/U1_0  ( .CIN(\add_20_root_add_29_I25/A[0] ), 
        .IN0(\add_20_root_add_29_I25/B[0] ), .IN1(\add_20_root_add_29_I25/CI ), 
        .COUT(N40), .SUM(N39) );
  AND U77 ( .A(N108), .B(N116), .Z(\add_9_root_add_29_I25/carry [1]) );
  XOR U78 ( .A(N116), .B(N108), .Z(\popcount[1] ) );
  AND U79 ( .A(N100), .B(N92), .Z(\add_10_root_add_29_I25/carry [1]) );
  XOR U80 ( .A(N100), .B(N92), .Z(N116) );
  AND U81 ( .A(N84), .B(N76), .Z(\add_11_root_add_29_I25/carry [1]) );
  XOR U82 ( .A(N84), .B(N76), .Z(N108) );
  AND U83 ( .A(N68), .B(N60), .Z(\add_12_root_add_29_I25/carry [1]) );
  XOR U84 ( .A(N68), .B(N60), .Z(N100) );
  AND U85 ( .A(N52), .B(N45), .Z(\add_13_root_add_29_I25/carry [1]) );
  XOR U86 ( .A(N52), .B(N45), .Z(N92) );
  AND U87 ( .A(N39), .B(N34), .Z(\add_14_root_add_29_I25/carry [1]) );
  XOR U88 ( .A(N39), .B(N34), .Z(N84) );
  NANDN U89 ( .B(\add_9_root_add_29_I25/carry [4]), .A(n69), .Z(o) );
  NAND U90 ( .A(n70), .B(\popcount[4] ), .Z(n69) );
  AND U91 ( .A(\popcount[3] ), .B(n71), .Z(n70) );
  OR U92 ( .A(\popcount[2] ), .B(\popcount[1] ), .Z(n71) );
  XNOR U93 ( .A(g_input[9]), .B(e_input[9]), .Z(\add_20_root_add_29_I25/CI )
         );
  XNOR U94 ( .A(g_input[11]), .B(e_input[11]), .Z(
        \add_20_root_add_29_I25/B[0] ) );
  XNOR U95 ( .A(g_input[10]), .B(e_input[10]), .Z(
        \add_20_root_add_29_I25/A[0] ) );
  XNOR U96 ( .A(g_input[12]), .B(e_input[12]), .Z(\add_19_root_add_29_I25/CI )
         );
  XNOR U97 ( .A(g_input[14]), .B(e_input[14]), .Z(
        \add_19_root_add_29_I25/B[0] ) );
  XNOR U98 ( .A(g_input[13]), .B(e_input[13]), .Z(
        \add_19_root_add_29_I25/A[0] ) );
  XNOR U99 ( .A(g_input[15]), .B(e_input[15]), .Z(\add_18_root_add_29_I25/CI )
         );
  XNOR U100 ( .A(g_input[17]), .B(e_input[17]), .Z(
        \add_18_root_add_29_I25/B[0] ) );
  XNOR U101 ( .A(g_input[16]), .B(e_input[16]), .Z(
        \add_18_root_add_29_I25/A[0] ) );
  XNOR U102 ( .A(g_input[18]), .B(e_input[18]), .Z(\add_17_root_add_29_I25/CI ) );
  XNOR U103 ( .A(g_input[20]), .B(e_input[20]), .Z(
        \add_17_root_add_29_I25/B[0] ) );
  XNOR U104 ( .A(g_input[19]), .B(e_input[19]), .Z(
        \add_17_root_add_29_I25/A[0] ) );
  XNOR U105 ( .A(g_input[21]), .B(e_input[21]), .Z(\add_16_root_add_29_I25/CI ) );
  XNOR U106 ( .A(g_input[23]), .B(e_input[23]), .Z(
        \add_16_root_add_29_I25/B[0] ) );
  XNOR U107 ( .A(g_input[22]), .B(e_input[22]), .Z(
        \add_16_root_add_29_I25/A[0] ) );
  XNOR U108 ( .A(g_input[24]), .B(e_input[24]), .Z(\add_15_root_add_29_I25/CI ) );
  NAND U109 ( .A(n72), .B(n73), .Z(N35) );
  OR U110 ( .A(n74), .B(n75), .Z(n73) );
  NANDN U111 ( .B(n76), .A(n77), .Z(n72) );
  XOR U112 ( .A(n75), .B(n74), .Z(N34) );
  XOR U113 ( .A(n76), .B(n77), .Z(n74) );
  XNOR U114 ( .A(g_input[7]), .B(e_input[7]), .Z(n77) );
  XOR U115 ( .A(g_input[8]), .B(e_input[8]), .Z(n76) );
  XOR U116 ( .A(g_input[6]), .B(e_input[6]), .Z(n75) );
  NAND U117 ( .A(n78), .B(n79), .Z(N31) );
  OR U118 ( .A(n80), .B(n81), .Z(n79) );
  NANDN U119 ( .B(n82), .A(n83), .Z(n78) );
  XOR U120 ( .A(n81), .B(n80), .Z(N30) );
  XOR U121 ( .A(n82), .B(n83), .Z(n80) );
  XNOR U122 ( .A(g_input[4]), .B(e_input[4]), .Z(n83) );
  XOR U123 ( .A(g_input[5]), .B(e_input[5]), .Z(n82) );
  XOR U124 ( .A(g_input[3]), .B(e_input[3]), .Z(n81) );
  NAND U125 ( .A(n84), .B(n85), .Z(N28) );
  OR U126 ( .A(n86), .B(n87), .Z(n85) );
  NANDN U127 ( .B(n88), .A(n89), .Z(n84) );
  XOR U128 ( .A(n87), .B(n86), .Z(N27) );
  XOR U129 ( .A(n88), .B(n89), .Z(n86) );
  XNOR U130 ( .A(g_input[1]), .B(e_input[1]), .Z(n89) );
  XOR U131 ( .A(g_input[2]), .B(e_input[2]), .Z(n88) );
  XOR U132 ( .A(g_input[0]), .B(e_input[0]), .Z(n87) );
endmodule

