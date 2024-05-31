// recording the remaining cards in the deck
// 6 bits: 2 bits for color, 4 bits for value
// 0: red, 1: yellow, 2: green, 3: blue
// 0: 0, 1: 1, 2: 2, 3: 3, 4: 4, 5: 5, 6: 6, 7: 7, 8: 8, 9: 9
// 10: skip, 11: reverse, 12: draw two, 13: wild, 14: wild draw four

module Deck(i_clk, i_rst_n, i_start, i_in_use, i_draw1, i_draw2, i_draw4, i_insert, i_insert_card, o_next_card, o_done, o_empty);
    //----------------- port definition -----------------//
    input i_clk, i_rst_n, i_start, i_insert, i_draw1, i_draw2, i_draw4;
    output [5:0] o_next_card;
    input i_in_use;
    input [5:0] i_insert_card;
    output o_done;
    output o_empty;
    //----------------- fsm state definition -----------------//
    localparam S_IDLE        = 4'd0;
    localparam S_SHUFFLE     = 4'd1;
    localparam S_WAIT_INSERT = 4'd2;
    localparam S_INSERT      = 4'd3;
    localparam S_INIT        = 4'd4;
    localparam S_DRAW        = 4'd5;
    localparam S_DRAW2       = 4'd6;
    localparam S_DRAW4_2     = 4'd7;
    localparam S_DRAW4_3     = 4'd8;
    localparam S_DRAW4_4     = 4'd9;
    localparam S_SET         = 4'd10;

    //----------------- wire connection -----------------//
    // logic [3:0] value;

    //----------------- sequential signal definition -----------------//
    logic [5:0] Deck_w [107:0];
    logic [5:0] Deck_r [107:0]; // 108 cards in the deck
    logic [6:0] counter_w, counter_r;
    logic [6:0] lfsr_w, lfsr_r; // Add LFSR registers
    logic [3:0] state_w, state_r;
    logic [6:0] end_index_w, end_index_r;
    logic [6:0] front_index_w, front_index_r; // indicate which card to be drawn
    logic       empty_w, empty_r; // pull up if deck has less than four cards
    logic [1:0] remain_w, remain_r; // indicate remaining card number

    // assign o_Deck = Deck_r;
    assign o_empty = empty_r;
    //----------------- combinational part -----------------//
    always_comb begin
        counter_w = counter_r;
        lfsr_w = lfsr_r;
        state_w = state_r;
        end_index_w = end_index_r;
        case(state_r)
            S_INIT: begin
                o_done = 1'b0;
                state_w = S_IDLE;
                Deck_w[0] = {2'b00, 4'b0000}; // red 0
                Deck_w[1] = {2'b00, 4'b0001}; // red 1
                Deck_w[2] = {2'b00, 4'b0001}; 
                Deck_w[3] = {2'b00, 4'b0010}; // red 2
                Deck_w[4] = {2'b00, 4'b0010};
                Deck_w[5] = {2'b00, 4'b0011}; // red 3
                Deck_w[6] = {2'b00, 4'b0011};
                Deck_w[7] = {2'b00, 4'b0100}; // red 4
                Deck_w[8] = {2'b00, 4'b0100};
                Deck_w[9] = {2'b00, 4'b0101}; // red 5
                Deck_w[10] = {2'b00, 4'b0101};
                Deck_w[11] = {2'b00, 4'b0110}; // red 6
                Deck_w[12] = {2'b00, 4'b0110};
                Deck_w[13] = {2'b00, 4'b0111}; // red 7
                Deck_w[14] = {2'b00, 4'b0111};
                Deck_w[15] = {2'b00, 4'b1000}; // red 8
                Deck_w[16] = {2'b00, 4'b1000};
                Deck_w[17] = {2'b00, 4'b1001}; // red 9
                Deck_w[18] = {2'b00, 4'b1001};
                Deck_w[19] = {2'b00, 4'b1010}; // red skip
                Deck_w[20] = {2'b00, 4'b1010};
                Deck_w[21] = {2'b00, 4'b1011}; // red reverse
                Deck_w[22] = {2'b00, 4'b1011};
                Deck_w[23] = {2'b00, 4'b1100}; // red draw two
                Deck_w[24] = {2'b00, 4'b1100};
                Deck_w[25] = {2'b00, 4'b1101}; // red wild
                Deck_w[26] = {2'b00, 4'b1110}; // red wild draw four
                
                Deck_w[27] = {2'b01, 4'b0000}; // yellow 0
                Deck_w[28] = {2'b01, 4'b0001}; // yellow 1
                Deck_w[29] = {2'b01, 4'b0001};
                Deck_w[30] = {2'b01, 4'b0010}; // yellow 2
                Deck_w[31] = {2'b01, 4'b0010};
                Deck_w[32] = {2'b01, 4'b0011}; // yellow 3
                Deck_w[33] = {2'b01, 4'b0011};
                Deck_w[34] = {2'b01, 4'b0100}; // yellow 4
                Deck_w[35] = {2'b01, 4'b0100};
                Deck_w[36] = {2'b01, 4'b0101}; // yellow 5
                Deck_w[37] = {2'b01, 4'b0101};
                Deck_w[38] = {2'b01, 4'b0110}; // yellow 6
                Deck_w[39] = {2'b01, 4'b0110};
                Deck_w[40] = {2'b01, 4'b0111}; // yellow 7
                Deck_w[41] = {2'b01, 4'b0111};
                Deck_w[42] = {2'b01, 4'b1000}; // yellow 8
                Deck_w[43] = {2'b01, 4'b1000};
                Deck_w[44] = {2'b01, 4'b1001}; // yellow 9
                Deck_w[45] = {2'b01, 4'b1001};
                Deck_w[46] = {2'b01, 4'b1010}; // yellow skip
                Deck_w[47] = {2'b01, 4'b1010};
                Deck_w[48] = {2'b01, 4'b1011}; // yellow reverse
                Deck_w[49] = {2'b01, 4'b1011};
                Deck_w[50] = {2'b01, 4'b1100}; // yellow draw two
                Deck_w[51] = {2'b01, 4'b1100};
                Deck_w[52] = {2'b01, 4'b1101}; // yellow wild
                Deck_w[53] = {2'b01, 4'b1110}; // yellow wild draw four

                Deck_w[54] = {2'b10, 4'b0000}; // green 0
                Deck_w[55] = {2'b10, 4'b0001}; // green 1
                Deck_w[56] = {2'b10, 4'b0001};
                Deck_w[57] = {2'b10, 4'b0010}; // green 2
                Deck_w[58] = {2'b10, 4'b0010};
                Deck_w[59] = {2'b10, 4'b0011}; // green 3
                Deck_w[60] = {2'b10, 4'b0011};
                Deck_w[61] = {2'b10, 4'b0100}; // green 4
                Deck_w[62] = {2'b10, 4'b0100};
                Deck_w[63] = {2'b10, 4'b0101}; // green 5
                Deck_w[64] = {2'b10, 4'b0101};
                Deck_w[65] = {2'b10, 4'b0110}; // green 6
                Deck_w[66] = {2'b10, 4'b0110};
                Deck_w[67] = {2'b10, 4'b0111}; // green 7
                Deck_w[68] = {2'b10, 4'b0111};
                Deck_w[69] = {2'b10, 4'b1000}; // green 8
                Deck_w[70] = {2'b10, 4'b1000};
                Deck_w[71] = {2'b10, 4'b1001}; // green 9
                Deck_w[72] = {2'b10, 4'b1001};
                Deck_w[73] = {2'b10, 4'b1010}; // green skip
                Deck_w[74] = {2'b10, 4'b1010};
                Deck_w[75] = {2'b10, 4'b1011}; // green reverse
                Deck_w[76] = {2'b10, 4'b1011};
                Deck_w[77] = {2'b10, 4'b1100}; // green draw two
                Deck_w[78] = {2'b10, 4'b1100};
                Deck_w[79] = {2'b10, 4'b1101}; // green wild
                Deck_w[80] = {2'b10, 4'b1110}; // green wild draw four

                Deck_w[81] = {2'b11, 4'b0000}; // blue 0
                Deck_w[82] = {2'b11, 4'b0001}; // blue 1
                Deck_w[83] = {2'b11, 4'b0001};
                Deck_w[84] = {2'b11, 4'b0010}; // blue 2
                Deck_w[85] = {2'b11, 4'b0010};
                Deck_w[86] = {2'b11, 4'b0011}; // blue 3
                Deck_w[87] = {2'b11, 4'b0011};
                Deck_w[88] = {2'b11, 4'b0100}; // blue 4
                Deck_w[89] = {2'b11, 4'b0100};
                Deck_w[90] = {2'b11, 4'b0101}; // blue 5
                Deck_w[91] = {2'b11, 4'b0101};
                Deck_w[92] = {2'b11, 4'b0110}; // blue 6
                Deck_w[93] = {2'b11, 4'b0110};
                Deck_w[94] = {2'b11, 4'b0111}; // blue 7
                Deck_w[95] = {2'b11, 4'b0111};
                Deck_w[96] = {2'b11, 4'b1000}; // blue 8
                Deck_w[97] = {2'b11, 4'b1000};
                Deck_w[98] = {2'b11, 4'b1001}; // blue 9
                Deck_w[99] = {2'b11, 4'b1001};
                Deck_w[100] = {2'b11, 4'b1010}; // blue skip
                Deck_w[101] = {2'b11, 4'b1010};
                Deck_w[102] = {2'b11, 4'b1011}; // blue reverse
                Deck_w[103] = {2'b11, 4'b1011};
                Deck_w[104] = {2'b11, 4'b1100}; // blue draw two
                Deck_w[105] = {2'b11, 4'b1100};
                Deck_w[106] = {2'b11, 4'b1101}; // blue wild
                Deck_w[107] = {2'b11, 4'b1110}; // blue wild draw four
            end
            S_IDLE: begin
                o_done = 1'b0;
                counter_w = counter_r + 1; // start counting
                if (start) begin
                    state_w = S_SHUFFLE;
                    lfsr_w = counter_r;
                end
                else if (!i_in_use) begin // if the deck is not in use, reset the deck
                    for (int i = 0; i < 108; i++) begin
                        Deck_w[i] = 0;
                    end
                    end_index_w = 0;
                    state_w = S_WAIT_INSERT;
                end
                else begin
                    state_w = S_IDLE;
                end
            end
            S_SHUFFLE: begin
                o_done = 1'b0;
                lfsr_w = {lfsr_r[3]^lfsr_r[0], lfsr_r[6], lfsr_r[5], lfsr_r[4], lfsr_r[3], lfsr_r[2], lfsr_r[1]};
                if(lfsr_w[6:0] > end_index) begin
                    state_w = S_SHUFFLE;// if rand_num > end_index , shuffle again
                end
                else begin
                    Deck_w[end_index_r] = Deck_r[lfsr_r[6:0]];
                    Deck_w[lfsr_r[6:0]] = Deck_r[end_index_r];
                    end_index_w = end_index_r - 1;
                    state_w = (end_index_r > 0) ? S_SHUFFLE : S_DRAW;
                    front_index_w = 6'd0;
                end
            end
            S_WAIT_INSERT: begin
                o_done = 1'b0;
                if(i_insert) state_w = S_INSERT;
                else state_w = i_in_use ? S_SHUFFLE : S_WAIT_INSERT;
            end
            S_INSERT: begin
                o_done = 1'b0;
                Deck_w[end_index_r] = i_insert_card;
                end_index_w = end_index_r + 1;
                state_w = S_WAIT_INSERT;
            end
            S_DRAW: begin
                o_done = 1'b1;
                o_next_card = Deck_r[front_index_r];
                if(i_draw1) begin           // draw one card
                    if(front_index_r >= end_index_r - 3) begin
                        empty_w = 1'b1;
                        front_index_w = front_index_r + 1;
                        remain_w = 2'b0;
                        state_w = S_SET;
                    end
                    else begin
                        empty_w = 1'b0;
                        front_index_w = front_index_r + 1;
                        state_w = S_DRAW;
                    end
                end
                else if(i_draw2) begin      // consecutive draw two
                    empty_w = 1'b0;
                    front_index_w = front_index_r + 1;
                    state_w = S_DRAW2;
                end
                else if(i_draw4) begin      // consecutive draw four
                    empty_w = 1'b0;
                    front_index_w = front_index_r + 1;
                    state_w = S_DRAW4_2;
                end
                else begin                  // wait draw
                    empty_w = 1'b0;
                    front_index_w = front_index_r;
                    state_w = S_DRAW;
                end
            end
            S_DRAW2: begin
                front_index_w = front_index_r + 1;
                if(front_index_r >= end_index_r - 3) begin
                    empty_w = 1'b1;
                    remain_w = 2'd0;
                    state_w = S_SET;
                end
                else begin
                    empty_w = 1'b0;
                    state_w = S_DRAW;
                end
            end
            S_DRAW4_2: begin
                empty_w = 1'b0;
                front_index_w = front_index_r + 1;
                state_w = S_DRAW4_3;
            end
            S_DRAW4_3: begin
                empty_w = 1'b0;
                front_index_w = front_index_r + 1;
                state_w = S_DRAW4_4;
            end
            S_DRAW4_4: begin
                front_index_w = front_index_r + 1;
                if(front_index_r >= end_index_r - 3) begin
                    empty_w = 1'b1;
                    remain_w = 2'd0;
                    state_w = S_SET;
                end
                else begin
                    empty_w = 1'b0;
                    state_w = S_DRAW;
                end
            end
            S_SET: begin // remove residual card to the front of the deck
                o_done = 1'b0;
                empty_w = 1'b1;
                Deck_w[remain] = Deck_r[front_index_r];
                if(front_index_r >= end_index_r) begin
                    end_index_w = remain_r + 1;
                    front_index_w = 7'd0;
                    remain_w = 2'd0;
                    state_w = S_WAIT_INSERT;
                end
                else begin
                    end_index_w = end_index_r;
                    front_index_w = front_index_r + 1;
                    remain_w = remain_r + 1;
                    state_w = S_SET;
                end
            end
        endcase
    end
    //----------------- sequential part -----------------//
    always_ff @(posedge i_clk or negedge i_rst_n) begin
        if (~i_rst_n) begin
            state_r <= S_INIT;
            for (int i = 0; i < 108; i++) begin
                Deck_r[i] <= 6'b0;
            end
            counter_r <= 7'b0;
            end_index_r <= 7'd'107;
            lfsr_r <= 7'b0;
            front_index_r <= 7'b0;
            empty_r <= 1'b0;
            remain_r <= 2'd0;
        end
        else begin
            state_r <= state_w;
            for (int i = 0; i < 108; i++) begin
                Deck_r[i] <= Deck_w[i];
            end
            counter_r <= counter_w;
            end_index_r <= end_index_w;
            lfsr_r <= lfsr_w;
            front_index_r <= front_index_w;
            empty_r <= empty_w;
            remain_r <= remain_w;
        end
    end
endmodule
