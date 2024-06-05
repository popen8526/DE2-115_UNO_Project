// run command : vcs -R -sverilog tb_Computer.sv Computer.sv -sverilog -v +access+all -full64 -debug_access

`timescale 1ns/100ps

module tb;
	localparam CLK = 10;
	localparam HCLK = CLK/2;

	logic clk, rst;
	initial clk = 0;
	always #HCLK clk = ~clk;
    logic        init;
    logic        insert;
    logic        com0_turn;
    logic [ 5:0] prev_card, com0_pcard;
    logic        com0_draw, draw2, draw4;
    logic        com0_play;
    logic        deck_idle;
    logic        card_drawn;
    logic [ 5:0] next_card;
	integer i, j;

	Computer COM0(
        .i_clk(clk),
        .i_rst_n(rst),
        .i_init(init),
        .i_start(com0_turn),
        .i_prev_card(prev_card),
        .o_out_card(com0_pcard),
        .o_draw_card(com0_draw),
        .i_draw_two(draw2),
        .i_draw_four(draw4),
        .i_drawn(card_drawn),
        .i_check(deck_idle),
        .i_drawed_card(next_card),
        .o_out(com0_play)
    );

	initial begin
		$fsdbDumpfile("Computer.fsdb");
		$fsdbDumpvars;
        insert = 0;
        card_drawn = 0;
		rst = 1;
		#(2*CLK)
		rst = 0;
        com0_turn = 0;
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
        // r0, r2, y4, g8, g8, br, w4

        // 1 : check color
        #(20*CLK)
        @(posedge clk)
		com0_turn = 1;
        prev_card = 6'b010001; // yellow 1
        @(posedge com0_play)
        $display("========1========");
        $display("Previous Card = %6b", prev_card);
        $display("Played Card   = %6b", com0_pcard);
        $display("Expected      = 010100");
        $display("=================");
        #(CLK)
        @(posedge clk)
        deck_idle = 1;
        com0_turn = 0;
        #(CLK)
        @(posedge clk)
        deck_idle = 0;
        // r0, r2, g8, g8, br, w4

        // 2 : check number
        #(20*CLK)
        @(posedge clk)
		com0_turn = 1;
        prev_card = 6'b010000; // yellow 0
        @(posedge com0_play)
        $display("========2========");
        $display("Previous Card = %6b", prev_card);
        $display("Played Card   = %6b", com0_pcard);
        $display("Expected      = 000000");
        $display("=================");
        #(CLK)
        @(posedge clk)
        deck_idle = 1;
        com0_turn = 0;
        #(CLK)
        @(posedge clk)
        deck_idle = 0;
        // r2, g8, g8, br, w4

        // 3 : no card - play wild
        #(20*CLK)
        @(posedge clk)
		com0_turn = 1;
        prev_card = 6'b010011; // yellow 3
        @(posedge com0_play)
        $display("========3========");
        $display("Previous Card = %6b", prev_card);
        $display("Played Card   = %6b", com0_pcard);
        $display("Expected      = XX1110");
        $display("=================");
        #(CLK)
        @(posedge clk)
        deck_idle = 1;
        com0_turn = 0;
        #(CLK)
        @(posedge clk)
        deck_idle = 0;
        // r2, g8, g8, br

        // 4 : no card - draw
        #(20*CLK)
        @(posedge clk)
		com0_turn = 1;
        prev_card = 6'b010000; // yellow 0
        deck_idle = 1;
        @(posedge com0_draw)
        #(CLK)
        @(posedge clk)
        card_drawn = 1;
        next_card = 6'b010101; // yellow 5
		@(posedge clk)
        card_drawn = 0;
        $display("========4========");
        $display("Card Drawn");
        $display("=================");
        #(CLK)
        @(posedge clk)
        deck_idle = 1;
        com0_turn = 0;
        #(CLK)
        @(posedge clk)
        deck_idle = 0;
        // r2, y5, g8, g8, br

        // 5 : draw 2
        #(20*CLK)
        @(posedge clk)
		com0_turn = 1;
        draw2 = 1;
        prev_card = 6'b110110; // blue 6
        #(CLK)
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
        @(posedge com0_play)
        $display("========5========");
        $display("Previous Card = %6b", prev_card);
        $display("Played Card   = %6b", com0_pcard);
        $display("Expected      = 111011");
        $display("=================");
        #(CLK)
        @(posedge clk)
        deck_idle = 1;
        com0_turn = 0;
        #(CLK)
        @(posedge clk)
        deck_idle = 0;
        // r2, r9, y3, y5, g8, g8

        // 6 : draw 4
        #(20*CLK)
        @(posedge clk)
		com0_turn = 1;
        draw4 = 1;
        prev_card = 6'b110000; // blue 0
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
        next_card = 6'b010001; // yellow 1
		@(posedge clk)
        card_drawn = 0;
        @(posedge com0_play)
        $display("========6========");
        $display("Previous Card = %6b", prev_card);
        $display("Played Card   = %6b", com0_pcard);
        $display("Expected      = 010000");
        $display("=================");
        #(CLK)
        @(posedge clk)
        deck_idle = 1;
        com0_turn = 0;
        #(CLK)
        @(posedge clk)
        deck_idle = 0;
        // r2, r7, r9, y1, y3, y5, g8, g8, wd

        // 7 : two same cards
        #(20*CLK)
        @(posedge clk)
		com0_turn = 1;
        prev_card = 6'b100001; // green 1
        @(posedge com0_play)
        $display("========7========");
        $display("Previous Card = %6b", prev_card);
        $display("Played Card   = %6b", com0_pcard);
        $display("Expected      = 101000");
        $display("=================");
        #(CLK)
        @(posedge clk)
        deck_idle = 1;
        com0_turn = 0;
        #(CLK)
        @(posedge clk)
        deck_idle = 0;
        #(5*CLK)
        @(posedge clk)
		com0_turn = 1;
        prev_card = 6'b100001; // green 1
        @(posedge com0_play)
        $display("========7========");
        $display("Previous Card = %6b", prev_card);
        $display("Played Card   = %6b", com0_pcard);
        $display("Expected      = 101000");
        $display("=================");
        #(CLK)
        @(posedge clk)
        deck_idle = 1;
        com0_turn = 0;
        #(CLK)
        @(posedge clk)
        deck_idle = 0;
        #(5*CLK)
        @(posedge clk)
		com0_turn = 1;
        prev_card = 6'b100001; // green 1
        @(posedge com0_play)
        $display("========8========");
        $display("Previous Card = %6b", prev_card);
        $display("Played Card   = %6b", com0_pcard);
        $display("Expected      = 010001");
        $display("=================");
        #(CLK)
        @(posedge clk)
        deck_idle = 1;
        com0_turn = 0;
        #(CLK)
        @(posedge clk)
        deck_idle = 0;
        // r2, r7, r9, y1, y3, y5, wd
        
        @(posedge clk)
		$finish;
	end

	initial begin
		#(100000*CLK)
		$display("Too slow, abort.");
		$finish;
	end

endmodule
