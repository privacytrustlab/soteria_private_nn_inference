/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5-2
// Date      : Thu Sep 17 21:35:20 2020
/////////////////////////////////////////////////////////////


module dotproduct7 ( clk, rst, g_input, e_input, o );
  input [6:0] g_input;
  input [6:0] e_input;
  input clk, rst;
  output o;
  wire   \popcount[3] , n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35,
         n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47;
  assign o = \popcount[3] ;

  IV U31 ( .A(n25), .Z(\popcount[3] ) );
  FADDER U32 ( .CIN(n26), .IN0(n27), .IN1(n28), .COUT(n25) );
  AND U33 ( .A(n29), .B(n30), .Z(n28) );
  NANDN U34 ( .B(n31), .A(n32), .Z(n30) );
  AND U35 ( .A(n33), .B(n34), .Z(n29) );
  NANDN U36 ( .B(n31), .A(n35), .Z(n34) );
  XOR U37 ( .A(g_input[6]), .B(e_input[6]), .Z(n31) );
  NAND U38 ( .A(n35), .B(n32), .Z(n33) );
  XOR U39 ( .A(n36), .B(n37), .Z(n32) );
  XOR U40 ( .A(n38), .B(n39), .Z(n35) );
  AND U41 ( .A(n40), .B(n41), .Z(n27) );
  OR U42 ( .A(n37), .B(n36), .Z(n41) );
  XOR U43 ( .A(g_input[3]), .B(e_input[3]), .Z(n36) );
  XOR U44 ( .A(n42), .B(n43), .Z(n37) );
  NANDN U45 ( .B(n42), .A(n43), .Z(n40) );
  XNOR U46 ( .A(g_input[4]), .B(e_input[4]), .Z(n43) );
  XOR U47 ( .A(g_input[5]), .B(e_input[5]), .Z(n42) );
  AND U48 ( .A(n44), .B(n45), .Z(n26) );
  OR U49 ( .A(n39), .B(n38), .Z(n45) );
  XOR U50 ( .A(g_input[0]), .B(e_input[0]), .Z(n38) );
  XOR U51 ( .A(n46), .B(n47), .Z(n39) );
  NANDN U52 ( .B(n46), .A(n47), .Z(n44) );
  XNOR U53 ( .A(g_input[1]), .B(e_input[1]), .Z(n47) );
  XOR U54 ( .A(g_input[2]), .B(e_input[2]), .Z(n46) );
endmodule

