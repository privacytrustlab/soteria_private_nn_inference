# This file contains the cide for verilog files, that doesn't change irrespective of the size of input and weights.

maxpool_verilog = """
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
"""


fc_verilog = """
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
input bit [ISIZE-1:0] g_input;
input bit [(LSIZE*ISIZE-1):0] e_input;

output bit [LSIZE-1:0] o;

bit [(LSIZE*ISIZE-1):0] xnorresults;


genvar gi, gj;
generate
    for (gi=0; gi<LSIZE; gi=gi+1) begin : genbit
        for (gj=0; gj<ISIZE; gj=gj+1) begin : genbit2
            if (valid[(gi*ISIZE + gj)] == 1'b1)
            begin
                assign xnorresults[(gi*ISIZE + gj)] = g_input[gj] ~^ e_input[(gi*ISIZE + gj)];
            end
        end
    end
endgenerate

shortint signed popcount [LSIZE-1:0];
shortint unsigned i;
shortint unsigned j;
shortint unsigned k;
bit [LSIZE-1:0] tempresult;

always @* begin
for (i=0; i<LSIZE; i=i+1) begin
    popcount[i] = 0;
    for (j=0; j<ISIZE; j=j+1) begin
        popcount[i] = popcount[i] + xnorresults[(i*ISIZE + j)];
    end
    popcount[i] = 2*popcount[i];
end

for (k=0; k<LSIZE; k=k+1) begin
    tempresult[k] = (popcount[k] > (threshold + NUM_VALID[k]));
end
end

assign o = tempresult;
endmodule
"""



conv_verilog = """
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
input bit [(CONV_SIZE*CONV_SIZE-1):0] e_input;
output bit [(ISIZE_L-4)*(ISIZE_H-4)-1:0] o;


bit [((ISIZE_L-4)*(ISIZE_H-4)*CONV_SIZE*CONV_SIZE-1):0] xnorresults;

genvar gi, gj, gk, gl;
generate
    for (gi=0; gi<ISIZE_H-4; gi=gi+1) begin : genbit
        for (gj=0; gj<ISIZE_L-4; gj=gj+1) begin : genbit2
            for (gk=0; gk<CONV_SIZE; gk=gk+1) begin : genbit3
                for (gl=0; gl<CONV_SIZE; gl=gl+1) begin : genbit4
                    if (valid[(gk*CONV_SIZE + gl)] == 1'b1)
                    begin
                        assign xnorresults[(gi*ISIZE_L+gj)*CONV_SIZE*CONV_SIZE + gk*CONV_SIZE+gl] = g_input[(gi+gk)*ISIZE_L+(gj+gl)] ~^ e_input[(gk*CONV_SIZE+gl)];
                    end
                end
            end
        end
    end
endgenerate

byte signed popcount [(ISIZE_L-4)*(ISIZE_H-4)-1:0];
shortint signed tot_popcount;
shortint unsigned i;
byte unsigned j;
bit [(ISIZE_L-4)*(ISIZE_H-4)-1:0] tempresult;

always @* begin
tot_popcount = 0;
for (i=0; i<(ISIZE_L-4)*(ISIZE_H-4); i=i+1) begin
    popcount[i] = 0;
    for (j=0; j<CONV_SIZE*CONV_SIZE; j=j+1) begin
        popcount[i] = popcount[i] + xnorresults[i*CONV_SIZE*CONV_SIZE + j];
    end
    popcount[i] = 2*popcount[i];
    tot_popcount = tot_popcount + popcount[i];
end
tot_popcount = tot_popcount - ((ISIZE_L-4)*(ISIZE_H-4)*NUM_VALID);
tot_popcount = tot_popcount/((ISIZE_L-4)*(ISIZE_H-4));
for (i=0; i<(ISIZE_L-4)*(ISIZE_H-4); i=i+1) begin
    tempresult[i] = (popcount[i] > (threshold + NUM_VALID + tot_popcount));
end
end

assign o = tempresult;
endmodule
"""

pad_verilog = """
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
output bit [(ISIZE_L+2*PAD_SIZE)*(ISIZE_H+2*PAD_SIZE)-1:0] o;


bit [(ISIZE_L+2*PAD_SIZE)*(ISIZE_H+2*PAD_SIZE)-1:0] tempresult;

byte unsigned gi, gj;

always @* begin
for (gi=0; gi<ISIZE_H; gi=gi+1) begin
    for (gj=0; gj<ISIZE_L; gj=gj+1) begin
        tempresult[(gi + PAD_SIZE)*(ISIZE_L + 2*PAD_SIZE) + gj + PAD_SIZE] = g_input[gi*ISIZE_L + gj];
    end
end
end

assign o = tempresult;
endmodule
"""



dotproduct_verilog = """
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
"""