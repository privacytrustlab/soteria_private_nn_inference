/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5-2
// Date      : Thu Sep 17 21:35:11 2020
/////////////////////////////////////////////////////////////


module dotproduct10 ( clk, rst, g_input, e_input, o );
  input [9:0] g_input;
  input [9:0] e_input;
  input clk, rst;
  output o;
  wire   N12, N13, N15, N16, N19, N20, \popcount[3] , \popcount[2] ,
         \popcount[1] , N26, N25, N24, \add_5_root_add_29_I10/carry[1] ,
         \add_5_root_add_29_I10/CI , n34, n35, n36, n37, n38, n39, n40, n41,
         n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53;
  wire   [6:1] \add_4_root_add_29_I10/carry ;

  FADDER \add_4_root_add_29_I10/U1_1  ( .CIN(N20), .IN0(N25), .IN1(
        \add_4_root_add_29_I10/carry [1]), .COUT(
        \add_4_root_add_29_I10/carry [2]), .SUM(\popcount[2] ) );
  FADDER \add_5_root_add_29_I10/U1_0  ( .CIN(N12), .IN0(N15), .IN1(
        \add_5_root_add_29_I10/CI ), .COUT(\add_5_root_add_29_I10/carry[1] ), 
        .SUM(N24) );
  FADDER \add_5_root_add_29_I10/U1_1  ( .CIN(N13), .IN0(N16), .IN1(
        \add_5_root_add_29_I10/carry[1] ), .COUT(N26), .SUM(N25) );
  AND U42 ( .A(N19), .B(N24), .Z(\add_4_root_add_29_I10/carry [1]) );
  XOR U43 ( .A(N24), .B(N19), .Z(\popcount[1] ) );
  AND U44 ( .A(\add_4_root_add_29_I10/carry [2]), .B(N26), .Z(
        \add_4_root_add_29_I10/carry [3]) );
  XOR U45 ( .A(N26), .B(\add_4_root_add_29_I10/carry [2]), .Z(\popcount[3] )
         );
  NANDN U46 ( .B(\add_4_root_add_29_I10/carry [3]), .A(n34), .Z(o) );
  NAND U47 ( .A(n35), .B(\popcount[3] ), .Z(n34) );
  OR U48 ( .A(\popcount[2] ), .B(\popcount[1] ), .Z(n35) );
  XNOR U49 ( .A(g_input[9]), .B(e_input[9]), .Z(\add_5_root_add_29_I10/CI ) );
  NAND U50 ( .A(n36), .B(n37), .Z(N20) );
  OR U51 ( .A(n38), .B(n39), .Z(n37) );
  NANDN U52 ( .B(n40), .A(n41), .Z(n36) );
  XOR U53 ( .A(n39), .B(n38), .Z(N19) );
  XOR U54 ( .A(n40), .B(n41), .Z(n38) );
  XNOR U55 ( .A(g_input[7]), .B(e_input[7]), .Z(n41) );
  XOR U56 ( .A(g_input[8]), .B(e_input[8]), .Z(n40) );
  XOR U57 ( .A(g_input[6]), .B(e_input[6]), .Z(n39) );
  NAND U58 ( .A(n42), .B(n43), .Z(N16) );
  OR U59 ( .A(n44), .B(n45), .Z(n43) );
  NANDN U60 ( .B(n46), .A(n47), .Z(n42) );
  XOR U61 ( .A(n45), .B(n44), .Z(N15) );
  XOR U62 ( .A(n46), .B(n47), .Z(n44) );
  XNOR U63 ( .A(g_input[4]), .B(e_input[4]), .Z(n47) );
  XOR U64 ( .A(g_input[5]), .B(e_input[5]), .Z(n46) );
  XOR U65 ( .A(g_input[3]), .B(e_input[3]), .Z(n45) );
  NAND U66 ( .A(n48), .B(n49), .Z(N13) );
  OR U67 ( .A(n50), .B(n51), .Z(n49) );
  NANDN U68 ( .B(n52), .A(n53), .Z(n48) );
  XOR U69 ( .A(n51), .B(n50), .Z(N12) );
  XOR U70 ( .A(n52), .B(n53), .Z(n50) );
  XNOR U71 ( .A(g_input[1]), .B(e_input[1]), .Z(n53) );
  XOR U72 ( .A(g_input[2]), .B(e_input[2]), .Z(n52) );
  XOR U73 ( .A(g_input[0]), .B(e_input[0]), .Z(n51) );
endmodule

