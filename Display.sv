module Display(
    input  i_rst_n,
    input  i_clk_25M,
    input  [5:0]  i_hands [108:0],
    input  [7:0]  i_index,
    input  [5:0]  i_prev_card,
    input  [6:0]  i_hands_num [3:0],
    input         i_finished,
    input         i_select_color,
    input  [10:0] i_score [3:0], 
    input  [3:0]  i_uno_state,
    input         i_start,
    input         i_reverse,
    input         i_replay,  
    input         [5:0] i_rank [3:0],
    output [7:0] VGA_B,
    output VGA_BLANK_N,
    output VGA_CLK,
    output [7:0] VGA_G,
    output VGA_HS,
    output [7:0] VGA_R,
    output VGA_SYNC_N,
    output VGA_VS,
    output [7:0] o_local_index
);
    logic [7:0] pixel          [2:0];
    logic [9:0] x_cnt, y_cnt, bg_x_pin, bg_y_pin, Index_x_pin_w, Index_x_pin_r, Index_y_pin_w, Index_y_pin_r, Index_2_x_pin_w, Index_2_x_pin_r, Index_2_y_pin_w, Index_2_y_pin_r;
    logic [9:0] current_x_pin, current_y_pin, prev_card_x_pin, prev_card_y_pin, pure_x_pin, pure_y_pin, prev_x_pin, prev_y_pin, cr_x_pin, cr_y_pin;
    logic [7:0] bg_r_pixel, bg_g_pixel, bg_b_pixel, sb_r_pixel, sb_g_pixel, sb_b_pixel, ce_r_pixel, ce_g_pixel, ce_b_pixel, cr_r_pixel, cr_g_pixel, cr_b_pixel, cl_r_pixel, cl_g_pixel, cl_b_pixel, start_r_pixel, start_g_pixel, start_b_pixel, arrow_r, arrow_g, arrow_b;
    logic [7:0] Index_r_pixel, Index_g_pixel, Index_b_pixel, pure_r_pixel, pure_g_pixel, pure_b_pixel, Index_2_r_pixel, Index_2_g_pixel, Index_2_b_pixel;
    logic [7:0] draw_card_r_pixel;
    logic [7:0] draw_card_g_pixel;
    logic [7:0] draw_card_b_pixel;
    logic [7:0] cards_r    [13:0];
    logic [7:0] cards_g    [13:0];
    logic [7:0] cards_b    [13:0];
    logic [7:0] wild_cards_r;
    logic [7:0] wild_cards_g;
    logic [7:0] wild_cards_b;
    logic [7:0] wild_draw_four_r;
    logic [7:0] wild_draw_four_g;
    logic [7:0] wild_draw_four_b;
    logic [9:0] card_x_pin     [14:0];
    logic [9:0] card_y_pin     [14:0];
    logic [9:0] i;
    logic [9:0] temp           [14:0];
    logic [1:0] color;
    logic [2:0] select_color;
    logic [7:0] local_index_w;
    logic [7:0] local_index_r;
    logic [7:0] current_index;
    logic [5:0] hands [14:0];
    logic [9:0] digits_pin_x [3:0];
    logic [9:0] digits_pin_y [3:0];
    logic [7:0] digits_r_one [3:0];
    logic [7:0] digits_g_one [3:0];
    logic [7:0] digits_b_one [3:0];
    logic [7:0] digits_r_ten [3:0];
    logic [7:0] digits_g_ten [3:0];
    logic [7:0] digits_b_ten [3:0];
    logic [7:0] digits_r_hundred [3:0];
    logic [7:0] digits_g_hundred [3:0];
    logic [7:0] digits_b_hundred [3:0];
    logic [3:0] digits_0_num [2:0]; // one, ten, hundred
    logic [3:0] digits_1_num [2:0]; // one, ten, hundred
    logic [3:0] digits_2_num [2:0]; // one, ten, hundred
    logic [3:0] digits_3_num [2:0]; // one, ten, hundred
    logic [9:0] digits_0_x_pin [2:0];
    logic [9:0] digits_0_y_pin [2:0];
    logic [9:0] digits_1_x_pin [2:0];
    logic [9:0] digits_1_y_pin [2:0];
    logic [9:0] digits_2_x_pin [2:0];
    logic [9:0] digits_2_y_pin [2:0];
    logic [9:0] digits_3_x_pin [2:0];
    logic [9:0] digits_3_y_pin [2:0];
    logic [9:0] digits_rank_0_x_pin [1:0];
    logic [9:0] digits_rank_0_y_pin [1:0];
    logic [9:0] digits_rank_1_x_pin [1:0];
    logic [9:0] digits_rank_1_y_pin [1:0];
    logic [9:0] digits_rank_2_x_pin [1:0];
    logic [9:0] digits_rank_2_y_pin [1:0];
    logic [9:0] digits_rank_3_x_pin [1:0];
    logic [9:0] digits_rank_3_y_pin [1:0];
    logic [7:0] digits_rank_0_one_pixel [2:0];
    logic [7:0] digits_rank_0_ten_pixel [2:0];
    logic [7:0] digits_rank_1_one_pixel [2:0];
    logic [7:0] digits_rank_1_ten_pixel [2:0];
    logic [7:0] digits_rank_2_one_pixel [2:0];
    logic [7:0] digits_rank_2_ten_pixel [2:0];
    logic [7:0] digits_rank_3_one_pixel [2:0];
    logic [7:0] digits_rank_3_ten_pixel [2:0];
    logic       init_pict_w, init_pict_r;
    logic [27:0] counter_w, counter_r;

    // 200~400
    // 165~365

    // logic [12:0] red_in_use, yellow_in_use, green_in_use, blue_in_use;
    // logic        wild_in_use, wild_draw_four_in_use;
    //left_up(160, 50)
    //right_down(760, 480)

    //  555, 195
    //  555, 260
    //  555, 325
    //  555, 390
    assign bg_x_pin = 160;
    assign bg_y_pin = 50;
    assign pure_x_pin = 460;
    assign pure_y_pin = 230;
    assign prev_x_pin = 430;
    assign prev_y_pin = 230;
    assign digits_pin_x[0] = 680;
    assign digits_pin_y[0] = 370;
    assign digits_pin_x[1] = 170;
    assign digits_pin_y[1] = 60;
    assign digits_pin_x[2] = 430;
    assign digits_pin_y[2] = 60;
    assign digits_pin_x[3] = 680;
    assign digits_pin_y[3] = 60;
    assign i = (x_cnt - 10'd170) / 10'd40;
    assign current_index = (i_index - local_index_r >= 10'd14) ? 10'd14 : (i_index - local_index_r);
    assign o_local_index = local_index_r;
    assign digits_0_num[0] = (i_finished) ? i_score[0] - (i_score[0]/10)*10 : i_hands_num[0] - (i_hands_num[0]/10)*10;
    assign digits_0_num[1] = (i_finished) ? i_score[0]/10 : i_hands_num[0]/10;
    assign digits_0_num[2] = i_score[0]/100;
    assign digits_1_num[0] = (i_finished) ? i_score[1] - (i_score[1]/10)*10 : i_hands_num[1] - (i_hands_num[1]/10)*10;
    assign digits_1_num[1] = (i_finished) ? i_score[1]/10 : i_hands_num[1]/10;
    assign digits_1_num[2] = i_score[1]/100;
    assign digits_2_num[0] = (i_finished) ? i_score[2] - (i_score[2]/10)*10 : i_hands_num[2] - (i_hands_num[2]/10)*10;
    assign digits_2_num[1] = (i_finished) ? i_score[2]/10 : i_hands_num[2]/10;
    assign digits_2_num[2] = i_score[2]/100;
    assign digits_3_num[0] = (i_finished) ? i_score[3] - (i_score[3]/10)*10 : i_hands_num[3] - (i_hands_num[3]/10)*10;
    assign digits_3_num[1] = (i_finished) ? i_score[3]/10 : i_hands_num[3]/10;
    assign digits_3_num[2] = i_score[3]/100;
    assign digits_0_x_pin[0] = (i_finished) ? 615 : 710;
    assign digits_0_y_pin[0] = (i_finished) ? 186 : 370;
    assign digits_0_x_pin[1] = (i_finished) ? 585 : 680;
    assign digits_0_y_pin[1] = (i_finished) ? 186 : 370;
    assign digits_0_x_pin[2] = (i_finished) ? 555 : 0;
    assign digits_0_y_pin[2] = (i_finished) ? 186 : 0;
    assign digits_1_x_pin[0] = (i_finished) ? 615 : 200;
    assign digits_1_y_pin[0] = (i_finished) ? 251 : 60;
    assign digits_1_x_pin[1] = (i_finished) ? 585 : 170;
    assign digits_1_y_pin[1] = (i_finished) ? 251 : 60;
    assign digits_1_x_pin[2] = (i_finished) ? 555 : 0;
    assign digits_1_y_pin[2] = (i_finished) ? 251 : 0;
    assign digits_2_x_pin[0] = (i_finished) ? 615 : 460;
    assign digits_2_y_pin[0] = (i_finished) ? 316 : 60;
    assign digits_2_x_pin[1] = (i_finished) ? 585 : 430;
    assign digits_2_y_pin[1] = (i_finished) ? 316 : 60;
    assign digits_2_x_pin[2] = (i_finished) ? 555 : 0;
    assign digits_2_y_pin[2] = (i_finished) ? 316 : 0;
    assign digits_3_x_pin[0] = (i_finished) ? 615 : 710;
    assign digits_3_y_pin[0] = (i_finished) ? 381 : 60;
    assign digits_3_x_pin[1] = (i_finished) ? 585 : 680;
    assign digits_3_y_pin[1] = (i_finished) ? 381 : 60;
    assign digits_3_x_pin[2] = (i_finished) ? 555 : 0;
    assign digits_3_y_pin[2] = (i_finished) ? 381 : 0;
    assign digits_rank_0_x_pin[0] = (i_finished) ? 710 : 0;
    assign digits_rank_0_y_pin[0] = (i_finished) ? 186 : 0;
    assign digits_rank_0_x_pin[1] = (i_finished) ? 680 : 0;
    assign digits_rank_0_y_pin[1] = (i_finished) ? 186 : 0;
    assign digits_rank_1_x_pin[0] = (i_finished) ? 710 : 0;
    assign digits_rank_1_y_pin[0] = (i_finished) ? 251 : 0;
    assign digits_rank_1_x_pin[1] = (i_finished) ? 680 : 0;
    assign digits_rank_1_y_pin[1] = (i_finished) ? 251 : 0;
    assign digits_rank_2_x_pin[0] = (i_finished) ? 710 : 0;
    assign digits_rank_2_y_pin[0] = (i_finished) ? 316 : 0;
    assign digits_rank_2_x_pin[1] = (i_finished) ? 680 : 0;
    assign digits_rank_2_y_pin[1] = (i_finished) ? 316 : 0;
    assign digits_rank_3_x_pin[0] = (i_finished) ? 710 : 0;
    assign digits_rank_3_y_pin[0] = (i_finished) ? 381 : 0;
    assign digits_rank_3_x_pin[1] = (i_finished) ? 680 : 0;
    assign digits_rank_3_y_pin[1] = (i_finished) ? 381 : 0;

    genvar j;
    generate
        for (j = 0; j < 15; j++) begin : gen_card_pins
            assign card_x_pin[j] = 170 + 40 * j;
            assign card_y_pin[j] = 420;
        end
    endgenerate

    vga vga_instance (
        .i_rst_n(i_rst_n),
        .i_clk_25M(i_clk_25M),
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

    scoreboard scoreboard_instance (
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(bg_x_pin),
        .y_pin(bg_y_pin),
        .r_data(sb_r_pixel),
        .g_data(sb_g_pixel),
        .b_data(sb_b_pixel)
    );

    Check_end check_end_instance (
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(310),
        .y_pin(215),
        .r_data(ce_r_pixel),
        .g_data(ce_g_pixel),
        .b_data(ce_b_pixel),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel)
    );

    Index index_instance (
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(Index_x_pin_r),
        .y_pin(Index_y_pin_r),
        .x_width(30),
        .y_width(10),
        .r_data(Index_r_pixel),
        .g_data(Index_g_pixel),
        .b_data(Index_b_pixel)
    );
    Index index_instance_2 (
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(Index_2_x_pin_r),
        .y_pin(Index_2_y_pin_r),
        .x_width(60),
        .y_width(10),
        .r_data(Index_2_r_pixel),
        .g_data(Index_2_g_pixel),
        .b_data(Index_2_b_pixel)
    );
    company_label company_label_instance (
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(160),
        .y_pin(50),
        .r_data(cl_r_pixel),
        .g_data(cl_g_pixel),
        .b_data(cl_b_pixel)
    );
    start start_instance (
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(160),
        .y_pin(50),
        .r_data(start_r_pixel),
        .g_data(start_g_pixel),
        .b_data(start_b_pixel)
    );
    arrow arrow_instance (
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(360),
        .y_pin(165),
        .r_data(arrow_r),
        .g_data(arrow_g),
        .b_data(arrow_b),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .i_reverse(i_reverse)
    );
    draw_card draw_card_instance (
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin),
        .y_pin(current_y_pin),
        .r_data(draw_card_r_pixel),
        .g_data(draw_card_g_pixel),
        .b_data(draw_card_b_pixel)
    );
    digits digits_instance_0_one(
        .number(digits_0_num[0]),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(digits_0_x_pin[0]),
        .y_pin(digits_0_y_pin[0]),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .i_finished(i_finished),
        .sb_r_pixel(sb_r_pixel),
        .sb_g_pixel(sb_g_pixel),
        .sb_b_pixel(sb_b_pixel),
        .r_data(digits_r_one[0]),
        .g_data(digits_g_one[0]),
        .b_data(digits_b_one[0])
    );
    digits digits_instance_0_ten(
        .number(digits_0_num[1]),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(digits_0_x_pin[1]),
        .y_pin(digits_0_y_pin[1]),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .i_finished(i_finished),
        .sb_r_pixel(sb_r_pixel),
        .sb_g_pixel(sb_g_pixel),
        .sb_b_pixel(sb_b_pixel),
        .r_data(digits_r_ten[0]),
        .g_data(digits_g_ten[0]),
        .b_data(digits_b_ten[0])
    );
    digits digits_instance_0_hundred(
        .number(digits_0_num[2]),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(digits_0_x_pin[2]),
        .y_pin(digits_0_y_pin[2]),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .i_finished(i_finished),
        .sb_r_pixel(sb_r_pixel),
        .sb_g_pixel(sb_g_pixel),
        .sb_b_pixel(sb_b_pixel),
        .r_data(digits_r_hundred[0]),
        .g_data(digits_g_hundred[0]),
        .b_data(digits_b_hundred[0])
    );
    digits digits_instance_1_one(
        .number(digits_1_num[0]),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(digits_1_x_pin[0]),
        .y_pin(digits_1_y_pin[0]),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .i_finished(i_finished),
        .sb_r_pixel(sb_r_pixel),
        .sb_g_pixel(sb_g_pixel),
        .sb_b_pixel(sb_b_pixel),
        .r_data(digits_r_one[1]),
        .g_data(digits_g_one[1]),
        .b_data(digits_b_one[1])
    );
    digits digits_instance_1_ten(
        .number(digits_1_num[1]),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(digits_1_x_pin[1]),
        .y_pin(digits_1_y_pin[1]),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .i_finished(i_finished),
        .sb_r_pixel(sb_r_pixel),
        .sb_g_pixel(sb_g_pixel),
        .sb_b_pixel(sb_b_pixel),
        .r_data(digits_r_ten[1]),
        .g_data(digits_g_ten[1]),
        .b_data(digits_b_ten[1])
    );
    digits digits_instance_1_hundred(
        .number(digits_1_num[2]),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(digits_1_x_pin[2]),
        .y_pin(digits_1_y_pin[2]),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .i_finished(i_finished),
        .sb_r_pixel(sb_r_pixel),
        .sb_g_pixel(sb_g_pixel),
        .sb_b_pixel(sb_b_pixel),
        .r_data(digits_r_hundred[1]),
        .g_data(digits_g_hundred[1]),
        .b_data(digits_b_hundred[1])
    );
    digits digits_instance_2_one(
        .number(digits_2_num[0]),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(digits_2_x_pin[0]),
        .y_pin(digits_2_y_pin[0]),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .i_finished(i_finished),
        .sb_r_pixel(sb_r_pixel),
        .sb_g_pixel(sb_g_pixel),
        .sb_b_pixel(sb_b_pixel),
        .r_data(digits_r_one[2]),
        .g_data(digits_g_one[2]),
        .b_data(digits_b_one[2])
    );
    digits digits_instance_2_ten(
        .number(digits_2_num[1]),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(digits_2_x_pin[1]),
        .y_pin(digits_2_y_pin[1]),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .i_finished(i_finished),
        .sb_r_pixel(sb_r_pixel),
        .sb_g_pixel(sb_g_pixel),
        .sb_b_pixel(sb_b_pixel),
        .r_data(digits_r_ten[2]),
        .g_data(digits_g_ten[2]),
        .b_data(digits_b_ten[2])
    );
    digits digits_instance_2_hundred(
        .number(digits_2_num[2]),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(digits_2_x_pin[2]),
        .y_pin(digits_2_y_pin[2]),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .i_finished(i_finished),
        .sb_r_pixel(sb_r_pixel),
        .sb_g_pixel(sb_g_pixel),
        .sb_b_pixel(sb_b_pixel),
        .r_data(digits_r_hundred[2]),
        .g_data(digits_g_hundred[2]),
        .b_data(digits_b_hundred[2])
    );
    digits digits_instance_3_one(
        .number(digits_3_num[0]),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(digits_3_x_pin[0]),
        .y_pin(digits_3_y_pin[0]),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .i_finished(i_finished),
        .sb_r_pixel(sb_r_pixel),
        .sb_g_pixel(sb_g_pixel),
        .sb_b_pixel(sb_b_pixel),
        .r_data(digits_r_one[3]),
        .g_data(digits_g_one[3]),
        .b_data(digits_b_one[3])
    );
    digits digits_instance_3_ten(
        .number(digits_3_num[1]),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(digits_3_x_pin[1]),
        .y_pin(digits_3_y_pin[1]),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .i_finished(i_finished),
        .sb_r_pixel(sb_r_pixel),
        .sb_g_pixel(sb_g_pixel),
        .sb_b_pixel(sb_b_pixel),
        .r_data(digits_r_ten[3]),
        .g_data(digits_g_ten[3]),
        .b_data(digits_b_ten[3])
    );
    digits digits_instance_3_hundred(
        .number(digits_3_num[2]),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(digits_3_x_pin[2]),
        .y_pin(digits_3_y_pin[2]),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .i_finished(i_finished),
        .sb_r_pixel(sb_r_pixel),
        .sb_g_pixel(sb_g_pixel),
        .sb_b_pixel(sb_b_pixel),
        .r_data(digits_r_hundred[3]),
        .g_data(digits_g_hundred[3]),
        .b_data(digits_b_hundred[3])
    );
    digits digits_instance_rank_0_one(
        .number(i_rank[0] - (i_rank[0]/10)*10),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(digits_rank_0_x_pin[0]),
        .y_pin(digits_rank_0_y_pin[0]),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .i_finished(i_finished),
        .sb_r_pixel(sb_r_pixel),
        .sb_g_pixel(sb_g_pixel),
        .sb_b_pixel(sb_b_pixel),
        .r_data(digits_rank_0_one_pixel[0]),
        .g_data(digits_rank_0_one_pixel[1]),
        .b_data(digits_rank_0_one_pixel[2])
    );
    digits digits_instance_rank_0_ten(
        .number(i_rank[0]/10),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(digits_rank_0_x_pin[1]),
        .y_pin(digits_rank_0_y_pin[1]),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .i_finished(i_finished),
        .sb_r_pixel(sb_r_pixel),
        .sb_g_pixel(sb_g_pixel),
        .sb_b_pixel(sb_b_pixel),
        .r_data(digits_rank_0_ten_pixel[0]),
        .g_data(digits_rank_0_ten_pixel[1]),
        .b_data(digits_rank_0_ten_pixel[2])
    );
    digits digits_instance_rank_1_one(
        .number(i_rank[1] - (i_rank[1]/10)*10),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(digits_rank_1_x_pin[0]),
        .y_pin(digits_rank_1_y_pin[0]),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .i_finished(i_finished),
        .sb_r_pixel(sb_r_pixel),
        .sb_g_pixel(sb_g_pixel),
        .sb_b_pixel(sb_b_pixel),
        .r_data(digits_rank_1_one_pixel[0]),
        .g_data(digits_rank_1_one_pixel[1]),
        .b_data(digits_rank_1_one_pixel[2])
    );
    digits digits_instance_rank_1_ten(
        .number(i_rank[1]/10),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(digits_rank_1_x_pin[1]),
        .y_pin(digits_rank_1_y_pin[1]),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .i_finished(i_finished),
        .sb_r_pixel(sb_r_pixel),
        .sb_g_pixel(sb_g_pixel),
        .sb_b_pixel(sb_b_pixel),
        .r_data(digits_rank_1_ten_pixel[0]),
        .g_data(digits_rank_1_ten_pixel[1]),
        .b_data(digits_rank_1_ten_pixel[2])
    );
    digits digits_instance_rank_2_one(
        .number(i_rank[2] - (i_rank[2]/10)*10),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(digits_rank_2_x_pin[0]),
        .y_pin(digits_rank_2_y_pin[0]),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .i_finished(i_finished),
        .sb_r_pixel(sb_r_pixel),
        .sb_g_pixel(sb_g_pixel),
        .sb_b_pixel(sb_b_pixel),
        .r_data(digits_rank_2_one_pixel[0]),
        .g_data(digits_rank_2_one_pixel[1]),
        .b_data(digits_rank_2_one_pixel[2])
    );
    digits digits_instance_rank_2_ten(
        .number(i_rank[2]/10),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(digits_rank_2_x_pin[1]),
        .y_pin(digits_rank_2_y_pin[1]),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .i_finished(i_finished),
        .sb_r_pixel(sb_r_pixel),
        .sb_g_pixel(sb_g_pixel),
        .sb_b_pixel(sb_b_pixel),
        .r_data(digits_rank_2_ten_pixel[0]),
        .g_data(digits_rank_2_ten_pixel[1]),
        .b_data(digits_rank_2_ten_pixel[2])
    );
    digits digits_instance_rank_3_one(
        .number(i_rank[3] - (i_rank[3]/10)*10),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(digits_rank_3_x_pin[0]),
        .y_pin(digits_rank_3_y_pin[0]),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .i_finished(i_finished),
        .sb_r_pixel(sb_r_pixel),
        .sb_g_pixel(sb_g_pixel),
        .sb_b_pixel(sb_b_pixel),
        .r_data(digits_rank_3_one_pixel[0]),
        .g_data(digits_rank_3_one_pixel[1]),
        .b_data(digits_rank_3_one_pixel[2])
    );
    digits digits_instance_rank_3_ten(
        .number(i_rank[3]/10),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(digits_rank_3_x_pin[1]),
        .y_pin(digits_rank_3_y_pin[1]),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .i_finished(i_finished),
        .sb_r_pixel(sb_r_pixel),
        .sb_g_pixel(sb_g_pixel),
        .sb_b_pixel(sb_b_pixel),
        .r_data(digits_rank_3_ten_pixel[0]),
        .g_data(digits_rank_3_ten_pixel[1]),
        .b_data(digits_rank_3_ten_pixel[2])
    );
// 0: 0, 1: 1, 2: 2, 3: 3, 4: 4, 5: 5, 6: 6, 7: 7, 8: 8, 9: 9
// 10: skip, 11: reverse, 12: draw two, 13: wild, 14: wild draw four
    zero zero_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin),
        .y_pin(current_y_pin),
        .color(color),
        .r_data(cards_r[0]),
        .g_data(cards_g[0]),
        .b_data(cards_b[0])
    );
    one one_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin),
        .y_pin(current_y_pin),
        .color(color),
        .r_data(cards_r[1]),
        .g_data(cards_g[1]),
        .b_data(cards_b[1])
    );
    two two_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin),
        .y_pin(current_y_pin),
        .color(color),
        .r_data(cards_r[2]),
        .g_data(cards_g[2]),
        .b_data(cards_b[2])
    );
    three three_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin),
        .y_pin(current_y_pin),
        .color(color),
        .r_data(cards_r[3]),
        .g_data(cards_g[3]),
        .b_data(cards_b[3])
    );
    four four_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin),
        .y_pin(current_y_pin),
        .color(color),
        .r_data(cards_r[4]),
        .g_data(cards_g[4]),
        .b_data(cards_b[4])
    );
    five five_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin),
        .y_pin(current_y_pin),
        .color(color),
        .r_data(cards_r[5]),
        .g_data(cards_g[5]),
        .b_data(cards_b[5])
    );
    six six_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin),
        .y_pin(current_y_pin),
        .color(color),
        .r_data(cards_r[6]),
        .g_data(cards_g[6]),
        .b_data(cards_b[6])
    );
    seven seven_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin),
        .y_pin(current_y_pin),
        .color(color),
        .r_data(cards_r[7]),
        .g_data(cards_g[7]),
        .b_data(cards_b[7])
    );
    eight eight_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin),
        .y_pin(current_y_pin),
        .color(color),
        .r_data(cards_r[8]),
        .g_data(cards_g[8]),
        .b_data(cards_b[8])
    );
    nine nine_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin),
        .y_pin(current_y_pin),
        .color(color),
        .r_data(cards_r[9]),
        .g_data(cards_g[9]),
        .b_data(cards_b[9])
    );
    skip skip_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin),
        .y_pin(current_y_pin),
        .color(color),
        .r_data(cards_r[10]),
        .g_data(cards_g[10]),
        .b_data(cards_b[10])
    );
    reverse reverse_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin),
        .y_pin(current_y_pin),
        .color(color),
        .r_data(cards_r[11]),
        .g_data(cards_g[11]),
        .b_data(cards_b[11])
    );
    draw_two draw_two_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin),
        .y_pin(current_y_pin),
        .color(color),
        .r_data(cards_r[12]),
        .g_data(cards_g[12]),
        .b_data(cards_b[12])
    );
    Pure pure_instance_1(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(pure_x_pin),
        .y_pin(pure_y_pin),
        .color({1'b1,i_prev_card[5:4]}),
        .r_data(pure_r_pixel),
        .g_data(pure_g_pixel),
        .b_data(pure_b_pixel)
    );
    Pure pure_instance_2(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin),
        .y_pin(current_y_pin),
        .color(select_color),
        .r_data(cards_r[13]),
        .g_data(cards_g[13]),
        .b_data(cards_b[13])
    );
    wild wild_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin),
        .y_pin(current_y_pin),
        .r_data(wild_cards_r),
        .g_data(wild_cards_g),
        .b_data(wild_cards_b)
    );
    wild_draw_four wild_draw_four_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(current_x_pin),
        .y_pin(current_y_pin),
        .r_data(wild_draw_four_r),
        .g_data(wild_draw_four_g),
        .b_data(wild_draw_four_b)
    );
    crown crown_instance (
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(cr_x_pin),
        .y_pin(cr_y_pin),
        .r_data(cr_r_pixel),
        .g_data(cr_g_pixel),
        .b_data(cr_b_pixel)
    );
    always_comb begin
        if(!counter_r[27])  counter_w = counter_r + 1;
        else                counter_w = counter_r;
    end
    always_comb begin
        Index_y_pin_w = 10'd470;
        if(i_index[6:0] - local_index_r > 8'd14) begin
            Index_x_pin_w = Index_x_pin_r;
            local_index_w = (local_index_r == 8'd108) ? 8'd0 :(local_index_r > (i_hands_num[0])) ? 8'd108 : local_index_r + 1;
        end
        else if(i_index[6:0] < local_index_r) begin
            Index_x_pin_w = Index_x_pin_r;
            local_index_w = (local_index_r == 8'd0) ? 8'd108 :(local_index_r == 8'd108) ? (i_hands_num[0]) : local_index_r - 1;
        end
        else begin
            Index_x_pin_w = card_x_pin[current_index];
            local_index_w = local_index_r;
        end
        for (int x = 0; x < 15; x++) begin
            temp[x] = ($signed($signed(8'd108) - $signed(x + local_index_r)) >= $signed(8'd0)) ? (x + local_index_r) : ($signed(x + local_index_r) - $signed(8'd109));
            hands[x] = i_hands[temp[x]];
            // hands[x] = i_hands[x + local_index_r];
        end
    end 
    always_comb begin
        init_pict_w = init_pict_r;
        if(i_finished) begin
            Index_2_x_pin_w = 0;
            Index_2_y_pin_w = 0;
        end
        else begin
            if(i_uno_state == 4'b0001) begin
                Index_2_x_pin_w = 680;
                Index_2_y_pin_w = 365;
            end
            else if(i_uno_state == 4'b0010) begin
                Index_2_x_pin_w = 170;
                Index_2_y_pin_w = 55;
            end
            else if(i_uno_state == 4'b0100) begin
                Index_2_x_pin_w = 430;
                Index_2_y_pin_w = 55;
            end
            else if(i_uno_state == 4'b1000) begin
                Index_2_x_pin_w = 680;
                Index_2_y_pin_w = 55;
            end
            else begin
                Index_2_x_pin_w = 0;
                Index_2_y_pin_w = 0;
            end
        end
        if(i_finished) begin
            current_x_pin = prev_x_pin;
            current_y_pin = prev_y_pin;
            color = i_prev_card[5:4];
            select_color = 3'b000;
            cr_x_pin = 10'd220;
            init_pict_w = init_pict_r;
            cr_y_pin = (i_hands_num[0] == 8'd0) ? 10'd185 : (i_hands_num[1] == 8'd0) ? 10'd250 : (i_hands_num[2] == 8'd0) ? 10'd315 : 10'd380;
            if ((cr_x_pin <= x_cnt && x_cnt < cr_x_pin + 80) && (cr_y_pin <= y_cnt && y_cnt < cr_y_pin + 50)) begin
                pixel[0] = cr_r_pixel;
                pixel[1] = cr_g_pixel;
                pixel[2] = cr_b_pixel;
            end
            else if((digits_0_x_pin[0] <= x_cnt && x_cnt < digits_0_x_pin[0] + 30) && (digits_0_y_pin[0] <= y_cnt && y_cnt < digits_0_y_pin[0] + 50)) begin
                pixel[0] = digits_r_one[0];
                pixel[1] = digits_g_one[0];
                pixel[2] = digits_b_one[0];
            end
            else if((digits_0_x_pin[1] <= x_cnt && x_cnt < digits_0_x_pin[1] + 30) && (digits_0_y_pin[1] <= y_cnt && y_cnt < digits_0_y_pin[1] + 50)) begin
                pixel[0] = digits_r_ten[0];
                pixel[1] = digits_g_ten[0];
                pixel[2] = digits_b_ten[0];
            end
            else if((digits_0_x_pin[2] <= x_cnt && x_cnt < digits_0_x_pin[2] + 30) && (digits_0_y_pin[2] <= y_cnt && y_cnt < digits_0_y_pin[2] + 50)) begin
                pixel[0] = digits_r_hundred[0];
                pixel[1] = digits_g_hundred[0];
                pixel[2] = digits_b_hundred[0];
            end
            else if((digits_1_x_pin[0] <= x_cnt && x_cnt < digits_1_x_pin[0] + 30) && (digits_1_y_pin[0] <= y_cnt && y_cnt < digits_1_y_pin[0] + 50)) begin
                pixel[0] = digits_r_one[1];
                pixel[1] = digits_g_one[1];
                pixel[2] = digits_b_one[1];
            end
            else if((digits_1_x_pin[1] <= x_cnt && x_cnt < digits_1_x_pin[1] + 30) && (digits_1_y_pin[1] <= y_cnt && y_cnt < digits_1_y_pin[1] + 50)) begin
                pixel[0] = digits_r_ten[1];
                pixel[1] = digits_g_ten[1];
                pixel[2] = digits_b_ten[1];
            end
            else if((digits_1_x_pin[2] <= x_cnt && x_cnt < digits_1_x_pin[2] + 30) && (digits_1_y_pin[2] <= y_cnt && y_cnt < digits_1_y_pin[2] + 50)) begin
                pixel[0] = digits_r_hundred[1];
                pixel[1] = digits_g_hundred[1];
                pixel[2] = digits_b_hundred[1];
            end
            else if((digits_2_x_pin[0] <= x_cnt && x_cnt < digits_2_x_pin[0] + 30) && (digits_2_y_pin[0] <= y_cnt && y_cnt < digits_2_y_pin[0] + 50)) begin
                pixel[0] = digits_r_one[2];
                pixel[1] = digits_g_one[2];
                pixel[2] = digits_b_one[2];
            end
            else if((digits_2_x_pin[1] <= x_cnt && x_cnt < digits_2_x_pin[1] + 30) && (digits_2_y_pin[1] <= y_cnt && y_cnt < digits_2_y_pin[1] + 50)) begin
                pixel[0] = digits_r_ten[2];
                pixel[1] = digits_g_ten[2];
                pixel[2] = digits_b_ten[2];
            end
            else if((digits_2_x_pin[2] <= x_cnt && x_cnt < digits_2_x_pin[2] + 30) && (digits_2_y_pin[2] <= y_cnt && y_cnt < digits_2_y_pin[2] + 50)) begin
                pixel[0] = digits_r_hundred[2];
                pixel[1] = digits_g_hundred[2];
                pixel[2] = digits_b_hundred[2];
            end
            else if((digits_3_x_pin[0] <= x_cnt && x_cnt < digits_3_x_pin[0] + 30) && (digits_3_y_pin[0] <= y_cnt && y_cnt < digits_3_y_pin[0] + 50)) begin
                pixel[0] = digits_r_one[3];
                pixel[1] = digits_g_one[3];
                pixel[2] = digits_b_one[3];
            end
            else if((digits_3_x_pin[1] <= x_cnt && x_cnt < digits_3_x_pin[1] + 30) && (digits_3_y_pin[1] <= y_cnt && y_cnt < digits_3_y_pin[1] + 50)) begin
                pixel[0] = digits_r_ten[3];
                pixel[1] = digits_g_ten[3];
                pixel[2] = digits_b_ten[3];
            end
            else if((digits_3_x_pin[2] <= x_cnt && x_cnt < digits_3_x_pin[2] + 30) && (digits_3_y_pin[2] <= y_cnt && y_cnt < digits_3_y_pin[2] + 50)) begin
                pixel[0] = digits_r_hundred[3];
                pixel[1] = digits_g_hundred[3];
                pixel[2] = digits_b_hundred[3];
            end
            else if((digits_rank_0_x_pin[0] <= x_cnt && x_cnt < digits_rank_0_x_pin[0] + 30) && (digits_rank_0_y_pin[0] <= y_cnt && y_cnt < digits_rank_0_y_pin[0] + 50)) begin
                pixel[0] = digits_rank_0_one_pixel[0];
                pixel[1] = digits_rank_0_one_pixel[1];
                pixel[2] = digits_rank_0_one_pixel[2];
            end
            else if((digits_rank_0_x_pin[1] <= x_cnt && x_cnt < digits_rank_0_x_pin[1] + 30) && (digits_rank_0_y_pin[1] <= y_cnt && y_cnt < digits_rank_0_y_pin[1] + 50)) begin
                pixel[0] = digits_rank_0_ten_pixel[0];
                pixel[1] = digits_rank_0_ten_pixel[1];
                pixel[2] = digits_rank_0_ten_pixel[2];
            end
            else if((digits_rank_1_x_pin[0] <= x_cnt && x_cnt < digits_rank_1_x_pin[0] + 30) && (digits_rank_1_y_pin[0] <= y_cnt && y_cnt < digits_rank_1_y_pin[0] + 50))  begin
                pixel[0] = digits_rank_1_one_pixel[0];
                pixel[1] = digits_rank_1_one_pixel[1];
                pixel[2] = digits_rank_1_one_pixel[2];
            end
            else if((digits_rank_1_x_pin[1] <= x_cnt && x_cnt < digits_rank_1_x_pin[1] + 30) && (digits_rank_1_y_pin[1] <= y_cnt && y_cnt < digits_rank_1_y_pin[1] + 50))  begin
                pixel[0] = digits_rank_1_ten_pixel[0];
                pixel[1] = digits_rank_1_ten_pixel[1];
                pixel[2] = digits_rank_1_ten_pixel[2];
            end
            else if((digits_rank_2_x_pin[0] <= x_cnt && x_cnt < digits_rank_2_x_pin[0] + 30) && (digits_rank_2_y_pin[0] <= y_cnt && y_cnt < digits_rank_2_y_pin[0] + 50))  begin
                pixel[0] = digits_rank_2_one_pixel[0];
                pixel[1] = digits_rank_2_one_pixel[1];
                pixel[2] = digits_rank_2_one_pixel[2];
            end
            else if((digits_rank_2_x_pin[1] <= x_cnt && x_cnt < digits_rank_2_x_pin[1] + 30) && (digits_rank_2_y_pin[1] <= y_cnt && y_cnt < digits_rank_2_y_pin[1] + 50))  begin
                pixel[0] = digits_rank_2_ten_pixel[0];
                pixel[1] = digits_rank_2_ten_pixel[1];
                pixel[2] = digits_rank_2_ten_pixel[2];
            end
            else if((digits_rank_3_x_pin[0] <= x_cnt && x_cnt < digits_rank_3_x_pin[0] + 30) && (digits_rank_3_y_pin[0] <= y_cnt && y_cnt < digits_rank_3_y_pin[0] + 50))  begin
                pixel[0] = digits_rank_3_one_pixel[0];
                pixel[1] = digits_rank_3_one_pixel[1];
                pixel[2] = digits_rank_3_one_pixel[2];
            end
            else if((digits_rank_3_x_pin[1] <= x_cnt && x_cnt < digits_rank_3_x_pin[1] + 30) && (digits_rank_3_y_pin[1] <= y_cnt && y_cnt < digits_rank_3_y_pin[1] + 50))  begin
                pixel[0] = digits_rank_3_ten_pixel[0];
                pixel[1] = digits_rank_3_ten_pixel[1];
                pixel[2] = digits_rank_3_ten_pixel[2];
            end
            else begin
                pixel[0] = sb_r_pixel;
                pixel[1] = sb_g_pixel;
                pixel[2] = sb_b_pixel;
            end
        end
        else if((i_hands_num[0] == 0) || (i_hands_num[1] == 0) || (i_hands_num[2] == 0) || (i_hands_num[3] == 0)) begin
            current_x_pin = prev_x_pin;
            current_y_pin = prev_y_pin;
            color = i_prev_card[5:4];
            select_color = 3'b000;
            cr_x_pin = 10'd0;
            cr_y_pin = 10'd0;
            if(!counter_r[27]) begin
                //  calling company logo
                pixel[0] = cl_r_pixel;
                pixel[1] = cl_g_pixel;
                pixel[2] = cl_b_pixel;
                init_pict_w = init_pict_r;
            end 
            else if(!init_pict_r) begin
                // calling start screen
                pixel[0] = start_r_pixel;
                pixel[1] = start_g_pixel;
                pixel[2] = start_b_pixel;
                if(i_start) begin
                    init_pict_w = 1'b1;
                end
                else         init_pict_w = 1'b0;
            end
            else begin
                pixel[0] = ce_r_pixel;
                pixel[1] = ce_g_pixel;
                pixel[2] = ce_b_pixel;
                if(i_replay) init_pict_w = 1'b0;
                else         init_pict_w = init_pict_r;
            end
        end
        else if ((Index_2_x_pin_r <= x_cnt && x_cnt < Index_2_x_pin_r + 60) && (Index_2_y_pin_r <= y_cnt && y_cnt < Index_2_y_pin_r + 10)) begin
            current_x_pin = prev_x_pin;
            current_y_pin = prev_y_pin;
            color = i_prev_card[5:4];
            select_color = 3'b000;
            cr_x_pin = 10'd0;
            cr_y_pin = 10'd0;
            pixel[0] = Index_2_r_pixel;
            pixel[1] = Index_2_g_pixel;
            pixel[2] = Index_2_b_pixel;
        end
        else if ((430 <= x_cnt && x_cnt < 460) && (230 <= y_cnt && y_cnt < 280)) begin
            current_x_pin = prev_x_pin;
            current_y_pin = prev_y_pin;
            color = i_prev_card[5:4];
            select_color = 3'b000;
            cr_x_pin = 10'd0;
            cr_y_pin = 10'd0;
            case(i_prev_card[3:0]) 
                4'b0000: begin
                    pixel[0] = cards_r[0];
                    pixel[1] = cards_g[0];
                    pixel[2] = cards_b[0];
                end
                4'b0001: begin
                    pixel[0] = cards_r[1];
                    pixel[1] = cards_g[1];
                    pixel[2] = cards_b[1];
                end
                4'b0010: begin
                    pixel[0] = cards_r[2];
                    pixel[1] = cards_g[2];
                    pixel[2] = cards_b[2];
                end
                4'b0011: begin
                    pixel[0] = cards_r[3];
                    pixel[1] = cards_g[3];
                    pixel[2] = cards_b[3];
                end
                4'b0100: begin
                    pixel[0] = cards_r[4];
                    pixel[1] = cards_g[4];
                    pixel[2] = cards_b[4];
                end
                4'b0101: begin
                    pixel[0] = cards_r[5];
                    pixel[1] = cards_g[5];
                    pixel[2] = cards_b[5];
                end
                4'b0110: begin
                    pixel[0] = cards_r[6];
                    pixel[1] = cards_g[6];
                    pixel[2] = cards_b[6];
                end
                4'b0111: begin
                    pixel[0] = cards_r[7];
                    pixel[1] = cards_g[7];
                    pixel[2] = cards_b[7];
                end
                4'b1000: begin
                    pixel[0] = cards_r[8];
                    pixel[1] = cards_g[8];
                    pixel[2] = cards_b[8];
                end
                4'b1001: begin
                    pixel[0] = cards_r[9];
                    pixel[1] = cards_g[9];
                    pixel[2] = cards_b[9];
                end
                4'b1010: begin
                    pixel[0] = cards_r[10];
                    pixel[1] = cards_g[10];
                    pixel[2] = cards_b[10];
                end
                4'b1011: begin
                    pixel[0] = cards_r[11];
                    pixel[1] = cards_g[11];
                    pixel[2] = cards_b[11];
                end
                4'b1100: begin
                    pixel[0] = cards_r[12];
                    pixel[1] = cards_g[12];
                    pixel[2] = cards_b[12];
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
        else if ((460 <= x_cnt && x_cnt < 490) && (230 <= y_cnt && y_cnt < 280)) begin
            pixel[0] = pure_r_pixel;
            pixel[1] = pure_g_pixel;
            pixel[2] = pure_b_pixel;
            color = 2'b00;
            select_color = 3'b000;
            cr_x_pin = 10'd0;
            cr_y_pin = 10'd0;
            current_x_pin = 0;
            current_y_pin = 0;
        end
        else if (470 <= y_cnt && y_cnt < 480) begin
            pixel[0] = Index_r_pixel;
            pixel[1] = Index_g_pixel;
            pixel[2] = Index_b_pixel;
            color = 2'b00;
            select_color = 3'b000;
            cr_x_pin = 10'd0;
            cr_y_pin = 10'd0;
            current_x_pin = 0;
            current_y_pin = 0;
        end
        else if ((710 <= x_cnt && x_cnt < 740) && (370 <= y_cnt && y_cnt < 420)) begin
            pixel[0] = digits_r_one[0];
            pixel[1] = digits_g_one[0];
            pixel[2] = digits_b_one[0];
            color = 2'b00;
            select_color = 3'b000;
            cr_x_pin = 10'd0;
            cr_y_pin = 10'd0;
            current_x_pin = 0;
            current_y_pin = 0;
        end
        else if ((680 <= x_cnt && x_cnt < 710) && (370 <= y_cnt && y_cnt < 420)) begin
            pixel[0] = digits_r_ten[0];
            pixel[1] = digits_g_ten[0];
            pixel[2] = digits_b_ten[0];
            color = 2'b00;
            select_color = 3'b000;
            cr_x_pin = 10'd0;
            cr_y_pin = 10'd0;
            current_x_pin = 0;
            current_y_pin = 0;
        end
        else if ((200 <= x_cnt && x_cnt < 230) && (60 <= y_cnt && y_cnt < 110)) begin
            pixel[0] = digits_r_one[1];
            pixel[1] = digits_g_one[1];
            pixel[2] = digits_b_one[1];
            color = 2'b00;
            select_color = 3'b000;
            cr_x_pin = 10'd0;
            cr_y_pin = 10'd0;
            current_x_pin = 0;
            current_y_pin = 0;
        end
        else if ((170 <= x_cnt && x_cnt < 200) && (60 <= y_cnt && y_cnt < 110)) begin
            pixel[0] = digits_r_ten[1];
            pixel[1] = digits_g_ten[1];
            pixel[2] = digits_b_ten[1];
            color = 2'b00;
            select_color = 3'b000;
            cr_x_pin = 10'd0;
            cr_y_pin = 10'd0;
            current_x_pin = 0;
            current_y_pin = 0;
        end
        else if ((460 <= x_cnt && x_cnt < 490) && (60 <= y_cnt && y_cnt < 110)) begin
            pixel[0] = digits_r_one[2];
            pixel[1] = digits_g_one[2];
            pixel[2] = digits_b_one[2];
            color = 2'b00;
            select_color = 3'b000;
            cr_x_pin = 10'd0;
            cr_y_pin = 10'd0;
            current_x_pin = 0;
            current_y_pin = 0;
        end
        else if ((430 <= x_cnt && x_cnt < 460) && (60 <= y_cnt && y_cnt < 110)) begin
            pixel[0] = digits_r_ten[2];
            pixel[1] = digits_g_ten[2];
            pixel[2] = digits_b_ten[2];
            color = 2'b00;
            select_color = 3'b000;
            cr_x_pin = 10'd0;
            cr_y_pin = 10'd0;
            current_x_pin = 0;
            current_y_pin = 0;
        end
        else if ((710 <= x_cnt && x_cnt < 740) && (60 <= y_cnt && y_cnt < 110)) begin
            pixel[0] = digits_r_one[3];
            pixel[1] = digits_g_one[3];
            pixel[2] = digits_b_one[3];
            color = 2'b00;
            select_color = 3'b000;
            cr_x_pin = 10'd0;
            cr_y_pin = 10'd0;
            current_x_pin = 0;
            current_y_pin = 0;
        end
        else if ((680 <= x_cnt && x_cnt < 710) && (60 <= y_cnt && y_cnt < 110)) begin
            pixel[0] = digits_r_ten[3];
            pixel[1] = digits_g_ten[3];
            pixel[2] = digits_b_ten[3];
            color = 2'b00;
            select_color = 3'b000;
            cr_x_pin = 10'd0;
            cr_y_pin = 10'd0;
            current_x_pin = 0;
            current_y_pin = 0;
        end
        else if((360 <= x_cnt && x_cnt < 560) && (165 <= y_cnt && y_cnt < 365)) begin
            pixel[0] = arrow_r;
            pixel[1] = arrow_g;
            pixel[2] = arrow_b;
            color = 2'b00;
            select_color = 3'b000;
            cr_x_pin = 10'd0;
            cr_y_pin = 10'd0;
            current_x_pin = 0;
            current_y_pin = 0;
        end
        else if (420 <= y_cnt && y_cnt < 470) begin
            color = hands[i][5:4];
            cr_x_pin = 10'd0;
            cr_y_pin = 10'd0;
            case (i)
                0: begin
                    current_x_pin = card_x_pin[0];
                    current_y_pin = card_y_pin[0];
                    select_color = 3'b100;
                end
                1: begin
                    current_x_pin = card_x_pin[1];
                    current_y_pin = card_y_pin[1];
                    select_color = 3'b101;
                end
                2: begin
                    current_x_pin = card_x_pin[2];
                    current_y_pin = card_y_pin[2];
                    select_color = 3'b110;
                end
                3: begin
                    current_x_pin = card_x_pin[3];
                    current_y_pin = card_y_pin[3];
                    select_color = 3'b111;
                end
                4: begin
                    current_x_pin = card_x_pin[4];
                    current_y_pin = card_y_pin[4];
                    select_color = 3'b000;
                end
                5: begin
                    current_x_pin = card_x_pin[5];
                    current_y_pin = card_y_pin[5];
                    select_color = 3'b000;
                end
                6: begin
                    current_x_pin = card_x_pin[6];
                    current_y_pin = card_y_pin[6];
                    select_color = 3'b000;
                end
                7: begin
                    current_x_pin = card_x_pin[7];
                    current_y_pin = card_y_pin[7];
                    select_color = 3'b000;
                end
                8: begin
                    current_x_pin = card_x_pin[8];
                    current_y_pin = card_y_pin[8];
                    select_color = 3'b000;
                end
                9: begin
                    current_x_pin = card_x_pin[9];
                    current_y_pin = card_y_pin[9];
                    select_color = 3'b000;
                end
                10: begin
                    current_x_pin = card_x_pin[10];
                    current_y_pin = card_y_pin[10];
                    select_color = 3'b000;
                end
                11: begin
                    current_x_pin = card_x_pin[11];
                    current_y_pin = card_y_pin[11];
                    select_color = 3'b000;
                end
                12: begin
                    current_x_pin = card_x_pin[12];
                    current_y_pin = card_y_pin[12];
                    select_color = 3'b000;
                end
                13: begin
                    current_x_pin = card_x_pin[13];
                    current_y_pin = card_y_pin[13];
                    select_color = 3'b000;
                end
                14: begin
                    current_x_pin = card_x_pin[14];
                    current_y_pin = card_y_pin[14];
                    select_color = 3'b000;
                end
                default: begin
                    current_x_pin = bg_x_pin;
                    current_y_pin = bg_y_pin;
                    select_color = 3'b000;
                end
            endcase
            if(i_select_color) begin
                pixel[0] = cards_r[13];
                pixel[1] = cards_g[13];
                pixel[2] = cards_b[13];
            end
            else begin
                case(hands[i][3:0])
                    4'b0000: begin
                        pixel[0] = cards_r[0];
                        pixel[1] = cards_g[0];
                        pixel[2] = cards_b[0];
                    end
                    4'b0001: begin
                        pixel[0] = cards_r[1];
                        pixel[1] = cards_g[1];
                        pixel[2] = cards_b[1];
                    end
                    4'b0010: begin
                        pixel[0] = cards_r[2];
                        pixel[1] = cards_g[2];
                        pixel[2] = cards_b[2];
                    end
                    4'b0011: begin
                        pixel[0] = cards_r[3];
                        pixel[1] = cards_g[3];
                        pixel[2] = cards_b[3];
                    end
                    4'b0100: begin
                        pixel[0] = cards_r[4];
                        pixel[1] = cards_g[4];
                        pixel[2] = cards_b[4];
                    end
                    4'b0101: begin
                        pixel[0] = cards_r[5];
                        pixel[1] = cards_g[5];
                        pixel[2] = cards_b[5];
                    end
                    4'b0110: begin
                        pixel[0] = cards_r[6];
                        pixel[1] = cards_g[6];
                        pixel[2] = cards_b[6];
                    end
                    4'b0111: begin
                        pixel[0] = cards_r[7];
                        pixel[1] = cards_g[7];
                        pixel[2] = cards_b[7];
                    end
                    4'b1000: begin
                        pixel[0] = cards_r[8];
                        pixel[1] = cards_g[8];
                        pixel[2] = cards_b[8];
                    end
                    4'b1001: begin
                        pixel[0] = cards_r[9];
                        pixel[1] = cards_g[9];
                        pixel[2] = cards_b[9];
                    end
                    4'b1010: begin
                        pixel[0] = cards_r[10];
                        pixel[1] = cards_g[10];
                        pixel[2] = cards_b[10];
                    end
                    4'b1011: begin
                        pixel[0] = cards_r[11];
                        pixel[1] = cards_g[11];
                        pixel[2] = cards_b[11];
                    end
                    4'b1100: begin
                        pixel[0] = cards_r[12];
                        pixel[1] = cards_g[12];
                        pixel[2] = cards_b[12];
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
                        if(hands[i][5:4] == 2'b00) begin
                            pixel[0] = draw_card_r_pixel;
                            pixel[1] = draw_card_g_pixel;
                            pixel[2] = draw_card_b_pixel;
                        end
                        else begin
                            pixel[0] = bg_r_pixel;
                            pixel[1] = bg_g_pixel;
                            pixel[2] = bg_b_pixel;
                        end
                    end
                endcase
            end
        end 
        else begin
            current_x_pin = 10'b0;
            current_y_pin = 10'b0;
            color = 2'b00;
            select_color = 3'b000;
            cr_x_pin = 10'd0;
            cr_y_pin = 10'd0;
            pixel[0] = bg_r_pixel;
            pixel[1] = bg_g_pixel;
            pixel[2] = bg_b_pixel;
        end
    end
    always_ff @(posedge i_clk_25M or negedge i_rst_n) begin
        if (!i_rst_n) begin
            Index_x_pin_r <= 10'd160;
            Index_y_pin_r <= 10'd410;
            Index_2_x_pin_r <= 10'd680;
            Index_2_y_pin_r <= 10'd365;
            local_index_r <= 7'd0;
            init_pict_r <= 1'b0;
            counter_r <= 26'd0;
        end
        else begin
            Index_x_pin_r <= Index_x_pin_w;
            Index_y_pin_r <= Index_y_pin_w;
            Index_2_x_pin_r <= Index_2_x_pin_w;
            Index_2_y_pin_r <= Index_2_y_pin_w;
            local_index_r <= local_index_w;
            init_pict_r <= init_pict_w;
            counter_r <= counter_w;
        end
    end
endmodule