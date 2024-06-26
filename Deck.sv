// recording the remaining cards in the deck
// 6 bits: 2 bits for color, 4 bits for value
// 0: red, 1: yellow, 2: green, 3: blue
// 0: 0, 1: 1, 2: 2, 3: 3, 4: 4, 5: 5, 6: 6, 7: 7, 8: 8, 9: 9
// 10: skip, 11: reverse, 12: draw two, 13: wild, 14: wild draw four
module Deck(i_clk, i_rst_n, i_start, i_insert, i_prev_card, i_draw, o_done, o_drawn, o_card, o_state_1, o_state_2); 
    //----------------- port definition -----------------//
    input        i_clk, i_rst_n, i_start, i_insert;
    // output [5:0] o_Deck [107:0]; // No need to output the whole deck
    input  [2:0] i_draw; // 100: draw four, 010 draw two, 001: draw one
    output       o_done, o_drawn;
    output [5:0] o_card;
    output [2:0] o_state_1, o_state_2;
    input  [5:0] i_prev_card;
    //----------------- fsm state definition -----------------//
    localparam  S_IDLE_1 = 3'b000, S_SHUFFLE_1 = 3'b001, S_INSERT_1 = 3'b011, S_INIT_1 = 3'b100, S_WAIT_DRAW_1 = 3'b101, S_DRAW_1 = 3'b110;
    localparam  S_IDLE_2 = 3'b000, S_SHUFFLE_2 = 3'b001, S_INSERT_2 = 3'b011, S_WAIT_DRAW_2 = 3'b100, S_DRAW_2 = 3'b101;
    //----------------- wire connection -----------------//
    logic        draw;
    //----------------- sequential signal definition -----------------//
    logic [5:0] Deck_1_w [107:0];
    logic [5:0] Deck_1_r [107:0]; // 108 cards in the deck
    logic [5:0] Deck_2_w [107:0];
    logic [5:0] Deck_2_r [107:0]; // backup deck
    logic [6:0] counter_w, counter_r;
    logic [6:0] lfsr_w, lfsr_r; // Add LFSR registers
    logic [2:0] state_1_w, state_1_r;
    logic [2:0] state_2_w, state_2_r;
    logic [6:0] end_index_1_w, end_index_1_r, end_index_2_w, end_index_2_r;
    logic [2:0] draw_w, draw_r;
    logic       in_use_w, in_use_r;
    logic       drawn_1, drawn_2;
    //----------------- wire connection -----------------//
    assign o_done = (state_1_r == S_IDLE_1 && state_2_r == S_IDLE_2);
    assign draw = (draw_r[0] || draw_r[1] || draw_r[2]);
    assign o_drawn = in_use_r ? drawn_1 : drawn_2;
    assign o_card = in_use_r ? Deck_1_r[end_index_1_r] : Deck_2_r[end_index_2_r]; // always output the last card in the deck, when o_drawn is high, the last card is drawn.
    assign o_state_1 = state_1_r;
    assign o_state_2 = state_2_r;
    //----------------- combinational part for draw -----------------//
    always_comb begin
        if(state_1_r == S_WAIT_DRAW_1 && end_index_1_r == 0) begin
            in_use_w = 1'b0;
        end
        else if(state_2_r == S_WAIT_DRAW_2 && end_index_2_r == 0) begin
            in_use_w = 1'b1;
        end
        else in_use_w = in_use_r;

        if(i_start) lfsr_w = counter_r;
        else lfsr_w = {lfsr_r[3]^lfsr_r[0], lfsr_r[6], lfsr_r[5], lfsr_r[4], lfsr_r[3], lfsr_r[2], lfsr_r[1]};
        if(state_1_r == S_WAIT_DRAW_1 || state_2_r == S_WAIT_DRAW_2) begin
            draw_w = draw_r - 1; // draw_w is the number of cards to draw
        end
        else if(state_1_r == S_IDLE_1 && state_2_r == S_IDLE_2) begin
            draw_w = i_draw;
        end
        else begin
            draw_w = draw_r;
        end
    end
    //----------------- combinational part for Deck_1-----------------//
    always_comb begin
        counter_w = counter_r;
        // state_1_w = state_1_r;
        end_index_1_w = end_index_1_r;
        drawn_1 = 1'b0;
        for (int i = 0; i < 108; i++) begin
            Deck_1_w[i] = Deck_1_r[i];
        end
        case(state_1_r)
            S_INIT_1: begin
                counter_w = counter_r + 1; // i_start counting
                if (i_start) begin
                    state_1_w = S_SHUFFLE_1;
                end
                else begin
                    state_1_w = S_INIT_1;
                end
            end
            S_IDLE_1: begin
                if (!in_use_r) begin // if the deck is not in use, i_rst_n the deck
                    for (int i = 0; i < 108; i++) begin
                        if(end_index_1_r >= i)  Deck_1_w[i] = 0;
                        else                    Deck_1_w[i] = Deck_1_r[i];
                    end
                    end_index_1_w = end_index_1_r;
                    state_1_w = (i_insert) ? S_INSERT_1 : S_IDLE_1;
                end
                else if (|i_draw) begin
                    state_1_w = S_DRAW_1;
                end
                else begin
                    state_1_w = S_IDLE_1;
                end
            end
            S_SHUFFLE_1: begin
                if(lfsr_r[6:0] > end_index_1_r) begin
                    state_1_w = (end_index_1_r == 0) ? S_IDLE_1 : S_SHUFFLE_1;// if rand_num > end_index , shuffle again
                    end_index_1_w = (end_index_1_r == 0) ? 7'd107 : (end_index_1_r - 1);
                end
                else begin
                    Deck_1_w[end_index_1_r] = Deck_1_r[lfsr_r[6:0]];
                    Deck_1_w[lfsr_r[6:0]] = Deck_1_r[end_index_1_r];
                    end_index_1_w = (end_index_1_r > 1) ? (end_index_1_r - 1) : 7'd107;
                    state_1_w = (end_index_1_r > 1) ? S_SHUFFLE_1 : S_IDLE_1;
                end
            end
            S_INSERT_1: begin
                if(end_index_1_r < 20) begin
                    Deck_1_w[end_index_1_r] = i_prev_card;
                    state_1_w = S_IDLE_1; // if the last card is inserted, keep the index value
                    end_index_1_w = (end_index_2_r == 0) ? end_index_1_r : end_index_1_r + 1;
                end
                else begin
                    if(lfsr_r[6:0] > end_index_1_r) begin
                        state_1_w = S_INSERT_1; // if rand_num > end_index , insert again
                        end_index_1_w = end_index_1_r;
                    end
                    else begin
                        Deck_1_w[end_index_1_r] = Deck_1_r[lfsr_r[6:0]];
                        Deck_1_w[lfsr_r[6:0]] = i_prev_card; // Do the shuffle thing
                        state_1_w = S_IDLE_1;
                        end_index_1_w = (end_index_2_r == 0) ? end_index_1_r : end_index_1_r + 1;
                    end
                end
            end
            S_DRAW_1: begin
                drawn_1 = (draw) ? 1'b1 : 1'b0;
                state_1_w = (draw) ? S_WAIT_DRAW_1 : S_IDLE_1;
            end
            S_WAIT_DRAW_1: begin
                if(end_index_1_r == 0) begin
                    end_index_1_w = 0; // Draw the last card, hold the index value for the insertion.
                    state_1_w = (state_2_r == S_IDLE_2) ? S_IDLE_1 : S_WAIT_DRAW_1;
                end
                else begin
                    end_index_1_w = end_index_1_r - 1;
                    state_1_w = S_DRAW_1;
                end
            end
        endcase
    end
    //----------------- combinational part for Deck_2-----------------//
    always_comb begin
        state_2_w = state_2_r;
        end_index_2_w = end_index_2_r;
        drawn_2 = 1'b0;
        for(int i = 0; i < 108; i++) begin
            Deck_2_w[i] = Deck_2_r[i];
        end
        case(state_2_r) 
            S_IDLE_2: begin
                if (in_use_r) begin // in_use_r is high, the deck_2 is not in use
                    for (int i = 0; i < 108; i++) begin
                        if(end_index_2_r >= i)  Deck_2_w[i] = 0;
                        else                    Deck_2_w[i] = Deck_2_r[i];
                    end
                    end_index_2_w = end_index_2_r;
                    state_2_w = (i_insert) ? S_INSERT_2 : S_IDLE_2;
                end
                else if (|i_draw) begin
                    state_2_w = S_DRAW_2;
                end
                else begin
                    state_2_w = S_IDLE_2;
                end
            end
            S_INSERT_2: begin
                if(end_index_2_r < 20) begin
                    Deck_2_w[end_index_2_r] = i_prev_card;
                    state_2_w = S_IDLE_2; // if the last card is inserted, keep the index value
                    end_index_2_w = (end_index_1_r == 0) ? end_index_2_r : end_index_2_r + 1;
                end
                else begin
                    if(lfsr_r[6:0] > end_index_2_r) begin
                        state_2_w = S_INSERT_2; // if rand_num > end_index , insert again
                        end_index_2_w = end_index_2_r;
                    end
                    else begin
                        Deck_2_w[end_index_2_r] = Deck_2_r[lfsr_r[6:0]];
                        Deck_2_w[lfsr_r[6:0]] = i_prev_card; // Do the shuffle thing
                        state_2_w = S_IDLE_2;
                        end_index_2_w = (end_index_1_r == 0) ? end_index_2_r : end_index_2_r + 1;
                    end
                end
            end
            S_DRAW_2: begin
                drawn_2 = (draw) ? 1'b1 : 1'b0;
                state_2_w = (draw) ? S_WAIT_DRAW_2 : S_IDLE_2;
            end
            S_WAIT_DRAW_2: begin
                if(end_index_2_r == 0) begin
                    end_index_2_w = end_index_2_r;
                    state_2_w = (state_1_r == S_IDLE_1) ? S_IDLE_2 : S_WAIT_DRAW_2;
                end
                else begin
                    end_index_2_w = end_index_2_r - 1;
                    state_2_w = S_DRAW_2;
                end
            end
        endcase
    end
    //----------------- sequential part for Deck_1-----------------//
    always_ff @(posedge i_clk or negedge i_rst_n) begin
        if (!i_rst_n) begin
            state_1_r <= S_INIT_1;
            state_2_r <= S_IDLE_2;
            Deck_1_r[0] = {2'b00, 4'b0000}; // red 0
            Deck_1_r[1] = {2'b00, 4'b0001}; // red 1
            Deck_1_r[2] = {2'b00, 4'b0001}; 
            Deck_1_r[3] = {2'b00, 4'b0010}; // red 2
            Deck_1_r[4] = {2'b00, 4'b0010};
            Deck_1_r[5] = {2'b00, 4'b0011}; // red 3
            Deck_1_r[6] = {2'b00, 4'b0011};
            Deck_1_r[7] = {2'b00, 4'b0100}; // red 4
            Deck_1_r[8] = {2'b00, 4'b0100};
            Deck_1_r[9] = {2'b00, 4'b0101}; // red 5
            Deck_1_r[10] = {2'b00, 4'b0101};
            Deck_1_r[11] = {2'b00, 4'b0110}; // red 6
            Deck_1_r[12] = {2'b00, 4'b0110};
            Deck_1_r[13] = {2'b00, 4'b0111}; // red 7
            Deck_1_r[14] = {2'b00, 4'b0111};
            Deck_1_r[15] = {2'b00, 4'b1000}; // red 8
            Deck_1_r[16] = {2'b00, 4'b1000};
            Deck_1_r[17] = {2'b00, 4'b1001}; // red 9
            Deck_1_r[18] = {2'b00, 4'b1001};
            Deck_1_r[19] = {2'b00, 4'b1010}; // red skip
            Deck_1_r[20] = {2'b00, 4'b1010};
            Deck_1_r[21] = {2'b00, 4'b1011}; // red reverse
            Deck_1_r[22] = {2'b00, 4'b1011};
            Deck_1_r[23] = {2'b00, 4'b1100}; // red draw two
            Deck_1_r[24] = {2'b00, 4'b1100};
            Deck_1_r[25] = {2'b00, 4'b1101}; // red wild
            Deck_1_r[26] = {2'b00, 4'b1110}; // red wild draw four
            
            Deck_1_r[27] = {2'b01, 4'b0000}; // yellow 0
            Deck_1_r[28] = {2'b01, 4'b0001}; // yellow 1
            Deck_1_r[29] = {2'b01, 4'b0001};
            Deck_1_r[30] = {2'b01, 4'b0010}; // yellow 2
            Deck_1_r[31] = {2'b01, 4'b0010};
            Deck_1_r[32] = {2'b01, 4'b0011}; // yellow 3
            Deck_1_r[33] = {2'b01, 4'b0011};
            Deck_1_r[34] = {2'b01, 4'b0100}; // yellow 4
            Deck_1_r[35] = {2'b01, 4'b0100};
            Deck_1_r[36] = {2'b01, 4'b0101}; // yellow 5
            Deck_1_r[37] = {2'b01, 4'b0101};
            Deck_1_r[38] = {2'b01, 4'b0110}; // yellow 6
            Deck_1_r[39] = {2'b01, 4'b0110};
            Deck_1_r[40] = {2'b01, 4'b0111}; // yellow 7
            Deck_1_r[41] = {2'b01, 4'b0111};
            Deck_1_r[42] = {2'b01, 4'b1000}; // yellow 8
            Deck_1_r[43] = {2'b01, 4'b1000};
            Deck_1_r[44] = {2'b01, 4'b1001}; // yellow 9
            Deck_1_r[45] = {2'b01, 4'b1001};
            Deck_1_r[46] = {2'b01, 4'b1010}; // yellow skip
            Deck_1_r[47] = {2'b01, 4'b1010};
            Deck_1_r[48] = {2'b01, 4'b1011}; // yellow reverse
            Deck_1_r[49] = {2'b01, 4'b1011};
            Deck_1_r[50] = {2'b01, 4'b1100}; // yellow draw two
            Deck_1_r[51] = {2'b01, 4'b1100};
            Deck_1_r[52] = {2'b01, 4'b1101}; // yellow wild
            Deck_1_r[53] = {2'b01, 4'b1110}; // yellow wild draw four

            Deck_1_r[54] = {2'b10, 4'b0000}; // green 0
            Deck_1_r[55] = {2'b10, 4'b0001}; // green 1
            Deck_1_r[56] = {2'b10, 4'b0001};
            Deck_1_r[57] = {2'b10, 4'b0010}; // green 2
            Deck_1_r[58] = {2'b10, 4'b0010};
            Deck_1_r[59] = {2'b10, 4'b0011}; // green 3
            Deck_1_r[60] = {2'b10, 4'b0011};
            Deck_1_r[61] = {2'b10, 4'b0100}; // green 4
            Deck_1_r[62] = {2'b10, 4'b0100};
            Deck_1_r[63] = {2'b10, 4'b0101}; // green 5
            Deck_1_r[64] = {2'b10, 4'b0101};
            Deck_1_r[65] = {2'b10, 4'b0110}; // green 6
            Deck_1_r[66] = {2'b10, 4'b0110};
            Deck_1_r[67] = {2'b10, 4'b0111}; // green 7
            Deck_1_r[68] = {2'b10, 4'b0111};
            Deck_1_r[69] = {2'b10, 4'b1000}; // green 8
            Deck_1_r[70] = {2'b10, 4'b1000};
            Deck_1_r[71] = {2'b10, 4'b1001}; // green 9
            Deck_1_r[72] = {2'b10, 4'b1001};
            Deck_1_r[73] = {2'b10, 4'b1010}; // green skip
            Deck_1_r[74] = {2'b10, 4'b1010};
            Deck_1_r[75] = {2'b10, 4'b1011}; // green reverse
            Deck_1_r[76] = {2'b10, 4'b1011};
            Deck_1_r[77] = {2'b10, 4'b1100}; // green draw two
            Deck_1_r[78] = {2'b10, 4'b1100};
            Deck_1_r[79] = {2'b10, 4'b1101}; // green wild
            Deck_1_r[80] = {2'b10, 4'b1110}; // green wild draw four

            Deck_1_r[81] = {2'b11, 4'b0000}; // blue 0
            Deck_1_r[82] = {2'b11, 4'b0001}; // blue 1
            Deck_1_r[83] = {2'b11, 4'b0001};
            Deck_1_r[84] = {2'b11, 4'b0010}; // blue 2
            Deck_1_r[85] = {2'b11, 4'b0010};
            Deck_1_r[86] = {2'b11, 4'b0011}; // blue 3
            Deck_1_r[87] = {2'b11, 4'b0011};
            Deck_1_r[88] = {2'b11, 4'b0100}; // blue 4
            Deck_1_r[89] = {2'b11, 4'b0100};
            Deck_1_r[90] = {2'b11, 4'b0101}; // blue 5
            Deck_1_r[91] = {2'b11, 4'b0101};
            Deck_1_r[92] = {2'b11, 4'b0110}; // blue 6
            Deck_1_r[93] = {2'b11, 4'b0110};
            Deck_1_r[94] = {2'b11, 4'b0111}; // blue 7
            Deck_1_r[95] = {2'b11, 4'b0111};
            Deck_1_r[96] = {2'b11, 4'b1000}; // blue 8
            Deck_1_r[97] = {2'b11, 4'b1000};
            Deck_1_r[98] = {2'b11, 4'b1001}; // blue 9
            Deck_1_r[99] = {2'b11, 4'b1001};
            Deck_1_r[100] = {2'b11, 4'b1010}; // blue skip
            Deck_1_r[101] = {2'b11, 4'b1010};
            Deck_1_r[102] = {2'b11, 4'b1011}; // blue reverse
            Deck_1_r[103] = {2'b11, 4'b1011};
            Deck_1_r[104] = {2'b11, 4'b1100}; // blue draw two
            Deck_1_r[105] = {2'b11, 4'b1100};
            Deck_1_r[106] = {2'b11, 4'b1101}; // blue wild
            Deck_1_r[107] = {2'b11, 4'b1110}; // blue wild draw four
            for (int i = 0; i < 108; i++) begin
                Deck_2_r[i] <= 0;
            end
            counter_r <= 0;
            lfsr_r <= 0;
            end_index_1_r <= 7'd107;
            end_index_2_r <= 0;
            draw_r <= 0;
            in_use_r <= 1;
        end
        else begin
            state_1_r <= state_1_w;
            state_2_r <= state_2_w;
            for (int i = 0; i < 108; i++) begin
                Deck_1_r[i] <= Deck_1_w[i];
                Deck_2_r[i] <= Deck_2_w[i];
            end
            counter_r <= counter_w;
            lfsr_r <= lfsr_w;
            end_index_1_r <= end_index_1_w;
            end_index_2_r <= end_index_2_w;
            draw_r <= draw_w;
            in_use_r <= in_use_w;
        end
    end
endmodule
