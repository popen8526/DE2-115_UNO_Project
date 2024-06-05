module Display(
    input  i_rst_n,
    input  i_clk_25M,
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
    logic [9:0] x_cnt, y_cnt, Card_x_pin, Card_y_pin;
    logic [7:0] bg_r_pixel, bg_g_pixel, bg_b_pixel;
    logic [7:0] cards_r_pixel [14:0];
    logic [7:0] cards_g_pixel [14:0];
    logic [7:0] cards_b_pixel [14:0];
    //left_up(160, 50)
    //right_down(760, 480)
    assign Card_x_pin = 160;
    assign Card_y_pin = 50;
    vga vga_instance (
        .i_rst_n(i_rst_n),
        .i_clk_25M(i_clk_25M),
        // .i_start_display((0 <= x_cnt && x_cnt < 80) && (0 <= y_cnt && y_cnt < 52)),
        .in_pixel(pixel),
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

    // Background background_instance (
    //     .x_cnt(x_cnt),
    //     .y_cnt(y_cnt),
    //     .x_pin(Card_x_pin),
    //     .y_pin(Card_y_pin),
    //     .r_data(bg_r_pixel),
    //     .g_data(bg_g_pixel),
    //     .b_data(bg_b_pixel)
    // );

    Card card_instacne_0(
        .card(6'b000000),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(10'd170),
        .y_pin(10'd410),
        .r_data(cards_r_pixel[0]),
        .g_data(cards_g_pixel[0]),
        .b_data(cards_b_pixel[0])
    );

    Card card_instacne_1(
        .card(6'b000000),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(10'd210),
        .y_pin(10'd410),
        .r_data(cards_r_pixel[1]),
        .g_data(cards_g_pixel[1]),
        .b_data(cards_b_pixel[1])
    );

    Card cards_instance_2(
        .card(6'b000000),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(10'd250),
        .y_pin(10'd410),
        .r_data(cards_r_pixel[2]),
        .g_data(cards_g_pixel[2]),
        .b_data(cards_b_pixel[2])
    );

    Card cards_instance_3(
        .card(6'b000000),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(10'd290),
        .y_pin(10'd410),
        .r_data(cards_r_pixel[3]),
        .g_data(cards_g_pixel[3]),
        .b_data(cards_b_pixel[3])
    );

    Card cards_instance_4(
        .card(6'b000000),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(10'd330),
        .y_pin(10'd410),
        .r_data(cards_r_pixel[4]),
        .g_data(cards_g_pixel[4]),
        .b_data(cards_b_pixel[4])
    );

    Card cards_instance_5(
        .card(6'b000000),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(10'd370),
        .y_pin(10'd410),
        .r_data(cards_r_pixel[5]),
        .g_data(cards_g_pixel[5]),
        .b_data(cards_b_pixel[5])
    );

    Card cards_instance_6(
        .card(6'b000000),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(10'd410),
        .y_pin(10'd410),
        .r_data(cards_r_pixel[6]),
        .g_data(cards_g_pixel[6]),
        .b_data(cards_b_pixel[6])
    );

    Card cards_instance_7(
        .card(6'b000000),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(10'd450),
        .y_pin(10'd410),
        .r_data(cards_r_pixel[7]),
        .g_data(cards_g_pixel[7]),
        .b_data(cards_b_pixel[7])
    );

    Card cards_instance_8(
        .card(6'b000000),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(10'd490),
        .y_pin(10'd410),
        .r_data(cards_r_pixel[8]),
        .g_data(cards_g_pixel[8]),
        .b_data(cards_b_pixel[8])
    );

    Card cards_instance_9(
        .card(6'b000000),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(10'd530),
        .y_pin(10'd410),
        .r_data(cards_r_pixel[9]),
        .g_data(cards_g_pixel[9]),
        .b_data(cards_b_pixel[9])
    );

    Card cards_instance_10(
        .card(6'b000000),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(10'd570),
        .y_pin(10'd410),
        .r_data(cards_r_pixel[10]),
        .g_data(cards_g_pixel[10]),
        .b_data(cards_b_pixel[10])
    );

    Card cards_instance_11(
        .card(6'b000000),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(10'd610),
        .y_pin(10'd410),
        .r_data(cards_r_pixel[11]),
        .g_data(cards_g_pixel[11]),
        .b_data(cards_b_pixel[11])
    );

    Card cards_instance_12(
        .card(6'b000000),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(10'd650),
        .y_pin(10'd410),
        .r_data(cards_r_pixel[12]),
        .g_data(cards_g_pixel[12]),
        .b_data(cards_b_pixel[12])
    );

    Card cards_instance_13(
        .card(6'b000000),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(10'd690),
        .y_pin(10'd410),
        .r_data(cards_r_pixel[13]),
        .g_data(cards_g_pixel[13]),
        .b_data(cards_b_pixel[13])
    );

    Card cards_instance_14(
        .card(6'b000000),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(10'd730),
        .y_pin(10'd410),
        .r_data(cards_r_pixel[14]),
        .g_data(cards_g_pixel[14]),
        .b_data(cards_b_pixel[14])
    );
    // assign pixel[0] = cards_r_pixel[0];
    // assign pixel[1] = cards_g_pixel[0];
    // assign pixel[2] = cards_b_pixel[0];
    always_comb begin
        if(170 <= x_cnt && x_cnt < 200 && 410 <= y_cnt && y_cnt < 460) begin
            pixel[0] = cards_r_pixel[0];
            pixel[1] = cards_g_pixel[0];
            pixel[2] = cards_b_pixel[0];
        end
        else if(210 <= x_cnt && x_cnt < 240 && 410 <= y_cnt && y_cnt < 460) begin
            pixel[0] = cards_r_pixel[1];
            pixel[1] = cards_g_pixel[1];
            pixel[2] = cards_b_pixel[1];
        end
        else if(250 <= x_cnt && x_cnt < 280 && 410 <= y_cnt && y_cnt < 460) begin
            pixel[0] = cards_r_pixel[2];
            pixel[1] = cards_g_pixel[2];
            pixel[2] = cards_b_pixel[2];
        end
        else if(290 <= x_cnt && x_cnt < 320 && 410 <= y_cnt && y_cnt < 460) begin
            pixel[0] = cards_r_pixel[3];
            pixel[1] = cards_g_pixel[3];
            pixel[2] = cards_b_pixel[3];
        end
        else if(330 <= x_cnt && x_cnt < 360 && 410 <= y_cnt && y_cnt < 460) begin
            pixel[0] = cards_r_pixel[4];
            pixel[1] = cards_g_pixel[4];
            pixel[2] = cards_b_pixel[4];
        end
        else if(370 <= x_cnt && x_cnt < 400 && 410 <= y_cnt && y_cnt < 460) begin
            pixel[0] = cards_r_pixel[5];
            pixel[1] = cards_g_pixel[5];
            pixel[2] = cards_b_pixel[5];
        end
        else if(410 <= x_cnt && x_cnt < 440 && 410 <= y_cnt && y_cnt < 460) begin
            pixel[0] = cards_r_pixel[6];
            pixel[1] = cards_g_pixel[6];
            pixel[2] = cards_b_pixel[6];
        end
        else if(450 <= x_cnt && x_cnt < 480 && 410 <= y_cnt && y_cnt < 460) begin
            pixel[0] = cards_r_pixel[7];
            pixel[1] = cards_g_pixel[7];
            pixel[2] = cards_b_pixel[7];
        end
        else if(490 <= x_cnt && x_cnt < 520 && 410 <= y_cnt && y_cnt < 460) begin
            pixel[0] = cards_r_pixel[8];
            pixel[1] = cards_g_pixel[8];
            pixel[2] = cards_b_pixel[8];
        end
        else if(530 <= x_cnt && x_cnt < 560 && 410 <= y_cnt && y_cnt < 460) begin
            pixel[0] = cards_r_pixel[9];
            pixel[1] = cards_g_pixel[9];
            pixel[2] = cards_b_pixel[9];
        end
        else if(570 <= x_cnt && x_cnt < 600 && 410 <= y_cnt && y_cnt < 460) begin
            pixel[0] = cards_r_pixel[10];
            pixel[1] = cards_g_pixel[10];
            pixel[2] = cards_b_pixel[10];
        end
        else if(610 <= x_cnt && x_cnt < 640 && 410 <= y_cnt && y_cnt < 460) begin
            pixel[0] = cards_r_pixel[11];
            pixel[1] = cards_g_pixel[11];
            pixel[2] = cards_b_pixel[11];
        end
        else if(650 <= x_cnt && x_cnt < 680 && 410 <= y_cnt && y_cnt < 460) begin
            pixel[0] = cards_r_pixel[12];
            pixel[1] = cards_g_pixel[12];
            pixel[2] = cards_b_pixel[12];
        end
        else if(690 <= x_cnt && x_cnt < 720 && 410 <= y_cnt && y_cnt < 460) begin
            pixel[0] = cards_r_pixel[13];
            pixel[1] = cards_g_pixel[13];
            pixel[2] = cards_b_pixel[13];
        end
        else if(730 <= x_cnt && x_cnt < 760 && 410 <= y_cnt && y_cnt < 460) begin
            pixel[0] = cards_r_pixel[14];
            pixel[1] = cards_g_pixel[14];
            pixel[2] = cards_b_pixel[14];
        end
        else begin
            // pixel[0] = bg_r_pixel;
            // pixel[1] = bg_g_pixel;
            // pixel[2] = bg_b_pixel;
            pixel[0] = 8'b00000000;
            pixel[1] = 8'b00000000;
            pixel[2] = 8'b00000000;
        end
    end
endmodule