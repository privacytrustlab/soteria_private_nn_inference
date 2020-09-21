/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5-2
// Date      : Thu Sep 17 21:35:17 2020
/////////////////////////////////////////////////////////////


module dotproduct12 ( clk, rst, g_input, e_input, o );
  input [11:0] g_input;
  input [11:0] e_input;
  input clk, rst;
  output o;
  wire   N14, N15, N17, N18, N21, N22, \popcount[3] , \popcount[2] , N40, N39,
         N34, N33, N32, N27, N26, \add_6_root_add_29_I12/carry[1] ,
         \add_7_root_add_29_I12/CI , \add_7_root_add_29_I12/B[0] ,
         \add_7_root_add_29_I12/A[0] , n40, n41, n42, n43, n44, n45, n46, n47,
         n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58;
  wire   [6:1] \add_4_root_add_29_I12/carry ;
  wire   [6:1] \add_5_root_add_29_I12/carry ;

  FADDER \add_4_root_add_29_I12/U1_1  ( .CIN(N33), .IN0(N40), .IN1(
        \add_4_root_add_29_I12/carry [1]), .COUT(
        \add_4_root_add_29_I12/carry [2]), .SUM(\popcount[2] ) );
  FADDER \add_4_root_add_29_I12/U1_2  ( .CIN(N34), .IN0(
        \add_5_root_add_29_I12/carry [2]), .IN1(
        \add_4_root_add_29_I12/carry [2]), .COUT(
        \add_4_root_add_29_I12/carry [3]), .SUM(\popcount[3] ) );
  FADDER \add_5_root_add_29_I12/U1_1  ( .CIN(N22), .IN0(N27), .IN1(
        \add_5_root_add_29_I12/carry [1]), .COUT(
        \add_5_root_add_29_I12/carry [2]), .SUM(N40) );
  FADDER \add_6_root_add_29_I12/U1_1  ( .CIN(N15), .IN0(N18), .IN1(
        \add_6_root_add_29_I12/carry[1] ), .COUT(N34), .SUM(N33) );
  FADDER \add_7_root_add_29_I12/U1_0  ( .CIN(\add_7_root_add_29_I12/A[0] ), 
        .IN0(\add_7_root_add_29_I12/B[0] ), .IN1(\add_7_root_add_29_I12/CI ), 
        .COUT(N27), .SUM(N26) );
  AND U48 ( .A(N26), .B(N21), .Z(\add_5_root_add_29_I12/carry [1]) );
  XOR U49 ( .A(N26), .B(N21), .Z(N39) );
  AND U50 ( .A(N17), .B(N14), .Z(\add_6_root_add_29_I12/carry[1] ) );
  XOR U51 ( .A(N17), .B(N14), .Z(N32) );
  NANDN U52 ( .B(\add_4_root_add_29_I12/carry [3]), .A(n40), .Z(o) );
  NAND U53 ( .A(\popcount[3] ), .B(\popcount[2] ), .Z(n40) );
  XNOR U54 ( .A(g_input[9]), .B(e_input[9]), .Z(\add_7_root_add_29_I12/CI ) );
  XNOR U55 ( .A(g_input[11]), .B(e_input[11]), .Z(\add_7_root_add_29_I12/B[0] ) );
  XNOR U56 ( .A(g_input[10]), .B(e_input[10]), .Z(\add_7_root_add_29_I12/A[0] ) );
  AND U57 ( .A(N39), .B(N32), .Z(\add_4_root_add_29_I12/carry [1]) );
  NAND U58 ( .A(n41), .B(n42), .Z(N22) );
  OR U59 ( .A(n43), .B(n44), .Z(n42) );
  NANDN U60 ( .B(n45), .A(n46), .Z(n41) );
  XOR U61 ( .A(n44), .B(n43), .Z(N21) );
  XOR U62 ( .A(n45), .B(n46), .Z(n43) );
  XNOR U63 ( .A(g_input[7]), .B(e_input[7]), .Z(n46) );
  XOR U64 ( .A(g_input[8]), .B(e_input[8]), .Z(n45) );
  XOR U65 ( .A(g_input[6]), .B(e_input[6]), .Z(n44) );
  NAND U66 ( .A(n47), .B(n48), .Z(N18) );
  OR U67 ( .A(n49), .B(n50), .Z(n48) );
  NANDN U68 ( .B(n51), .A(n52), .Z(n47) );
  XOR U69 ( .A(n50), .B(n49), .Z(N17) );
  XOR U70 ( .A(n51), .B(n52), .Z(n49) );
  XNOR U71 ( .A(g_input[4]), .B(e_input[4]), .Z(n52) );
  XOR U72 ( .A(g_input[5]), .B(e_input[5]), .Z(n51) );
  XOR U73 ( .A(g_input[3]), .B(e_input[3]), .Z(n50) );
  NAND U74 ( .A(n53), .B(n54), .Z(N15) );
  OR U75 ( .A(n55), .B(n56), .Z(n54) );
  NANDN U76 ( .B(n57), .A(n58), .Z(n53) );
  XOR U77 ( .A(n56), .B(n55), .Z(N14) );
  XOR U78 ( .A(n57), .B(n58), .Z(n55) );
  XNOR U79 ( .A(g_input[1]), .B(e_input[1]), .Z(n58) );
  XOR U80 ( .A(g_input[2]), .B(e_input[2]), .Z(n57) );
  XOR U81 ( .A(g_input[0]), .B(e_input[0]), .Z(n56) );
endmodule

