module Display(
    input  i_rst_n,
    input  i_clk_25M
    output [7:0] VGA_B,
    output VGA_BLANK_N,
    output VGA_CLK,
    output [7:0] VGA_G,
    output VGA_HS,
    output [7:0] VGA_R,
    output VGA_SYNC_N,
    output VGA_VS
);
    logic [7:0] pixel[2:0];
    logic [9:0] x_cnt, y_cnt;
    logic [7:0] bg_r_pixel, bg_g_pixel, bg_b_pixel;

    vga vga_instance (
        .i_rst_n(i_rst_n),
        .i_clk_25M(i_clk_25M),
        .in_pixel(in_pixel),
        .VGA_B(VGA_B),
        .VGA_BLANK_N(VGA_BLANK_N),
        .VGA_CLK(VGA_CLK),
        .VGA_G(VGA_G),
        .VGA_HS(VGA_HS),
        .VGA_R(VGA_R),
        .VGA_SYNC_N(VGA_SYNC_N),
        .VGA_VS(VGA_VS),
        .o_x_cnt(x_cnt),
        .o_y_cnt(y_cnt)
    );

    Background background_instance (
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .r_data(bg_r_pixel),
        .g_data(bg_g_pixel),
        .b_data(bg_b_pixel)
    );

endmodule