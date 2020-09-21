/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5-2
// Date      : Thu Sep 17 21:35:19 2020
/////////////////////////////////////////////////////////////


module dotproduct16 ( clk, rst, g_input, e_input, o );
  input [15:0] g_input;
  input [15:0] e_input;
  input clk, rst;
  output o;
  wire   \popcount[4] , N18, N19, N21, N22, N25, N26, N61, N60, N59, N52, N51,
         N45, N44, N43, N37, N36, N31, N30, \add_9_root_add_29_I16/carry[1] ,
         \add_9_root_add_29_I16/CI , \add_10_root_add_29_I16/CI ,
         \add_10_root_add_29_I16/B[0] , \add_10_root_add_29_I16/A[0] ,
         \add_11_root_add_29_I16/CI , \add_11_root_add_29_I16/B[0] ,
         \add_11_root_add_29_I16/A[0] , n44, n45, n46, n47, n48, n49, n50, n51,
         n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65,
         n66, n67, n68, n69;
  wire   [6:1] \add_6_root_add_29_I16/carry ;
  wire   [6:1] \add_7_root_add_29_I16/carry ;
  wire   [6:1] \add_8_root_add_29_I16/carry ;

  FADDER \add_7_root_add_29_I16/U1_1  ( .CIN(N37), .IN0(N44), .IN1(
        \add_7_root_add_29_I16/carry [1]), .COUT(
        \add_7_root_add_29_I16/carry [2]), .SUM(N60) );
  FADDER \add_8_root_add_29_I16/U1_1  ( .CIN(N26), .IN0(N31), .IN1(
        \add_8_root_add_29_I16/carry [1]), .COUT(
        \add_8_root_add_29_I16/carry [2]), .SUM(N52) );
  FADDER \add_9_root_add_29_I16/U1_0  ( .CIN(N18), .IN0(N21), .IN1(
        \add_9_root_add_29_I16/CI ), .COUT(\add_9_root_add_29_I16/carry[1] ), 
        .SUM(N43) );
  FADDER \add_9_root_add_29_I16/U1_1  ( .CIN(N19), .IN0(N22), .IN1(
        \add_9_root_add_29_I16/carry[1] ), .COUT(N45), .SUM(N44) );
  FADDER \add_10_root_add_29_I16/U1_0  ( .CIN(\add_10_root_add_29_I16/A[0] ), 
        .IN0(\add_10_root_add_29_I16/B[0] ), .IN1(\add_10_root_add_29_I16/CI ), 
        .COUT(N37), .SUM(N36) );
  FADDER \add_11_root_add_29_I16/U1_0  ( .CIN(\add_11_root_add_29_I16/A[0] ), 
        .IN0(\add_11_root_add_29_I16/B[0] ), .IN1(\add_11_root_add_29_I16/CI ), 
        .COUT(N31), .SUM(N30) );
  AND U51 ( .A(N43), .B(N36), .Z(\add_7_root_add_29_I16/carry [1]) );
  XOR U52 ( .A(N43), .B(N36), .Z(N59) );
  AND U53 ( .A(N30), .B(N25), .Z(\add_8_root_add_29_I16/carry [1]) );
  XOR U54 ( .A(N30), .B(N25), .Z(N51) );
  AND U55 ( .A(N45), .B(\add_7_root_add_29_I16/carry [2]), .Z(
        \add_7_root_add_29_I16/carry [3]) );
  XOR U56 ( .A(N45), .B(\add_7_root_add_29_I16/carry [2]), .Z(N61) );
  AND U57 ( .A(\add_6_root_add_29_I16/carry [3]), .B(
        \add_7_root_add_29_I16/carry [3]), .Z(\add_6_root_add_29_I16/carry [4]) );
  XOR U58 ( .A(\add_7_root_add_29_I16/carry [3]), .B(
        \add_6_root_add_29_I16/carry [3]), .Z(\popcount[4] ) );
  OR U59 ( .A(\add_6_root_add_29_I16/carry [4]), .B(\popcount[4] ), .Z(o) );
  XNOR U60 ( .A(g_input[15]), .B(e_input[15]), .Z(\add_9_root_add_29_I16/CI )
         );
  NAND U61 ( .A(n44), .B(n45), .Z(\add_6_root_add_29_I16/carry [3]) );
  NAND U62 ( .A(n46), .B(N61), .Z(n45) );
  OR U63 ( .A(\add_8_root_add_29_I16/carry [2]), .B(n47), .Z(n46) );
  NAND U64 ( .A(n47), .B(\add_8_root_add_29_I16/carry [2]), .Z(n44) );
  NAND U65 ( .A(n48), .B(n49), .Z(n47) );
  NAND U66 ( .A(n50), .B(N59), .Z(n49) );
  AND U67 ( .A(N51), .B(n51), .Z(n50) );
  OR U68 ( .A(N60), .B(N52), .Z(n51) );
  NAND U69 ( .A(N60), .B(N52), .Z(n48) );
  XNOR U70 ( .A(g_input[9]), .B(e_input[9]), .Z(\add_11_root_add_29_I16/CI )
         );
  XNOR U71 ( .A(g_input[11]), .B(e_input[11]), .Z(
        \add_11_root_add_29_I16/B[0] ) );
  XNOR U72 ( .A(g_input[10]), .B(e_input[10]), .Z(
        \add_11_root_add_29_I16/A[0] ) );
  XNOR U73 ( .A(g_input[12]), .B(e_input[12]), .Z(\add_10_root_add_29_I16/CI )
         );
  XNOR U74 ( .A(g_input[14]), .B(e_input[14]), .Z(
        \add_10_root_add_29_I16/B[0] ) );
  XNOR U75 ( .A(g_input[13]), .B(e_input[13]), .Z(
        \add_10_root_add_29_I16/A[0] ) );
  NAND U76 ( .A(n52), .B(n53), .Z(N26) );
  OR U77 ( .A(n54), .B(n55), .Z(n53) );
  NANDN U78 ( .B(n56), .A(n57), .Z(n52) );
  XOR U79 ( .A(n55), .B(n54), .Z(N25) );
  XOR U80 ( .A(n56), .B(n57), .Z(n54) );
  XNOR U81 ( .A(g_input[7]), .B(e_input[7]), .Z(n57) );
  XOR U82 ( .A(g_input[8]), .B(e_input[8]), .Z(n56) );
  XOR U83 ( .A(g_input[6]), .B(e_input[6]), .Z(n55) );
  NAND U84 ( .A(n58), .B(n59), .Z(N22) );
  OR U85 ( .A(n60), .B(n61), .Z(n59) );
  NANDN U86 ( .B(n62), .A(n63), .Z(n58) );
  XOR U87 ( .A(n61), .B(n60), .Z(N21) );
  XOR U88 ( .A(n62), .B(n63), .Z(n60) );
  XNOR U89 ( .A(g_input[4]), .B(e_input[4]), .Z(n63) );
  XOR U90 ( .A(g_input[5]), .B(e_input[5]), .Z(n62) );
  XOR U91 ( .A(g_input[3]), .B(e_input[3]), .Z(n61) );
  NAND U92 ( .A(n64), .B(n65), .Z(N19) );
  OR U93 ( .A(n66), .B(n67), .Z(n65) );
  NANDN U94 ( .B(n68), .A(n69), .Z(n64) );
  XOR U95 ( .A(n67), .B(n66), .Z(N18) );
  XOR U96 ( .A(n68), .B(n69), .Z(n66) );
  XNOR U97 ( .A(g_input[1]), .B(e_input[1]), .Z(n69) );
  XOR U98 ( .A(g_input[2]), .B(e_input[2]), .Z(n68) );
  XOR U99 ( .A(g_input[0]), .B(e_input[0]), .Z(n67) );
endmodule

