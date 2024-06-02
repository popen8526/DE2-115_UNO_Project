module Uno(i_cle, i_rst_n, i_start);
    input i_clk, i_rst_n, i_start;


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
    localparam S_CAL       = 4'd14;
    
    logic [ 2:0] state_w, state_r;
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
    logic [ 1:0] turn; // 00:p0, 01:com0, 10:com1, 11:com2
    logic        p0_turn, com0_turn, com1_turn, com2_turn;
    logic [ 5:0] p0_pcard, com0_pcard, com1_pcard, com2_pcard;
    logic        p0_draw, com0_draw, com1_draw, com2_draw;
    logic        p0_draw2_w, p0_draw2_r, com0_draw2_w, com0_draw2_r, com1_draw2_w, com1_draw2_r, com2_draw2_w, com2_draw2_r;
    logic        p0_draw4_w, p0_draw4_r, com0_draw4_w, com0_draw4_r, com1_draw4_w, com1_draw4_r, com2_draw4_w, com2_draw4_r;
    logic [ 5:0] p0_dcard, com0_dcard, com1_dcard, com2_dcard;
    logic        p0_play, com0_play, com1_play, com2_play;
    logic [ 5:0] last_card_w, last_card_r;

    // combinational logic
    assign insert = (turn[1]) ? (turn[0] ? com2_play : com1_play) : (turn[0] ? com0_play : p0_play);
    assign in_card = (turn[1]) ? (turn[0] ? com2_pcard : com1_pcard) : (turn[0] ? com0_pcard : p0_pcard);
    assign p0_turn = (turn == 2'b00);
    assign com0_turn = (turn == 2'b01);
    assign com1_turn = (turn == 2'b10);
    assign com2_turn = (turn == 2'b11);

    Deck Deck(
        .i_clk(i_clk),
        .i_rst_n(i_rst_n),
        .i_start(shuffle_r),
        .i_insert(insert),
        .i_prev_card(in_card),
        .i_draw(draw_num_r),
        .o_done(deck_idle),
        .o_drawn(card_drawn),
        .o_card(next_card)
    );

    Player P0(
        .clk(i_clk),
        .reset(i_rst_n),
        .init(p0_init_r),
        .start(p0_turn),
        // .hand(),
        .check(deck_idle),
        .prev_card(last_card_r),
        .out_cards(p0_pcard),
        .draw_card(p0_draw),
        .i_drawn(card_drawn),
        // .skip(),
        .draw_two(p0_draw2_r),
        .draw_four(p0_draw4_r),
        .drawed_card(next_card),
        .out(p0_play)
    );
    Computer Com0(
        .clk(i_clk),
        .reset(i_rst_n),
        .init(com0_init_r),
        .start(com0_turn),
        // .hands(),
        .check(deck_idle),
        .prev_card(last_card_r),
        .out_cards(com0_pcard),
        .draw_card(com0_draw),
        .i_drawn(card_drawn),
        // .skip(),
        .draw_two(com0_draw2_r),
        .draw_four(com0_draw4_r),
        .drawed_card(next_card),
        .out(com0_play)
    );
    Computer Com1(
        .clk(i_clk),
        .reset(i_rst_n),
        .init(com1_init_r),
        .start(com1_turn),
        // .hands(),
        .check(deck_idle),
        .prev_card(last_card_r),
        .out_cards(com1_pcard),
        .draw_card(com1_draw),
        .i_drawn(card_drawn),
        // .skip(),
        .draw_two(com1_draw2_r),
        .draw_four(com1_draw4_r),
        .drawed_card(next_card),
        .out(com1_play)
    );
    Computer Com2(
        .clk(i_clk),
        .reset(i_rst_n),
        .init(com2_init_r),
        .start(com2_turn),
        // .hands(),
        .check(deck_idle),
        .prev_card(last_card_r),
        .out_cards(com2_pcard),
        .draw_card(com2_draw),
        .i_drawn(card_drawn),
        // .skip(),
        .draw_two(com2_draw2_r),
        .draw_four(com2_draw4_r),
        .drawed_card(next_card),
        .out(com2_play)
    );


    always_comb begin
        case(state_r)
            S_IDLE: begin
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
                if(draw_count_r >= 5'd7) begin
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
                    if(card_drawn)  draw_count_w = draw_count_r + 1;
                    else            draw_count_w = draw_count_r;
                end
            end
            S_COM0_INIT: begin
                if(draw_count_r >= 5'd14) begin
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
                    if(card_drawn)  draw_count_w = draw_count_r + 1;
                    else            draw_count_w = draw_count_r;
                end
            end
            S_COM1_INIT: begin
                if(draw_count_r >= 5'd21) begin
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
                    if(card_drawn)  draw_count_w = draw_count_r + 1;
                    else            draw_count_w = draw_count_r;
                end
            end
            S_COM2_INIT: begin
                if(draw_count_r >= 5'd28) begin
                    draw_count_w = 0;
                    if(deck_idle)   state_w = S_PLAYER;
                    else            state_w = S_COM2_INIT;
                end
                else begin
                    state_w = S_COM2_INIT;
                    if(card_drawn)  draw_count_w = draw_count_r + 1;
                    else            draw_count_w = draw_count_r;
                end
            end
            // 10: skip, 11: reverse, 12: draw two, 13: wild, 14: wild draw four
            S_PLAYER: begin
                turn = 2'b00;
                if(p0_play) begin
                    last_card_w = p0_pcard;
                    reversed_w = reversed_r ^ (p0_pcard[3:0] == 4'd11);
                    if(p0_pcard[3:0] == 4'd10) begin // skip
                        draw_num_w = 3'b000;
                        state_w = S_COM1;
                    end
                    else if(p0_pcard[3:0] == 4'd11) begin // reverse
                        draw_num_w = 3'b000;
                        state_w = (reversed_r)? S_COM0:S_COM2;
                    end
                    else if(p0_pcard[3:0] == 4'd12) begin // draw two
                        if(deck_idle) begin
                            draw_num_w = 3'b010;
                            if(reversed_r) begin
                                state_w = S_COM2;
                                com0_draw2_w = 1'b0;
                                com0_draw4_w = 1'b0;
                                com2_draw2_w = 1'b1;
                                com2_draw4_w = 1'b0;
                            end
                            else begin
                                state_w = S_COM0;
                                com0_draw2_w = 1'b1;
                                com0_draw4_w = 1'b0;
                                com2_draw2_w = 1'b0;
                                com2_draw4_w = 1'b0;
                            end
                        end
                        else begin
                            draw_num_w = 3'b000;
                            state_w = S_P0_BUFF;
                        end
                    end
                    else if(p0_pcard[3:0] == 4'd14) begin // wild draw four
                        if(deck_idle) begin
                            draw_num_w = 3'b100;
                            if(reversed_r) begin
                                state_w = S_COM2;
                                com0_draw2_w = 1'b0;
                                com0_draw4_w = 1'b0;
                                com2_draw2_w = 1'b0;
                                com2_draw4_w = 1'b1;
                            end
                            else begin
                                state_w = S_COM0;
                                com0_draw2_w = 1'b0;
                                com0_draw4_w = 1'b1;
                                com2_draw2_w = 1'b0;
                                com2_draw4_w = 1'b0;
                            end
                        end
                        else begin
                            draw_num_w = 3'b000;
                            state_w = S_P0_BUFF;
                        end
                    end
                    else begin
                        draw_num_w = 3'b000;
                        state_w = (reversed_r)? S_COM2:S_COM0;
                    end
                end
                else begin
                    draw_num_w = 3'b000;
                    state_w = S_PLAYER;
                    last_card_w = last_card_r;
                end
            end
            S_P0_BUFF: begin
                turn = 2'b00;
                last_card_w = last_card_r;
                reversed_w = reversed_r;
                if(deck_idle) begin
                    if(last_card_r[3:0] == 4'd12) begin // draw two
                        draw_num_w = 3'b010;
                        if(reversed_r) begin
                            state_w = S_COM2;
                            com0_draw2_w = 1'b0;
                            com0_draw4_w = 1'b0;
                            com2_draw2_w = 1'b1;
                            com2_draw4_w = 1'b0;
                        end
                        else begin
                            state_w = S_COM0;
                            com0_draw2_w = 1'b1;
                            com0_draw4_w = 1'b0;
                            com2_draw2_w = 1'b0;
                            com2_draw4_w = 1'b0;
                        end
                    end
                    else if(last_card_r[3:0] == 4'd14) begin // wild draw four
                        draw_num_w = 3'b100;
                        if(reversed_r) begin
                            state_w = S_COM2;
                            com0_draw2_w = 1'b0;
                            com0_draw4_w = 1'b0;
                            com2_draw2_w = 1'b0;
                            com2_draw4_w = 1'b1;
                        end
                        else begin
                            state_w = S_COM0;
                            com0_draw2_w = 1'b0;
                            com0_draw4_w = 1'b1;
                            com2_draw2_w = 1'b0;
                            com2_draw4_w = 1'b0;
                        end
                    end
                    else begin
                        draw_num_w = 3'b000;
                        state_w = (reversed_r)? S_COM2:S_COM0;
                    end
                end
                else begin
                    draw_num_w = 3'b000;
                    state_w = S_P0_BUFF;
                end
            end
            S_COM0: begin
                turn = 2'b01;
                if(com0_play) begin
                    last_card_w = com0_pcard;
                    reversed_w = reversed_r ^ (com0_pcard[3:0] == 4'd11);
                    if(com0_pcard[3:0] == 4'd10) begin // skip
                        draw_num_w = 3'b000;
                        state_w = S_COM2;
                    end
                    else if(com0_pcard[3:0] == 4'd11) begin // reverse
                        draw_num_w = 3'b000;
                        state_w = (reversed_r)? S_COM1:S_PLAYER;
                    end
                    else if(com0_pcard[3:0] == 4'd12) begin // draw two
                        if(deck_idle) begin
                            draw_num_w = 3'b010;
                            if(reversed_r) begin
                                state_w = S_PLAYER;
                                com1_draw2_w = 1'b0;
                                com1_draw4_w = 1'b0;
                                p0_draw2_w = 1'b1;
                                p0_draw4_w = 1'b0;
                            end
                            else begin
                                state_w = S_COM1;
                                com1_draw2_w = 1'b1;
                                com1_draw4_w = 1'b0;
                                p0_draw2_w = 1'b0;
                                p0_draw4_w = 1'b0;
                            end
                        end
                        else begin
                            draw_num_w = 3'b000;
                            state_w = S_COM0_BUFF;
                        end
                    end
                    else if(com0_pcard[3:0] == 4'd14) begin // wild draw four
                        if(deck_idle) begin
                            draw_num_w = 3'b100;
                            if(reversed_r) begin
                                state_w = S_PLAYER;
                                com1_draw2_w = 1'b0;
                                com1_draw4_w = 1'b0;
                                p0_draw2_w = 1'b0;
                                p0_draw4_w = 1'b1;
                            end
                            else begin
                                state_w = S_COM1;
                                com1_draw2_w = 1'b0;
                                com1_draw4_w = 1'b1;
                                p0_draw2_w = 1'b0;
                                p0_draw4_w = 1'b0;
                            end
                        end
                        else begin
                            draw_num_w = 3'b000;
                            state_w = S_COM0_BUFF;
                        end
                    end
                    else begin
                        draw_num_w = 3'b000;
                        state_w = (reversed_r)? S_PLAYER:S_COM1;
                    end
                end
                else begin
                    draw_num_w = 3'b000;
                    state_w = S_COM0;
                    last_card_w = last_card_r;
                end
            end
            S_COM0_BUFF: begin
                turn = 2'b01;
                last_card_w = last_card_r;
                reversed_w = reversed_r;
                if(deck_idle) begin
                    if(last_card_r[3:0] == 4'd12) begin // draw two
                        draw_num_w = 3'b010;
                        if(reversed_r) begin
                            state_w = S_PLAYER;
                            com1_draw2_w = 1'b0;
                            com1_draw4_w = 1'b0;
                            p0_draw2_w = 1'b1;
                            p0_draw4_w = 1'b0;
                        end
                        else begin
                            state_w = S_COM1;
                            com1_draw2_w = 1'b1;
                            com1_draw4_w = 1'b0;
                            p0_draw2_w = 1'b0;
                            p0_draw4_w = 1'b0;
                        end
                    end
                    else if(last_card_r[3:0] == 4'd14) begin // wild draw four
                        draw_num_w = 3'b100;
                        if(reversed_r) begin
                            state_w = S_PLAYER;
                            com1_draw2_w = 1'b0;
                            com1_draw4_w = 1'b0;
                            p0_draw2_w = 1'b0;
                            p0_draw4_w = 1'b1;
                        end
                        else begin
                            state_w = S_COM1;
                            com1_draw2_w = 1'b0;
                            com1_draw4_w = 1'b1;
                            p0_draw2_w = 1'b0;
                            p0_draw4_w = 1'b0;
                        end
                    end
                    else begin
                        draw_num_w = 3'b000;
                        state_w = (reversed_r)? S_PLAYER:S_COM1;
                    end
                end
                else begin
                    draw_num_w = 3'b000;
                    state_w = S_COM0_BUFF;
                end
            end
            S_COM1: begin
                turn = 2'b10
                if(com1_play) begin
                    last_card_w = com1_pcard;
                    reversed_w = reversed_r ^ (com1_pcard[3:0] == 4'd11);
                    if(com1_pcard[3:0] == 4'd10) begin // skip
                        draw_num_w = 3'b000;
                        state_w = S_PLAYER;
                    end
                    else if(com1_pcard[3:0] == 4'd11) begin // reverse
                        draw_num_w = 3'b000;
                        state_w = (reversed_r)? S_COM2:S_COM0;
                    end
                    else if(com1_pcard[3:0] == 4'd12) begin // draw two
                        if(deck_idle) begin
                            draw_num_w = 3'b010;
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
                        else begin
                            draw_num_w = 3'b000;
                            state_w = S_COM1_BUFF;
                        end
                    end
                    else if(com1_pcard[3:0] == 4'd14) begin // wild draw four
                        if(deck_idle) begin
                            draw_num_w = 3'b100;
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
                            state_w = S_COM1_BUFF;
                        end
                    end
                    else begin
                        draw_num_w = 3'b000;
                        state_w = (reversed_r)? S_COM0:S_COM2;
                    end
                end
                else begin
                    draw_num_w = 3'b000;
                    state_w = S_COM1;
                    last_card_w = last_card_r;
                end
            end
            S_COM1_BUFF: begin
                turn = 2'b10;
                last_card_w = last_card_r;
                reversed_w = reversed_r;
                if(deck_idle) begin
                    if(last_card_r[3:0] == 4'd12) begin // draw two
                        draw_num_w = 3'b010;
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
                    else if(last_card_r[3:0] == 4'd14) begin // wild draw four
                        draw_num_w = 3'b100;
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
                else begin
                    draw_num_w = 3'b000;
                    state_w = S_COM1_BUFF;
                end
            end
            S_COM2: begin
                turn = 2'b11;
                if(com2_play) begin
                    last_card_w = com2_pcard;
                    reversed_w = reversed_r ^ (com2_pcard[3:0] == 4'd11);
                    if(com2_pcard[3:0] == 4'd10) begin // skip
                        draw_num_w = 3'b000;
                        state_w = S_COM0;
                    end
                    else if(com2_pcard[3:0] == 4'd11) begin // reverse
                        draw_num_w = 3'b000;
                        state_w = (reversed_r)? S_PLAYER:S_COM1;
                    end
                    else if(com2_pcard[3:0] == 4'd12) begin // draw two
                        if(deck_idle) begin
                            draw_num_w = 3'b010;
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
                        else begin
                            draw_num_w = 3'b000;
                            state_w = S_COM2_BUFF;
                        end
                    end
                    else if(com2_pcard[3:0] == 4'd14) begin // wild draw four
                        if(deck_idle) begin
                            draw_num_w = 3'b100;
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
                            state_w = S_COM2_BUFF;
                        end
                    end
                    else begin
                        draw_num_w = 3'b000;
                        state_w = (reversed_r)? S_COM1:S_PLAYER;
                    end
                end
                else begin
                    draw_num_w = 3'b000;
                    state_w = S_COM2;
                    last_card_w = last_card_r;
                end
            end
            S_COM2_BUFF: begin
                turn = 2'b11;
                last_card_w = last_card_r;
                reversed_w = reversed_r;
                if(deck_idle) begin
                    if(last_card_r[3:0] == 4'd12) begin // draw two
                        draw_num_w = 3'b010;
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
                    else if(last_card_r[3:0] == 4'd14) begin // wild draw four
                        draw_num_w = 3'b100;
                        if(reversed_r) begin
                            state_w = S_COM1;
                            p0_draw2_w = 1'b0;
                            p0_draw4_w = 1'b0;
                            com1_draw2_w = 1'b0;
                            com1_draw4_w = 1'b1;
                        end
                        else begin
                            state_w = S_PLAYER;
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
                else begin
                    draw_num_w = 3'b000;
                    state_w = S_COM2_BUFF;
                end
            end
            S_CAL: begin
                
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
        end
    end
endmodule
