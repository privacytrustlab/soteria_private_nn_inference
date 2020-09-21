/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5-2
// Date      : Thu Sep 17 21:35:16 2020
/////////////////////////////////////////////////////////////


module dotproduct14 ( clk, rst, g_input, e_input, o );
  input [13:0] g_input;
  input [13:0] e_input;
  input clk, rst;
  output o;
  wire   N16, N17, N19, N20, N23, N24, N97, \popcount[4] , \popcount[3] ,
         \popcount[2] , \popcount[1] , N51, N50, N49, N43, N42, N41, N36, N35,
         N34, N29, N28, \add_7_root_add_29_I14/carry[1] ,
         \add_8_root_add_29_I14/carry[1] , \add_8_root_add_29_I14/CI ,
         \add_8_root_add_29_I14/A[0] , \add_9_root_add_29_I14/CI ,
         \add_9_root_add_29_I14/B[0] , \add_9_root_add_29_I14/A[0] , n44, n45,
         n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59,
         n60, n61, n62, n63, n64;
  wire   [6:1] \add_5_root_add_29_I14/carry ;
  wire   [6:1] \add_6_root_add_29_I14/carry ;
  assign o = N97;

  FADDER \add_5_root_add_29_I14/U1_1  ( .CIN(N42), .IN0(N50), .IN1(
        \add_5_root_add_29_I14/carry [1]), .COUT(
        \add_5_root_add_29_I14/carry [2]), .SUM(\popcount[2] ) );
  FADDER \add_5_root_add_29_I14/U1_2  ( .CIN(N43), .IN0(N51), .IN1(
        \add_5_root_add_29_I14/carry [2]), .COUT(
        \add_5_root_add_29_I14/carry [3]), .SUM(\popcount[3] ) );
  FADDER \add_6_root_add_29_I14/U1_1  ( .CIN(N29), .IN0(N35), .IN1(
        \add_6_root_add_29_I14/carry [1]), .COUT(
        \add_6_root_add_29_I14/carry [2]), .SUM(N50) );
  FADDER \add_7_root_add_29_I14/U1_1  ( .CIN(N20), .IN0(N24), .IN1(
        \add_7_root_add_29_I14/carry[1] ), .COUT(N43), .SUM(N42) );
  FADDER \add_8_root_add_29_I14/U1_0  ( .CIN(\add_8_root_add_29_I14/A[0] ), 
        .IN0(N16), .IN1(\add_8_root_add_29_I14/CI ), .COUT(
        \add_8_root_add_29_I14/carry[1] ), .SUM(N34) );
  FADDER \add_9_root_add_29_I14/U1_0  ( .CIN(\add_9_root_add_29_I14/A[0] ), 
        .IN0(\add_9_root_add_29_I14/B[0] ), .IN1(\add_9_root_add_29_I14/CI ), 
        .COUT(N29), .SUM(N28) );
  AND U52 ( .A(N41), .B(N49), .Z(\add_5_root_add_29_I14/carry [1]) );
  XOR U53 ( .A(N49), .B(N41), .Z(\popcount[1] ) );
  AND U54 ( .A(N34), .B(N28), .Z(\add_6_root_add_29_I14/carry [1]) );
  XOR U55 ( .A(N34), .B(N28), .Z(N49) );
  AND U56 ( .A(\add_5_root_add_29_I14/carry [3]), .B(
        \add_6_root_add_29_I14/carry [3]), .Z(\add_5_root_add_29_I14/carry [4]) );
  XOR U57 ( .A(\add_6_root_add_29_I14/carry [3]), .B(
        \add_5_root_add_29_I14/carry [3]), .Z(\popcount[4] ) );
  AND U58 ( .A(N23), .B(N19), .Z(\add_7_root_add_29_I14/carry[1] ) );
  XOR U59 ( .A(N23), .B(N19), .Z(N41) );
  AND U60 ( .A(N17), .B(\add_8_root_add_29_I14/carry[1] ), .Z(N36) );
  XOR U61 ( .A(N17), .B(\add_8_root_add_29_I14/carry[1] ), .Z(N35) );
  AND U62 ( .A(N36), .B(\add_6_root_add_29_I14/carry [2]), .Z(
        \add_6_root_add_29_I14/carry [3]) );
  XOR U63 ( .A(N36), .B(\add_6_root_add_29_I14/carry [2]), .Z(N51) );
  XNOR U64 ( .A(g_input[9]), .B(e_input[9]), .Z(\add_9_root_add_29_I14/CI ) );
  XNOR U65 ( .A(g_input[11]), .B(e_input[11]), .Z(\add_9_root_add_29_I14/B[0] ) );
  XNOR U66 ( .A(g_input[10]), .B(e_input[10]), .Z(\add_9_root_add_29_I14/A[0] ) );
  XNOR U67 ( .A(g_input[12]), .B(e_input[12]), .Z(\add_8_root_add_29_I14/CI )
         );
  XNOR U68 ( .A(g_input[13]), .B(e_input[13]), .Z(\add_8_root_add_29_I14/A[0] ) );
  NAND U69 ( .A(n44), .B(n45), .Z(N97) );
  NAND U70 ( .A(n46), .B(\popcount[3] ), .Z(n45) );
  AND U71 ( .A(\popcount[2] ), .B(\popcount[1] ), .Z(n46) );
  NOR U72 ( .A(\popcount[4] ), .B(\add_5_root_add_29_I14/carry [4]), .Z(n44)
         );
  NAND U73 ( .A(n47), .B(n48), .Z(N24) );
  OR U74 ( .A(n49), .B(n50), .Z(n48) );
  NANDN U75 ( .B(n51), .A(n52), .Z(n47) );
  XOR U76 ( .A(n50), .B(n49), .Z(N23) );
  XOR U77 ( .A(n51), .B(n52), .Z(n49) );
  XNOR U78 ( .A(g_input[7]), .B(e_input[7]), .Z(n52) );
  XOR U79 ( .A(g_input[8]), .B(e_input[8]), .Z(n51) );
  XOR U80 ( .A(g_input[6]), .B(e_input[6]), .Z(n50) );
  NAND U81 ( .A(n53), .B(n54), .Z(N20) );
  OR U82 ( .A(n55), .B(n56), .Z(n54) );
  NANDN U83 ( .B(n57), .A(n58), .Z(n53) );
  XOR U84 ( .A(n56), .B(n55), .Z(N19) );
  XOR U85 ( .A(n57), .B(n58), .Z(n55) );
  XNOR U86 ( .A(g_input[4]), .B(e_input[4]), .Z(n58) );
  XOR U87 ( .A(g_input[5]), .B(e_input[5]), .Z(n57) );
  XOR U88 ( .A(g_input[3]), .B(e_input[3]), .Z(n56) );
  NAND U89 ( .A(n59), .B(n60), .Z(N17) );
  OR U90 ( .A(n61), .B(n62), .Z(n60) );
  NANDN U91 ( .B(n63), .A(n64), .Z(n59) );
  XOR U92 ( .A(n62), .B(n61), .Z(N16) );
  XOR U93 ( .A(n63), .B(n64), .Z(n61) );
  XNOR U94 ( .A(g_input[1]), .B(e_input[1]), .Z(n64) );
  XOR U95 ( .A(g_input[2]), .B(e_input[2]), .Z(n63) );
  XOR U96 ( .A(g_input[0]), .B(e_input[0]), .Z(n62) );
endmodule

