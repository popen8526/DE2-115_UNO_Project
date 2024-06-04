module Computer(i_clk, i_rst_n, i_init, i_start, i_prev_card, o_out_card, o_draw_card, i_draw_two, i_draw_four, i_drawn, i_check, i_drawed_card, o_out);
    //----------------- port definition -----------------//
    input i_clk, i_rst_n, i_init, i_start, i_draw_two, i_draw_four, i_drawn, i_check;
    input [5:0] i_prev_card;
    output [5:0] o_out_card; // output cards
    output o_out; // decide whether to play a card
    output o_draw_card; // decide whether to draw a card
    input [5:0] i_drawed_card; // the card that the player drawed
    //----------------- fsm state definition -----------------//
    localparam S_IDLE = 3'b000, S_DRAW = 3'b001, S_OUT = 3'b010, S_DRAW_BUFF = 3'b011, S_CHECK_COLOR = 3'b100, S_CHECK_NUM = 3'b101, S_INIT = 3'b110;
    //----------------- sequential signal definition -----------------//
    // first dimension : 0-red, 1-yellow, 2-green, 3-blue, 4-wild, 5-wild draw four
    // second dimension : card num/function
    // third dimension : 00-no, 01-one, 11-two (00-no, 01-one, 10-two, 11-three for wild & wild4)
    logic [1:0] hands_w [5:0][12:0];
    logic [1:0] hands_r [5:0][12:0];

    logic draw_card_w, draw_card_r;
    logic [2:0] state_w, state_r;
    logic [5:0] red_exist, blue_exist, green_exist, yellow_exist, wild_exist, wild4_exist;
    logic       number_exist [12:0];
    logic [2:0] iter_w, iter_r; // number of card to be drawn
    logic [5:0] out_card_w, out_card_r;

    logic [3:0] lfsr_w, lfsr_r;
    //----------------- wire connection -----------------//
    assign red_exist = (hands_r[0][0][0] || hands_r[0][1][0] || hands_r[0][2][0] || hands_r[0][3][0] || hands_r[0][4][0] || hands_r[0][5][0] || hands_r[0][6][0] || hands_r[0][7][0] || hands_r[0][8][0] || hands_r[0][9][0] || hands_r[0][10][0] || hands_r[0][11][0] || hands_r[0][12][0]);
    assign blue_exist = (hands_r[1][0][0] || hands_r[1][1][0] || hands_r[1][2][0] || hands_r[1][3][0] || hands_r[1][4][0] || hands_r[1][5][0] || hands_r[1][6][0] || hands_r[1][7][0] || hands_r[1][8][0] || hands_r[1][9][0] || hands_r[1][10][0] || hands_r[1][11][0] || hands_r[1][12][0]);
    assign green_exist = (hands_r[2][0][0] || hands_r[2][1][0] || hands_r[2][2][0] || hands_r[2][3][0] || hands_r[2][4][0] || hands_r[2][5][0] || hands_r[2][6][0] || hands_r[2][7][0] || hands_r[2][8][0] || hands_r[2][9][0] || hands_r[2][10][0] || hands_r[2][11][0] || hands_r[2][12][0]);
    assign yellow_exist = (hands_r[3][0][0] || hands_r[3][1][0] || hands_r[3][2][0] || hands_r[3][3][0] || hands_r[3][4][0] || hands_r[3][5][0] || hands_r[3][6][0] || hands_r[3][7][0] || hands_r[3][8][0] || hands_r[3][9][0] || hands_r[3][10][0] || hands_r[3][11][0] || hands_r[3][12][0]);
    assign wild_exist = (hands_r[4][0][0] || hands_r[4][0][1]);
    assign wild4_exist = (hands_r[5][0][0] || hands_r[5][0][1]);
    for(int i=0; i<13; i++) begin
        assign number_exist[i] = (hands_r[0][i][0] || hands_r[1][i][0] || hands_r[2][i][0] || hands_r[3][i][0]);
    end
    assign o_out_card = out_card_r;
    assign o_draw_card = draw_card_r;
    //----------------- combinational part -----------------//
    always_comb begin
        for(int i=0; i<6; i++) begin
            for(int j=0; j<13; j++) begin
                hands_w[i][j] = hands_r[i][j];
            end
        end
        out_card_w = out_card_r;
        draw_card_w = draw_card_r;
        iter_w = iter_r;
        state_w = state_r;
        lfsr_w = {lfsr_r[0]^lfsr_r[1], lfsr_r[3], lfsr_r[2], lfsr_r[1]};
        case(state_r)
            S_IDLE: begin
                if(i_start) begin // if it's the computer's turn
                    if(i_draw_two) begin
                        state_w = S_DRAW;
                        iter_w = 3'd2;
                    end
                    else if(i_draw_four) begin
                        state_w = S_DRAW;
                        iter_w = 3'd4;
                    end
                    else begin
                        state_w = S_CHECK_COLOR;
                        iter_w = 3'd0;
                    end
                end
                else if(i_init) begin // if it's the initial hands
                    state_w = S_DRAW;
                    iter_w = 3'd7;
                end
                else begin
                    state_w = S_IDLE;
                end
            end
            S_DRAW: begin
                if(i_drawn) begin
                    if(iter_r <= 1 && i_start) begin
                        state_w = S_IDLE;
                        iter_w = 3'd0;
                    end
                    else begin
                        state_w = S_DRAW;
                        iter_w = iter_r - 1;
                    end
                    if(i_drawed_card[3:0] == 4'b1101) begin // if the card is wild
                        hands_w[4][0] = hands_r[4][0] + 1;
                    end
                    else if (drawed_card_r[3:0] == 4'b1110) begin // if the card is wild draw four
                        hands_w[5][0] = hands_r[5][0] + 1;
                    end
                    else begin
                        hands_w[i_drawed_card[5:4]][i_drawed_card[3:0]] = (hands_r[i_drawed_card[5:4]][i_drawed_card[3:0]][0]) ? 2'b11 : 2'b01;
                    end
                end
                else begin
                    state_w = S_DRAW;
                    iter_w = iter_r;
                end
            end
            S_OUT: begin
                o_out = 1'b1; // play the card
                if(deck_idle) begin
                    state_w = S_IDLE;
                    out_card_w = 6'd0;
                end
                else begin
                    state_w = S_OUT;
                    out_card_w = out_card_r;
                end
            end
            S_CHECK_COLOR: begin
                iter_w = 3'd0;
                case(i_prev_card[5:4])
                    2'b00: begin // red
                        if(red_exist) begin
                            if(lfsr_r[3:0] > 4'd12) begin
                                state_w = S_CHECK_COLOR;
                                out_card_w = 6'd0;
                            end
                            else begin
                                if(hands_r[0][lfsr_r][0]) begin
                                    state_w = S_OUT;
                                    out_card_w = {2'b00, lfsr[3:0]};
                                    hands_r[0][lfsr_r] = (hands_r[0][lfsr_r][1]) ? 2'b01 : 2'b00;
                                end
                                else begin
                                    state_w = S_CHECK_COLOR;
                                    out_card_w = 6'd0;
                                end
                            end
                        end
                        else begin
                            state_w = S_CHECK_NUM;
                            out_card_w = 6'd0;
                        end
                    end
                    2'b01: begin // yellow
                        if(yellow_exist) begin
                            if(lfsr_r[3:0] > 4'd12) begin
                                state_w = S_CHECK_COLOR;
                                out_card_w = 6'd0;
                            end
                            else begin
                                if(hands_r[1][lfsr_r][0]) begin
                                    state_w = S_OUT;
                                    out_card_w = {2'b01, lfsr[3:0]};
                                    hands_r[1][lfsr_r] = (hands_r[1][lfsr_r][1]) ? 2'b01 : 2'b00;
                                end
                                else begin
                                    state_w = S_CHECK_COLOR;
                                    out_card_w = 6'd0;
                                end
                            end
                        end
                        else begin
                            state_w = S_CHECK_NUM;
                            out_card_w = 6'd0;
                        end
                    end
                    2'b10: begin // green
                        if(green_exist) begin
                            if(lfsr_r[3:0] > 4'd12) begin
                                state_w = S_CHECK_COLOR;
                                out_card_w = 6'd0;
                            end
                            else begin
                                if(hands_r[2][lfsr_r][0]) begin
                                    state_w = S_OUT;
                                    out_card_w = {2'b10, lfsr[3:0]};
                                    hands_r[2][lfsr_r] = (hands_r[2][lfsr_r][1]) ? 2'b01 : 2'b00;
                                end
                                else begin
                                    state_w = S_CHECK_COLOR;
                                    out_card_w = 6'd0;
                                end
                            end
                        end
                        else begin
                            state_w = S_CHECK_NUM;
                            out_card_w = 6'd0;
                        end
                    end
                    2'b11: begin // blue
                        if(blue_exist) begin
                            if(lfsr_r[3:0] > 4'd12) begin
                                state_w = S_CHECK_COLOR;
                                out_card_w = 6'd0;
                            end
                            else begin
                                if(hands_r[3][lfsr_r][0]) begin
                                    state_w = S_OUT;
                                    out_card_w = {2'b11, lfsr[3:0]};
                                    hands_r[3][lfsr_r] = (hands_r[3][lfsr_r][1]) ? 2'b01 : 2'b00;
                                end
                                else begin
                                    state_w = S_CHECK_COLOR;
                                    out_card_w = 6'd0;
                                end
                            end
                        end
                        else begin
                            state_w = S_CHECK_NUM;
                            out_card_w = 6'd0;
                        end    
                    end
                endcase
            end
            S_CHECK_NUM: begin
                if(i_prev_card[3:0] == 4'd13 || i_prev_card[3:0] == 4'd14) begin // prev card is wild - can only play wild if no color card
                    if(wild_exist) begin
                        state_w = S_CHOOSE;
                        hands_w[4][0] = hands_r[4][0] - 1;
                        out_card_w = {i_prev_card[5:4], 4'd13};
                        draw_card_w = 1'b0;
                        iter_w = 3'd0;
                    end
                    else if(wild4_exist) begin
                        state_w = S_CHOOSE;
                        hands_w[5][0] = hands_r[5][0] - 1;
                        out_card_w = {i_prev_card[5:4], 4'd14};
                        draw_card_w = 1'b0;
                        iter_w = 3'd0;
                    end
                    else begin
                        if(i_check) begin
                            state_w = S_DRAW;
                            draw_card_w = 1'b1;
                            iter_w = 3'd1;
                            out_card_w = 6'd0;
                        end
                        else begin
                            state_w = S_DRAW_BUFF;
                            draw_card_w = 1'b0;
                            iter_w = 3'd1;
                            out_card_w = 6'd0;
                        end
                    end
                end
                else begin
                    out_card_w = 6'd0;
                    if(number_exist[i_prev_card[3:0]]) begin
                        if(hands_r[0][i_prev_card[3:0]][0]) begin
                            state_w = S_OUT;
                            hands_w[0][i_prev_card[3:0]] = (hands_r[0][i_prev_card[3:0]][1]) ? 2'b01 : 2'b00;
                            draw_card_w = 1'b0;
                            iter_w = 3'd0;
                        end
                        else if(hands_r[1][i_prev_card[3:0]][0]) begin
                            state_w = S_OUT;
                            hands_w[1][i_prev_card[3:0]] = (hands_r[1][i_prev_card[3:0]][1]) ? 2'b01 : 2'b00;
                            draw_card_w = 1'b0;
                            iter_w = 3'd0;
                        end
                        else if(hands_r[2][i_prev_card[3:0]][0]) begin
                            state_w = S_OUT;
                            hands_w[2][i_prev_card[3:0]] = (hands_r[2][i_prev_card[3:0]][1]) ? 2'b01 : 2'b00;
                            draw_card_w = 1'b0;
                            iter_w = 3'd0;
                        end
                        else if(hands_r[3][i_prev_card[3:0]][0]) begin
                            state_w = S_OUT;
                            hands_w[3][i_prev_card[3:0]] = (hands_r[3][i_prev_card[3:0]][1]) ? 2'b01 : 2'b00;
                            draw_card_w = 1'b0;
                            iter_w = 3'd0;
                        end
                        else begin
                            if(i_check) begin
                                state_w = S_DRAW;
                                draw_card_w = 1'b1;
                                iter_w = 3'd1;
                            end
                            else begin
                                state_w = S_DRAW_BUFF;
                                draw_card_w = 1'b0;
                                iter_w = 3'd1;
                            end
                        end
                    end
                    else begin
                        if(i_check) begin
                            state_w = S_DRAW;
                            draw_card_w = 1'b1;
                            iter_w = 3'd1;
                        end
                        else begin
                            state_w = S_DRAW_BUFF;
                            draw_card_w = 1'b0;
                            iter_w = 3'd1;
                        end
                    end
                end
            end
            S_DRAW_BUFF: begin // wait for deck_idle to draw
                iter_w = iter_r;
                if(i_check) begin
                    state_w = S_DRAW;
                    draw_card_w = 1'b1;
                end
                else begin
                    state_w = S_DRAW_BUFF;
                    draw_card_w = 1'b0;
                end
            end
            S_CHOOSE: begin // choose random color when played wild card (maybe if (color_exist != 0)&&(color != i_prev_card[5:4]) ?)
                out_card_w = {lfsr_r[1], lfsr[0], out_card_r[3:0]};
                state_w = S_OUT;
            end
        endcase
    end
    //----------------- sequential part -----------------//
    always_ff @(posedge i_clk or negedge i_rst_n) begin
        if(i_rst_n) begin
            state_r <= S_IDLE;
            for(int i=0; i<6; i++) begin
                for(int j=0; j<13; j++) begin
                    hands_r[i][j] <= 2'b00;
                end
            end
            draw_card_r <= 1'b0;
            iter_r <= 3'd0;
            out_card_r <= 6'd0;
            lfsr_r <= 4'b0110;
        end
        else begin
            state_r <= state_w;
            for(int i=0; i<6; i++) begin
                for(int j=0; j<13; j++) begin
                    hands_r[i][j] <= hands_w[i][j];
                end
            end
            draw_card_r <= draw_card_w;
            iter_r <= iter_w;
            out_card_r <= out_card_w;
            lfsr_r <= lfsr_w;
        end
    end
endmodule