module Player(i_clk, i_rst_n, i_init, i_left, i_right, i_select, i_start, i_prev_card, o_draw, o_out_card, i_draw_two, i_draw_four, i_drawn, i_check, i_drawed_card, o_out, o_hands, o_index);
    //----------------- port definition -----------------//
    input i_clk, i_rst_n, i_init, i_left, i_right, i_select, i_start, i_draw_two, i_draw_four, i_drawn, i_check;
    input [5:0] i_prev_card;
    output [5:0] o_out_card; // output cards
    output       o_draw; // player decide to draw a card
    output [5:0] o_hands [14:0]; // the player's hand
    output      o_out; // decide whether to play a card
    input [5:0] i_drawed_card; // the card that the player drawed
    // output      o_full; // player has 20 cards
    output [3:0] o_index; // current index of hand
    //----------------- fsm state definition -----------------//
    // states for main FSM
    localparam S_IDLE = 4'b0000, S_DRAW = 4'b0001, S_OUT = 4'b0010, S_PLAY = 4'b0011, S_SEARCHR = 4'b0100, S_SEARCHY = 4'b0101, S_SEARCHG = 4'b0110, S_SEARCHB = 4'b0111;
    localparam S_NOCARD = 4'b1000, S_CHECK = 4'b1001, S_CHOOSE = 4'b1010;
    // states for hands update
    localparam S_HOLD = 1'b0, S_SORT = 1'b1;
    // states for current hand index
    localparam S_STAY = 2'b00, S_LEFT = 2'b01, S_RIGHT = 2'b10, S_COLOR = 2'b11;
    //----------------- sequential signal definition -----------------//
    logic [5:0] red_hands_w [24:0];
    logic [5:0] red_hands_r [24:0];
    logic [5:0] blue_hands_w [24:0];
    logic [5:0] blue_hands_r [24:0];
    logic [5:0] green_hands_w [24:0];
    logic [5:0] green_hands_r [24:0];
    logic [5:0] yellow_hands_w [24:0];
    logic [5:0] yellow_hands_r [24:0];
    logic [5:0] wild_hands_w [3:0];
    logic [5:0] wild_hands_r [3:0];
    logic [5:0] wildf_hands_w [3:0];
    logic [5:0] wildf_hands_r [3:0];
    logic [5:0] hands_w [107:0];
    logic [5:0] hands_r [107:0];

    logic [4:0] red_num_w, red_num_r, blue_num_w, blue_num_r, green_num_w, green_num_r, yellow_num_w, yellow_num_r;
    logic [1:0] wild_num_w, wild_num_r, wildf_num_w, wildf_num_r;
    logic [5:0] out_card_w, out_card_r;
    logic [3:0] state_w, state_r;
    logic       state_hands_w, state_hands_r;
    logic [1:0] state_index_w, state_index_r;
    logic [3:0] index_w, index_r;
    logic [2:0] draw_num_w, draw_num_r;
    logic [3:0] iter_w, iter_r;
    logic       sort_w, sort_r;
    logic       out;
    logic       draw_card;
    logic       select_color;

    logic [3:0] lfsr_w, lfsr_r;

    integer i, j, k;
    //----------------- wire connection -----------------//
    genvar x;
    generate
        for(x=0; x<15; x++) begin
            assign o_hands[x] = hands_r[x];
        end
    endgenerate
    assign o_out = out;
    assign o_draw = draw_card;
    assign o_out_card = out_card_r;
    // assign o_full = ((red_num_r + yellow_num_r + green_num_r + blue_num_r + wild_num_r + wildf_num_r) >= 4'd15);
    assign o_index = index_r;
    //----------------- combinational part -----------------//
    always_comb begin
        for(i = 0; i < 15; i = i + 1) begin
            red_hands_w[i] = red_hands_r[i];
            blue_hands_w[i] = blue_hands_r[i];
            green_hands_w[i] = green_hands_r[i];
            yellow_hands_w[i] = yellow_hands_r[i];
        end
        for(i = 0; i < 4; i = i + 1) begin
            wild_hands_w[i] = wild_hands_r[i];
            wildf_hands_w[i] = wildf_hands_r[i];
        end
        red_num_w = red_num_r;
        blue_num_w = blue_num_r;
        green_num_w = green_num_r;
        yellow_num_w = yellow_num_r;
        wild_num_w = wild_num_r;
        wildf_num_w = wildf_num_r;
        out_card_w = out_card_r;
        draw_num_w = 3'd0;
        iter_w = 3'd0;
        sort_w = 1'b0;
        lfsr_w = {lfsr_r[0]^lfsr_r[1], lfsr_r[3], lfsr_r[2], lfsr_r[1]};
        case(state_r)
            S_IDLE: begin
                select_color = 1'b0;
                iter_w = 4'd0;
                out = 1'b0;
                draw_card = 1'b0;
                if(i_start) begin // if it's the player's turn
                    if(i_draw_two) begin
                        state_w = S_DRAW;
                        draw_num_w = 3'd2;
                    end
                    else if(i_draw_four) begin
                        state_w = S_DRAW;
                        draw_num_w = 3'd4;
                    end
                    else begin
                        state_w = S_PLAY;
                        draw_num_w = 3'd0;
                    end
                end
                else if(i_init) begin // if it's the initial hands
                    state_w = S_DRAW;
                    draw_num_w = 3'd7;
                end
                else begin
                    state_w = S_IDLE;
                end
            end
            S_DRAW: begin
                iter_w = 4'd0;
                out = 1'b0;
                draw_card = 1'b0;
                select_color = 1'b0;
                if(i_drawn) begin
                    if(draw_num_r <= 1) begin
                        state_w = (i_start) ? S_PLAY : S_IDLE;
                        sort_w = 1'b1;
                        draw_num_w = 3'd0;
                    end
                    else begin
                        state_w = S_DRAW;
                        sort_w = 1'b0;
                        draw_num_w = draw_num_r - 1;
                    end
                    if(i_drawed_card[3:0] == 4'b1101) begin // if the card is wild
                        wild_hands_w[wild_num_r] = i_drawed_card;
                        wild_num_w = wild_num_r + 1;
                    end
                    else if (i_drawed_card[3:0] == 4'b1110) begin // if the card is wild draw four
                        wildf_hands_w[wildf_num_r] = i_drawed_card;
                        wildf_num_w = wildf_num_r + 1;
                    end
                    else begin
                        case(i_drawed_card[5:4])
                            2'b00: begin // red
                                red_hands_w[red_num_r] = i_drawed_card;
                                red_num_w = red_num_r + 1;
                            end
                            2'b01: begin // yellow
                                yellow_hands_w[yellow_num_r] = i_drawed_card;
                                yellow_num_w = yellow_num_r + 1;
                            end
                            2'b10: begin // green
                                green_hands_w[green_num_r] = i_drawed_card;
                                green_num_w = green_num_r + 1;
                            end
                            2'b11: begin // blue
                                blue_hands_w[blue_num_r] = i_drawed_card;
                                blue_num_w = blue_num_r + 1;
                            end
                        endcase
                    end
                end
                else begin
                    state_w = S_DRAW;
                    sort_w = 1'b0;
                    draw_num_w = draw_num_r;
                end
            end
            S_OUT: begin
                iter_w = 4'd0;
                out = 1'b1; // play the card
                sort_w = 1'b0;
                select_color = 1'b0;
                draw_card = 1'b0;
                out_card_w = out_card_r;
                if(i_check)   state_w = S_IDLE;
                else            state_w = S_OUT;
            end
            S_PLAY: begin
                iter_w = 4'd0;
                sort_w = 1'b0;
                select_color = 1'b0;
                out = 1'b0;
                draw_card = 1'b0;
                if(i_select) begin
                    if(index_r == 4'd15) begin
                        state_w = S_NOCARD;
                        out_card_w = out_card_r;
                    end
                    else begin
                        if(hands_r[index_r][3:0] == 4'd13 || hands_r[index_r][3:0] == 4'd14) begin
                            state_w = S_CHOOSE;
                            out_card_w = {2'b00, hands_r[index_r][3:0]};
                        end
                        else if(hands_r[index_r][5:4] == i_prev_card[5:4] || hands_r[index_r][3:0] == i_prev_card[3:0]) begin
                            case (hands_r[index_r][5:4])
                                2'b00:  state_w = S_SEARCHR;
                                2'b01:  state_w = S_SEARCHY;
                                2'b10:  state_w = S_SEARCHG;
                                2'b11:  state_w = S_SEARCHB;
                            endcase
                            out_card_w = out_card_r;
                        end
                        else begin
                            state_w = S_PLAY;
                            out_card_w = out_card_r;
                        end
                    end
                end
                else begin
                    state_w = S_PLAY;
                    out_card_w = out_card_r;
                end
            end
            S_SEARCHR: begin
                select_color = 1'b0;
                out = 1'b0;
                draw_card = 1'b0;
                if(red_hands_r[iter_r][3:0] == hands_r[index_r][3:0]) begin
                    state_w = S_OUT;
                    sort_w = 1'b1;
                    iter_w = 0;
                    for(i=iter_r; i<red_num_r; i++) begin
                        red_hands_w[iter_r] = red_hands_r[iter_r+1];
                    end
                    red_num_w = red_num_r - 1;
                    out_card_w = red_hands_r[iter_r];
                end
                else begin
                    state_w = S_SEARCHR;
                    sort_w = 1'b0;
                    iter_w = iter_r + 1;
                    red_num_w = red_num_r;
                    out_card_w = out_card_r;
                end
            end
            S_SEARCHY: begin
                select_color = 1'b0;
                out = 1'b0;
                draw_card = 1'b0;
                if(yellow_hands_r[iter_r][3:0] == hands_r[index_r][3:0]) begin
                    state_w = S_OUT;
                    sort_w = 1'b1;
                    iter_w = 0;
                    for(i=iter_r; i<yellow_num_r; i++) begin
                        yellow_hands_w[iter_r] = yellow_hands_r[iter_r+1];
                    end
                    yellow_num_w = yellow_num_r - 1;
                    out_card_w = yellow_hands_r[iter_r];
                end
                else begin
                    state_w = S_SEARCHY;
                    sort_w = 1'b0;
                    iter_w = iter_r + 1;
                    yellow_num_w = yellow_num_r;
                    out_card_w = out_card_r;
                end
            end
            S_SEARCHG: begin
                select_color = 1'b0;
                out = 1'b0;
                draw_card = 1'b0;
                if(green_hands_r[iter_r][3:0] == hands_r[index_r][3:0]) begin
                    state_w = S_OUT;
                    sort_w = 1'b1;
                    iter_w = 0;
                    for(i=iter_r; i<green_num_r; i++) begin
                        green_hands_w[iter_r] = green_hands_r[iter_r+1];
                    end
                    green_num_w = green_num_r - 1;
                    out_card_w = green_hands_r[iter_r];
                end
                else begin
                    state_w = S_SEARCHG;
                    sort_w = 1'b0;
                    iter_w = iter_r + 1;
                    green_num_w = green_num_r;
                    out_card_w = out_card_r;
                end
            end
            S_SEARCHB: begin
                select_color = 1'b0;
                out = 1'b0;
                draw_card = 1'b0;
                if(blue_hands_r[iter_r][3:0] == hands_r[index_r][3:0]) begin
                    state_w = S_OUT;
                    sort_w = 1'b1;
                    iter_w = 0;
                    for(i=iter_r; i<blue_num_r; i++) begin
                        blue_hands_w[iter_r] = blue_hands_r[iter_r+1];
                    end
                    blue_num_w = blue_num_r - 1;
                    out_card_w = blue_hands_r[iter_r];
                end
                else begin
                    state_w = S_SEARCHB;
                    sort_w = 1'b0;
                    iter_w = iter_r + 1;
                    blue_num_w = blue_num_r;
                    out_card_w = out_card_r;
                end
            end
            S_NOCARD: begin
                select_color = 1'b0;
                out = 1'b0;
                draw_card = 1'b1;
                if(i_drawn) begin
                    state_w = S_CHECK;
                    if(i_drawed_card[3:0] == 4'b1101) begin // if the card is wild
                        wild_hands_w[wild_num_r] = i_drawed_card;
                        wild_num_w = wild_num_r + 1;
                    end
                    else if (i_drawed_card[3:0] == 4'b1110) begin // if the card is wild draw four
                        wildf_hands_w[wildf_num_r] = i_drawed_card;
                        wildf_num_w = wildf_num_r + 1;
                    end
                    else begin
                        case(i_drawed_card[5:4])
                            2'b00: begin // red
                                red_hands_w[red_num_r] = i_drawed_card;
                                red_num_w = red_num_r + 1;
                            end
                            2'b01: begin // yellow
                                yellow_hands_w[yellow_num_r] = i_drawed_card;
                                yellow_num_w = yellow_num_r + 1;
                            end
                            2'b10: begin // green
                                green_hands_w[green_num_r] = i_drawed_card;
                                green_num_w = green_num_r + 1;
                            end
                            2'b11: begin // blue
                                blue_hands_w[blue_num_r] = i_drawed_card;
                                blue_num_w = blue_num_r + 1;
                            end
                        endcase
                    end
                end
                else begin
                    state_w = S_NOCARD;
                    draw_num_w = draw_num_r;
                end
            end
            S_CHECK: begin
                select_color = 1'b0;
                out = 1'b0;
                draw_card = 1'b0;
                state_w = (i_check) ? S_IDLE : S_CHECK;
            end
            S_CHOOSE: begin
                select_color = 1'b1;
                out = 1'b0;
                draw_card = 1'b0;
                if(i_select) begin
                    state_w = S_OUT;
                    out_card_w = {index_r[1:0], out_card_r[3:0]};
                end
                else begin
                    state_w = S_CHOOSE;
                    out_card_w = out_card_r;
                end
            end
            default: begin
                select_color = 1'b0;
                out = 1'b0;
                draw_card = 1'b0;
                state_w = S_IDLE;
            end
        endcase
    end
    always_comb begin
        case (state_hands_r)
            S_HOLD: begin
                for(j=0; j<15; j++) begin
                    hands_w[j] = hands_r[j];
                end
                if(sort_r)  state_hands_w = S_SORT;
                else        state_hands_w = S_HOLD;
            end
            S_SORT: begin
                for(j=0; j<red_num_r; j++) begin
                    hands_w[j] = red_hands_r[j];
                end
                for(j=0; j<yellow_num_r; j++) begin
                    hands_w[red_num_r + j] = yellow_hands_r[j];
                end
                for(j=0; j<green_num_r; j++) begin
                    hands_w[red_num_r + yellow_num_r + j] = green_hands_r[j];
                end
                for(j=0; j<blue_num_r; j++) begin
                    hands_w[red_num_r + yellow_num_r + green_num_r + j] = blue_hands_r[j];
                end
                for(j=0; j<wild_num_r; j++) begin
                    hands_w[red_num_r + yellow_num_r + green_num_r + blue_num_r + j] = wild_hands_r[j];
                end
                for(j=0; j<wildf_num_r; j++) begin
                    hands_w[red_num_r + yellow_num_r + green_num_r + blue_num_r + wild_num_r + j] = wildf_hands_r[j];
                end
                for(j=red_num_r+yellow_num_r+green_num_r+blue_num_r+wild_num_r+wildf_num_r; j<108; j++) begin
                    hands_w[j] = 6'b111111;
                end
                state_hands_w = S_HOLD;
            end
        endcase
    end
    always_comb begin
        case (state_index_r)
            S_STAY: begin
                if(select_color) begin
                    index_w = 4'b0;
                    state_index_w = S_COLOR;
                end
                else if(i_left) begin
                    if(index_r == 4'd0)         index_w = 4'd15;
                    else if(index_r == 4'd15)   index_w = (red_num_r + yellow_num_r + green_num_r + blue_num_r + wild_num_r + wildf_num_r - 1);
                    else                        index_w = index_r - 1;
                    state_index_w = S_LEFT;
                end
                else if(i_right) begin
                    if(index_r == (red_num_r + yellow_num_r + green_num_r + blue_num_r + wild_num_r + wildf_num_r - 1)) index_w = 4'd15;
                    else if(index_r == 4'd15)                                                                           index_w = 4'd0;
                    else                                                                                                index_w = index_r + 1;
                    state_index_w = S_RIGHT;
                end
                else begin
                    if(index_r == 4'd15)    index_w = index_r;
                    else if (index_r > (red_num_r + yellow_num_r + green_num_r + blue_num_r + wild_num_r + wildf_num_r - 1))    index_w = (red_num_r + yellow_num_r + green_num_r + blue_num_r + wild_num_r + wildf_num_r - 1);
                    else index_w = index_r;
                    state_index_w = S_STAY;
                end
            end
            S_LEFT: begin
                index_w = index_r;
                if(!i_left)     state_index_w = (select_color) ? S_COLOR : S_STAY;
                else            state_index_w = S_LEFT;
            end
            S_RIGHT: begin
                index_w = index_r;
                if(!i_right)    state_index_w = (select_color) ? S_COLOR : S_STAY;
                else            state_index_w = S_RIGHT;
            end
            S_COLOR: begin
                if(select_color) begin
                    if(i_left) begin
                        index_w = (index_r == 4'd0) ? 4'd3 : index_r - 1;
                        state_index_w = S_LEFT;
                    end
                    else if(i_right) begin
                        index_w = (index_r == 4'd3) ? 4'd0 : index_r + 1;
                        state_index_w = S_RIGHT;
                    end
                    else begin
                        index_w = index_r;
                        state_index_w = S_COLOR;
                    end
                end
                else begin
                    index_w = 4'd0;
                    state_index_w = S_STAY;
                end
            end
        endcase
    end
    //----------------- sequential part -----------------//
    always_ff @(posedge i_clk or negedge i_rst_n) begin
        if(!i_rst_n) begin
            state_r <= S_IDLE;
            state_hands_r <= S_HOLD;
            state_index_r <= S_STAY;
            index_r <= 4'd0;
            for(k = 0; k < 108; k = k + 1) begin
                hands_r[k] <= 6'b111111;
            end
            for(k = 0; k < 25; k = k + 1) begin
                red_hands_r[k] <= 6'b111111;
                blue_hands_r[k] <= 6'b111111;
                green_hands_r[k] <= 6'b111111;
                yellow_hands_r[k] <= 6'b111111;
            end
            for(k = 0; k < 4; k = k + 1) begin
                wild_hands_r[k] <= 6'b111111;
                wildf_hands_r[k] <= 6'b111111;
            end
            red_num_r <= 5'b0;
            blue_num_r <= 5'b0;
            green_num_r <= 5'b0;
            yellow_num_r <= 5'b0;
            wild_num_r <= 2'b0;
            wildf_num_r <= 2'b0;
            draw_num_r <= 3'd0;
            out_card_r <= 6'b000000;
            iter_r <= 4'd0;
            lfsr_r <= 4'b0110;
            sort_r <= 1'b0;
        end
        else begin
            state_r <= state_w;
            state_hands_r <= state_hands_w;
            state_index_r <= state_index_w;
            index_r <= index_w;
            for(k = 0; k < 108; k = k + 1) begin
                hands_r[k] <= hands_w[k];
            end
            for(k = 0; k < 25; k = k + 1) begin
                red_hands_r[k] <= red_hands_w[k];
                blue_hands_r[k] <= blue_hands_w[k];
                green_hands_r[k] <= green_hands_w[k];
                yellow_hands_r[k] <= yellow_hands_w[k];
            end
            for(k = 0; k < 4; k = k + 1) begin
                wild_hands_r[k] <= wild_hands_w[k];
                wildf_hands_r[k] <= wildf_hands_w[k];
            end
            red_num_r <= red_num_w;
            blue_num_r <= blue_num_w;
            green_num_r <= green_num_w;
            yellow_num_r <= yellow_num_w;
            wild_num_r <= wild_num_w;
            wildf_num_r <= wildf_num_w;
            draw_num_r <= draw_num_w;
            out_card_r <= out_card_w;
            iter_r <= iter_w;
            lfsr_r <= lfsr_w;
            sort_r <= sort_w;
        end
    end
endmodule
