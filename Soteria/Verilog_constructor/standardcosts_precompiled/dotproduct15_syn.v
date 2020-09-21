/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5-2
// Date      : Thu Sep 17 21:35:16 2020
/////////////////////////////////////////////////////////////


module dotproduct15 ( clk, rst, g_input, e_input, o );
  input [14:0] g_input;
  input [14:0] e_input;
  input clk, rst;
  output o;
  wire   N17, N18, N20, N21, N24, N25, \popcount[4] , N60, N59, N58, N51, N50,
         N44, N43, N42, N36, N35, N30, N29, \add_8_root_add_29_I15/carry[1] ,
         \add_9_root_add_29_I15/CI , \add_9_root_add_29_I15/B[0] ,
         \add_9_root_add_29_I15/A[0] , \add_10_root_add_29_I15/CI ,
         \add_10_root_add_29_I15/B[0] , \add_10_root_add_29_I15/A[0] , n47,
         n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61,
         n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72;
  wire   [6:1] \add_5_root_add_29_I15/carry ;
  wire   [6:1] \add_6_root_add_29_I15/carry ;
  wire   [6:1] \add_7_root_add_29_I15/carry ;

  FADDER \add_6_root_add_29_I15/U1_1  ( .CIN(N36), .IN0(N43), .IN1(
        \add_6_root_add_29_I15/carry [1]), .COUT(
        \add_6_root_add_29_I15/carry [2]), .SUM(N59) );
  FADDER \add_7_root_add_29_I15/U1_1  ( .CIN(N25), .IN0(N30), .IN1(
        \add_7_root_add_29_I15/carry [1]), .COUT(
        \add_7_root_add_29_I15/carry [2]), .SUM(N51) );
  FADDER \add_8_root_add_29_I15/U1_1  ( .CIN(N18), .IN0(N21), .IN1(
        \add_8_root_add_29_I15/carry[1] ), .COUT(N44), .SUM(N43) );
  FADDER \add_9_root_add_29_I15/U1_0  ( .CIN(\add_9_root_add_29_I15/A[0] ), 
        .IN0(\add_9_root_add_29_I15/B[0] ), .IN1(\add_9_root_add_29_I15/CI ), 
        .COUT(N36), .SUM(N35) );
  FADDER \add_10_root_add_29_I15/U1_0  ( .CIN(\add_10_root_add_29_I15/A[0] ), 
        .IN0(\add_10_root_add_29_I15/B[0] ), .IN1(\add_10_root_add_29_I15/CI ), 
        .COUT(N30), .SUM(N29) );
  AND U55 ( .A(N42), .B(N35), .Z(\add_6_root_add_29_I15/carry [1]) );
  XOR U56 ( .A(N42), .B(N35), .Z(N58) );
  AND U57 ( .A(N29), .B(N24), .Z(\add_7_root_add_29_I15/carry [1]) );
  XOR U58 ( .A(N29), .B(N24), .Z(N50) );
  AND U59 ( .A(N20), .B(N17), .Z(\add_8_root_add_29_I15/carry[1] ) );
  XOR U60 ( .A(N20), .B(N17), .Z(N42) );
  AND U61 ( .A(N44), .B(\add_6_root_add_29_I15/carry [2]), .Z(
        \add_6_root_add_29_I15/carry [3]) );
  XOR U62 ( .A(N44), .B(\add_6_root_add_29_I15/carry [2]), .Z(N60) );
  AND U63 ( .A(\add_5_root_add_29_I15/carry [3]), .B(
        \add_6_root_add_29_I15/carry [3]), .Z(\add_5_root_add_29_I15/carry [4]) );
  XOR U64 ( .A(\add_6_root_add_29_I15/carry [3]), .B(
        \add_5_root_add_29_I15/carry [3]), .Z(\popcount[4] ) );
  OR U65 ( .A(\add_5_root_add_29_I15/carry [4]), .B(\popcount[4] ), .Z(o) );
  XNOR U66 ( .A(g_input[12]), .B(e_input[12]), .Z(\add_9_root_add_29_I15/CI )
         );
  XNOR U67 ( .A(g_input[14]), .B(e_input[14]), .Z(\add_9_root_add_29_I15/B[0] ) );
  XNOR U68 ( .A(g_input[13]), .B(e_input[13]), .Z(\add_9_root_add_29_I15/A[0] ) );
  NAND U69 ( .A(n47), .B(n48), .Z(\add_5_root_add_29_I15/carry [3]) );
  NAND U70 ( .A(n49), .B(N60), .Z(n48) );
  OR U71 ( .A(\add_7_root_add_29_I15/carry [2]), .B(n50), .Z(n49) );
  NAND U72 ( .A(n50), .B(\add_7_root_add_29_I15/carry [2]), .Z(n47) );
  NAND U73 ( .A(n51), .B(n52), .Z(n50) );
  NAND U74 ( .A(n53), .B(N58), .Z(n52) );
  AND U75 ( .A(N50), .B(n54), .Z(n53) );
  OR U76 ( .A(N59), .B(N51), .Z(n54) );
  NAND U77 ( .A(N59), .B(N51), .Z(n51) );
  XNOR U78 ( .A(g_input[9]), .B(e_input[9]), .Z(\add_10_root_add_29_I15/CI )
         );
  XNOR U79 ( .A(g_input[11]), .B(e_input[11]), .Z(
        \add_10_root_add_29_I15/B[0] ) );
  XNOR U80 ( .A(g_input[10]), .B(e_input[10]), .Z(
        \add_10_root_add_29_I15/A[0] ) );
  NAND U81 ( .A(n55), .B(n56), .Z(N25) );
  OR U82 ( .A(n57), .B(n58), .Z(n56) );
  NANDN U83 ( .B(n59), .A(n60), .Z(n55) );
  XOR U84 ( .A(n58), .B(n57), .Z(N24) );
  XOR U85 ( .A(n59), .B(n60), .Z(n57) );
  XNOR U86 ( .A(g_input[7]), .B(e_input[7]), .Z(n60) );
  XOR U87 ( .A(g_input[8]), .B(e_input[8]), .Z(n59) );
  XOR U88 ( .A(g_input[6]), .B(e_input[6]), .Z(n58) );
  NAND U89 ( .A(n61), .B(n62), .Z(N21) );
  OR U90 ( .A(n63), .B(n64), .Z(n62) );
  NANDN U91 ( .B(n65), .A(n66), .Z(n61) );
  XOR U92 ( .A(n64), .B(n63), .Z(N20) );
  XOR U93 ( .A(n65), .B(n66), .Z(n63) );
  XNOR U94 ( .A(g_input[4]), .B(e_input[4]), .Z(n66) );
  XOR U95 ( .A(g_input[5]), .B(e_input[5]), .Z(n65) );
  XOR U96 ( .A(g_input[3]), .B(e_input[3]), .Z(n64) );
  NAND U97 ( .A(n67), .B(n68), .Z(N18) );
  OR U98 ( .A(n69), .B(n70), .Z(n68) );
  NANDN U99 ( .B(n71), .A(n72), .Z(n67) );
  XOR U100 ( .A(n70), .B(n69), .Z(N17) );
  XOR U101 ( .A(n71), .B(n72), .Z(n69) );
  XNOR U102 ( .A(g_input[1]), .B(e_input[1]), .Z(n72) );
  XOR U103 ( .A(g_input[2]), .B(e_input[2]), .Z(n71) );
  XOR U104 ( .A(g_input[0]), .B(e_input[0]), .Z(n70) );
endmodule

