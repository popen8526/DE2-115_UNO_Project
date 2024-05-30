module Uno();
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
    
    logic [ 2:0] state_w, state_r;
    logic [ 5:0] Deck0[107:0], Deck1[107:0];
    logic        use_deck_w, use_deck_r;
    logic        insert0_w, insert0_r, insert1_w, insert1_r;
    logic        shuffle0_w, shuffle0_r, shuffle1_w, shuffle1_r;
    logic [ 5:0] incard_d0, incard_d1;
    logic        shuff0_done, shuff1_done;
    logic        p0_init_w, p0_init_r, com0_init_w, com0_init_r, com1_init_w, com1_init_r, com2_init_w, com2_init_r;
    logic        p0_turn_w, p0_turn_r, com0_turn_w, com0_turn_r, com1_turn_w, com1_turn_r, com2_turn_w, com2_turn_r;
    logic [ 5:0] p0_pcard, com0_pcard, com1_pcard, com2_pcard;
    logic        p0_draw, com0_draw, com1_draw, com2_draw;
    logic        p0_draw2_w, p0_draw2_r, com0_draw2_w, com0_draw2_r, com1_draw2_w, com1_draw2_r, com2_draw2_w, com2_draw2_r;
    logic        p0_draw4_w, p0_draw4_r, com0_draw4_w, com0_draw4_r, com1_draw4_w, com1_draw4_r, com2_draw4_w, com2_draw4_r;
    logic [ 5:0] p0_dcard, com0_dcard, com1_dcard, com2_dcard;
    logic        p0_play, com0_play, com1_play, com2_play;
    logic [ 5:0] last_card_w, last_card_r;

    Card Deck0(
        .clk(i_clk),
        .reset(i_rst_n),
        .start(shuffle0_r),
        .o_Deck(Deck0),
        .in_use(!use_deck_r),
        .insert(insert0_r),
        .insert_card(incard_d0),
        .done(shuff0_done),
    );
    Card Deck1(
        .clk(i_clk),
        .reset(i_rst_n),
        .start(shuffle1_r),
        .o_Deck(Deck1),
        .in_use(use_deck_r),
        .insert(insert1_r),
        .insert_card(incard_d1),
        .done(shuff1_done),
    );

    Player P0(
        .clk(i_clk),
        .reset(i_rst_n),
        .init(p0_init_r),
        .start(p0_turn_r),
        .hands(),
        .prev_card(last_card_r),
        .out_cards(p0_pcard),
        .draw_card(p0_draw),
        .skip(),
        .draw_two(p0_draw2_r),
        .draw_four(p0_draw4_r),
        .drawed_card(p0_dcard),
        .out(p0_play)
    );
    Computer Com0(
        .clk(i_clk),
        .reset(i_rst_n),
        .init(com0_init_r),
        .start(com0_turn_r),
        .hands(),
        .prev_card(last_card_r),
        .out_cards(com0_pcard),
        .draw_card(com0_draw),
        .skip(),
        .draw_two(com0_draw2_r),
        .draw_four(com0_draw4_r),
        .drawed_card(com0_dcard),
        .out(com0_play)
    );
    Computer Com1(
        .clk(i_clk),
        .reset(i_rst_n),
        .init(com1_init_r),
        .start(com1_turn_r),
        .hands(),
        .prev_card(last_card_r),
        .out_cards(com1_pcard),
        .draw_card(com1_draw),
        .skip(),
        .draw_two(com1_draw2_r),
        .draw_four(com1_draw4_r),
        .drawed_card(com1_dcard),
        .out(com1_play)
    );
    Computer Com2(
        .clk(i_clk),
        .reset(i_rst_n),
        .init(com2_init_r),
        .start(com2_turn_r),
        .hands(),
        .prev_card(last_card_r),
        .out_cards(com2_pcard),
        .draw_card(com2_draw),
        .skip(),
        .draw_two(com2_draw2_r),
        .draw_four(com2_draw4_r),
        .drawed_card(com2_dcard),
        .out(com2_play)
    );


    always_comb begin
        case(state_r)
            S_IDLE: begin
                if(start) begin
                    state_w = S_SHUFFLE;
                    shuffle0_w = 1'b1;
                    shuffle1_w = 1'b0;
                    use_deck_w = 1'b0;
                end
                else begin
                    state_w = S_IDLE;
                    shuffle0_w = 1'b0;
                    shuffle1_w = 1'b0;
                    use_deck_w = 1'b0;
                end
            end
            S_SHUFFLE: begin
                if(shuff0_done) begin
                    state_w = S_P0_INIT;
                    p0_init_w = 1'b1;
                end
                else begin     
                    state_w = S_SHUFFLE;
                    p0_init_w = 1'b0;
                end
            end
            S_P0_INIT: begin
                if() begin
                    state_w = S_COM0_INIT;
                    com0_init_w = 1'b1;
                end
                else begin
                    state_w = S_P0_INIT;
                    com0_init_w = 1'b0;
                end
            end
            S_COM0_INIT: begin
                if() begin
                    state_w = S_COM1_INIT;
                    com1_init_w = 1'b1;
                end
                else begin
                    state_w = S_COM0_INIT;
                    com1_init_w = 1'b0;
                end
            end
            S_COM1_INIT: begin
                if() begin
                    state_w = S_COM2_INIT;
                    com2_init_w = 1'b1;
                end
                else begin
                    state_w = S_COM1_INIT;
                    com2_init_w = 1'b0;
                end
            end
            S_COM2_INIT: begin
                if() begin
                    state_w = S_PLAYER;
                    p0_turn_w = 1'b1;
                end
                else begin
                    state_w = S_COM2_INIT;
                    p0_turn_w = 1'b0;
                end
            end
            // 10: skip, 11: reverse, 12: draw two, 13: wild, 14: wild draw four
            S_PLAYER: begin
                if(p0_play) begin
                    last_card_w = p0_pcard;
                    p0_turn_w = 1'b0;
                    if(use_deck_r) begin
                        incard_d1 = p0_pcard;
                        insert1_w = 1'b1;
                    end
                    else begin
                        incard_d0 = p0_pcard;
                        insert0_w = 1'b1;
                    end
                    reversed_w = reversed_r ^ (p0_pcard[3:0] == 4'd11);
                    if(p0_pcard[3:0] == 4'd10) begin // skip
                        state_w = S_COM1;
                    end
                    else if(p0_pcard[3:0] == 4'd11) begin // reverse
                        state_w = (reversed_r)? S_COM0:S_COM2;
                    end
                    else if(p0_pcard[3:0] == 4'd12) begin // draw two
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
                    else if(p0_pcard[3:0] == 4'd14) begin // wild draw four
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
                        state_w = (reversed_r)? S_COM2:S_COM0;
                    end
                end
                else begin
                    state_w = S_PLAYER;
                    last_card_w = last_card_r;
                    p0_turn_w = 1'b1;
                end
            end
            S_COM0: begin
                if(com0_play) begin
                    last_card_w = com0_pcard;
                    if(use_deck_r) begin
                        incard_d1 = com0_pcard;
                        insert1_w = 1'b1;
                    end
                    else begin
                        incard_d0 = com0_pcard;
                        insert0_w = 1'b1;
                    end
                    reversed_w = reversed_r ^ (com0_pcard[3:0] == 4'd11);
                    if(com0_pcard[3:0] == 4'd10) begin // skip
                        state_w = S_COM2;
                    end
                    else if(com0_pcard[3:0] == 4'd11) begin // reverse
                        state_w = (reversed_r)? S_COM1:S_PLAYER;
                    end
                    else if(com0_pcard[3:0] == 4'd12) begin // draw two
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
                    else if(com0_pcard[3:0] == 4'd14) begin // wild draw four
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
                        state_w = (reversed_r)? S_PLAYER:S_COM1;
                    end
                end
                else begin
                    state_w = S_COM0;
                    last_card_w = last_card_r;
                end
            end
            S_COM1: begin
                if(com1_play) begin
                    last_card_w = com1_pcard;
                    if(use_deck_r) begin
                        incard_d1 = com1_pcard;
                        insert1_w = 1'b1;
                    end
                    else begin
                        incard_d0 = com1_pcard;
                        insert0_w = 1'b1;
                    end
                    reversed_w = reversed_r ^ (com1_pcard[3:0] == 4'd11);
                    if(com1_pcard[3:0] == 4'd10) begin // skip
                        state_w = S_PLAYER;
                    end
                    else if(com1_pcard[3:0] == 4'd11) begin // reverse
                        state_w = (reversed_r)? S_COM2:S_COM0;
                    end
                    else if(com1_pcard[3:0] == 4'd12) begin // draw two
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
                        state_w = (reversed_r)? S_COM0:S_COM2;
                    end
                end
                else begin
                    state_w = S_COM1;
                    last_card_w = last_card_r;
                end
            end
            S_COM2: begin
                if(com2_play) begin
                    last_card_w = com2_pcard;
                    if(use_deck_r) begin
                        incard_d1 = com2_pcard;
                        insert1_w = 1'b1;
                    end
                    else begin
                        incard_d0 = com2_pcard;
                        insert0_w = 1'b1;
                    end
                    reversed_w = reversed_r ^ (com2_pcard[3:0] == 4'd11);
                    if(com2_pcard[3:0] == 4'd10) begin // skip
                        state_w = S_COM0;
                    end
                    else if(com2_pcard[3:0] == 4'd11) begin // reverse
                        state_w = (reversed_r)? S_PLAYER:S_COM1;
                    end
                    else if(com2_pcard[3:0] == 4'd12) begin // draw two
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
                        state_w = (reversed_r)? S_COM1:S_PLAYER;
                    end
                end
                else begin
                    state_w = S_COM2;
                    last_card_w = last_card_r;
                end
            end
        endcase
    end

    always_ff @(negedge i_rst_n or posedge i_clk) begin
        if(!i_rst_n) begin
            state_r <= S_IDLE;
            use_deck_r <= 1'b0;
            insert0_r <= 1'b0;
            insert1_r <= 1'b0;
            shuffle0_r <= 1'b0;
            shuffle1_r <= 1'b0;
            p0_init_r <= 1'b0;
            com0_init_r <= 1'b0;
            com1_init_r <= 1'b0;
            com2_init_r <= 1'b0;
            p0_turn_r <= 1'b0;
            com0_turn_r <= 1'b0;
            com1_turn_r <= 1'b0;
            com2_turn_r <= 1'b0;
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
            use_deck_r <= use_deck_w;
            insert0_r <= insert0_w;
            insert1_r <= insert1_w;
            shuffle0_r <= shuffle0_w;
            shuffle1_r <= shuffle1_w;
            p0_init_r <= p0_init_w;
            com0_init_r <= com0_init_w;
            com1_init_r <= com1_init_w;
            com2_init_r <= com2_init_w;
            p0_turn_r <= p0_turn_w;
            com0_turn_r <= com0_turn_w;
            com1_turn_r <= com1_turn_w;
            com2_turn_r <= com2_turn_w;
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
