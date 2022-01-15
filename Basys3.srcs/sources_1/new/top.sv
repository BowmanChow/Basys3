`default_nettype none

module top (
    // Clock
    input wire clk,

    // switch
    input wire [15:0] sw,

    // leds
    output wire [15:0] led,

    // 7 Segment Display
    output wire [6:0] seg,
    output wire dp,
    output wire [3:0] an,

    // Buttons
    input wire btnC,
    input wire btnU,
    input wire btnL,
    input wire btnR,
    input wire btnD,

    // VGA Display
    output wire [3:0] vgaRed,
    output wire [3:0] vgaBlue,
    output wire [3:0] vgaGreen,
    output wire Hsync,
    output wire Vsync,

    // USB-RS232 Interface
    input wire RsRx,
    output wire RsTx
    );

ClkDiv #(25) clk_div(
    .clk(clk)
);

ClkDiv #(15) clk_div_seg(
    .clk(clk)
);

Segment7 segment7(
    .number(
        ~seg_en[0] ? sw[3:0] :
        ~seg_en[1] ? sw[7:4] :
        ~seg_en[2] ? sw[11:8] : sw[15:12]
    ),
    .segments(seg)
);

reg [3:0] seg_en = 4'b1110;
assign an = seg_en;
always_ff @(posedge clk_div_seg.out)
    seg_en <= {seg_en[2:0], seg_en[3]};

reg dp_r = 0;
assign dp = dp_r;
always_ff @(posedge clk_div.out)
    dp_r <= ~dp_r;

assign led = sw;

endmodule
