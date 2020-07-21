
module maxpool1
#(
    parameter ISIZE_L = 26,  
    parameter ISIZE_H = 26,  
    parameter POOL_SIZE = 2

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
input bit [(ISIZE_L*ISIZE_H-1):0] g_input;       //Data obtained is assumed to be flattened.
input bit e_input;
output bit [((ISIZE_L/POOL_SIZE)*(ISIZE_H/POOL_SIZE)-1):0] o;


byte unsigned i;
byte unsigned j;
byte unsigned k;
byte unsigned l;
bit [((ISIZE_L/POOL_SIZE)*(ISIZE_H/POOL_SIZE)-1):0] tempresult;


always @* begin
for (i=0; i<ISIZE_H; i=i+POOL_SIZE) begin
    for (j=0; j<ISIZE_L; j=j+POOL_SIZE) begin
        tempresult[(i*ISIZE_L/POOL_SIZE + j)/POOL_SIZE] = 1'b0;
        for (k=0; k<POOL_SIZE; k=k+1) begin
            for (l=0; l<POOL_SIZE; l=l+1) begin
                tempresult[(i*ISIZE_L/POOL_SIZE + j)/POOL_SIZE] = g_input[(i+k)*ISIZE_L+j+l] || tempresult[(i*ISIZE_L/POOL_SIZE + j)/POOL_SIZE];
            end
        end
    end
end
end

assign o = tempresult;
endmodule
 
    