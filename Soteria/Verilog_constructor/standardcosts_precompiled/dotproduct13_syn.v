/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5-2
// Date      : Thu Sep 17 21:35:13 2020
/////////////////////////////////////////////////////////////


module dotproduct13 ( clk, rst, g_input, e_input, o );
  input [12:0] g_input;
  input [12:0] e_input;
  input clk, rst;
  output o;
  wire   N15, N16, N18, N19, N22, N23, \popcount[3] , \popcount[2] ,
         \popcount[1] , N41, N40, N35, N34, N33, N28, N27,
         \add_7_root_add_29_I13/carry[1] , \add_7_root_add_29_I13/CI ,
         \add_8_root_add_29_I13/CI , \add_8_root_add_29_I13/B[0] ,
         \add_8_root_add_29_I13/A[0] , n41, n42, n43, n44, n45, n46, n47, n48,
         n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60;
  wire   [6:1] \add_5_root_add_29_I13/carry ;
  wire   [6:1] \add_6_root_add_29_I13/carry ;

  FADDER \add_5_root_add_29_I13/U1_1  ( .CIN(N34), .IN0(N41), .IN1(
        \add_5_root_add_29_I13/carry [1]), .COUT(
        \add_5_root_add_29_I13/carry [2]), .SUM(\popcount[2] ) );
  FADDER \add_5_root_add_29_I13/U1_2  ( .CIN(N35), .IN0(
        \add_6_root_add_29_I13/carry [2]), .IN1(
        \add_5_root_add_29_I13/carry [2]), .COUT(
        \add_5_root_add_29_I13/carry [3]), .SUM(\popcount[3] ) );
  FADDER \add_6_root_add_29_I13/U1_1  ( .CIN(N23), .IN0(N28), .IN1(
        \add_6_root_add_29_I13/carry [1]), .COUT(
        \add_6_root_add_29_I13/carry [2]), .SUM(N41) );
  FADDER \add_7_root_add_29_I13/U1_0  ( .CIN(N15), .IN0(N18), .IN1(
        \add_7_root_add_29_I13/CI ), .COUT(\add_7_root_add_29_I13/carry[1] ), 
        .SUM(N33) );
  FADDER \add_7_root_add_29_I13/U1_1  ( .CIN(N16), .IN0(N19), .IN1(
        \add_7_root_add_29_I13/carry[1] ), .COUT(N35), .SUM(N34) );
  FADDER \add_8_root_add_29_I13/U1_0  ( .CIN(\add_8_root_add_29_I13/A[0] ), 
        .IN0(\add_8_root_add_29_I13/B[0] ), .IN1(\add_8_root_add_29_I13/CI ), 
        .COUT(N28), .SUM(N27) );
  AND U49 ( .A(N33), .B(N40), .Z(\add_5_root_add_29_I13/carry [1]) );
  XOR U50 ( .A(N40), .B(N33), .Z(\popcount[1] ) );
  AND U51 ( .A(N27), .B(N22), .Z(\add_6_root_add_29_I13/carry [1]) );
  XOR U52 ( .A(N27), .B(N22), .Z(N40) );
  NANDN U53 ( .B(\add_5_root_add_29_I13/carry [3]), .A(n41), .Z(o) );
  NAND U54 ( .A(n42), .B(\popcount[3] ), .Z(n41) );
  AND U55 ( .A(\popcount[2] ), .B(\popcount[1] ), .Z(n42) );
  XNOR U56 ( .A(g_input[9]), .B(e_input[9]), .Z(\add_8_root_add_29_I13/CI ) );
  XNOR U57 ( .A(g_input[11]), .B(e_input[11]), .Z(\add_8_root_add_29_I13/B[0] ) );
  XNOR U58 ( .A(g_input[10]), .B(e_input[10]), .Z(\add_8_root_add_29_I13/A[0] ) );
  XNOR U59 ( .A(g_input[12]), .B(e_input[12]), .Z(\add_7_root_add_29_I13/CI )
         );
  NAND U60 ( .A(n43), .B(n44), .Z(N23) );
  OR U61 ( .A(n45), .B(n46), .Z(n44) );
  NANDN U62 ( .B(n47), .A(n48), .Z(n43) );
  XOR U63 ( .A(n46), .B(n45), .Z(N22) );
  XOR U64 ( .A(n47), .B(n48), .Z(n45) );
  XNOR U65 ( .A(g_input[7]), .B(e_input[7]), .Z(n48) );
  XOR U66 ( .A(g_input[8]), .B(e_input[8]), .Z(n47) );
  XOR U67 ( .A(g_input[6]), .B(e_input[6]), .Z(n46) );
  NAND U68 ( .A(n49), .B(n50), .Z(N19) );
  OR U69 ( .A(n51), .B(n52), .Z(n50) );
  NANDN U70 ( .B(n53), .A(n54), .Z(n49) );
  XOR U71 ( .A(n52), .B(n51), .Z(N18) );
  XOR U72 ( .A(n53), .B(n54), .Z(n51) );
  XNOR U73 ( .A(g_input[4]), .B(e_input[4]), .Z(n54) );
  XOR U74 ( .A(g_input[5]), .B(e_input[5]), .Z(n53) );
  XOR U75 ( .A(g_input[3]), .B(e_input[3]), .Z(n52) );
  NAND U76 ( .A(n55), .B(n56), .Z(N16) );
  OR U77 ( .A(n57), .B(n58), .Z(n56) );
  NANDN U78 ( .B(n59), .A(n60), .Z(n55) );
  XOR U79 ( .A(n58), .B(n57), .Z(N15) );
  XOR U80 ( .A(n59), .B(n60), .Z(n57) );
  XNOR U81 ( .A(g_input[1]), .B(e_input[1]), .Z(n60) );
  XOR U82 ( .A(g_input[2]), .B(e_input[2]), .Z(n59) );
  XOR U83 ( .A(g_input[0]), .B(e_input[0]), .Z(n58) );
endmodule

