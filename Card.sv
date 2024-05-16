// recording the remaining cards in the deck
// 6 bits: 2 bits for color, 4 bits for value
// 0: red, 1: yellow, 2: green, 3: blue
// 0: 0, 1: 1, 2: 2, 3: 3, 4: 4, 5: 5, 6: 6, 7: 7, 8: 8, 9: 9
// 10: skip, 11: reverse, 12: draw two, 13: wild, 14: wild draw four

module Card(clk, reset, start, color, o_Deck); 
    //----------------- port definition -----------------//
    input clk, reset, start;
    input [1:0] color;
    output [5:0] o_Deck [107:0];

    //----------------- fsm state definition -----------------//
    localparam  S_IDLE = 1'b0, S_SHUFFLE = 1'b1;
    //----------------- wire connection -----------------//
    logic [3:0] value;

    //----------------- sequential signal definition -----------------//
    logic [5:0] Deck_w [107:0];
    logic [5:0] Deck_r [107:0]; // 108 cards in the deck
    logic [6:0] counter_w, counter_r;
    logic [6:0] lfsr_w, lfsr_r; // Add LFSR registers
    logic [1:0] state_w, state_r;
    logic [6:0] end_index_w, end_index_r;

    assign o_Deck = Deck_r;
    //----------------- combinational part -----------------//
    always_comb begin : 
        counter_w = counter_r;
        lfsr_w = lfsr_r;
        state_w = state_r;
        end_index_w = end_index_r;
        case(state_r)
            S_IDLE: begin
                counter_w = counter_r + 1; // start counting
                for (int i = 0; i < 108; i++) begin
                    Deck_w[i] <= i;
                end
                if (start) begin
                    state_w = S_SHUFFLE;
                    lfsr_w = counter_r;
                end
                else begin
                    state_w = S_IDLE;
                end
            end
            S_SHUFFLE: begin
                lfsr_w = {lfsr_r[3]^lfsr_r[0], lfsr_r[6], lfsr_r[5], lfsr_r[4], lfsr_r[3], lfsr_r[2], lfsr_r[1]};
                if(lfsr[6:0] > end_index) begin
                    state_w = S_SHUFFLE;// if rand_num > end_index , shuffle again
                end
                else begin
                    Deck_w[end_index_r] = Deck_r[lfsr_r[6:0]];
                    Deck_w[lfsr_r[6:0]] = Deck_r[end_index_r];
                    end_index_w = end_index_r - 1;
                    state_w = (end_index_r > 0) ? S_SHUFFLE : S_IDLE;
                end
            end
        endcase
    end
    //----------------- sequential part -----------------//
    always_ff @(posedge i_clk or negedge i_rst_n) begin
        if (~i_rst_n) begin
            state_r <= S_IDLE;
            for (int i = 0; i < 108; i++) begin
                Deck_r[i] <= 6'b0;
            end
            counter_r <= 7'b0;
            end_index_r <= 7'd'107;
            lfsr_r <= 7'b0;
        end
        else begin
            state_r <= state_w;
            for (int i = 0; i < 108; i++) begin
                Deck_r[i] <= Deck_w[i];
            end
            counter_r <= counter_w;
            end_index_r <= end_index_w;
            lfsr_r <= lfsr_w;
        end
    end
endmodule