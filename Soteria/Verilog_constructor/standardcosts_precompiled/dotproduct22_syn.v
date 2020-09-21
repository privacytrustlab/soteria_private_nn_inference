/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5-2
// Date      : Thu Sep 17 21:35:07 2020
/////////////////////////////////////////////////////////////


module dotproduct22 ( clk, rst, g_input, e_input, o );
  input [21:0] g_input;
  input [21:0] e_input;
  input clk, rst;
  output o;
  wire   N24, N25, N27, N28, N31, N32, \popcount[4] , \popcount[3] ,
         \popcount[2] , \popcount[1] , N99, N98, N97, N91, N90, N89, N82, N81,
         N74, N73, N67, N66, N65, N58, N57, N50, N49, N43, N42, N37, N36,
         \add_13_root_add_29_I22/carry[1] , \add_13_root_add_29_I22/CI ,
         \add_14_root_add_29_I22/CI , \add_14_root_add_29_I22/B[0] ,
         \add_14_root_add_29_I22/A[0] , \add_15_root_add_29_I22/CI ,
         \add_15_root_add_29_I22/B[0] , \add_15_root_add_29_I22/A[0] ,
         \add_16_root_add_29_I22/CI , \add_16_root_add_29_I22/B[0] ,
         \add_16_root_add_29_I22/A[0] , \add_17_root_add_29_I22/CI ,
         \add_17_root_add_29_I22/B[0] , \add_17_root_add_29_I22/A[0] , n62,
         n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76,
         n77, n78, n79, n80, n81, n82;
  wire   [6:1] \add_8_root_add_29_I22/carry ;
  wire   [6:1] \add_9_root_add_29_I22/carry ;
  wire   [6:1] \add_10_root_add_29_I22/carry ;
  wire   [6:1] \add_11_root_add_29_I22/carry ;
  wire   [6:1] \add_12_root_add_29_I22/carry ;

  FADDER \add_8_root_add_29_I22/U1_1  ( .CIN(N90), .IN0(N98), .IN1(
        \add_8_root_add_29_I22/carry [1]), .COUT(
        \add_8_root_add_29_I22/carry [2]), .SUM(\popcount[2] ) );
  FADDER \add_8_root_add_29_I22/U1_2  ( .CIN(N91), .IN0(N99), .IN1(
        \add_8_root_add_29_I22/carry [2]), .COUT(
        \add_8_root_add_29_I22/carry [3]), .SUM(\popcount[3] ) );
  FADDER \add_8_root_add_29_I22/U1_3  ( .CIN(\add_10_root_add_29_I22/carry [3]), .IN0(\add_9_root_add_29_I22/carry [3]), .IN1(
        \add_8_root_add_29_I22/carry [3]), .COUT(
        \add_8_root_add_29_I22/carry [4]), .SUM(\popcount[4] ) );
  FADDER \add_9_root_add_29_I22/U1_1  ( .CIN(N74), .IN0(N82), .IN1(
        \add_9_root_add_29_I22/carry [1]), .COUT(
        \add_9_root_add_29_I22/carry [2]), .SUM(N98) );
  FADDER \add_9_root_add_29_I22/U1_2  ( .CIN(\add_12_root_add_29_I22/carry [2]), .IN0(\add_11_root_add_29_I22/carry [2]), .IN1(
        \add_9_root_add_29_I22/carry [2]), .COUT(
        \add_9_root_add_29_I22/carry [3]), .SUM(N99) );
  FADDER \add_10_root_add_29_I22/U1_1  ( .CIN(N58), .IN0(N66), .IN1(
        \add_10_root_add_29_I22/carry [1]), .COUT(
        \add_10_root_add_29_I22/carry [2]), .SUM(N90) );
  FADDER \add_11_root_add_29_I22/U1_1  ( .CIN(N43), .IN0(N50), .IN1(
        \add_11_root_add_29_I22/carry [1]), .COUT(
        \add_11_root_add_29_I22/carry [2]), .SUM(N82) );
  FADDER \add_12_root_add_29_I22/U1_1  ( .CIN(N32), .IN0(N37), .IN1(
        \add_12_root_add_29_I22/carry [1]), .COUT(
        \add_12_root_add_29_I22/carry [2]), .SUM(N74) );
  FADDER \add_13_root_add_29_I22/U1_0  ( .CIN(N24), .IN0(N27), .IN1(
        \add_13_root_add_29_I22/CI ), .COUT(\add_13_root_add_29_I22/carry[1] ), 
        .SUM(N65) );
  FADDER \add_13_root_add_29_I22/U1_1  ( .CIN(N25), .IN0(N28), .IN1(
        \add_13_root_add_29_I22/carry[1] ), .COUT(N67), .SUM(N66) );
  FADDER \add_14_root_add_29_I22/U1_0  ( .CIN(\add_14_root_add_29_I22/A[0] ), 
        .IN0(\add_14_root_add_29_I22/B[0] ), .IN1(\add_14_root_add_29_I22/CI ), 
        .COUT(N58), .SUM(N57) );
  FADDER \add_15_root_add_29_I22/U1_0  ( .CIN(\add_15_root_add_29_I22/A[0] ), 
        .IN0(\add_15_root_add_29_I22/B[0] ), .IN1(\add_15_root_add_29_I22/CI ), 
        .COUT(N50), .SUM(N49) );
  FADDER \add_16_root_add_29_I22/U1_0  ( .CIN(\add_16_root_add_29_I22/A[0] ), 
        .IN0(\add_16_root_add_29_I22/B[0] ), .IN1(\add_16_root_add_29_I22/CI ), 
        .COUT(N43), .SUM(N42) );
  FADDER \add_17_root_add_29_I22/U1_0  ( .CIN(\add_17_root_add_29_I22/A[0] ), 
        .IN0(\add_17_root_add_29_I22/B[0] ), .IN1(\add_17_root_add_29_I22/CI ), 
        .COUT(N37), .SUM(N36) );
  AND U70 ( .A(N89), .B(N97), .Z(\add_8_root_add_29_I22/carry [1]) );
  XOR U71 ( .A(N97), .B(N89), .Z(\popcount[1] ) );
  AND U72 ( .A(N81), .B(N73), .Z(\add_9_root_add_29_I22/carry [1]) );
  XOR U73 ( .A(N81), .B(N73), .Z(N97) );
  AND U74 ( .A(N65), .B(N57), .Z(\add_10_root_add_29_I22/carry [1]) );
  XOR U75 ( .A(N65), .B(N57), .Z(N89) );
  AND U76 ( .A(N49), .B(N42), .Z(\add_11_root_add_29_I22/carry [1]) );
  XOR U77 ( .A(N49), .B(N42), .Z(N81) );
  AND U78 ( .A(N36), .B(N31), .Z(\add_12_root_add_29_I22/carry [1]) );
  XOR U79 ( .A(N36), .B(N31), .Z(N73) );
  AND U80 ( .A(N67), .B(\add_10_root_add_29_I22/carry [2]), .Z(
        \add_10_root_add_29_I22/carry [3]) );
  XOR U81 ( .A(N67), .B(\add_10_root_add_29_I22/carry [2]), .Z(N91) );
  NANDN U82 ( .B(\add_8_root_add_29_I22/carry [4]), .A(n62), .Z(o) );
  NAND U83 ( .A(n63), .B(\popcount[4] ), .Z(n62) );
  NANDN U84 ( .B(\popcount[3] ), .A(n64), .Z(n63) );
  NAND U85 ( .A(\popcount[2] ), .B(\popcount[1] ), .Z(n64) );
  XNOR U86 ( .A(g_input[9]), .B(e_input[9]), .Z(\add_17_root_add_29_I22/CI )
         );
  XNOR U87 ( .A(g_input[11]), .B(e_input[11]), .Z(
        \add_17_root_add_29_I22/B[0] ) );
  XNOR U88 ( .A(g_input[10]), .B(e_input[10]), .Z(
        \add_17_root_add_29_I22/A[0] ) );
  XNOR U89 ( .A(g_input[12]), .B(e_input[12]), .Z(\add_16_root_add_29_I22/CI )
         );
  XNOR U90 ( .A(g_input[14]), .B(e_input[14]), .Z(
        \add_16_root_add_29_I22/B[0] ) );
  XNOR U91 ( .A(g_input[13]), .B(e_input[13]), .Z(
        \add_16_root_add_29_I22/A[0] ) );
  XNOR U92 ( .A(g_input[15]), .B(e_input[15]), .Z(\add_15_root_add_29_I22/CI )
         );
  XNOR U93 ( .A(g_input[17]), .B(e_input[17]), .Z(
        \add_15_root_add_29_I22/B[0] ) );
  XNOR U94 ( .A(g_input[16]), .B(e_input[16]), .Z(
        \add_15_root_add_29_I22/A[0] ) );
  XNOR U95 ( .A(g_input[18]), .B(e_input[18]), .Z(\add_14_root_add_29_I22/CI )
         );
  XNOR U96 ( .A(g_input[20]), .B(e_input[20]), .Z(
        \add_14_root_add_29_I22/B[0] ) );
  XNOR U97 ( .A(g_input[19]), .B(e_input[19]), .Z(
        \add_14_root_add_29_I22/A[0] ) );
  XNOR U98 ( .A(g_input[21]), .B(e_input[21]), .Z(\add_13_root_add_29_I22/CI )
         );
  NAND U99 ( .A(n65), .B(n66), .Z(N32) );
  OR U100 ( .A(n67), .B(n68), .Z(n66) );
  NANDN U101 ( .B(n69), .A(n70), .Z(n65) );
  XOR U102 ( .A(n68), .B(n67), .Z(N31) );
  XOR U103 ( .A(n69), .B(n70), .Z(n67) );
  XNOR U104 ( .A(g_input[7]), .B(e_input[7]), .Z(n70) );
  XOR U105 ( .A(g_input[8]), .B(e_input[8]), .Z(n69) );
  XOR U106 ( .A(g_input[6]), .B(e_input[6]), .Z(n68) );
  NAND U107 ( .A(n71), .B(n72), .Z(N28) );
  OR U108 ( .A(n73), .B(n74), .Z(n72) );
  NANDN U109 ( .B(n75), .A(n76), .Z(n71) );
  XOR U110 ( .A(n74), .B(n73), .Z(N27) );
  XOR U111 ( .A(n75), .B(n76), .Z(n73) );
  XNOR U112 ( .A(g_input[4]), .B(e_input[4]), .Z(n76) );
  XOR U113 ( .A(g_input[5]), .B(e_input[5]), .Z(n75) );
  XOR U114 ( .A(g_input[3]), .B(e_input[3]), .Z(n74) );
  NAND U115 ( .A(n77), .B(n78), .Z(N25) );
  OR U116 ( .A(n79), .B(n80), .Z(n78) );
  NANDN U117 ( .B(n81), .A(n82), .Z(n77) );
  XOR U118 ( .A(n80), .B(n79), .Z(N24) );
  XOR U119 ( .A(n81), .B(n82), .Z(n79) );
  XNOR U120 ( .A(g_input[1]), .B(e_input[1]), .Z(n82) );
  XOR U121 ( .A(g_input[2]), .B(e_input[2]), .Z(n81) );
  XOR U122 ( .A(g_input[0]), .B(e_input[0]), .Z(n80) );
endmodule

