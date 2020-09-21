/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5-2
// Date      : Thu Sep 17 21:35:08 2020
/////////////////////////////////////////////////////////////


module dotproduct11 ( clk, rst, g_input, e_input, o );
  input [10:0] g_input;
  input [10:0] e_input;
  input clk, rst;
  output o;
  wire   N13, N14, N16, N17, N20, N21, \popcount[3] , \popcount[2] , N33, N32,
         N31, N27, N26, N25, \add_5_root_add_29_I11/carry[1] ,
         \add_6_root_add_29_I11/carry[1] , \add_6_root_add_29_I11/CI ,
         \add_6_root_add_29_I11/A[0] , n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55;
  wire   [6:1] \add_4_root_add_29_I11/carry ;

  FADDER \add_4_root_add_29_I11/U1_1  ( .CIN(N26), .IN0(N32), .IN1(
        \add_4_root_add_29_I11/carry [1]), .COUT(
        \add_4_root_add_29_I11/carry [2]), .SUM(\popcount[2] ) );
  FADDER \add_4_root_add_29_I11/U1_2  ( .CIN(N27), .IN0(N33), .IN1(
        \add_4_root_add_29_I11/carry [2]), .COUT(
        \add_4_root_add_29_I11/carry [3]), .SUM(\popcount[3] ) );
  FADDER \add_5_root_add_29_I11/U1_1  ( .CIN(N17), .IN0(N21), .IN1(
        \add_5_root_add_29_I11/carry[1] ), .COUT(N33), .SUM(N32) );
  FADDER \add_6_root_add_29_I11/U1_0  ( .CIN(\add_6_root_add_29_I11/A[0] ), 
        .IN0(N13), .IN1(\add_6_root_add_29_I11/CI ), .COUT(
        \add_6_root_add_29_I11/carry[1] ), .SUM(N25) );
  AND U45 ( .A(N20), .B(N16), .Z(\add_5_root_add_29_I11/carry[1] ) );
  XOR U46 ( .A(N20), .B(N16), .Z(N31) );
  AND U47 ( .A(N14), .B(\add_6_root_add_29_I11/carry[1] ), .Z(N27) );
  XOR U48 ( .A(N14), .B(\add_6_root_add_29_I11/carry[1] ), .Z(N26) );
  NANDN U49 ( .B(\add_4_root_add_29_I11/carry [3]), .A(n37), .Z(o) );
  NAND U50 ( .A(\popcount[3] ), .B(\popcount[2] ), .Z(n37) );
  XNOR U51 ( .A(g_input[9]), .B(e_input[9]), .Z(\add_6_root_add_29_I11/CI ) );
  XNOR U52 ( .A(g_input[10]), .B(e_input[10]), .Z(\add_6_root_add_29_I11/A[0] ) );
  AND U53 ( .A(N31), .B(N25), .Z(\add_4_root_add_29_I11/carry [1]) );
  NAND U54 ( .A(n38), .B(n39), .Z(N21) );
  OR U55 ( .A(n40), .B(n41), .Z(n39) );
  NANDN U56 ( .B(n42), .A(n43), .Z(n38) );
  XOR U57 ( .A(n41), .B(n40), .Z(N20) );
  XOR U58 ( .A(n42), .B(n43), .Z(n40) );
  XNOR U59 ( .A(g_input[7]), .B(e_input[7]), .Z(n43) );
  XOR U60 ( .A(g_input[8]), .B(e_input[8]), .Z(n42) );
  XOR U61 ( .A(g_input[6]), .B(e_input[6]), .Z(n41) );
  NAND U62 ( .A(n44), .B(n45), .Z(N17) );
  OR U63 ( .A(n46), .B(n47), .Z(n45) );
  NANDN U64 ( .B(n48), .A(n49), .Z(n44) );
  XOR U65 ( .A(n47), .B(n46), .Z(N16) );
  XOR U66 ( .A(n48), .B(n49), .Z(n46) );
  XNOR U67 ( .A(g_input[4]), .B(e_input[4]), .Z(n49) );
  XOR U68 ( .A(g_input[5]), .B(e_input[5]), .Z(n48) );
  XOR U69 ( .A(g_input[3]), .B(e_input[3]), .Z(n47) );
  NAND U70 ( .A(n50), .B(n51), .Z(N14) );
  OR U71 ( .A(n52), .B(n53), .Z(n51) );
  NANDN U72 ( .B(n54), .A(n55), .Z(n50) );
  XOR U73 ( .A(n53), .B(n52), .Z(N13) );
  XOR U74 ( .A(n54), .B(n55), .Z(n52) );
  XNOR U75 ( .A(g_input[1]), .B(e_input[1]), .Z(n55) );
  XOR U76 ( .A(g_input[2]), .B(e_input[2]), .Z(n54) );
  XOR U77 ( .A(g_input[0]), .B(e_input[0]), .Z(n53) );
endmodule

