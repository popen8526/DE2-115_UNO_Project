// run command : vcs -R -sverilog tb_Deck.sv Deck.sv -sverilog -v +access+all -full64 -debug_access

`timescale 1ns/100ps

module tb;
	localparam CLK = 10;
	localparam HCLK = CLK/2;

	logic clk, rst;
	initial clk = 0;
	always #HCLK clk = ~clk;
    logic        shuffle;
    logic        insert;
    logic [ 5:0] in_card;
    logic [ 2:0] draw_num;
    logic        deck_idle;
    logic        card_drawn;
    logic [ 5:0] next_card;
	logic [ 5:0] card;
	integer i, j;

	Deck Deck(
        .i_clk(clk),
        .i_rst_n(rst),
        .i_start(shuffle),
        .i_insert(insert),
        .i_prev_card(in_card),
        .i_draw(draw_num),
        .o_done(deck_idle),
        .o_drawn(card_drawn),
        .o_card(next_card)
    );

	initial begin
		$fsdbDumpfile("Deck.fsdb");
		$fsdbDumpvars;
        insert = 0;
		rst = 1;
		#(2*CLK)
		rst = 0;
        #(2*CLK)
        rst = 1;
        #(2*CLK)
        @(posedge clk)
        shuffle = 1;
        @(posedge clk)
        shuffle = 0;
		// draw 1
        @(posedge deck_idle)
        draw_num = 3'd1;
		@(posedge clk)
		draw_num = 3'd0;
        for(i=0; i<1; i++) begin
            @(posedge card_drawn)
			$display("=========");
			$display("Card  %2d = %6b", i+1, next_card);
			$display("=========");
        end
		// draw 2
		@(posedge deck_idle)
        draw_num = 3'd2;
		@(posedge clk)
		draw_num = 3'd0;
        for(i=0; i<2; i++) begin
            @(posedge card_drawn)
			$display("=========");
			$display("Card  %2d = %6b", i+1, next_card);
			$display("=========");
        end
		// draw 4
		@(posedge deck_idle)
        draw_num = 3'd4;
		@(posedge clk)
		draw_num = 3'd0;
        for(i=0; i<4; i++) begin
            @(posedge card_drawn)
			$display("=========");
			$display("Card  %2d = %6b", i+1, next_card);
			$display("=========");
        end
		// draw 7
		@(posedge deck_idle)
        draw_num = 3'd7;
		@(posedge clk)
		draw_num = 3'd0;
        for(i=0; i<7; i++) begin
            @(posedge card_drawn)
			$display("=========");
			$display("Card  %2d = %6b", i+1, next_card);
			$display("=========");
        end
		// draw 1, insert 1 * 108 times
		for(j=0; j<108; j++) begin
			@(posedge deck_idle)
			draw_num = 3'd1;
			@(posedge clk)
			draw_num = 3'd0;
            @(posedge card_drawn)
            card = next_card;
            if(j%10 == 0) begin
                $display("=========");
                $display("Card  %2d = %6b", j+1, next_card);
                $display("=========");
            end
            @(posedge deck_idle)
            insert = 1'd1;
            in_card = card;
            @(posedge clk)
            insert = 1'd0;
		end
        $display("Draw another 108 cards");
        for(j=0; j<108; j++) begin
			@(posedge deck_idle)
			draw_num = 3'd1;
			@(posedge clk)
			draw_num = 3'd0;
            @(posedge card_drawn)
            card = next_card;
            if(j%10 == 0) begin
                $display("=========");
                $display("Card  %2d = %6b", j+1, next_card);
                $display("=========");
            end
            @(posedge deck_idle)
            insert = 1'd1;
            in_card = card;
            @(posedge clk)
            insert = 1'd0;
		end
        $display("Draw another 108 cards");
        for(j=0; j<108; j++) begin
			@(posedge deck_idle)
			draw_num = 3'd1;
			@(posedge clk)
			draw_num = 3'd0;
            @(posedge card_drawn)
            card = next_card;
            if(j%10 == 0) begin
                $display("=========");
                $display("Card  %2d = %6b", j+1, next_card);
                $display("=========");
            end
            @(posedge deck_idle)
            insert = 1'd1;
            in_card = card;
            @(posedge clk)
            insert = 1'd0;
		end
        @(posedge deck_idle)
		$finish;
	end

	initial begin
		#(500000*CLK)
		$display("Too slow, abort.");
		$finish;
	end

endmodule
