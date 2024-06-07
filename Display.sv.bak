module Display(
    input  i_rst_n,
    input  i_clk_25M,
    input  [5:0] hands [14:0];
    output [7:0] VGA_B,
    output VGA_BLANK_N,
    output VGA_CLK,
    output [7:0] VGA_G,
    output VGA_HS,
    output [7:0] VGA_R,
    output VGA_SYNC_N,
    output VGA_VS
);
    logic [7:0] pixel          [2:0];
    logic [9:0] x_cnt, y_cnt, bg_x_pin, bg_y_pin, current_x_pin, current_y_pin;
    logic [7:0] bg_r_pixel, bg_g_pixel, bg_b_pixel;
    logic [7:0] cards_r_pixel  [14:0];
    logic [7:0] cards_g_pixel  [14:0];
    logic [7:0] cards_b_pixel  [14:0];
    logic [7:0] red_cards_r    [12:0];
    logic [7:0] red_cards_g    [12:0];
    logic [7:0] red_cards_b    [12:0];
    logic [7:0] yellow_cards_r [12:0];
    logic [7:0] yellow_cards_g [12:0];
    logic [7:0] yellow_cards_b [12:0];
    logic [7:0] green_cards_r  [12:0];
    logic [7:0] green_cards_g  [12:0];
    logic [7:0] green_cards_b  [12:0];
    logic [7:0] blue_cards_r   [12:0];
    logic [7:0] blue_cards_g   [12:0];
    logic [7:0] blue_cards_b   [12:0];
    logic [7:0] wild_cards_r;
    logic [7:0] wild_cards_g;
    logic [7:0] wild_cards_b;
    logic [7:0] wild_draw_four_r;
    logic [7:0] wild_draw_four_g;
    logic [7:0] wild_draw_four_b;
    logic [9:0] card_x_pin     [14:0];
    logic [9:0] card_y_pin     [14:0];
    // logic [12:0] red_in_use, yellow_in_use, green_in_use, blue_in_use;
    // logic        wild_in_use, wild_draw_four_in_use;
    //left_up(160, 50)
    //right_down(760, 480)
    assign bg_x_pin = 160;
    assign bg_y_pin = 50;
    genvar i;
    generate
        for (i = 0; i < 15; i++) begin : gen_card_pins
            assign card_x_pin[i] = 170 + 40 * i;
            assign card_y_pin[i] = 410;
        end
    endgenerate

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

    Background background_instance (
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(bg_x_pin),
        .y_pin(bg_y_pin),
        .r_data(bg_r_pixel),
        .g_data(bg_g_pixel),
        .b_data(bg_b_pixel)
    );
