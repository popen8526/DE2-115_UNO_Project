// run command : vcs -R -sverilog tb_Computer.sv Computer.sv -sverilog -v +access+all -full64 -debug_access

`timescale 1ns/100ps

module tb;
	localparam CLK = 10;
	localparam HCLK = CLK/2;

	logic clk, rst;
	initial clk = 0;
	always #HCLK clk = ~clk;
    logic        init;
    logic        in_left, in_right, in_select;
    logic        p0_turn;
    logic [ 5:0] prev_card, p0_pcard;
    logic        p0_draw, draw2, draw4;
    logic        p0_play;
    logic        deck_idle;
    logic        card_drawn;
    logic [ 5:0] next_card;
    logic        p0_full;
    logic [ 6:0] p0_hands [14:0];
    logic [ 3:0] index;
	integer i, j;

	Player P0(
        .i_clk(clk),
        .i_rst_n(rst),
        .i_init(init),
        .i_left(in_left),
        .i_right(in_right),
        .i_select(in_select),
        .i_start(p0_turn),
        .i_prev_card(prev_card),
        .o_out_card(p0_pcard),
        .o_draw(p0_draw),
        .i_draw_two(draw2),
        .i_draw_four(draw4),
        .i_drawn(card_drawn),
        .i_check(deck_idle),
        .i_drawed_card(next_card),
        .o_out(p0_play),
        // .o_full(p0_full),
        .o_hands(p0_hands),
        .o_index(index)
    );

	initial begin
		$fsdbDumpfile("Player.fsdb");
        $fsdbDumpvars;
		$fsdbDumpvars(0, P0.red_hands_w);
        $fsdbDumpvars(0, P0.red_hands_r);
        $fsdbDumpvars(0, P0.yellow_hands_w);
        $fsdbDumpvars(0, P0.yellow_hands_r);
        $fsdbDumpvars(0, P0.green_hands_w);
        $fsdbDumpvars(0, P0.green_hands_r);
        $fsdbDumpvars(0, P0.blue_hands_w);
        $fsdbDumpvars(0, P0.blue_hands_r);
        $fsdbDumpvars(0, P0.wild_hands_w);
        $fsdbDumpvars(0, P0.wild_hands_r);
        $fsdbDumpvars(0, P0.wildf_hands_w);
        $fsdbDumpvars(0, P0.wildf_hands_r);
        $fsdbDumpvars(0, P0.hands_w);
        $fsdbDumpvars(0, P0.hands_r);
        card_drawn = 0;
        in_left = 0;
        in_right = 0;
        in_select = 0;
		rst = 1;
		#(2*CLK)
		rst = 0;
        p0_turn = 0;
        #(2*CLK)
        rst = 1;
        #(2*CLK)
        
        // initialization - draw 7 cards
        @(posedge clk)
        init = 1;
        @(posedge clk)
        init = 0;
        #(2*CLK)
        @(posedge clk)
        card_drawn = 1;
        next_card = 6'b000010; // red 2
		@(posedge clk)
        card_drawn = 0;
        #(CLK)
        @(posedge clk)
        card_drawn = 1;
        next_card = 6'b010100; // yellow 4
		@(posedge clk)
        card_drawn = 0;
        #(CLK)
        @(posedge clk)
        card_drawn = 1;
        next_card = 6'b101000; // green 8
		@(posedge clk)
        card_drawn = 0;
        #(CLK)
        @(posedge clk)
        card_drawn = 1;
        next_card = 6'b111011; // blue reverse
		@(posedge clk)
        card_drawn = 0;
        #(CLK)
        @(posedge clk)
        card_drawn = 1;
        next_card = 6'b000000; // red 0
		@(posedge clk)
        card_drawn = 0;
        #(CLK)
        @(posedge clk)
        card_drawn = 1;
        next_card = 6'b101000; // green 8
		@(posedge clk)
        card_drawn = 0;
        #(CLK)
        @(posedge clk)
        card_drawn = 1;
        next_card = 6'b011110; // wild draw 4
		@(posedge clk)
        card_drawn = 0;
        $display("========0========");
        $display("Initialize");
        $display("=================");
        // r2, r0, y4, g8, g8, br, w4 (at 0)

        // 1 : play card
        #(20*CLK)
        @(posedge clk)
		p0_turn = 1;
        prev_card = 6'b001000; // red 8
        @(posedge clk)
        in_select = 1;
        @(posedge clk)
        in_select = 0;
        @(posedge p0_play)
        $display("========1========");
        $display("Previous Card = %6b", prev_card);
        $display("Played Card   = %6b", p0_pcard);
        $display("Expected      = 000010");
        $display("=================");
        #(CLK)
        @(posedge clk)
        deck_idle = 1;
        p0_turn = 0;
        #(CLK)
        @(posedge clk)
        deck_idle = 0;
        // r0, y4, g8, g8, br, w4 (at 0)

        // 2 : right shift
        #(20*CLK)
        @(posedge clk)
		p0_turn = 1;
        prev_card = 6'b010000; // yellow 0
        @(posedge clk)
        in_right = 1;
        @(posedge clk)
        in_right = 0;
        #(CLK)
        @(posedge clk)
        in_select = 1;
        @(posedge clk)
        in_select = 0;
        @(posedge p0_play)
        $display("========2========");
        $display("Previous Card = %6b", prev_card);
        $display("Played Card   = %6b", p0_pcard);
        $display("Expected      = 010100");
        $display("=================");
        #(CLK)
        @(posedge clk)
        deck_idle = 1;
        p0_turn = 0;
        #(CLK)
        @(posedge clk)
        deck_idle = 0;
        // r0, g8, g8, br, w4 (at 1)

        // 3 : left shift
        #(20*CLK)
        @(posedge clk)
		p0_turn = 1;
        prev_card = 6'b110000; // blue 0
        @(posedge clk)
        in_left = 1;
        @(posedge clk)
        in_left = 0;
        #(CLK)
        @(posedge clk)
        in_select = 1;
        @(posedge clk)
        in_select = 0;
        @(posedge p0_play)
        $display("========3========");
        $display("Previous Card = %6b", prev_card);
        $display("Played Card   = %6b", p0_pcard);
        $display("Expected      = 000000");
        $display("=================");
        #(CLK)
        @(posedge clk)
        deck_idle = 1;
        p0_turn = 0;
        #(CLK)
        @(posedge clk)
        deck_idle = 0;
        // g8, g8, br, w4 (at 0)

        // 4 : card is not playable
        #(20*CLK)
        @(posedge clk)
		p0_turn = 1;
        prev_card = 6'b110011; // blue 3
        @(posedge clk)
        in_select = 1;
        @(posedge clk)
        in_select = 0;
        #(3*CLK)
        @(posedge clk)
        in_right = 1;
        @(posedge clk)
        in_right = 0;
        #(CLK)
        @(posedge clk)
        in_right = 1;
        @(posedge clk)
        in_right = 0;
        #(CLK)
        @(posedge clk)
        in_select = 1;
        @(posedge clk)
        in_select = 0;
        @(posedge p0_play)
        $display("========4========");
        $display("Previous Card = %6b", prev_card);
        $display("Played Card   = %6b", p0_pcard);
        $display("Expected      = 111011");
        $display("=================");
        #(CLK)
        @(posedge clk)
        deck_idle = 1;
        p0_turn = 0;
        #(CLK)
        @(posedge clk)
        deck_idle = 0;
        // g8, g8, w4 (at 2)

        // 5 : player draw
        #(20*CLK)
        @(posedge clk)
		p0_turn = 1;
        prev_card = 6'b001001; // red 9
        deck_idle = 1;
        #(CLK)
        @(posedge clk)
        in_right = 1;
        @(posedge clk)
        in_right = 0;
        #(CLK)
        @(posedge clk)
        in_select = 1;
        @(posedge p0_draw)
        in_select = 0;
        #(CLK)
        @(posedge clk)
        card_drawn = 1;
        next_card = 6'b010101; // yellow 5
		@(posedge clk)
        card_drawn = 0;
        $display("========5========");
        $display("Card Drawn");
        $display("=================");
        #(CLK)
        @(posedge clk)
        deck_idle = 1;
        p0_turn = 0;
        #(CLK)
        @(posedge clk)
        deck_idle = 0;
        // y5, g8, g8, w4 (at draw)

        // 6 : draw 2
        #(20*CLK)
        @(posedge clk)
		p0_turn = 1;
        draw2 = 1;
        prev_card = 6'b111000; // blue 8
        @(posedge clk)
        draw2 = 0;
        #(CLK)
        @(posedge clk)
        card_drawn = 1;
        next_card = 6'b001001; // red 9
		@(posedge clk)
        card_drawn = 0;
        #(2*CLK)
        @(posedge clk)
        card_drawn = 1;
        next_card = 6'b010011; // yellow 3
		@(posedge clk)
        card_drawn = 0;
        #(2*CLK)
        @(posedge clk)
        in_left = 1;
        @(posedge clk)
        in_left = 0;
        #(CLK)
        @(posedge clk)
        in_left = 1;
        @(posedge clk)
        in_left = 0;
        #(CLK)
        @(posedge clk)
        in_select = 1;
        @(posedge clk)
        in_select = 0;
        @(posedge p0_play)
        $display("========6========");
        $display("Previous Card = %6b", prev_card);
        $display("Played Card   = %6b", p0_pcard);
        $display("Expected      = 101000");
        $display("=================");
        #(CLK)
        @(posedge clk)
        deck_idle = 1;
        p0_turn = 0;
        #(CLK)
        @(posedge clk)
        deck_idle = 0;
        // r9, y5, y3, g8, w4 (at 4)

        // 7 : draw 4
        #(20*CLK)
        @(posedge clk)
		p0_turn = 1;
        draw4 = 1;
        prev_card = 6'b010101; // yellow 5
        #(CLK)
        @(posedge clk)
        draw4 = 0;
        #(CLK)
        @(posedge clk)
        card_drawn = 1;
        next_card = 6'b001101; // wild
		@(posedge clk)
        card_drawn = 0;
        #(2*CLK)
        @(posedge clk)
        card_drawn = 1;
        next_card = 6'b000111; // red 7
		@(posedge clk)
        card_drawn = 0;
        #(2*CLK)
        @(posedge clk)
        card_drawn = 1;
        next_card = 6'b010000; // yellow 0
		@(posedge clk)
        card_drawn = 0;
        #(2*CLK)
        @(posedge clk)
        card_drawn = 1;
        next_card = 6'b110001; // blue 1
		@(posedge clk)
        card_drawn = 0;
        #(2*CLK)
        @(posedge clk)
        in_select = 1;
        @(posedge clk)
        in_select = 0;
        @(posedge p0_play)
        $display("========7========");
        $display("Previous Card = %6b", prev_card);
        $display("Played Card   = %6b", p0_pcard);
        $display("Expected      = 010000");
        $display("=================");
        #(CLK)
        @(posedge clk)
        deck_idle = 1;
        p0_turn = 0;
        #(CLK)
        @(posedge clk)
        deck_idle = 0;
        // r9, r7, y5, y3, g8, b1, wd, w4 (at 4)

        // 8 : play wild
        #(20*CLK)
        @(posedge clk)
		p0_turn = 1;
        prev_card = 6'b100001; // green 1
        #(2*CLK)
        @(posedge clk)
        in_right = 1;
        @(posedge clk)
        in_right = 0;
        #(CLK)
        @(posedge clk)
        in_right = 1;
        @(posedge clk)
        in_right = 0;
        #(CLK)
        @(posedge clk)
        in_select = 1;
        @(posedge clk)
        in_select = 0;
        #(5*CLK)
        @(posedge clk)
        in_right = 1;
        @(posedge clk)
        in_right = 0;
        #(CLK)
        @(posedge clk)
        in_select = 1;
        @(posedge clk)
        in_select = 0;
        @(posedge p0_play)
        $display("========8========");
        $display("Previous Card = %6b", prev_card);
        $display("Played Card   = %6b", p0_pcard);
        $display("Expected      = 011101");
        $display("=================");
        #(CLK)
        @(posedge clk)
        deck_idle = 1;
        p0_turn = 0;
        #(CLK)
        @(posedge clk)
        deck_idle = 0;
        // r9, r7, y5, y3, g8, b1, w4 (at 0)
        
        @(posedge clk)
		$finish;
	end

	initial begin
		#(1000*CLK)
		$display("Too slow, abort.");
		$finish;
	end

endmodule
