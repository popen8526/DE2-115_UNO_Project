module Display(
    input  i_rst_n,
    input  i_clk_25M,
    input  [5:0] i_hands [108:0],
    input  [7:0] i_index,
    input  [5:0] i_prev_card,
    input  [6:0] i_hands_num [3:0],
    input        i_finished,
    input        i_select_color,
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
    logic [9:0] x_cnt, y_cnt, bg_x_pin, bg_y_pin, Index_x_pin_w, Index_x_pin_r, Index_y_pin_w, Index_y_pin_r;
    logic [9:0] current_x_pin, current_y_pin, prev_card_x_pin, prev_card_y_pin, pure_x_pin, pure_y_pin, prev_x_pin, prev_y_pin;
    logic [7:0] bg_r_pixel, bg_g_pixel, bg_b_pixel;
    logic [7:0] Index_r_pixel, Index_g_pixel, Index_b_pixel, pure_r_pixel, pure_g_pixel, pure_b_pixel;
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
    // logic [12:0] red_in_use, yellow_in_use, green_in_use, blue_in_use;
    // logic        wild_in_use, wild_draw_four_in_use;
    //left_up(160, 50)
    //right_down(760, 480)
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

    Index index_instance (
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(Index_x_pin_r),
        .y_pin(Index_y_pin_r),
        .r_data(Index_r_pixel),
        .g_data(Index_g_pixel),
        .b_data(Index_b_pixel)
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
        .number(i_hands_num[0] - (i_hands_num[0]/10)*10),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(710),
        .y_pin(370),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .r_data(digits_r_one[0]),
        .g_data(digits_g_one[0]),
        .b_data(digits_b_one[0])
    );
    digits digits_instance_0_ten(
        .number(i_hands_num[0]/10),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(680),
        .y_pin(370),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .r_data(digits_r_ten[0]),
        .g_data(digits_g_ten[0]),
        .b_data(digits_b_ten[0])
    );
    digits digits_instance_1_one(
        .number(i_hands_num[1] - (i_hands_num[1]/10)*10),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(200),
        .y_pin(60),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .r_data(digits_r_one[1]),
        .g_data(digits_g_one[1]),
        .b_data(digits_b_one[1])
    );
    digits digits_instance_1_ten(
        .number(i_hands_num[1]/10),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(170),
        .y_pin(60),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .r_data(digits_r_ten[1]),
        .g_data(digits_g_ten[1]),
        .b_data(digits_b_ten[1])
    );
    digits digits_instance_2_one(
        .number(i_hands_num[2] - (i_hands_num[2]/10)*10),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(460),
        .y_pin(60),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .r_data(digits_r_one[2]),
        .g_data(digits_g_one[2]),
        .b_data(digits_b_one[2])
    );
    digits digits_instance_2_ten(
        .number(i_hands_num[2]/10),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(430),
        .y_pin(60),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .r_data(digits_r_ten[2]),
        .g_data(digits_g_ten[2]),
        .b_data(digits_b_ten[2])
    );
    digits digits_instance_3_one(
        .number(i_hands_num[3] - (i_hands_num[3]/10)*10),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(710),
        .y_pin(60),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .r_data(digits_r_one[3]),
        .g_data(digits_g_one[3]),
        .b_data(digits_b_one[3])
    );
    digits digits_instance_3_ten(
        .number(i_hands_num[3]/10),
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(680),
        .y_pin(60),
        .x_width(30),
        .y_width(50),
        .bg_r_pixel(bg_r_pixel),
        .bg_g_pixel(bg_g_pixel),
        .bg_b_pixel(bg_b_pixel),
        .r_data(digits_r_ten[3]),
        .g_data(digits_g_ten[3]),
        .b_data(digits_b_ten[3])
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
        if ((430 <= x_cnt && x_cnt < 460) && (230 <= y_cnt && y_cnt < 280)) begin
            current_x_pin = prev_x_pin;
            current_y_pin = prev_y_pin;
            color = i_prev_card[5:4];
            select_color = 3'b000;
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
            current_x_pin = 0;
            current_y_pin = 0;
        end
        else if (470 <= y_cnt && y_cnt < 480) begin
            pixel[0] = Index_r_pixel;
            pixel[1] = Index_g_pixel;
            pixel[2] = Index_b_pixel;
            color = 2'b00;
            select_color = 3'b000;
            current_x_pin = 0;
            current_y_pin = 0;
        end
        else if ((710 <= x_cnt && x_cnt < 740) && (370 <= y_cnt && y_cnt < 420)) begin
            pixel[0] = digits_r_one[0];
            pixel[1] = digits_g_one[0];
            pixel[2] = digits_b_one[0];
            color = 2'b00;
            select_color = 3'b000;
            current_x_pin = 0;
            current_y_pin = 0;
        end
        else if ((680 <= x_cnt && x_cnt < 710) && (370 <= y_cnt && y_cnt < 420)) begin
            pixel[0] = digits_r_ten[0];
            pixel[1] = digits_g_ten[0];
            pixel[2] = digits_b_ten[0];
            color = 2'b00;
            select_color = 3'b000;
            current_x_pin = 0;
            current_y_pin = 0;
        end
        else if ((200 <= x_cnt && x_cnt < 230) && (60 <= y_cnt && y_cnt < 110)) begin
            pixel[0] = digits_r_one[1];
            pixel[1] = digits_g_one[1];
            pixel[2] = digits_b_one[1];
            color = 2'b00;
            select_color = 3'b000;
            current_x_pin = 0;
            current_y_pin = 0;
        end
        else if ((170 <= x_cnt && x_cnt < 200) && (60 <= y_cnt && y_cnt < 110)) begin
            pixel[0] = digits_r_ten[1];
            pixel[1] = digits_g_ten[1];
            pixel[2] = digits_b_ten[1];
            color = 2'b00;
            select_color = 3'b000;
            current_x_pin = 0;
            current_y_pin = 0;
        end
        else if ((460 <= x_cnt && x_cnt < 490) && (60 <= y_cnt && y_cnt < 110)) begin
            pixel[0] = digits_r_one[2];
            pixel[1] = digits_g_one[2];
            pixel[2] = digits_b_one[2];
            color = 2'b00;
            select_color = 3'b000;
            current_x_pin = 0;
            current_y_pin = 0;
        end
        else if ((430 <= x_cnt && x_cnt < 460) && (60 <= y_cnt && y_cnt < 110)) begin
            pixel[0] = digits_r_ten[2];
            pixel[1] = digits_g_ten[2];
            pixel[2] = digits_b_ten[2];
            color = 2'b00;
            select_color = 3'b000;
            current_x_pin = 0;
            current_y_pin = 0;
        end
        else if ((710 <= x_cnt && x_cnt < 740) && (60 <= y_cnt && y_cnt < 110)) begin
            pixel[0] = digits_r_one[3];
            pixel[1] = digits_g_one[3];
            pixel[2] = digits_b_one[3];
            color = 2'b00;
            select_color = 3'b000;
            current_x_pin = 0;
            current_y_pin = 0;
        end
        else if ((680 <= x_cnt && x_cnt < 710) && (60 <= y_cnt && y_cnt < 110)) begin
            pixel[0] = digits_r_ten[3];
            pixel[1] = digits_g_ten[3];
            pixel[2] = digits_b_ten[3];
            color = 2'b00;
            select_color = 3'b000;
            current_x_pin = 0;
            current_y_pin = 0;
        end
        else if (420 <= y_cnt && y_cnt < 470) begin
            color = hands[i][5:4];
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
            pixel[0] = bg_r_pixel;
            pixel[1] = bg_g_pixel;
            pixel[2] = bg_b_pixel;
        end
    end
    always_ff @(posedge i_clk_25M or negedge i_rst_n) begin
        if (!i_rst_n) begin
            Index_x_pin_r <= 10'd160;
            Index_y_pin_r <= 10'd410;
            local_index_r <= 7'd0;
        end
        else begin
            Index_x_pin_r <= Index_x_pin_w;
            Index_y_pin_r <= Index_y_pin_w;
            local_index_r <= local_index_w;
        end
    end
endmodule