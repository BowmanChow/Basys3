module ClkDiv #(
    parameter BIT_WIDTH = 2)
    (
    input wire clk,
    output reg out = 0
    );

reg [BIT_WIDTH-1:0] count = 0;

always_ff @(posedge clk) begin
    count <= count + 1;
    if (count == 0)
        out <= ~out;
end

endmodule
