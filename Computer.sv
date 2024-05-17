module Computer(clk, reset, start, hands, prev_card, out_cards, draw_card, skip, draw_two, draw_four, drawed_card);
    //----------------- port definition -----------------//
    input clk, reset, start, skip, draw_two, draw_four;
    input [5:0] hands [20:0];
    input [5:0] prev_card;
    output [5:0] out_cards; // output cards
    output draw_card; // decide whether to draw a card
    input [5:0] drawed_card; // the card that the player drawed
    //----------------- fsm state definition -----------------//
    localparam [2:0] S_IDLE = 3'b000, S_DRAW = 3'b001, S_OUT = 3'b010, S_SKIP = 3'b011, S_CHECK_COLOR = 3'b100, S_CHECK_NUM = 3'b101, S_SEARCH_COLOR = 3'b110, S_SEARCH_NUM = 3'b111;
    //----------------- sequential signal definition -----------------//
    logic [5:0] hands_w [20:0];
    logic [5:0] hands_r [20:0];
    logic [5:0] out_cards_w, out_cards_r;
    logic [5:0] draw_card_w, draw_card_r;
    logic [6:0] red_num_w, red_num_r, blue_num_w, blue_num_r, green_num_w, green_num_r, yellow_num_w, yellow_num_r;
    logic [1:0] state_w, state_r;
    logic [5:0] red_exist, blue_exist, green_exist, yellow_exist;
    logic [1:0] number_exist_w [14:0];
    logic [1:0] number_exist_r [14:0];
    logic [6:0] counter_w, counter_r, iter_w, iter_r;
    logic [5:0] search_card;
    //----------------- wire connection -----------------//
    assign red_exist = (red_num_r[0] || red_num_r[1] || red_num_r[2] || red_num_r[3] || red_num_r[4] || red_num_r[5]);
    assign blue_exist = (blue_num_r[0] || blue_num_r[1] || blue_num_r[2] || blue_num_r[3] || blue_num_r[4] || blue_num_r[5]);
    assign green_exist = (green_num_r[0] || green_num_r[1] || green_num_r[2] || green_num_r[3] || green_num_r[4] || green_num_r[5]);
    assign yellow_exist = (yellow_num_r[0] || yellow_num_r[1] || yellow_num_r[2] || yellow_num_r[3] || yellow_num_r[4] || yellow_num_r[5]);
    //----------------- combinational part -----------------//
    always_comb begin : 
        hands_w = hands_r;
        prev_card_w = prev_card_r;
        out_cards_w = out_cards_r;
        draw_card_w = draw_card_r;
        counter_w = counter_r; // counter for the number of cards in the hand
        iter_w = iter_r; // iterator for the number of cards in the hand
        state_w = state_r;
        case(state_r)
            S_IDLE: begin
                if(start) begin // if it's the computer's turn
                    state_w = S_CHECK_COLOR;
                    counter_w = 7'b0;
                end
                else begin
                    state_w = S_IDLE;
                end
            end
            S_DRAW: begin
                // TODO: draw a card, need to collaborate with the top module
            end
            S_OUT: begin
                
            end
            S_SKIP: begin
                state_w = S_IDLE; // skip the turn
            end
            S_CHECK_COLOR: begin
                search_card = 6'b111111; // initialize the search card to NONE card
                iter_w = 7'b0;
                case(prev_card[5:4])
                    2'b00: begin // red
                        if(red_exist) begin
                            state_w = S_SEARCH_COLOR;
                            search_card = {2'b00, 4'b1111}; // only caare about the color, setting the number to 1111 -> none 
                            red_num_w = red_num_r - 1;
                        end
                        else begin
                            state_w = S_CHECK_NUM;
                        end
                    end
                    2'b01: begin // yellow
                        if(yellow_exist) begin
                            state_w = S_SEARCH_COLOR;
                            search_card = {2'b01, 4'b1111};
                            yellow_num_w = yellow_num_r - 1;
                        end
                        else begin
                            state_w = S_CHECK_NUM;
                        end                        
                    end
                    2'b10: begin // green
                        if(green_exist) begin
                            state_w = S_SEARCH_COLOR;
                            search_card = {2'b10, 4'b1111};
                            green_num_w = green_num_r - 1;
                        end
                        else begin
                            state_w = S_CHECK_NUM;
                        end
                    end
                    2'b11: begin // blue
                        if(blue_exist) begin
                            state_w = S_SEARCH_COLOR;
                            search_card = {2'b11, 4'b1111};
                            blue_num_w = blue_num_r - 1;
                        end
                        else begin
                            state_w = S_CHECK_NUM;
                        end
                    end
                endcase
            end
            S_CHECK_NUM: begin
                search_card = 6'b111111; // initialize the search card to NONE card
                iter_w = 7'b0;
                case(prev_card[3:0])
                    4'b0000: begin // 0
                        if(number_exist_r[0][0] || number_exist_r[0][1]) begin
                            state_w = S_SEARCH_NUM;
                            search_card = {2'b00, 4'b0000}; // only care about the number, setting the color to 00 -> red, following will be don't care
                            number_exist_w[0] = number_exist_r[0] - 1;
                        end
                        else begin
                            state_w = S_DRAW;
                        end
                    end
                    4'b0001: begin // 1
                        if(number_exist_r[1][0] || number_exist_r[1][1]) begin
                            state_w = S_SEARCH_NUM;
                            search_card = {2'b00, 4'b0001};
                            number_exist_w[1] = number_exist_r[1] - 1;
                        end
                        else begin
                            state_w = S_DRAW;
                        end
                    end
                    4'b0010: begin // 2
                        if(number_exist_r[2][0] || number_exist_r[2][1]) begin
                            state_w = S_SEARCH_NUM;
                            search_card = {2'b00, 4'b0010};
                            number_exist_w[2] = number_exist_r[2] - 1;
                        end
                        else begin
                            state_w = S_DRAW;
                        end
                    end
                    4'b0011: begin // 3
                        if(number_exist_r[3][0] || number_exist_r[3][1]) begin
                            state_w = S_SEARCH_NUM;
                            search_card = {2'b00, 4'b0011};
                            number_exist_w[3] = number_exist_r[3] - 1;
                        end
                        else begin
                            state_w = S_DRAW;
                        end
                    end
                    4'b0100: begin // 4
                        if(number_exist_r[4][0] || number_exist_r[4][1]) begin
                            state_w = S_SEARCH_NUM;
                            search_card = {2'b00, 4'b0100};
                            number_exist_w[4] = number_exist_r[4] - 1;
                        end
                        else begin
                            state_w = S_DRAW;
                        end
                    end
                    4'b0101: begin // 5
                        if(number_exist_r[5][0] || number_exist_r[5][1]) begin
                            state_w = S_SEARCH_NUM;
                            search_card = {2'b00, 4'b0101};
                            number_exist_w[5] = number_exist_r[5] - 1;
                        end
                        else begin
                            state_w = S_DRAW;
                        end
                    end
                    4'b0110: begin // 6
                        if(number_exist_r[6][0] || number_exist_r[6][1]) begin
                            state_w = S_SEARCH_NUM;
                            search_card = {2'b00, 4'b0110};
                            number_exist_w[6] = number_exist_r[6] - 1;
                        end
                        else begin
                            state_w = S_DRAW;
                        end
                    end
                    4'b0111: begin // 7
                        if(number_exist_r[7][0] || number_exist_r[7][1]) begin
                            state_w = S_SEARCH_NUM;
                            search_card = {2'b00, 4'b0111};
                            number_exist_w[7] = number_exist_r[7] - 1;
                        end
                        else begin
                            state_w = S_DRAW;
                        end
                    end
                    4'b1000: begin // 8
                        if(number_exist_r[8][0] || number_exist_r[8][1]) begin
                            state_w = S_SEARCH_NUM;
                            search_card = {2'b00, 4'b1000};
                            number_exist_w[8] = number_exist_r[8] - 1;
                        end
                        else begin
                            state_w = S_DRAW;
                        end
                    end
                    4'b1001: begin // 9
                        if(number_exist_r[9][0] || number_exist_r[9][1]) begin
                            state_w = S_SEARCH_NUM;
                            search_card = {2'b00, 4'b1001};
                            number_exist_w[9] = number_exist_r[9] - 1;
                        end
                        else begin
                            state_w = S_DRAW;
                        end
                    end
                    4'b1010: begin // skip
                        if(number_exist_r[10][0] || number_exist_r[10][1]) begin
                            state_w = S_SEARCH_NUM;
                            search_card = {2'b00, 4'b1010};
                            number_exist_w[10] = number_exist_r[10] - 1;
                        end
                        else begin
                            state_w = S_DRAW;
                        end
                    end
                    4'b1011: begin // reverse
                        if(number_exist_r[11][0] || number_exist_r[11][1]) begin
                            state_w = S_SEARCH_NUM;
                            search_card = {2'b00, 4'b1011};
                            number_exist_w[11] = number_exist_r[11] - 1;
                        end
                        else begin
                            state_w = S_DRAW;
                        end
                    end
                    4'b1100: begin // draw two
                        if(number_exist_r[12][0] || number_exist_r[12][1]) begin
                            state_w = S_SEARCH_NUM;
                            search_card = {2'b00, 4'b1100};
                            number_exist_w[12] = number_exist_r[12] - 1;
                        end
                        else begin
                            state_w = S_DRAW;
                        end
                    end
                    default: begin // wild or wild draw four
                        if(number_exist_r[13][0] || number_exist_r[13][1]) begin
                            state_w = S_SEARCH_NUM;
                            search_card = {2'b00, 4'b1101};
                            number_exist_w[13] = number_exist_r[13] - 1;
                        end
                        else if(number_exist_r[14][0] || number_exist_r[14][1]) begin
                            state_w = S_SEARCH_NUM;
                            search_card = {2'b00, 4'b1110};
                            number_exist_w[14] = number_exist_r[14] - 1;
                        end
                        else begin
                            state_w = S_DRAW;
                        end
                    end
                endcase
            end
            S_SEARCH_COLOR: begin
                if(iter_r < counter_r) begin
                    iter_w = iter_r + 1;
                    if(hands_r[iter_r][5:4] == search_card[5:4]) begin
                        out_cards_w = hands_r[iter_r];
                        state_w = S_OUT;
                    end
                    else begin
                        state_w = S_SEARCH_COLOR;
                    end
                end
                else begin
                    state_w = S_DRAW;
                end
            end
            S_SEARCH_NUM: begin
                if(iter_r < counter_r) begin
                    iter_w = iter_r + 1;
                    if(hands_r[iter_r][3:0] == search_card[3:0]) begin
                        out_cards_w = hands_r[iter_r];
                        state_w = S_OUT;
                    end
                    else begin
                        state_w = S_SEARCH_NUM;
                    end
                end
                else begin
                    state_w = S_DRAW;
                end
            end
        endcase
    end
    //----------------- sequential part -----------------//
    always_ff @(posedge clk or posedge reset) begin : 
        if(reset) begin
            hands_r = 7'b0;
            prev_card_r = 6'b0;
            out_cards_r = 7'b0;
            draw_card_r = 6'b0;
            counter_r = 7'b0;
            state_r = S_IDLE;
        end
        else begin
            hands_r = hands_w;
            prev_card_r = prev_card_w;
            out_cards_r = out_cards_w;
            draw_card_r = draw_card_w;
            counter_r = counter_w;
            state_r = state_w;
        end
    end
endmodule