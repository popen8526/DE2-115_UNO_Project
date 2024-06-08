module Uno(i_clk, i_rst_n, i_start, i_left, i_right, i_select, o_hand_num, o_score, o_index, o_hands, o_end, o_last_card, o_player_state, o_com0_state, o_com1_state, o_com2_state, o_deck_state_1, o_deck_state_2, o_select, o_uno_state);
    input i_clk, i_rst_n, i_start, i_left, i_right, i_select;
    output [ 6:0] o_hand_num [3:0];
    output [10:0] o_score [3:0];
    output [ 6:0] o_index;
    output [ 5:0] o_hands [107:0];
    output        o_end, o_select;
    output [ 5:0] o_last_card;
    output [ 3:0] o_player_state, o_com0_state, o_com1_state, o_com2_state, o_deck_state_1, o_deck_state_2, o_uno_state;


    localparam S_IDLE      = 4'd0;
    localparam S_SHUFFLE   = 4'd1;
    localparam S_PLAYER    = 4'd2;
    localparam S_COM0      = 4'd3;
    localparam S_COM1      = 4'd4;
    localparam S_COM2      = 4'd5;
    localparam S_P0_INIT   = 4'd6;
    localparam S_COM0_INIT = 4'd7;
    localparam S_COM1_INIT = 4'd8;
    localparam S_COM2_INIT = 4'd9;
    localparam S_P0_BUFF   = 4'd10;
    localparam S_COM0_BUFF = 4'd11;
    localparam S_COM1_BUFF = 4'd12;
    localparam S_COM2_BUFF = 4'd13;
    localparam S_END       = 4'd14;
    
    logic [ 3:0] state_w, state_r;
    // wire definition for deck
    logic        shuffle_w, shuffle_r;
    logic        insert;
    logic [ 5:0] in_card;
    logic [ 2:0] draw_num_w, draw_num_r;
    logic        deck_idle;
    logic        card_drawn;
    logic [ 5:0] next_card;
    // wire definition for player and computer
    logic        p0_init_w, p0_init_r, com0_init_w, com0_init_r, com1_init_w, com1_init_r, com2_init_w, com2_init_r;
    logic [ 4:0] draw_count_w, draw_count_r; // counter for initialization draw
    logic        p0_turn, com0_turn, com1_turn, com2_turn;
    logic [ 5:0] p0_pcard, com0_pcard, com1_pcard, com2_pcard;
    logic        p0_draw, com0_draw, com1_draw, com2_draw;
    logic        p0_draw2_w, p0_draw2_r, com0_draw2_w, com0_draw2_r, com1_draw2_w, com1_draw2_r, com2_draw2_w, com2_draw2_r;
    logic        p0_draw4_w, p0_draw4_r, com0_draw4_w, com0_draw4_r, com1_draw4_w, com1_draw4_r, com2_draw4_w, com2_draw4_r;
    logic [ 5:0] p0_dcard, com0_dcard, com1_dcard, com2_dcard;
    logic        p0_play, com0_play, com1_play, com2_play;
    logic [ 5:0] last_card_w, last_card_r;
    logic        reversed_w, reversed_r;
    logic        finish;

    logic [3:0]  player_state;
    logic [3:0]  com0_state;
    logic [3:0]  com1_state;
    logic [3:0]  com2_state;
    logic [3:0]  deck_state_1;
    logic [3:0]  deck_state_2;

    assign deck_state_1[3] = 1'b0;

    assign deck_state_2[3] = 1'b0;
    
    // combinational logic
    assign insert = ((p0_turn && p0_play) || (com0_turn && com0_play) || (com1_turn && com1_play) || (com2_turn && com2_play));
    assign in_card = (com1_turn || com2_turn) ? ((p0_turn || com0_turn) ? com2_pcard : com1_pcard) : ((p0_turn || com0_turn) ? com0_pcard : p0_pcard);
    assign p0_turn = ((state_r == S_PLAYER) || (state_r == S_P0_BUFF));
    assign com0_turn = ((state_r == S_COM0) || (state_r == S_COM0_BUFF));
    assign com1_turn = ((state_r == S_COM1) || (state_r == S_COM1_BUFF));
    assign com2_turn = ((state_r == S_COM2) || (state_r == S_COM2_BUFF));
    assign o_end = finish;
    assign o_last_card = last_card_r;
    assign o_player_state = player_state;
    assign o_com0_state = com0_state;
    assign o_com1_state = com1_state;
    assign o_com2_state = com2_state;
    assign o_deck_state_1 = deck_state_1;
    assign o_deck_state_2 = deck_state_2;
    assign o_uno_state = state_r;
    
    Deck Deck(
        .i_clk(i_clk),
        .i_rst_n(i_rst_n),
        .i_start(shuffle_r),
        .i_insert(insert),
        .i_prev_card(in_card),
        .i_draw(draw_num_r),
        .o_done(deck_idle),
        .o_drawn(card_drawn),
        .o_card(next_card),
        .o_state_1(deck_state_1[2:0]),
        .o_state_2(deck_state_2[2:0])
    );

    Player P0(
        .i_clk(i_clk),
        .i_rst_n(i_rst_n),
        .i_init(p0_init_r),
        .i_start(p0_turn),
        .i_check(deck_idle),
        .i_prev_card(last_card_r),
        .o_out_card(p0_pcard),
        .o_draw(p0_draw),
        .i_drawn(card_drawn),
        .i_draw_two(p0_draw2_r),
        .i_draw_four(p0_draw4_r),
        .i_drawed_card(next_card),
        .o_out(p0_play),
        .i_left(i_left),
        .i_right(i_right),
        .i_select(i_select),
        .o_hands(o_hands),
        .o_index(o_index),
        .o_hand_num(o_hand_num[0]),
        .o_score(o_score[0]),
        .o_state(player_state),
        .o_select(o_select)
    );

    Computer Com0(
        .i_clk(i_clk),
        .i_rst_n(i_rst_n),
        .i_init(com0_init_r),
        .i_start(com0_turn),
        .i_check(deck_idle),
        .i_prev_card(last_card_r),
        .o_out_card(com0_pcard),
        .o_draw_card(com0_draw),
        .i_drawn(card_drawn),
        .i_draw_two(com0_draw2_r),
        .i_draw_four(com0_draw4_r),
        .i_drawed_card(next_card),
        .o_out(com0_play),
        .o_hand_num(o_hand_num[1]),
        .o_score(o_score[1]),
        .o_state(com0_state)
    );

    Computer Com1(
        .i_clk(i_clk),
        .i_rst_n(i_rst_n),
        .i_init(com1_init_r),
        .i_start(com1_turn),
        .i_check(deck_idle),
        .i_prev_card(last_card_r),
        .o_out_card(com1_pcard),
        .o_draw_card(com1_draw),
        .i_drawn(card_drawn),
        .i_draw_two(com1_draw2_r),
        .i_draw_four(com1_draw4_r),
        .i_drawed_card(next_card),
        .o_out(com1_play),
        .o_hand_num(o_hand_num[2]),
        .o_score(o_score[2]),
        .o_state(com1_state)
    );

    Computer Com2(
        .i_clk(i_clk),
        .i_rst_n(i_rst_n),
        .i_init(com2_init_r),
        .i_start(com2_turn),
        .i_check(deck_idle),
        .i_prev_card(last_card_r),
        .o_out_card(com2_pcard),
        .o_draw_card(com2_draw),
        .i_drawn(card_drawn),
        .i_draw_two(com2_draw2_r),
        .i_draw_four(com2_draw4_r),
        .i_drawed_card(next_card),
        .o_out(com2_play),
        .o_hand_num(o_hand_num[3]),
        .o_score(o_score[3]),
        .o_state(com2_state)
    );


    always_comb begin
        shuffle_w = 1'b0;
        p0_init_w = 1'b0;
        com0_init_w = 1'b0;
        com1_init_w = 1'b0;
        com2_init_w = 1'b0;
        p0_draw2_w = 1'b0;
        com0_draw2_w = 1'b0;
        com1_draw2_w = 1'b0;
        com2_draw2_w = 1'b0;
        p0_draw4_w = 1'b0;
        com0_draw4_w = 1'b0;
        com1_draw4_w = 1'b0;
        com2_draw4_w = 1'b0;
        draw_count_w = draw_count_r;
        draw_num_w = draw_num_r;
        last_card_w = last_card_r;
        reversed_w = reversed_r;
        case(state_r)
            S_IDLE: begin
                finish = 1'b0;
                if(i_start) begin
                    state_w = S_SHUFFLE;
                    shuffle_w = 1'b1;
                end
                else begin
                    state_w = S_IDLE;
                    shuffle_w = 1'b0;
                end
            end
            S_SHUFFLE: begin
                finish = 1'b0;
                if(deck_idle) begin
                    state_w = S_P0_INIT;
                    p0_init_w = 1'b1;
                    draw_num_w = 3'b111;
                end
                else begin
                    state_w = S_SHUFFLE;
                    p0_init_w = 1'b0;
                    draw_num_w = 3'b000;
                end
            end
            S_P0_INIT: begin
                finish = 1'b0;
                if(draw_count_r >= 5'd7) begin
                    draw_count_w = draw_count_r;
                    if(deck_idle) begin
                        state_w = S_COM0_INIT;
                        com0_init_w = 1'b1;
                        draw_num_w = 3'b111;
                    end
                    else begin
                        state_w = S_P0_INIT;
                        com0_init_w = 1'b0;
                        draw_num_w = 3'b000;
                    end
                end
                else begin
                    state_w = S_P0_INIT;
                    com0_init_w = 1'b0;
                    draw_num_w = 3'b000;
                    if(card_drawn)  draw_count_w = draw_count_r + 1;
                    else            draw_count_w = draw_count_r;
                end
            end
            S_COM0_INIT: begin
                finish = 1'b0;
                if(draw_count_r >= 5'd14) begin
                    draw_count_w = draw_count_r;
                    if(deck_idle) begin
                        state_w = S_COM1_INIT;
                        com1_init_w = 1'b1;
                        draw_num_w = 3'b111;
                    end
                    else begin
                        state_w = S_COM0_INIT;
                        com1_init_w = 1'b0;
                        draw_num_w = 3'b000;
                    end
                end
                else begin
                    state_w = S_COM0_INIT;
                    com1_init_w = 1'b0;
                    draw_num_w = 3'b000;
                    if(card_drawn)  draw_count_w = draw_count_r + 1;
                    else            draw_count_w = draw_count_r;
                end
            end
            S_COM1_INIT: begin
                finish = 1'b0;
                if(draw_count_r >= 5'd21) begin
                    draw_count_w = draw_count_r;
                    if(deck_idle) begin
                        state_w = S_COM2_INIT;
                        com2_init_w = 1'b1;
                        draw_num_w = 3'b111;
                    end
                    else begin
                        state_w = S_COM1_INIT;
                        com2_init_w = 1'b0;
                        draw_num_w = 3'b000;
                    end
                end
                else begin
                    state_w = S_COM1_INIT;
                    com2_init_w = 1'b0;
                    draw_num_w = 3'b000;
                    if(card_drawn)  draw_count_w = draw_count_r + 1;
                    else            draw_count_w = draw_count_r;
                end
            end
            S_COM2_INIT: begin
                finish = 1'b0;
                if(draw_count_r >= 5'd28) begin
                    draw_num_w = 3'b000;
                    if(deck_idle) begin
                        state_w = S_PLAYER;
                        draw_count_w = 0;
                    end
                    else begin
                        state_w = S_COM2_INIT;
                        draw_count_w = draw_count_r;
                    end
                end
                else begin
                    state_w = S_COM2_INIT;
                    draw_num_w = 3'b000;
                    if(card_drawn)  draw_count_w = draw_count_r + 1;
                    else            draw_count_w = draw_count_r;
                end
            end
            // 10: skip, 11: reverse, 12: draw two, 13: wild, 14: wild draw four
            S_PLAYER: begin
                finish = 1'b0;
                if(p0_play) begin
                    last_card_w = p0_pcard;
                    reversed_w = reversed_r ^ (p0_pcard[3:0] == 4'd11);
                    if(o_hand_num[0] == 7'd0) begin
                        state_w = S_END;
                        draw_num_w = 3'b000;
                    end
                    else begin
                        if(p0_pcard[3:0] == 4'd10) begin // skip
                            draw_num_w = 3'b000;
                            state_w = S_COM1;
                        end
                        else if(p0_pcard[3:0] == 4'd11) begin // reverse
                            draw_num_w = 3'b000;
                            state_w = (reversed_r)? S_COM0:S_COM2;
                        end
                        else if(p0_pcard[3:0] == 4'd12) begin // draw two
                            draw_num_w = 3'b000;
                            state_w = S_P0_BUFF;
                            if(reversed_r) begin
                                com0_draw2_w = 1'b0;
                                com0_draw4_w = 1'b0;
                                com2_draw2_w = 1'b1;
                                com2_draw4_w = 1'b0;
                            end
                            else begin
                                com0_draw2_w = 1'b1;
                                com0_draw4_w = 1'b0;
                                com2_draw2_w = 1'b0;
                                com2_draw4_w = 1'b0;
                            end
                        end
                        else if(p0_pcard[3:0] == 4'd14) begin // wild draw four
                            draw_num_w = 3'b000;
                            state_w = S_P0_BUFF;
                            if(reversed_r) begin
                                com0_draw2_w = 1'b0;
                                com0_draw4_w = 1'b0;
                                com2_draw2_w = 1'b0;
                                com2_draw4_w = 1'b1;
                            end
                            else begin
                                com0_draw2_w = 1'b0;
                                com0_draw4_w = 1'b1;
                                com2_draw2_w = 1'b0;
                                com2_draw4_w = 1'b0;
                            end
                        end
                        else begin
                            draw_num_w = 3'b000;
                            state_w = (reversed_r)? S_COM2 : S_COM0;
                        end
                    end
                end
                else if(p0_draw) begin
                    last_card_w = last_card_r;
                    reversed_w = reversed_r;
                    if(deck_idle) begin
                        draw_num_w = 3'b001;
                        if(reversed_r) begin
                            state_w = S_COM2;
                        end
                        else begin
                            state_w = S_COM0;
                        end
                    end
                    else begin
                        draw_num_w = 3'b000;
                        state_w = S_PLAYER;
                    end
                end
                else begin
                    draw_num_w = 3'b000;
                    state_w = S_PLAYER;
                    last_card_w = last_card_r;
                    reversed_w = reversed_r;
                end
            end
            S_P0_BUFF: begin
                finish = 1'b0;
                last_card_w = last_card_r;
                reversed_w = reversed_r;
                com0_draw2_w = com0_draw2_r;
                com0_draw4_w = com0_draw4_r;
                com2_draw2_w = com2_draw2_r;
                com2_draw4_w = com2_draw4_r;
                if(deck_idle) begin
                    state_w = (com0_draw2_r || com0_draw4_r) ? S_COM0 : S_COM2;
                    draw_num_w = (com0_draw2_r||com2_draw2_r) ? 3'b010 : 3'b100;
                end
                else begin
                    state_w = S_P0_BUFF;
                    draw_num_w = 0;
                end
            end
            S_COM0: begin
                finish = 1'b0;
                if(com0_play) begin
                    last_card_w = com0_pcard;
                    reversed_w = reversed_r ^ (com0_pcard[3:0] == 4'd11);
                    if(o_hand_num[1] == 7'd0) begin
                        state_w = S_END;
                        draw_num_w = 3'b000;
                    end
                    else begin
                        if(com0_pcard[3:0] == 4'd10) begin // skip
                            draw_num_w = 3'b000;
                            state_w = S_COM2;
                        end
                        else if(com0_pcard[3:0] == 4'd11) begin // reverse
                            draw_num_w = 3'b000;
                            state_w = (reversed_r)? S_COM1:S_PLAYER;
                        end
                        else if(com0_pcard[3:0] == 4'd12) begin // draw two
                            draw_num_w = 3'b000;
                            state_w = S_COM0_BUFF;
                            if(reversed_r) begin
                                com1_draw2_w = 1'b0;
                                com1_draw4_w = 1'b0;
                                p0_draw2_w = 1'b1;
                                p0_draw4_w = 1'b0;
                            end
                            else begin
                                com1_draw2_w = 1'b1;
                                com1_draw4_w = 1'b0;
                                p0_draw2_w = 1'b0;
                                p0_draw4_w = 1'b0;
                            end
                        end
                        else if(com0_pcard[3:0] == 4'd14) begin // wild draw four
                            draw_num_w = 3'b000;
                            state_w = S_COM0_BUFF;
                            if(reversed_r) begin
                                com1_draw2_w = 1'b0;
                                com1_draw4_w = 1'b0;
                                p0_draw2_w = 1'b0;
                                p0_draw4_w = 1'b1;
                            end
                            else begin
                                com1_draw2_w = 1'b0;
                                com1_draw4_w = 1'b1;
                                p0_draw2_w = 1'b0;
                                p0_draw4_w = 1'b0;
                            end
                        end
                        else begin
                            draw_num_w = 3'b000;
                            state_w = (reversed_r)? S_PLAYER : S_COM1;
                        end
                    end
                end
                else if(com0_draw) begin
                    last_card_w = last_card_r;
                    reversed_w = reversed_r;
                    if(deck_idle) begin
                        draw_num_w = 3'b001;
                        if(reversed_r) begin
                            state_w = S_PLAYER;
                        end
                        else begin
                            state_w = S_COM1;                                
                        end
                    end
                    else begin
                        draw_num_w = 3'b000;
                        state_w = S_COM0;
                    end
                end
                else begin
                    draw_num_w = 3'b000;
                    state_w = S_COM0;
                    last_card_w = last_card_r;
                    reversed_w = reversed_r;
                end
            end
            S_COM0_BUFF: begin
                finish = 1'b0;
                last_card_w = last_card_r;
                reversed_w = reversed_r;
                com1_draw2_w = com1_draw2_r;
                com1_draw4_w = com1_draw4_r;
                p0_draw2_w = p0_draw2_r;
                p0_draw4_w = p0_draw4_r;
                if(deck_idle) begin
                    state_w = (com1_draw2_r || com1_draw4_r) ? S_COM1 : S_PLAYER;
                    draw_num_w = (com1_draw2_r||p0_draw2_r) ? 3'b010 : 3'b100;
                end
                else begin
                    state_w = S_COM0_BUFF;
                    draw_num_w = 0;
                end
            end
            S_COM1: begin
                finish = 1'b0;
                if(com1_play) begin
                    last_card_w = com1_pcard;
                    reversed_w = reversed_r ^ (com1_pcard[3:0] == 4'd11);
                    if(o_hand_num[2] == 7'd0) begin
                        state_w = S_END;
                        draw_num_w = 3'b000;
                    end
                    else begin
                        if(com1_pcard[3:0] == 4'd10) begin // skip
                            draw_num_w = 3'b000;
                            state_w = S_PLAYER;
                        end
                        else if(com1_pcard[3:0] == 4'd11) begin // reverse
                            draw_num_w = 3'b000;
                            state_w = (reversed_r)? S_COM2:S_COM0;
                        end
                        else if(com1_pcard[3:0] == 4'd12) begin // draw two
                            draw_num_w = 3'b000;
                            state_w = S_COM1_BUFF;
                            if(reversed_r) begin
                                state_w = S_COM0;
                                com2_draw2_w = 1'b0;
                                com2_draw4_w = 1'b0;
                                com0_draw2_w = 1'b1;
                                com0_draw4_w = 1'b0;
                            end
                            else begin
                                state_w = S_COM2;
                                com2_draw2_w = 1'b1;
                                com2_draw4_w = 1'b0;
                                com0_draw2_w = 1'b0;
                                com0_draw4_w = 1'b0;
                            end
                        end
                        else if(com1_pcard[3:0] == 4'd14) begin // wild draw four
                            draw_num_w = 3'b000;
                            state_w = S_COM1_BUFF;
                            if(reversed_r) begin
                                state_w = S_COM0;
                                com2_draw2_w = 1'b0;
                                com2_draw4_w = 1'b0;
                                com0_draw2_w = 1'b0;
                                com0_draw4_w = 1'b1;
                            end
                            else begin
                                state_w = S_COM2;
                                com2_draw2_w = 1'b0;
                                com2_draw4_w = 1'b1;
                                com0_draw2_w = 1'b0;
                                com0_draw4_w = 1'b0;
                            end
                        end
                        else begin
                            draw_num_w = 3'b000;
                            state_w = (reversed_r)? S_COM0:S_COM2;
                        end
                    end
                end
                else if(com1_draw) begin
                    last_card_w = last_card_r;
                    reversed_w = reversed_r;
                    if(deck_idle) begin
                        draw_num_w = 3'b001;
                        if(reversed_r) begin
                            state_w = S_COM0;
                        end
                        else begin
                            state_w = S_COM2;                                
                        end
                    end
                    else begin
                        draw_num_w = 3'b000;
                        state_w = S_COM1;
                    end
                end
                else begin
                    draw_num_w = 3'b000;
                    state_w = S_COM1;
                    last_card_w = last_card_r;
                    reversed_w = reversed_r;
                end
            end
            S_COM1_BUFF: begin
                finish = 1'b0;
                last_card_w = last_card_r;
                reversed_w = reversed_r;
                com2_draw2_w = com2_draw2_r;
                com2_draw4_w = com2_draw4_r;
                com0_draw2_w = com0_draw2_r;
                com0_draw4_w = com0_draw4_r;
                draw_num_w = draw_num_r;
                if(deck_idle) begin
                    state_w = (com2_draw2_r || com2_draw4_r) ? S_COM2 : S_COM0;
                    draw_num_w = (com2_draw2_r|| com0_draw2_r) ? 3'b010 : 3'b100;
                end
                else begin
                    state_w = S_COM1_BUFF;
                    draw_num_w = 0;
                end
            end
            S_COM2: begin
                finish = 1'b0;
                if(com2_play) begin
                    last_card_w = com2_pcard;
                    reversed_w = reversed_r ^ (com2_pcard[3:0] == 4'd11);
                    if(o_hand_num[3] == 7'd0) begin
                        state_w = S_END;
                        draw_num_w = 3'b000;
                    end
                    else begin
                        if(com2_pcard[3:0] == 4'd10) begin // skip
                            draw_num_w = 3'b000;
                            state_w = S_COM0;
                        end
                        else if(com2_pcard[3:0] == 4'd11) begin // reverse
                            draw_num_w = 3'b000;
                            state_w = (reversed_r)? S_PLAYER:S_COM1;
                        end
                        else if(com2_pcard[3:0] == 4'd12) begin // draw two
                            draw_num_w = 3'b000;
                            state_w = S_COM2_BUFF;
                            if(reversed_r) begin
                                state_w = S_COM1;
                                p0_draw2_w = 1'b0;
                                p0_draw4_w = 1'b0;
                                com1_draw2_w = 1'b1;
                                com1_draw4_w = 1'b0;
                            end
                            else begin
                                state_w = S_PLAYER;
                                p0_draw2_w = 1'b1;
                                p0_draw4_w = 1'b0;
                                com1_draw2_w = 1'b0;
                                com1_draw4_w = 1'b0;
                            end
                        end
                        else if(com2_pcard[3:0] == 4'd14) begin // wild draw four
                            draw_num_w = 3'b000;
                            state_w = S_COM2_BUFF;
                            if(reversed_r) begin
                                state_w = S_COM0;
                                p0_draw2_w = 1'b0;
                                p0_draw4_w = 1'b0;
                                com1_draw2_w = 1'b0;
                                com1_draw4_w = 1'b1;
                            end
                            else begin
                                state_w = S_COM2;
                                p0_draw2_w = 1'b0;
                                p0_draw4_w = 1'b1;
                                com1_draw2_w = 1'b0;
                                com1_draw4_w = 1'b0;
                            end
                        end
                        else begin
                            draw_num_w = 3'b000;
                            state_w = (reversed_r)? S_COM1:S_PLAYER;
                        end
                    end
                end
                else if(com2_draw) begin
                    last_card_w = last_card_r;
                    reversed_w = reversed_r;
                    if(deck_idle) begin
                        draw_num_w = 3'b001;
                        if(reversed_r) begin
                            state_w = S_COM1;
                        end
                        else begin
                            state_w = S_PLAYER;                                
                        end
                    end
                    else begin
                        draw_num_w = 3'b000;
                        state_w = S_COM2;
                    end
                end
                else begin
                    draw_num_w = 3'b000;
                    state_w = S_COM2;
                    last_card_w = last_card_r;
                    reversed_w = reversed_r;
                end
            end
            S_COM2_BUFF: begin
                finish = 1'b0;
                last_card_w = last_card_r;
                reversed_w = reversed_r;
                p0_draw2_w = p0_draw2_r;
                p0_draw4_w = p0_draw4_r;
                com1_draw2_w = com1_draw2_r;
                com1_draw4_w = com1_draw4_r;
                draw_num_w = draw_num_r;
                if(deck_idle) begin
                    state_w = (p0_draw2_r || p0_draw4_r) ? S_PLAYER : S_COM1;
                    draw_num_w = (p0_draw2_r||com1_draw2_r) ? 3'b010 : 3'b100;
                end
                else begin
                    state_w = S_COM2_BUFF;
                    draw_num_w = 0;
                end
            end
            S_END: begin
                finish = 1'b1;
                if(!i_start)    state_w = S_IDLE;
                else            state_w = S_END;
            end
        endcase
    end

    always_ff @(negedge i_rst_n or posedge i_clk) begin
        if(!i_rst_n) begin
            state_r <= S_IDLE;
            shuffle_r <= 1'b0;
            draw_num_r <= 3'd0;
            p0_init_r <= 1'b0;
            com0_init_r <= 1'b0;
            com1_init_r <= 1'b0;
            com2_init_r <= 1'b0;
            draw_count_r <= 5'd0;
            p0_draw2_r <= 1'b0;
            com0_draw2_r <= 1'b0;
            com1_draw2_r <= 1'b0;
            com2_draw2_r <= 1'b0;
            p0_draw4_r <= 1'b0;
            com0_draw4_r <= 1'b0;
            com1_draw4_r <= 1'b0;
            com2_draw4_r <= 1'b0;
            last_card_r <= 6'd0;
            reversed_r <= 1'b0;
        end
        else begin
            state_r <= state_w;
            shuffle_r <= shuffle_w;
            draw_num_r <= draw_num_w;
            p0_init_r <= p0_init_w;
            com0_init_r <= com0_init_w;
            com1_init_r <= com1_init_w;
            com2_init_r <= com2_init_w;
            draw_count_r <= draw_count_w;
            p0_draw2_r <= p0_draw2_w;
            com0_draw2_r <= com0_draw2_w;
            com1_draw2_r <= com1_draw2_w;
            com2_draw2_r <= com2_draw2_w;
            p0_draw4_r <= p0_draw4_w;
            com0_draw4_r <= com0_draw4_w;
            com1_draw4_r <= com1_draw4_w;
            com2_draw4_r <= com2_draw4_w;
            last_card_r <= last_card_w;
            reversed_r <= reversed_w;
        end
    end
endmodule
