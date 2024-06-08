module Computer(i_clk, i_rst_n, i_init, i_start, i_prev_card, o_out_card, o_draw_card, i_draw_two, i_draw_four, i_drawn, i_check, i_drawed_card, o_out, o_hand_num, o_score, o_state);
    //----------------- port definition -----------------//
    input i_clk, i_rst_n, i_init, i_start, i_draw_two, i_draw_four, i_drawn, i_check;
    input [5:0] i_prev_card;
    output [5:0] o_out_card; // output cards
    output o_out; // decide whether to play a card
    output o_draw_card; // decide whether to draw a card
    input [5:0] i_drawed_card; // the card that the player drawed
    output [6:0] o_hand_num;
    output [10:0] o_score;
    output [3:0] o_state;
    //----------------- fsm state definition -----------------//
    localparam S_IDLE = 4'b0000, S_DRAW = 4'b0001, S_OUT = 4'b0010, S_NOCARD = 4'b0011, S_CHECK_COLOR = 4'b0100, S_CHECK_NUM = 4'b0101, S_CHECK = 4'b0110, S_CHOOSE = 4'b0111;
    localparam S_DRAW_R = 4'b1000, S_DRAW_Y = 4'b1001, S_DRAW_G = 4'b1010, S_DRAW_B = 4'b1011, S_NOCARD_R = 4'b1100, S_NOCARD_Y = 4'b1101, S_NOCARD_G = 4'b1110, S_NOCARD_B = 4'b1111;
    //----------------- sequential signal definition -----------------//
    // first dimension : 0-red, 1-yellow, 2-green, 3-blue, 4-wild, 5-wild draw four
    // second dimension : card num/function
    // third dimension : 00-no, 01-one, 11-two (00-no, 01-one, 10-two, 11-three for wild & wild4)
    logic [1:0] hands_w [5:0][12:0];
    logic [1:0] hands_r [5:0][12:0];
    logic [6:0] hand_num_w, hand_num_r;
    logic [10:0] score_w, score_r;

    logic       draw_card;
    logic [3:0] state_w, state_r;
    logic [5:0] red_exist, blue_exist, green_exist, yellow_exist, wild_exist, wild4_exist;
    logic       number_exist [12:0];
    logic [2:0] iter_w, iter_r; // number of card to be drawn
    logic [5:0] out_card_w, out_card_r;
    logic       out;

    logic [5:0] lfsr_w, lfsr_r;
    logic [27:0] counter_w, counter_r;
    integer i, j, k, l;
    //----------------- wire connection -----------------//
    assign red_exist = (hands_r[0][0][0] || hands_r[0][1][0] || hands_r[0][2][0] || hands_r[0][3][0] || hands_r[0][4][0] || hands_r[0][5][0] || hands_r[0][6][0] || hands_r[0][7][0] || hands_r[0][8][0] || hands_r[0][9][0] || hands_r[0][10][0] || hands_r[0][11][0] || hands_r[0][12][0]);
    assign yellow_exist = (hands_r[1][0][0] || hands_r[1][1][0] || hands_r[1][2][0] || hands_r[1][3][0] || hands_r[1][4][0] || hands_r[1][5][0] || hands_r[1][6][0] || hands_r[1][7][0] || hands_r[1][8][0] || hands_r[1][9][0] || hands_r[1][10][0] || hands_r[1][11][0] || hands_r[1][12][0]);
    assign green_exist = (hands_r[2][0][0] || hands_r[2][1][0] || hands_r[2][2][0] || hands_r[2][3][0] || hands_r[2][4][0] || hands_r[2][5][0] || hands_r[2][6][0] || hands_r[2][7][0] || hands_r[2][8][0] || hands_r[2][9][0] || hands_r[2][10][0] || hands_r[2][11][0] || hands_r[2][12][0]);
    assign blue_exist = (hands_r[3][0][0] || hands_r[3][1][0] || hands_r[3][2][0] || hands_r[3][3][0] || hands_r[3][4][0] || hands_r[3][5][0] || hands_r[3][6][0] || hands_r[3][7][0] || hands_r[3][8][0] || hands_r[3][9][0] || hands_r[3][10][0] || hands_r[3][11][0] || hands_r[3][12][0]);
    assign wild_exist = (hands_r[4][0][0] || hands_r[4][0][1]);
    assign wild4_exist = (hands_r[5][0][0] || hands_r[5][0][1]);
    assign o_state = state_r; // debug
    genvar x;
    generate
        for(x=0; x<13; x++) begin : QQ_1
            assign number_exist[x] = (hands_r[0][x][0] || hands_r[1][x][0] || hands_r[2][x][0] || hands_r[3][x][0]);
        end
    endgenerate
    
    assign o_out_card = out_card_r;
    assign o_out = out;
    assign o_draw_card = draw_card;
    assign o_hand_num = hand_num_r;
    assign o_score = score_r;
    //----------------- combinational part -----------------//
    always_comb begin
        for(i=0; i<6; i++) begin
            for(j=0; j<13; j++) begin
                hands_w[i][j] = hands_r[i][j];
            end
        end
        hand_num_w = hand_num_r;
        score_w = score_r;
        out_card_w = out_card_r;
        iter_w = iter_r;
        lfsr_w = {lfsr_r[0]^lfsr_r[1], lfsr_r[5], lfsr_r[4], lfsr_r[3], lfsr_r[2], lfsr_r[1]};
        case(state_r)
            S_IDLE: begin
                counter_w = 28'd0;
                out = 1'b0;
                draw_card = 1'b0;
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
                counter_w = (counter_r[20]) ? counter_r : (counter_r + 1);
                out = 1'b0;
                draw_card = 1'b0;
                if(i_drawn) begin
                    if(i_drawed_card[3:0] == 4'b1101) begin // if the card is wild
                        hands_w[4][0] = hands_r[4][0] + 1;
                        score_w = score_r + 50;
                        hand_num_w = hand_num_r + 1;
                        if(iter_r <= 1) begin
                            if(i_start) begin
                                state_w = S_CHECK_COLOR;
                                iter_w = 3'd0;
                            end
                            else begin
                                state_w = S_IDLE;
                                iter_w = 3'd0;
                            end
                        end
                        else begin
                            state_w = S_DRAW;
                            iter_w = iter_r - 1;
                        end
                    end
                    else if (i_drawed_card[3:0] == 4'b1110) begin // if the card is wild draw four
                        hands_w[5][0] = hands_r[5][0] + 1;
                        score_w = score_r + 50;
                        hand_num_w = hand_num_r + 1;
                        if(iter_r <= 1) begin
                            if(i_start) begin
                                state_w = S_CHECK_COLOR;
                                iter_w = 3'd0;
                            end
                            else begin
                                state_w = S_IDLE;
                                iter_w = 3'd0;
                            end
                        end
                        else begin
                            state_w = S_DRAW;
                            iter_w = iter_r - 1;
                        end
                    end
                    else begin
                        score_w = score_r;
                        iter_w = iter_r;
                        hand_num_w = hand_num_r;
                        case (i_drawed_card[5:4])
                            2'b00:  state_w = S_DRAW_R;
                            2'b01:  state_w = S_DRAW_Y;
                            2'b10:  state_w = S_DRAW_G;
                            2'b11:  state_w = S_DRAW_B;
                        endcase
                    end
                end
                else begin
                    hand_num_w = hand_num_r;
                    state_w = S_DRAW;
                    iter_w = iter_r;
                    score_w = score_r;
                end
            end
            S_DRAW_R: begin
                counter_w = (counter_r[20]) ? counter_r : (counter_r + 1);
                out = 1'b0;
                draw_card = 1'b0;
                if(iter_r <= 1) begin
                    if(i_start) begin
                        state_w = S_CHECK_COLOR;
                        iter_w = 3'd0;
                    end
                    else begin
                        state_w = S_IDLE;
                        iter_w = 3'd0;
                    end
                end
                else begin
                    state_w = S_DRAW;
                    iter_w = iter_r - 1;
                end
                hands_w[0][i_drawed_card[3:0]] = (hands_r[0][i_drawed_card[3:0]][0]) ? 2'b11 : 2'b01;
                score_w = score_r + ((i_drawed_card[3:0] >= 4'd10) ? (20) : (i_drawed_card[3:0]));
                hand_num_w = hand_num_r + 1;
            end
            S_DRAW_Y: begin
                counter_w = (counter_r[20]) ? counter_r : (counter_r + 1);
                out = 1'b0;
                draw_card = 1'b0;
                if(iter_r <= 1) begin
                    if(i_start) begin
                        state_w = S_CHECK_COLOR;
                        iter_w = 3'd0;
                    end
                    else begin
                        state_w = S_IDLE;
                        iter_w = 3'd0;
                    end
                end
                else begin
                    state_w = S_DRAW;
                    iter_w = iter_r - 1;
                end
                hands_w[1][i_drawed_card[3:0]] = (hands_r[1][i_drawed_card[3:0]][0]) ? 2'b11 : 2'b01;
                score_w = score_r + ((i_drawed_card[3:0] >= 4'd10) ? (20) : (i_drawed_card[3:0]));
                hand_num_w = hand_num_r + 1;
            end
            S_DRAW_G: begin
                counter_w = (counter_r[20]) ? counter_r : (counter_r + 1);
                out = 1'b0;
                draw_card = 1'b0;
                if(iter_r <= 1) begin
                    if(i_start) begin
                        state_w = S_CHECK_COLOR;
                        iter_w = 3'd0;
                    end
                    else begin
                        state_w = S_IDLE;
                        iter_w = 3'd0;
                    end
                end
                else begin
                    state_w = S_DRAW;
                    iter_w = iter_r - 1;
                end
                hands_w[2][i_drawed_card[3:0]] = (hands_r[2][i_drawed_card[3:0]][0]) ? 2'b11 : 2'b01;
                score_w = score_r + ((i_drawed_card[3:0] >= 4'd10) ? (20) : (i_drawed_card[3:0]));
                hand_num_w = hand_num_r + 1;
            end
            S_DRAW_B: begin
                counter_w = (counter_r[20]) ? counter_r : (counter_r + 1);
                out = 1'b0;
                draw_card = 1'b0;
                if(iter_r <= 1) begin
                    if(i_start) begin
                        state_w = S_CHECK_COLOR;
                        iter_w = 3'd0;
                    end
                    else begin
                        state_w = S_IDLE;
                        iter_w = 3'd0;
                    end
                end
                else begin
                    state_w = S_DRAW;
                    iter_w = iter_r - 1;
                end
                hands_w[3][i_drawed_card[3:0]] = (hands_r[3][i_drawed_card[3:0]][0]) ? 2'b11 : 2'b01;
                score_w = score_r + ((i_drawed_card[3:0] >= 4'd10) ? (20) : (i_drawed_card[3:0]));
                hand_num_w = hand_num_r + 1;
            end
            S_OUT: begin
                counter_w = (counter_r[20]) ? counter_r : (counter_r + 1);
                draw_card = 1'b0;
                // out = counter_r[20];
                out = 1'b1;
                if(i_check) begin
                    out = 1'b1; // play the card
                    state_w = S_CHECK;
                    out_card_w = 6'd0;
                end
                else begin
                    out = 1'b0; // play the card
                    state_w = S_OUT;
                    out_card_w = out_card_r;
                end
            end
            S_CHECK_COLOR: begin
                counter_w = (counter_r[20]) ? counter_r : (counter_r + 1);
                out = 1'b0;
                iter_w = 3'd0;
                draw_card = 1'b0;
                case(i_prev_card[5:4])
                    2'b00: begin // red
                        if(red_exist) begin
                            if(lfsr_r[3:0] > 4'd12) begin
                                state_w = S_CHECK_COLOR;
                                out_card_w = 6'd0;
                                hand_num_w = hand_num_r;
                                score_w = score_r;
                            end
                            else begin
                                if(hands_r[0][lfsr_r[3:0]][0]) begin
                                    state_w = S_OUT;
                                    out_card_w = {2'b00, lfsr_r[3:0]};
                                    hands_w[0][lfsr_r[3:0]] = (hands_r[0][lfsr_r[3:0]][1]) ? 2'b01 : 2'b00;
                                    hand_num_w = hand_num_r - 1;
                                    score_w = score_r - ((lfsr_r[3:0] >= 4'd10) ? (20) : (lfsr_r[3:0]));
                                end
                                else begin
                                    state_w = S_CHECK_COLOR;
                                    out_card_w = 6'd0;
                                    hand_num_w = hand_num_r;
                                    score_w = score_r;
                                end
                            end
                        end
                        else begin
                            state_w = S_CHECK_NUM;
                            out_card_w = 6'd0;
                            hand_num_w = hand_num_r;
                            score_w = score_r;
                        end
                    end
                    2'b01: begin // yellow
                        if(yellow_exist) begin
                            if(lfsr_r[3:0] > 4'd12) begin
                                state_w = S_CHECK_COLOR;
                                out_card_w = 6'd0;
                                hand_num_w = hand_num_r;
                                score_w = score_r;
                            end
                            else begin
                                if(hands_r[1][lfsr_r[3:0]][0]) begin
                                    state_w = S_OUT;
                                    out_card_w = {2'b01, lfsr_r[3:0]};
                                    hands_w[1][lfsr_r[3:0]] = (hands_r[1][lfsr_r[3:0]][1]) ? 2'b01 : 2'b00;
                                    hand_num_w = hand_num_r - 1;
                                    score_w = score_r - ((lfsr_r[3:0] >= 4'd10) ? (20) : (lfsr_r[3:0]));
                                end
                                else begin
                                    state_w = S_CHECK_COLOR;
                                    out_card_w = 6'd0;
                                    hand_num_w = hand_num_r;
                                    score_w = score_r;
                                end
                            end
                        end
                        else begin
                            state_w = S_CHECK_NUM;
                            out_card_w = 6'd0;
                            hand_num_w = hand_num_r;
                            score_w = score_r;
                        end
                    end
                    2'b10: begin // green
                        if(green_exist) begin
                            if(lfsr_r[3:0] > 4'd12) begin
                                state_w = S_CHECK_COLOR;
                                out_card_w = 6'd0;
                                hand_num_w = hand_num_r;
                                score_w = score_r;
                            end
                            else begin
                                if(hands_r[2][lfsr_r[3:0]][0]) begin
                                    state_w = S_OUT;
                                    out_card_w = {2'b10, lfsr_r[3:0]};
                                    hands_w[2][lfsr_r[3:0]] = (hands_r[2][lfsr_r[3:0]][1]) ? 2'b01 : 2'b00;
                                    hand_num_w = hand_num_r - 1;
                                    score_w = score_r - ((lfsr_r[3:0] >= 4'd10) ? (20) : (lfsr_r[3:0]));
                                end
                                else begin
                                    state_w = S_CHECK_COLOR;
                                    out_card_w = 6'd0;
                                    hand_num_w = hand_num_r;
                                    score_w = score_r;
                                end
                            end
                        end
                        else begin
                            state_w = S_CHECK_NUM;
                            out_card_w = 6'd0;
                            hand_num_w = hand_num_r;
                            score_w = score_r;
                        end
                    end
                    2'b11: begin // blue
                        if(blue_exist) begin
                            if(lfsr_r[3:0] > 4'd12) begin
                                state_w = S_CHECK_COLOR;
                                out_card_w = 6'd0;
                                hand_num_w = hand_num_r;
                                score_w = score_r;
                            end
                            else begin
                                if(hands_r[3][lfsr_r[3:0]][0]) begin
                                    state_w = S_OUT;
                                    out_card_w = {2'b11, lfsr_r[3:0]};
                                    hands_w[3][lfsr_r[3:0]] = (hands_r[3][lfsr_r[3:0]][1]) ? 2'b01 : 2'b00;
                                    hand_num_w = hand_num_r - 1;
                                    score_w = score_r - ((lfsr_r[3:0] >= 4'd10) ? (20) : (lfsr_r[3:0]));
                                end
                                else begin
                                    state_w = S_CHECK_COLOR;
                                    out_card_w = 6'd0;
                                    hand_num_w = hand_num_r;
                                    score_w = score_r;
                                end
                            end
                        end
                        else begin
                            state_w = S_CHECK_NUM;
                            out_card_w = 6'd0;
                            hand_num_w = hand_num_r;
                            score_w = score_r;
                        end    
                    end
                endcase
            end
            S_CHECK_NUM: begin
                counter_w = (counter_r[20]) ? counter_r : (counter_r + 1);
                out = 1'b0;
                draw_card = 1'b0;
                if(i_prev_card[3:0] == 4'd13 || i_prev_card[3:0] == 4'd14) begin // prev card is wild - can only play wild if no color card
                    if(wild_exist) begin
                        state_w = S_CHOOSE;
                        hands_w[4][0] = hands_r[4][0] - 1;
                        out_card_w = {i_prev_card[5:4], 4'd13};
                        hand_num_w = hand_num_r;
                        score_w = score_r;
                        iter_w = 3'd0;
                    end
                    else if(wild4_exist) begin
                        state_w = S_CHOOSE;
                        hands_w[5][0] = hands_r[5][0] - 1;
                        out_card_w = {i_prev_card[5:4], 4'd14};
                        hand_num_w = hand_num_r;
                        score_w = score_r;
                        iter_w = 3'd0;
                    end
                    else begin
                        state_w = S_NOCARD;
                        iter_w = 3'd1;
                        out_card_w = 6'd0;
                        hand_num_w = hand_num_r;
                        score_w = score_r;
                    end
                end
                else begin
                    if(number_exist[i_prev_card[3:0]]) begin
                        if(hands_r[0][i_prev_card[3:0]][0]) begin
                            state_w = S_OUT;
                            out_card_w = {2'b00, i_prev_card[3:0]};
                            hands_w[0][i_prev_card[3:0]] = (hands_r[0][i_prev_card[3:0]][1]) ? 2'b01 : 2'b00;
                            hand_num_w = hand_num_r - 1;
                            score_w = score_r - ((i_prev_card[3:0] >= 4'd10) ? (20) : (i_prev_card[3:0]));
                            iter_w = 3'd0;
                        end
                        else if(hands_r[1][i_prev_card[3:0]][0]) begin
                            state_w = S_OUT;
                            out_card_w = {2'b01, i_prev_card[3:0]};
                            hands_w[1][i_prev_card[3:0]] = (hands_r[1][i_prev_card[3:0]][1]) ? 2'b01 : 2'b00;
                            hand_num_w = hand_num_r - 1;
                            score_w = score_r - ((i_prev_card[3:0] >= 4'd10) ? (20) : (i_prev_card[3:0]));
                            iter_w = 3'd0;
                        end
                        else if(hands_r[2][i_prev_card[3:0]][0]) begin
                            state_w = S_OUT;
                            out_card_w = {2'b10, i_prev_card[3:0]};
                            hands_w[2][i_prev_card[3:0]] = (hands_r[2][i_prev_card[3:0]][1]) ? 2'b01 : 2'b00;
                            hand_num_w = hand_num_r - 1;
                            score_w = score_r - ((i_prev_card[3:0] >= 4'd10) ? (20) : (i_prev_card[3:0]));
                            iter_w = 3'd0;
                        end
                        else if(hands_r[3][i_prev_card[3:0]][0]) begin
                            state_w = S_OUT;
                            out_card_w = {2'b11, i_prev_card[3:0]};
                            hands_w[3][i_prev_card[3:0]] = (hands_r[3][i_prev_card[3:0]][1]) ? 2'b01 : 2'b00;
                            hand_num_w = hand_num_r - 1;
                            score_w = score_r - ((i_prev_card[3:0] >= 4'd10) ? (20) : (i_prev_card[3:0]));
                            iter_w = 3'd0;
                        end
                        else begin
                            state_w = S_NOCARD;
                            iter_w = 3'd0;
                            out_card_w = 6'd0;
                            hand_num_w = hand_num_r;
                            score_w = score_r;
                        end
                    end
                    else if(wild_exist) begin
                        state_w = S_CHOOSE;
                        hands_w[4][0] = hands_r[4][0] - 1;
                        out_card_w = {i_prev_card[5:4], 4'd13};
                        hand_num_w = hand_num_r;
                        score_w = score_r;
                        iter_w = 3'd0;
                    end
                    else if(wild4_exist) begin
                        state_w = S_CHOOSE;
                        hands_w[5][0] = hands_r[5][0] - 1;
                        out_card_w = {i_prev_card[5:4], 4'd14};
                        hand_num_w = hand_num_r;
                        score_w = score_r;
                        iter_w = 3'd0;
                    end
                    else begin
                        state_w = S_NOCARD;
                        out_card_w = 6'd0;
                        hand_num_w = hand_num_r;
                        score_w = score_r;
                        iter_w = 3'd0;
                    end
                end
            end
            S_CHOOSE: begin // choose random color when played wild card
                counter_w = (counter_r[20]) ? counter_r : (counter_r + 1);
                out = 1'b0;
                draw_card = 1'b0;
                if(lfsr_r[1:0] != i_prev_card[5:4]) begin
                    case (lfsr_r[1:0])
                        2'b00: begin
                            if(red_exist) begin
                                state_w = S_OUT;
                                out_card_w = {2'b00, out_card_r[3:0]};
                                hand_num_w = hand_num_r - 1;
                                score_w = score_r - 50;
                            end
                            else begin
                                state_w = S_CHOOSE;
                                out_card_w = 6'd0;
                                hand_num_w = hand_num_r;
                                score_w = score_r;
                            end
                        end 
                        2'b01: begin
                            if(yellow_exist) begin
                                state_w = S_OUT;
                                out_card_w = {2'b01, out_card_r[3:0]};
                                hand_num_w = hand_num_r - 1;
                                score_w = score_r - 50;
                            end
                            else begin
                                state_w = S_CHOOSE;
                                out_card_w = 6'd0;
                                hand_num_w = hand_num_r;
                                score_w = score_r;
                            end
                        end 
                        2'b10: begin
                            if(green_exist) begin
                                state_w = S_OUT;
                                out_card_w = {2'b10, out_card_r[3:0]};
                                hand_num_w = hand_num_r - 1;
                                score_w = score_r - 50;
                            end
                            else begin
                                state_w = S_CHOOSE;
                                out_card_w = 6'd0;
                                hand_num_w = hand_num_r;
                                score_w = score_r;
                            end
                        end 
                        2'b11: begin
                            if(blue_exist) begin
                                state_w = S_OUT;
                                out_card_w = {2'b11, out_card_r[3:0]};
                                hand_num_w = hand_num_r - 1;
                                score_w = score_r - 50;
                            end
                            else begin
                                state_w = S_CHOOSE;
                                out_card_w = 6'd0;
                                hand_num_w = hand_num_r;
                                score_w = score_r;
                            end
                        end 
                    endcase
                end
                else begin
                    state_w = S_CHOOSE;
                    out_card_w = out_card_r;
                    hand_num_w = hand_num_r;
                    score_w = score_r;
                end
            end
            S_NOCARD: begin
                counter_w = (counter_r[20]) ? counter_r : (counter_r + 1);
                out = 1'b0;
                // if(1'b1) begin // counter_r[20]
                    draw_card = 1'b1;
                    if(i_drawn) begin
                        if(i_drawed_card[3:0] == 4'b1101) begin // if the card is wild
                            hands_w[4][0] = hands_r[4][0] + 1;
                            score_w = score_r + 50;
                            hand_num_w = hand_num_r + 1;
                            state_w = S_CHECK;
                        end
                        else if (i_drawed_card[3:0] == 4'b1110) begin // if the card is wild draw four
                            hands_w[5][0] = hands_r[5][0] + 1;
                            score_w = score_r + 50;
                            hand_num_w = hand_num_r + 1;
                            state_w = S_CHECK;
                        end
                        else begin
                            score_w = score_r;
                            hand_num_w = hand_num_r;
                            case (i_drawed_card[5:4])
                                2'b00:  state_w = S_DRAW_R;
                                2'b01:  state_w = S_DRAW_Y;
                                2'b10:  state_w = S_DRAW_G;
                                2'b11:  state_w = S_DRAW_B;
                            endcase
                        end
                    end
                    else begin
                        state_w = S_NOCARD;
                        hand_num_w = hand_num_r;
                        score_w = score_r;
                    end
                // end
                // else begin
                //     draw_card = 1'b0;
                //     state_w = S_NOCARD;
                //     hand_num_w = hand_num_r;
                //     score_w = score_r;
                // end
            end
            S_NOCARD_R: begin
                counter_w = (counter_r[20]) ? counter_r : (counter_r + 1);
                out = 1'b0;
                draw_card = 1'b0;
                state_w = S_CHECK;
                hands_w[0][i_drawed_card[3:0]] = (hands_r[0][i_drawed_card[3:0]][0]) ? 2'b11 : 2'b01;
                score_w = score_r + ((i_drawed_card[3:0] >= 4'd10) ? (20) : (i_drawed_card[3:0]));
                hand_num_w = hand_num_r + 1;
            end
            S_NOCARD_Y: begin
                counter_w = (counter_r[20]) ? counter_r : (counter_r + 1);
                out = 1'b0;
                draw_card = 1'b0;
                state_w = S_CHECK;
                hands_w[1][i_drawed_card[3:0]] = (hands_r[1][i_drawed_card[3:0]][0]) ? 2'b11 : 2'b01;
                score_w = score_r + ((i_drawed_card[3:0] >= 4'd10) ? (20) : (i_drawed_card[3:0]));
                hand_num_w = hand_num_r + 1;
            end
            S_NOCARD_G: begin
                counter_w = (counter_r[20]) ? counter_r : (counter_r + 1);
                out = 1'b0;
                draw_card = 1'b0;
                state_w = S_CHECK;
                hands_w[2][i_drawed_card[3:0]] = (hands_r[2][i_drawed_card[3:0]][0]) ? 2'b11 : 2'b01;
                score_w = score_r + ((i_drawed_card[3:0] >= 4'd10) ? (20) : (i_drawed_card[3:0]));
                hand_num_w = hand_num_r + 1;
            end
            S_NOCARD_B: begin
                counter_w = (counter_r[20]) ? counter_r : (counter_r + 1);
                out = 1'b0;
                draw_card = 1'b0;
                state_w = S_CHECK;
                hands_w[3][i_drawed_card[3:0]] = (hands_r[3][i_drawed_card[3:0]][0]) ? 2'b11 : 2'b01;
                score_w = score_r + ((i_drawed_card[3:0] >= 4'd10) ? (20) : (i_drawed_card[3:0]));
                hand_num_w = hand_num_r + 1;
            end
            S_CHECK: begin
                counter_w = (counter_r[20]) ? counter_r : (counter_r + 1);
                draw_card = 1'b0;
                iter_w = 1'b0;
                out = 1'b0;
                state_w = (i_check) ? S_IDLE : S_CHECK;
            end
        endcase
    end
    //----------------- sequential part -----------------//
    always_ff @(posedge i_clk or negedge i_rst_n) begin
        if(!i_rst_n) begin
            state_r <= S_IDLE;
            for(k=0; k<6; k++) begin
                for(l=0; l<13; l++) begin
                    hands_r[k][l] <= 2'b00;
                end
            end
            iter_r <= 3'd0;
            out_card_r <= 6'd0;
            lfsr_r <= 6'b000110;
            counter_r <= 28'd0;
            hand_num_r <= 7'd0;
            score_r <= 11'd0;
        end
        else begin
            state_r <= state_w;
            for(k=0; k<6; k++) begin
                for(l=0; l<13; l++) begin
                    hands_r[k][l] <= hands_w[k][l];
                end
            end
            iter_r <= iter_w;
            out_card_r <= out_card_w;
            lfsr_r <= lfsr_w;
            counter_r <= counter_w;
            hand_num_r <= hand_num_w;
            score_r <= score_w;
        end
    end
endmodule
