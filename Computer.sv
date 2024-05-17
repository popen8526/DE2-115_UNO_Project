module Computer(clk, reset, start, hands, prev_card, out_cards, draw_card, skip, draw_two, draw_four);
    //----------------- port definition -----------------//
    input clk, reset, start, skip, draw_two, draw_four;
    input [5:0] hands [20:0];
    input [5:0] prev_card;
    output [5:0] out_cards; // output cards
    output [5:0] draw_card; // decide whether to draw a card
    //----------------- fsm state definition -----------------//
    localparam [2:0] S_IDLE = 3'b000, S_DRAW = 3'b001, S_OUT = 3'b010, S_SKIP = 3'b011, S_CHECK_COLOR = 3'b100, S_CHECK_NUM = 3'b101;
    //----------------- sequential signal definition -----------------//
    logic [5:0] hands_w [20:0];
    logic [5:0] hands_r [20:0];
    logic [5:0] out_cards_w, out_cards_r;
    logic [5:0] draw_card_w, draw_card_r;
    logic [6:0] red_num_w, red_num_r, blue_num_w, blue_num_r, green_num_w, green_num_r, yellow_num_w, yellow_num_r;
    logic [1:0] state_w, state_r;
    logic [5:0] red_exist, blue_exist, green_exist, yellow_exist;
    logic [14:0] number_exist_w, number_exist_r;
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
        counter_w = counter_r;
        state_w = state_r;
        case(state_r)
            S_IDLE: begin
                if(start) begin // if it's the computer's turn
                    state_w = S_CHECK_HANDS;
                    counter_w = 7'b0;
                    out_cards_w = 6'b0;
                    draw_card_w = 6'b0;
                end
                else begin
                    state_w = S_IDLE;
                    out_cards_w = 6'b0;
                    draw_card_w = 6'b0;
                end
            end
            S_DRAW: begin
                
            end
            S_OUT: begin
                
            end
            S_SKIP: begin
                
            end
            S_CHECK_COLOR: begin
                case(prev_card[5:4])
                    2'b00: begin // red
                        if(red_exist) begin
                            state_w = S_OUT;
                            out_cards_w = 6'b0;
                        end
                        else begin
                            state_w = S_DRAW;
                            draw_card_w = 6'b0;
                        end
                    end
                    2'b01: begin // yellow
                        
                    end
                    2'b10: begin // green
                        
                    end
                    2'b11: begin // blue
                        
                    end
                endcase
            end
            S_CHECK_NUM: begin
                case(prev_card[3:0])
                    4'b0000: begin // 0
                        if(number_exist_r[0]) begin
                            state_w = S_OUT;
                            out_cards_w = 6'b0;
                        end
                        else begin
                            state_w = S_DRAW;
                            draw_card_w = 6'b0;
                        end
                    end
                    4'b0001: begin // 1
                        if(number_exist_r[1]) begin
                            state_w = S_OUT;
                            out_cards_w = 6'b0;
                        end
                        else begin
                            state_w = S_DRAW;
                            draw_card_w = 6'b0;
                        end
                    end
                    4'b0010: begin // 2
                        if(number_exist_r[2]) begin
                            state_w = S_OUT;
                            out_cards_w = 6'b0;
                        end
                        else begin
                            state_w = S_DRAW;
                            draw_card_w = 6'b0;
                        end
                    end
                    4'b0011: begin // 3
                        if(number_exist_r[3]) begin
                            state_w = S_OUT;
                            out_cards_w = 6'b0;
                        end
                        else begin
                            state_w = S_DRAW;
                            draw_card_w = 6'b0;
                        end
                    end
                    4'b0100: begin // 4
                        if(number_exist_r[4]) begin
                            state_w = S_OUT;
                            out_cards_w = 6'b0;
                        end
                        else begin
                            state_w = S_DRAW;
                            draw_card_w = 6'b0;
                        end
                    end
                    4'b0101: begin // 5
                        if(number_exist_r[5]) begin
                            state_w = S_OUT;
                            out_cards_w = 6'b0;
                        end
                        else begin
                            state_w = S_DRAW;
                            draw_card_w = 6'b0;
                        end
                    end
                    4'b0110: begin // 6
                        if(number_exist_r[6]) begin
                            state_w = S_OUT;
                            out_cards_w = 6'b0;
                        end
                        else begin
                            state_w = S_DRAW;
                            draw_card_w = 6'b0;
                        end
                    end
                    4'b0111: begin // 7
                        if(number_exist_r[7]) begin
                            state_w = S_OUT;
                            out_cards_w = 6'b0;
                        end
                        else begin
                            state_w = S_DRAW;
                            draw_card_w = 6'b0;
                        end
                    end
                    4'b1000: begin // 8
                        if(number_exist_r[8]) begin
                            state_w = S_OUT;
                            out_cards_w = 6'b0;
                        end
                        else begin
                            state_w = S_DRAW;
                            draw_card_w = 6'b0;
                        end
                    end
                    4'b1001: begin // 9
                        if(number_exist_r[9]) begin
                            state_w = S_OUT;
                            out_cards_w = 6'b0;
                        end
                        else begin
                            state_w = S_DRAW;
                            draw_card_w = 6'b0;
                        end
                    end
                    4'b1010: begin // skip
                        if(number_exist_r[10]) begin
                            state_w = S_OUT;
                            out_cards_w = 6'b0;
                        end
                        else begin
                            state_w = S_DRAW;
                            draw_card_w = 6'b0;
                        end
                    end
                    4'b1011: begin // reverse
                        if(number_exist_r[11]) begin
                            state_w = S_OUT;
                            out_cards_w = 6'b0;
                        end
                        else begin
                            state_w = S_DRAW;
                            draw_card_w = 6'b0;
                        end
                    end
                    4'b1100: begin // draw two
                        if(number_exist_r[12]) begin
                            state_w = S_OUT;
                            out_cards_w = 6'b0;
                        end
                        else begin
                            state_w = S_DRAW;
                            draw_card_w = 6'b0;
                        end
                    end
                    4'b1101: begin // wild
                        
                    end
                    4'b1110: begin // wild draw four
                        
                    end
                endcase
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