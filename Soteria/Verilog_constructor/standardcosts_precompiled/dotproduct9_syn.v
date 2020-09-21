/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5-2
// Date      : Thu Sep 17 21:35:20 2020
/////////////////////////////////////////////////////////////


module dotproduct9 ( clk, rst, g_input, e_input, o );
  input [8:0] g_input;
  input [8:0] e_input;
  input clk, rst;
  output o;
  wire   N11, N12, N14, N15, N18, N19, \popcount[3] , \popcount[2] ,
         \popcount[1] , N25, N24, N23, \add_4_root_add_29_I9/carry[1] , n33,
         n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n48, n49, n50, n51, n52;
  wire   [6:1] \add_3_root_add_29_I9/carry ;

  FADDER \add_3_root_add_29_I9/U1_1  ( .CIN(N19), .IN0(N24), .IN1(
        \add_3_root_add_29_I9/carry [1]), .COUT(
        \add_3_root_add_29_I9/carry [2]), .SUM(\popcount[2] ) );
  FADDER \add_4_root_add_29_I9/U1_1  ( .CIN(N12), .IN0(N15), .IN1(
        \add_4_root_add_29_I9/carry[1] ), .COUT(N25), .SUM(N24) );
  AND U41 ( .A(N18), .B(N23), .Z(\add_3_root_add_29_I9/carry [1]) );
  XOR U42 ( .A(N23), .B(N18), .Z(\popcount[1] ) );
  AND U43 ( .A(\add_3_root_add_29_I9/carry [2]), .B(N25), .Z(
        \add_3_root_add_29_I9/carry [3]) );
  XOR U44 ( .A(N25), .B(\add_3_root_add_29_I9/carry [2]), .Z(\popcount[3] ) );
  AND U45 ( .A(N14), .B(N11), .Z(\add_4_root_add_29_I9/carry[1] ) );
  XOR U46 ( .A(N14), .B(N11), .Z(N23) );
  NANDN U47 ( .B(\add_3_root_add_29_I9/carry [3]), .A(n33), .Z(o) );
  NAND U48 ( .A(n34), .B(\popcount[3] ), .Z(n33) );
  OR U49 ( .A(\popcount[2] ), .B(\popcount[1] ), .Z(n34) );
  NAND U50 ( .A(n35), .B(n36), .Z(N19) );
  OR U51 ( .A(n37), .B(n38), .Z(n36) );
  NANDN U52 ( .B(n39), .A(n40), .Z(n35) );
  XOR U53 ( .A(n38), .B(n37), .Z(N18) );
  XOR U54 ( .A(n39), .B(n40), .Z(n37) );
  XNOR U55 ( .A(g_input[7]), .B(e_input[7]), .Z(n40) );
  XOR U56 ( .A(g_input[8]), .B(e_input[8]), .Z(n39) );
  XOR U57 ( .A(g_input[6]), .B(e_input[6]), .Z(n38) );
  NAND U58 ( .A(n41), .B(n42), .Z(N15) );
  OR U59 ( .A(n43), .B(n44), .Z(n42) );
  NANDN U60 ( .B(n45), .A(n46), .Z(n41) );
  XOR U61 ( .A(n44), .B(n43), .Z(N14) );
  XOR U62 ( .A(n45), .B(n46), .Z(n43) );
  XNOR U63 ( .A(g_input[4]), .B(e_input[4]), .Z(n46) );
  XOR U64 ( .A(g_input[5]), .B(e_input[5]), .Z(n45) );
  XOR U65 ( .A(g_input[3]), .B(e_input[3]), .Z(n44) );
  NAND U66 ( .A(n47), .B(n48), .Z(N12) );
  OR U67 ( .A(n49), .B(n50), .Z(n48) );
  NANDN U68 ( .B(n51), .A(n52), .Z(n47) );
  XOR U69 ( .A(n50), .B(n49), .Z(N11) );
  XOR U70 ( .A(n51), .B(n52), .Z(n49) );
  XNOR U71 ( .A(g_input[1]), .B(e_input[1]), .Z(n52) );
  XOR U72 ( .A(g_input[2]), .B(e_input[2]), .Z(n51) );
  XOR U73 ( .A(g_input[0]), .B(e_input[0]), .Z(n50) );
endmodule

