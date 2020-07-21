
module dotproduct5
#(
    parameter ISIZE = 5

)
(
    clk,
	rst,
	g_input,
	e_input,
	o
); 

input clk;
input rst;
input bit [(ISIZE-1):0] g_input;       //Data obtained is assumed to be flattened.
input bit [(ISIZE-1):0] e_input;
output bit o;

byte unsigned k;
byte unsigned popcount;
bit temp;
always @* begin
    popcount = 0;
    for (k=0; k<ISIZE; k=k+1) begin
        bit a;
        a = g_input[k] ~^ e_input[k];
        popcount = popcount + a;
    end
    popcount = 2*popcount;

    if (popcount >= ISIZE) begin
        temp = 1'b1;
    end else begin
        temp = 1'b0;
    end	
end
assign o = temp;
endmodule
 
    