// 0: 0, 1: 1, 2: 2, 3: 3, 4: 4, 5: 5, 6: 6, 7: 7, 8: 8, 9: 9
// 10: skip, 11: reverse, 12: draw two, 13: wild, 14: wild draw four
    red_zero red_zero_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[0]),
        .y_pin(current_y_pin[0]),
        .r_data(red_cards_r[0]),
        .g_data(red_cards_g[0]),
        .b_data(red_cards_b[0])
    );
    red_one red_one_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[1]),
        .y_pin(current_y_pin[1]),
        .r_data(red_cards_r[1]),
        .g_data(red_cards_g[1]),
        .b_data(red_cards_b[1])
    );
    red_two red_two_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[2]),
        .y_pin(current_y_pin[2]),
        .r_data(red_cards_r[2]),
        .g_data(red_cards_g[2]),
        .b_data(red_cards_b[2])
    );
    red_three red_three_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[3]),
        .y_pin(current_y_pin[3]),
        .r_data(red_cards_r[3]),
        .g_data(red_cards_g[3]),
        .b_data(red_cards_b[3])
    );
    red_four red_four_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[4]),
        .y_pin(current_y_pin[4]),
        .r_data(red_cards_r[4]),
        .g_data(red_cards_g[4]),
        .b_data(red_cards_b[4])
    );
    red_five red_five_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[5]),
        .y_pin(current_y_pin[5]),
        .r_data(red_cards_r[5]),
        .g_data(red_cards_g[5]),
        .b_data(red_cards_b[5])
    );
    red_six red_six_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[6]),
        .y_pin(current_y_pin[6]),
        .r_data(red_cards_r[6]),
        .g_data(red_cards_g[6]),
        .b_data(red_cards_b[6])
    );
    red_seven red_seven_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[7]),
        .y_pin(current_y_pin[7]),
        .r_data(red_cards_r[7]),
        .g_data(red_cards_g[7]),
        .b_data(red_cards_b[7])
    );
    red_eight red_eight_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[8]),
        .y_pin(current_y_pin[8]),
        .r_data(red_cards_r[8]),
        .g_data(red_cards_g[8]),
        .b_data(red_cards_b[8])
    );
    red_nine red_nine_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[9]),
        .y_pin(current_y_pin[9]),
        .r_data(red_cards_r[9]),
        .g_data(red_cards_g[9]),
        .b_data(red_cards_b[9])
    );
    red_skip red_skip_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[10]),
        .y_pin(current_y_pin[10]),
        .r_data(red_cards_r[10]),
        .g_data(red_cards_g[10]),
        .b_data(red_cards_b[10])
    );
    red_reverse red_reverse_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[11]),
        .y_pin(current_y_pin[11]),
        .r_data(red_cards_r[11]),
        .g_data(red_cards_g[11]),
        .b_data(red_cards_b[11])
    );
    red_draw_two red_draw_two_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[12]),
        .y_pin(current_y_pin[12]),
        .r_data(red_cards_r[12]),
        .g_data(red_cards_g[12]),
        .b_data(red_cards_b[12])
    );
    yellow_zero yellow_zero_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[0]),
        .y_pin(current_y_pin[0]),
        .r_data(yellow_cards_r[0]),
        .g_data(yellow_cards_g[0]),
        .b_data(yellow_cards_b[0])
    );
    yellow_one yellow_one_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[1]),
        .y_pin(current_y_pin[1]),
        .r_data(yellow_cards_r[1]),
        .g_data(yellow_cards_g[1]),
        .b_data(yellow_cards_b[1])
    );
    yellow_two yellow_two_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[2]),
        .y_pin(current_y_pin[2]),
        .r_data(yellow_cards_r[2]),
        .g_data(yellow_cards_g[2]),
        .b_data(yellow_cards_b[2])
    );
    yellow_three yellow_three_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[3]),
        .y_pin(current_y_pin[3]),
        .r_data(yellow_cards_r[3]),
        .g_data(yellow_cards_g[3]),
        .b_data(yellow_cards_b[3])
    );
    yellow_four yellow_four_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[4]),
        .y_pin(current_y_pin[4]),
        .r_data(yellow_cards_r[4]),
        .g_data(yellow_cards_g[4]),
        .b_data(yellow_cards_b[4])
    );
    yellow_five yellow_five_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[5]),
        .y_pin(current_y_pin[5]),
        .r_data(yellow_cards_r[5]),
        .g_data(yellow_cards_g[5]),
        .b_data(yellow_cards_b[5])
    );
    yellow_six yellow_six_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[6]),
        .y_pin(current_y_pin[6]),
        .r_data(yellow_cards_r[6]),
        .g_data(yellow_cards_g[6]),
        .b_data(yellow_cards_b[6])
    );
    yellow_seven yellow_seven_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[7]),
        .y_pin(current_y_pin[7]),
        .r_data(yellow_cards_r[7]),
        .g_data(yellow_cards_g[7]),
        .b_data(yellow_cards_b[7])
    );
    yellow_eight yellow_eight_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[8]),
        .y_pin(current_y_pin[8]),
        .r_data(yellow_cards_r[8]),
        .g_data(yellow_cards_g[8]),
        .b_data(yellow_cards_b[8])
    );
    yellow_nine yellow_nine_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[9]),
        .y_pin(current_y_pin[9]),
        .r_data(yellow_cards_r[9]),
        .g_data(yellow_cards_g[9]),
        .b_data(yellow_cards_b[9])
    );
    yellow_skip yellow_skip_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[10]),
        .y_pin(current_y_pin[10]),
        .r_data(yellow_cards_r[10]),
        .g_data(yellow_cards_g[10]),
        .b_data(yellow_cards_b[10])
    );
    yellow_reverse yellow_reverse_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[11]),
        .y_pin(current_y_pin[11]),
        .r_data(yellow_cards_r[11]),
        .g_data(yellow_cards_g[11]),
        .b_data(yellow_cards_b[11])
    );
    yellow_draw_two yellow_draw_two_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[12]),
        .y_pin(current_y_pin[12]),
        .r_data(yellow_cards_r[12]),
        .g_data(yellow_cards_g[12]),
        .b_data(yellow_cards_b[12])
    );
    green_zero green_zero_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[0]),
        .y_pin(current_y_pin[0]),
        .r_data(green_cards_r[0]),
        .g_data(green_cards_g[0]),
        .b_data(green_cards_b[0])
    );
    green_one green_one_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[1]),
        .y_pin(current_y_pin[1]),
        .r_data(green_cards_r[1]),
        .g_data(green_cards_g[1]),
        .b_data(green_cards_b[1])
    );
    green_two green_two_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[2]),
        .y_pin(current_y_pin[2]),
        .r_data(green_cards_r[2]),
        .g_data(green_cards_g[2]),
        .b_data(green_cards_b[2])
    );
    green_three green_three_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[3]),
        .y_pin(current_y_pin[3]),
        .r_data(green_cards_r[3]),
        .g_data(green_cards_g[3]),
        .b_data(green_cards_b[3])
    );
    green_four green_four_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[4]),
        .y_pin(current_y_pin[4]),
        .r_data(green_cards_r[4]),
        .g_data(green_cards_g[4]),
        .b_data(green_cards_b[4])
    );
    green_five green_five_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[5]),
        .y_pin(current_y_pin[5]),
        .r_data(green_cards_r[5]),
        .g_data(green_cards_g[5]),
        .b_data(green_cards_b[5])
    );
    green_six green_six_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[6]),
        .y_pin(current_y_pin[6]),
        .r_data(green_cards_r[6]),
        .g_data(green_cards_g[6]),
        .b_data(green_cards_b[6])
    );
    green_seven green_seven_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[7]),
        .y_pin(current_y_pin[7]),
        .r_data(green_cards_r[7]),
        .g_data(green_cards_g[7]),
        .b_data(green_cards_b[7])
    );
    green_eight green_eight_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[8]),
        .y_pin(current_y_pin[8]),
        .r_data(green_cards_r[8]),
        .g_data(green_cards_g[8]),
        .b_data(green_cards_b[8])
    );
    green_nine green_nine_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[9]),
        .y_pin(current_y_pin[9]),
        .r_data(green_cards_r[9]),
        .g_data(green_cards_g[9]),
        .b_data(green_cards_b[9])
    );
    green_skip green_skip_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[10]),
        .y_pin(current_y_pin[10]),
        .r_data(green_cards_r[10]),
        .g_data(green_cards_g[10]),
        .b_data(green_cards_b[10])
    );
    green_reverse green_reverse_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[11]),
        .y_pin(current_y_pin[11]),
        .r_data(green_cards_r[11]),
        .g_data(green_cards_g[11]),
        .b_data(green_cards_b[11])
    );
    green_draw_two green_draw_two_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[12]),
        .y_pin(current_y_pin[12]),
        .r_data(green_cards_r[12]),
        .g_data(green_cards_g[12]),
        .b_data(green_cards_b[12])
    );
    blue_zero blue_zero_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[0]),
        .y_pin(current_y_pin[0]),
        .r_data(blue_cards_r[0]),
        .g_data(blue_cards_g[0]),
        .b_data(blue_cards_b[0])
    );
    blue_one blue_one_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[1]),
        .y_pin(current_y_pin[1]),
        .r_data(blue_cards_r[1]),
        .g_data(blue_cards_g[1]),
        .b_data(blue_cards_b[1])
    );
    blue_two blue_two_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[2]),
        .y_pin(current_y_pin[2]),
        .r_data(blue_cards_r[2]),
        .g_data(blue_cards_g[2]),
        .b_data(blue_cards_b[2])
    );
    blue_three blue_three_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[3]),
        .y_pin(current_y_pin[3]),
        .r_data(blue_cards_r[3]),
        .g_data(blue_cards_g[3]),
        .b_data(blue_cards_b[3])
    );
    blue_four blue_four_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[4]),
        .y_pin(current_y_pin[4]),
        .r_data(blue_cards_r[4]),
        .g_data(blue_cards_g[4]),
        .b_data(blue_cards_b[4])
    );
    blue_five blue_five_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[5]),
        .y_pin(current_y_pin[5]),
        .r_data(blue_cards_r[5]),
        .g_data(blue_cards_g[5]),
        .b_data(blue_cards_b[5])
    );
    blue_six blue_six_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[6]),
        .y_pin(current_y_pin[6]),
        .r_data(blue_cards_r[6]),
        .g_data(blue_cards_g[6]),
        .b_data(blue_cards_b[6])
    );
    blue_seven blue_seven_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[7]),
        .y_pin(current_y_pin[7]),
        .r_data(blue_cards_r[7]),
        .g_data(blue_cards_g[7]),
        .b_data(blue_cards_b[7])
    );
    blue_eight blue_eight_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[8]),
        .y_pin(current_y_pin[8]),
        .r_data(blue_cards_r[8]),
        .g_data(blue_cards_g[8]),
        .b_data(blue_cards_b[8])
    );
    blue_nine blue_nine_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[9]),
        .y_pin(current_y_pin[9]),
        .r_data(blue_cards_r[9]),
        .g_data(blue_cards_g[9]),
        .b_data(blue_cards_b[9])
    );
    blue_skip blue_skip_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[10]),
        .y_pin(current_y_pin[10]),
        .r_data(blue_cards_r[10]),
        .g_data(blue_cards_g[10]),
        .b_data(blue_cards_b[10])
    );
    blue_reverse blue_reverse_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[11]),
        .y_pin(current_y_pin[11]),
        .r_data(blue_cards_r[11]),
        .g_data(blue_cards_g[11]),
        .b_data(blue_cards_b[11])
    );
    blue_draw_two blue_draw_two_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[12]),
        .y_pin(current_y_pin[12]),
        .r_data(blue_cards_r[12]),
        .g_data(blue_cards_g[12]),
        .b_data(blue_cards_b[12])
    );
    wild wild_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[13]),
        .y_pin(current_y_pin[13]),
        .r_data(wild_cards_r),
        .g_data(wild_cards_g),
        .b_data(wild_cards_b)
    );
    wild_draw_four wild_draw_four_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin[14]),
        .y_pin(current_y_pin[14]),
        .r_data(wild_draw_four_r),
        .g_data(wild_draw_four_g),
        .b_data(wild_draw_four_b)
    );
    always_comb begin
        for (int i = 0; i < 15; i++) begin
            case(hands[i][5:4])
                2'b00: begin // red
                    case(hands[i][3:0])
                        4'b0000: begin
                            pixel[0] = red_cards_r[0];
                            pixel[1] = red_cards_g[0];
                            pixel[2] = red_cards_b[0];
                        end
                        4'b0001: begin
                            pixel[0] = red_cards_r[1];
                            pixel[1] = red_cards_g[1];
                            pixel[2] = red_cards_b[1];
                        end
                        4'b0010: begin
                            pixel[0] = red_cards_r[2];
                            pixel[1] = red_cards_g[2];
                            pixel[2] = red_cards_b[2];
                        end
                        4'b0011: begin
                            pixel[0] = red_cards_r[3];
                            pixel[1] = red_cards_g[3];
                            pixel[2] = red_cards_b[3];
                        end
                        4'b0100: begin
                            pixel[0] = red_cards_r[4];
                            pixel[1] = red_cards_g[4];
                            pixel[2] = red_cards_b[4];
                        end
                        4'b0101: begin
                            pixel[0] = red_cards_r[5];
                            pixel[1] = red_cards_g[5];
                            pixel[2] = red_cards_b[5];
                        end
                        4'b0110: begin
                            pixel[0] = red_cards_r[6];
                            pixel[1] = red_cards_g[6];
                            pixel[2] = red_cards_b[6];
                        end
                        4'b0111: begin
                            pixel[0] = red_cards_r[7];
                            pixel[1] = red_cards_g[7];
                            pixel[2] = red_cards_b[7];
                        end
                        4'b1000: begin
                            pixel[0] = red_cards_r[8];
                            pixel[1] = red_cards_g[8];
                            pixel[2] = red_cards_b[8];
                        end
                        4'b1001: begin
                            pixel[0] = red_cards_r[9];
                            pixel[1] = red_cards_g[9];
                            pixel[2] = red_cards_b[9];
                        end
                        4'b1010: begin
                            pixel[0] = red_cards_r[10];
                            pixel[1] = red_cards_g[10];
                            pixel[2] = red_cards_b[10];
                        end
                        4'b1011: begin
                            pixel[0] = red_cards_r[11];
                            pixel[1] = red_cards_g[11];
                            pixel[2] = red_cards_b[11];
                        end
                        4'b1100: begin
                            pixel[0] = red_cards_r[12];
                            pixel[1] = red_cards_g[12];
                            pixel[2] = red_cards_b[12];
                        end
                        4'b1101: begin
                            pixel[0] = wild_cards_r;
                            pixel[1] = wild_cards_g;
                            pixel[2] = wild_cards_b;
                        end
                        4'b1110: begin
                            pixel[0] = wild_draw_four_r;
                            pixel[1] = wild_draw_four_g;
                            pixel[2] = wild_draw_four_b;
                        end
                        default: begin
                            pixel[0] = bg_r_pixel;
                            pixel[1] = bg_g_pixel;
                            pixel[2] = bg_b_pixel;
                        end
                    endcase
                end
                2'b01: begin // yellow
                    case(hands[i][3:0])
                        4'b0000: begin
                            pixel[0] = yellow_cards_r[0];
                            pixel[1] = yellow_cards_g[0];
                            pixel[2] = yellow_cards_b[0];
                        end
                        4'b0001: begin
                            pixel[0] = yellow_cards_r[1];
                            pixel[1] = yellow_cards_g[1];
                            pixel[2] = yellow_cards_b[1];
                        end
                        4'b0010: begin
                            pixel[0] = yellow_cards_r[2];
                            pixel[1] = yellow_cards_g[2];
                            pixel[2] = yellow_cards_b[2];
                        end
                        4'b0011: begin
                            pixel[0] = yellow_cards_r[3];
                            pixel[1] = yellow_cards_g[3];
                            pixel[2] = yellow_cards_b[3];
                        end
                        4'b0100: begin
                            pixel[0] = yellow_cards_r[4];
                            pixel[1] = yellow_cards_g[4];
                            pixel[2] = yellow_cards_b[4];
                        end
                        4'b0101: begin
                            pixel[0] = yellow_cards_r[5];
                            pixel[1] = yellow_cards_g[5];
                            pixel[2] = yellow_cards_b[5];
                        end
                        4'b0110: begin
                            pixel[0] = yellow_cards_r[6];
                            pixel[1] = yellow_cards_g[6];
                            pixel[2] = yellow_cards_b[6];
                        end
                        4'b0111: begin
                            pixel[0] = yellow_cards_r[7];
                            pixel[1] = yellow_cards_g[7];
                            pixel[2] = yellow_cards_b[7];
                        end
                        4'b1000: begin
                            pixel[0] = yellow_cards_r[8];
                            pixel[1] = yellow_cards_g[8];
                            pixel[2] = yellow_cards_b[8];
                        end
                        4'b1001: begin
                            pixel[0] = yellow_cards_r[9];
                            pixel[1] = yellow_cards_g[9];
                            pixel[2] = yellow_cards_b[9];
                        end
                        4'b1010: begin
                            pixel[0] = yellow_cards_r[10];
                            pixel[1] = yellow_cards_g[10];
                            pixel[2] = yellow_cards_b[10];
                        end
                        4'b1011: begin
                            pixel[0] = yellow_cards_r[11];
                            pixel[1] = yellow_cards_g[11];
                            pixel[2] = yellow_cards_b[11];
                        end
                        4'b1100: begin
                            pixel[0] = yellow_cards_r[12];
                            pixel[1] = yellow_cards_g[12];
                            pixel[2] = yellow_cards_b[12];
                        end
                        4'b1101: begin
                            pixel[0] = wild_cards_r;
                            pixel[1] = wild_cards_g;
                            pixel[2] = wild_cards_b;
                        end
                        4'b1110: begin
                            pixel[0] = wild_draw_four_r;
                            pixel[1] = wild_draw_four_g;
                            pixel[2] = wild_draw_four_b;
                        end
                        default: begin
                            pixel[0] = bg_r_pixel;
                            pixel[1] = bg_g_pixel;
                            pixel[2] = bg_b_pixel;
                        end
                    endcase
                end
                2'b10: begin // green
                    case(hands[i][3:0])
                        4'b0000: begin
                            pixel[0] = green_cards_r[0];
                            pixel[1] = green_cards_g[0];
                            pixel[2] = green_cards_b[0];
                        end
                        4'b0001: begin
                            pixel[0] = green_cards_r[1];
                            pixel[1] = green_cards_g[1];
                            pixel[2] = green_cards_b[1];
                        end
                        4'b0010: begin
                            pixel[0] = green_cards_r[2];
                            pixel[1] = green_cards_g[2];
                            pixel[2] = green_cards_b[2];
                        end
                        4'b0011: begin
                            pixel[0] = green_cards_r[3];
                            pixel[1] = green_cards_g[3];
                            pixel[2] = green_cards_b[3];
                        end
                        4'b0100: begin
                            pixel[0] = green_cards_r[4];
                            pixel[1] = green_cards_g[4];
                            pixel[2] = green_cards_b[4];
                        end
                        4'b0101: begin
                            pixel[0] = green_cards_r[5];
                            pixel[1] = green_cards_g[5];
                            pixel[2] = green_cards_b[5];
                        end
                        4'b0110: begin
                            pixel[0] = green_cards_r[6];
                            pixel[1] = green_cards_g[6];
                            pixel[2] = green_cards_b[6];
                        end
                        4'b0111: begin
                            pixel[0] = green_cards_r[7];
                            pixel[1] = green_cards_g[7];
                            pixel[2] = green_cards_b[7];
                        end
                        4'b1000: begin
                            pixel[0] = green_cards_r[8];
                            pixel[1] = green_cards_g[8];
                            pixel[2] = green_cards_b[8];
                        end
                        4'b1001: begin
                            pixel[0] = green_cards_r[9];
                            pixel[1] = green_cards_g[9];
                            pixel[2] = green_cards_b[9];
                        end
                        4'b1010: begin
                            pixel[0] = green_cards_r[10];
                            pixel[1] = green_cards_g[10];
                            pixel[2] = green_cards_b[10];
                        end
                        4'b1011: begin
                            pixel[0] = green_cards_r[11];
                            pixel[1] = green_cards_g[11];
                            pixel[2] = green_cards_b[11];
                        end
                        4'b1100: begin
                            pixel[0] = green_cards_r[12];
                            pixel[1] = green_cards_g[12];
                            pixel[2] = green_cards_b[12];
                        end
                        4'b1101: begin
                            pixel[0] = wild_cards_r;
                            pixel[1] = wild_cards_g;
                            pixel[2] = wild_cards_b;
                        end
                        4'b1110: begin
                            pixel[0] = wild_draw_four_r;
                            pixel[1] = wild_draw_four_g;
                            pixel[2] = wild_draw_four_b;
                        end
                        default: begin
                            pixel[0] = bg_r_pixel;
                            pixel[1] = bg_g_pixel;
                            pixel[2] = bg_b_pixel;
                        end
                    endcase
                end
                2'b11: begin // blue
                    case(hands[i][3:0])
                        4'b0000: begin
                            pixel[0] = blue_cards_r[0];
                            pixel[1] = blue_cards_g[0];
                            pixel[2] = blue_cards_b[0];
                        end
                        4'b0001: begin
                            pixel[0] = blue_cards_r[1];
                            pixel[1] = blue_cards_g[1];
                            pixel[2] = blue_cards_b[1];
                        end
                        4'b0010: begin
                            pixel[0] = blue_cards_r[2];
                            pixel[1] = blue_cards_g[2];
                            pixel[2] = blue_cards_b[2];
                        end
                        4'b0011: begin
                            pixel[0] = blue_cards_r[3];
                            pixel[1] = blue_cards_g[3];
                            pixel[2] = blue_cards_b[3];
                        end
                        4'b0100: begin
                            pixel[0] = blue_cards_r[4];
                            pixel[1] = blue_cards_g[4];
                            pixel[2] = blue_cards_b[4];
                        end
                        4'b0101: begin
                            pixel[0] = blue_cards_r[5];
                            pixel[1] = blue_cards_g[5];
                            pixel[2] = blue_cards_b[5];
                        end
                        4'b0110: begin
                            pixel[0] = blue_cards_r[6];
                            pixel[1] = blue_cards_g[6];
                            pixel[2] = blue_cards_b[6];
                        end
                        4'b0111: begin
                            pixel[0] = blue_cards_r[7];
                            pixel[1] = blue_cards_g[7];
                            pixel[2] = blue_cards_b[7];
                        end
                        4'b1000: begin
                            pixel[0] = blue_cards_r[8];
                            pixel[1] = blue_cards_g[8];
                            pixel[2] = blue_cards_b[8];
                        end
                        4'b1001: begin
                            pixel[0] = blue_cards_r[9];
                            pixel[1] = blue_cards_g[9];
                            pixel[2] = blue_cards_b[9];
                        end
                        4'b1010: begin
                            pixel[0] = blue_cards_r[10];
                            pixel[1] = blue_cards_g[10];
                            pixel[2] = blue_cards_b[10];
                        end
                        4'b1011: begin
                            pixel[0] = blue_cards_r[11];
                            pixel[1] = blue_cards_g[11];
                            pixel[2] = blue_cards_b[11];
                        end
                        4'b1100: begin
                            pixel[0] = blue_cards_r[12];
                            pixel[1] = blue_cards_g[12];
                            pixel[2] = blue_cards_b[12];
                        end
                        4'b1101: begin
                            pixel[0] = wild_cards_r;
                            pixel[1] = wild_cards_g;
                            pixel[2] = wild_cards_b;
                        end
                        4'b1110: begin
                            pixel[0] = wild_draw_four_r;
                            pixel[1] = wild_draw_four_g;
                            pixel[2] = wild_draw_four_b;
                        end
                        default: begin
                            pixel[0] = bg_r_pixel;
                            pixel[1] = bg_g_pixel;
                            pixel[2] = bg_b_pixel;
                        end
                    endcase
                end
            endcase
        end
    end
    always_comb begin
        integer i;
        if (410 <= y_cnt && y_cnt < 460) begin
            i = (x_cnt - 170) / 40;
            case (i)
                0: begin
                    current_x_pin = card_x_pin[0];
                    current_y_pin = card_y_pin[0];
                end
                1: begin
                    current_x_pin = card_x_pin[1];
                    current_y_pin = card_y_pin[1];
                end
                2: begin
                    current_x_pin = card_x_pin[2];
                    current_y_pin = card_y_pin[2];
                end
                3: begin
                    current_x_pin = card_x_pin[3];
                    current_y_pin = card_y_pin[3];
                end
                4: begin
                    current_x_pin = card_x_pin[4];
                    current_y_pin = card_y_pin[4];
                end
                5: begin
                    current_x_pin = card_x_pin[5];
                    current_y_pin = card_y_pin[5];
                end
                6: begin
                    current_x_pin = card_x_pin[6];
                    current_y_pin = card_y_pin[6];
                end
                7: begin
                    current_x_pin = card_x_pin[7];
                    current_y_pin = card_y_pin[7];
                end
                8: begin
                    current_x_pin = card_x_pin[8];
                    current_y_pin = card_y_pin[8];
                end
                9: begin
                    current_x_pin = card_x_pin[9];
                    current_y_pin = card_y_pin[9];
                end
                10: begin
                    current_x_pin = card_x_pin[10];
                    current_y_pin = card_y_pin[10];
                end
                11: begin
                    current_x_pin = card_x_pin[11];
                    current_y_pin = card_y_pin[11];
                end
                12: begin
                    current_x_pin = card_x_pin[12];
                    current_y_pin = card_y_pin[12];
                end
                13: begin
                    current_x_pin = card_x_pin[13];
                    current_y_pin = card_y_pin[13];
                end
                14: begin
                    current_x_pin = card_x_pin[14];
                    current_y_pin = card_y_pin[14];
                end
                default: begin
                    current_x_pin = bg_x_pin;
                    current_y_pin = bg_y_pin;
                end
            endcase
        end 
        else begin
            current_x_pin = bg_x_pin;
            current_y_pin = bg_y_pin;
        end
end
endmodule