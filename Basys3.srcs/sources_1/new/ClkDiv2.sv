module ClkDiv2 (
    input wire clk,
    output reg out = 0
    );

always_ff @(posedge clk)
    out = ~out;

endmodule
