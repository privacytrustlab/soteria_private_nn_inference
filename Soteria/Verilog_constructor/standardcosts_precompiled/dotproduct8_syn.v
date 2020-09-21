/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5-2
// Date      : Thu Sep 17 21:35:09 2020
/////////////////////////////////////////////////////////////


module dotproduct8 ( clk, rst, g_input, e_input, o );
  input [7:0] g_input;
  input [7:0] e_input;
  input clk, rst;
  output o;
  wire   N19, \add_3_root_add_29_I8/carry[2] , n30, n31, n32, n33, n34, n35,
         n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49,
         n50, n51, n52, n53, n54, n55, n56, n57;
  wire   [7:3] popcount;

  FADDER \add_3_root_add_29_I8/U1_2  ( .CIN(1'b0), .IN0(N19), .IN1(
        \add_3_root_add_29_I8/carry[2] ), .COUT(popcount[4]), .SUM(popcount[3]) );
  OR U36 ( .A(popcount[4]), .B(popcount[3]), .Z(o) );
  NAND U37 ( .A(n30), .B(n31), .Z(\add_3_root_add_29_I8/carry[2] ) );
  NAND U38 ( .A(n32), .B(n33), .Z(n31) );
  XOR U39 ( .A(n34), .B(n35), .Z(n33) );
  AND U40 ( .A(n36), .B(n37), .Z(n32) );
  NANDN U41 ( .B(n38), .A(n39), .Z(n37) );
  XOR U42 ( .A(n40), .B(n41), .Z(n36) );
  NANDN U43 ( .B(n39), .A(n38), .Z(n30) );
  NAND U44 ( .A(n42), .B(n43), .Z(n38) );
  OR U45 ( .A(n35), .B(n34), .Z(n43) );
  XOR U46 ( .A(g_input[3]), .B(e_input[3]), .Z(n34) );
  XOR U47 ( .A(n44), .B(n45), .Z(n35) );
  NANDN U48 ( .B(n44), .A(n45), .Z(n42) );
  XNOR U49 ( .A(g_input[4]), .B(e_input[4]), .Z(n45) );
  XOR U50 ( .A(g_input[5]), .B(e_input[5]), .Z(n44) );
  XNOR U51 ( .A(n46), .B(n47), .Z(n39) );
  NOR U52 ( .A(n47), .B(n46), .Z(N19) );
  AND U53 ( .A(n48), .B(n49), .Z(n46) );
  OR U54 ( .A(n50), .B(n51), .Z(n49) );
  NANDN U55 ( .B(n52), .A(n53), .Z(n48) );
  AND U56 ( .A(n54), .B(n55), .Z(n47) );
  NANDN U57 ( .B(n56), .A(n57), .Z(n55) );
  OR U58 ( .A(n41), .B(n40), .Z(n54) );
  XOR U59 ( .A(g_input[6]), .B(e_input[6]), .Z(n40) );
  XOR U60 ( .A(n57), .B(n56), .Z(n41) );
  XOR U61 ( .A(g_input[7]), .B(e_input[7]), .Z(n56) );
  XOR U62 ( .A(n51), .B(n50), .Z(n57) );
  XOR U63 ( .A(n52), .B(n53), .Z(n50) );
  XNOR U64 ( .A(g_input[1]), .B(e_input[1]), .Z(n53) );
  XOR U65 ( .A(g_input[2]), .B(e_input[2]), .Z(n52) );
  XOR U66 ( .A(g_input[0]), .B(e_input[0]), .Z(n51) );
endmodule

