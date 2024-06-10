module DE2_115 (
	input CLOCK_50,
	input CLOCK2_50,
	input CLOCK3_50,
	input ENETCLK_25,
	input SMA_CLKIN,
	output SMA_CLKOUT,
	output [8:0] LEDG,
	output [17:0] LEDR,
	input [3:0] KEY,
	input [17:0] SW,
	output [6:0] HEX0,
	output [6:0] HEX1,
	output [6:0] HEX2,
	output [6:0] HEX3,
	output [6:0] HEX4,
	output [6:0] HEX5,
	output [6:0] HEX6,
	output [6:0] HEX7,
	output LCD_BLON,
	inout [7:0] LCD_DATA,
	output LCD_EN,
	output LCD_ON,
	output LCD_RS,
	output LCD_RW,
	output UART_CTS,
	input UART_RTS,
	input UART_RXD,
	output UART_TXD,
	inout PS2_CLK,
	inout PS2_DAT,
	inout PS2_CLK2,
	inout PS2_DAT2,
	output SD_CLK,
	inout SD_CMD,
	inout [3:0] SD_DAT,
	input SD_WP_N,
	output [7:0] VGA_B,
	output VGA_BLANK_N,
	output VGA_CLK,
	output [7:0] VGA_G,
	output VGA_HS,
	output [7:0] VGA_R,
	output VGA_SYNC_N,
	output VGA_VS,
	input AUD_ADCDAT,
	inout AUD_ADCLRCK,
	inout AUD_BCLK,
	output AUD_DACDAT,
	inout AUD_DACLRCK,
	output AUD_XCK,
	output EEP_I2C_SCLK,
	inout EEP_I2C_SDAT,
	output I2C_SCLK,
	inout I2C_SDAT,
	output ENET0_GTX_CLK,
	input ENET0_INT_N,
	output ENET0_MDC,
	input ENET0_MDIO,
	output ENET0_RST_N,
	input ENET0_RX_CLK,
	input ENET0_RX_COL,
	input ENET0_RX_CRS,
	input [3:0] ENET0_RX_DATA,
	input ENET0_RX_DV,
	input ENET0_RX_ER,
	input ENET0_TX_CLK,
	output [3:0] ENET0_TX_DATA,
	output ENET0_TX_EN,
	output ENET0_TX_ER,
	input ENET0_LINK100,
	output ENET1_GTX_CLK,
	input ENET1_INT_N,
	output ENET1_MDC,
	input ENET1_MDIO,
	output ENET1_RST_N,
	input ENET1_RX_CLK,
	input ENET1_RX_COL,
	input ENET1_RX_CRS,
	input [3:0] ENET1_RX_DATA,
	input ENET1_RX_DV,
	input ENET1_RX_ER,
	input ENET1_TX_CLK,
	output [3:0] ENET1_TX_DATA,
	output ENET1_TX_EN,
	output ENET1_TX_ER,
	input ENET1_LINK100,
	input TD_CLK27,
	input [7:0] TD_DATA,
	input TD_HS,
	output TD_RESET_N,
	input TD_VS,
	inout [15:0] OTG_DATA,
	output [1:0] OTG_ADDR,
	output OTG_CS_N,
	output OTG_WR_N,
	output OTG_RD_N,
	input OTG_INT,
	output OTG_RST_N,
	input IRDA_RXD,
	output [12:0] DRAM_ADDR,
	output [1:0] DRAM_BA,
	output DRAM_CAS_N,
	output DRAM_CKE,
	output DRAM_CLK,
	output DRAM_CS_N,
	inout [31:0] DRAM_DQ,
	output [3:0] DRAM_DQM,
	output DRAM_RAS_N,
	output DRAM_WE_N,
	output [19:0] SRAM_ADDR,
	output SRAM_CE_N,
	inout [15:0] SRAM_DQ,
	output SRAM_LB_N,
	output SRAM_OE_N,
	output SRAM_UB_N,
	output SRAM_WE_N,
	output [22:0] FL_ADDR,
	output FL_CE_N,
	inout [7:0] FL_DQ,
	output FL_OE_N,
	output FL_RST_N,
	input FL_RY,
	output FL_WE_N,
	output FL_WP_N,
	inout [35:0] GPIO,
	input HSMC_CLKIN_P1,
	input HSMC_CLKIN_P2,
	input HSMC_CLKIN0,
	output HSMC_CLKOUT_P1,
	output HSMC_CLKOUT_P2,
	output HSMC_CLKOUT0,
	inout [3:0] HSMC_D,
	input [16:0] HSMC_RX_D_P,
	output [16:0] HSMC_TX_D_P,
	inout [6:0] EX_IO
);

wire i_clk_25M, i_clk_1M;
wire i_rst_n = KEY[0];
wire [7:0] char;
wire alter_key_1;
wire alter_key_2;
wire alter_key_3;
wire start_key;
wire uno_key;

assign alter_key_1 = (char == 8'h24);
assign alter_key_2 = (char == 8'h5a);
assign alter_key_3 = (char == 8'h15);
assign start_key = (char == 8'h29);
assign uno_key = (char == 8'h3c);
assign reset_key = (char == 8'h2d);

// TODO: Using Qsys to generate PLL to create "i_clk_25M"
audio audio_inst (
    .altpll_1_c0_clk(i_clk_25M), // Connect the output clock
    .altpll_1_inclk_interface_clk(CLOCK_50),
    .altpll_1_inclk_interface_reset_reset(i_rst_n),
	 .altpll_0_c0_clk(i_clk_1M),                      //                    altpll_0_c0.clk
	 .altpll_0_inclk_interface_clk(CLOCK_50),         //       altpll_0_inclk_interface.clk
	 .altpll_0_inclk_interface_reset_reset(i_rst_n)
);


keyboard_driver keyboard_driver_inst (
	.CLOCK_50(CLOCK_50),
	.PS2_CLK(PS2_CLK),
	.i_rst_n(i_rst_n && replay),
	.PS2_DAT(PS2_DAT),
	.LEDG(LEDG),
	.LEDR(LEDR),
	.char(char)
);

localparam S_INIT = 2'b00, S_HOLD = 2'b01, S_DONE = 2'b11;
logic [2:0] state_1_w, state_1_r, state_2_w, state_2_r, state_3_w, state_3_r;
logic [2:0] state_4_w, state_4_r, state_5_w, state_5_r, state_6_w, state_6_r, prev_key_r, prev_key_w;
// logic [5:0] hands_w [108:0];
// logic [5:0] hands_r [108:0];
// logic [6:0] hands_num [3:0];
// logic [10:0] score [3:0];
// logic [1:0] color_w, color_r;
logic [4:0] prev_card_w, prev_card_r;
// logic [6:0] index_w, index_r;
// logic [7:0] local_index;
// logic [6:0] hands_num_w [3:0];
// logic [6:0] hands_num_r [3:0];
wire key1down, key2down, key3down, start, uno, replay, reverse;

logic [4:0]  player_state;
logic [4:0]  com0_state;
logic [4:0]  com1_state;
logic [4:0]  com2_state;
logic [3:0]  uno_state;
logic [4:0]  deck_state_1;
logic [4:0]  deck_state_2;

logic [5:0] hands [108:0];
logic [6:0] hands_num [3:0];
logic [10:0] score [3:0];
logic [5:0] prev_card;
logic [6:0] index;
logic finished, select_color;
logic [5:0] sorted_rank_w [3:0];
logic [5:0] sorted_rank_r [3:0];
assign hands[108] = 6'b001111;

Display display_instance (
    .i_rst_n(i_rst_n),
    .i_clk_25M(i_clk_25M),
	.i_hands(hands),
	.i_index(index),
	.i_prev_card(prev_card),
	.i_finished(finished),
	.i_hands_num(hands_num),
	.i_select_color(select_color),
	.i_score(score),
	.i_uno_state(uno_state),
	.i_start(start),
    .VGA_B(VGA_B),
    .VGA_BLANK_N(VGA_BLANK_N),
    .VGA_CLK(VGA_CLK),
    .VGA_G(VGA_G),
    .VGA_HS(VGA_HS),
    .VGA_R(VGA_R),
    .VGA_SYNC_N(VGA_SYNC_N),
    .VGA_VS(VGA_VS),
	.o_local_index(local_index),
	.i_reverse(reverse),
	.i_replay(!replay),
	.i_rank(sorted_rank_r)
);

Uno uno_instance (
	.i_clk(i_clk_1M),
	.i_rst_n(i_rst_n && replay),
	.i_start(start),
	.i_left(key3down),
	.i_right(key1down),
	.i_select(key2down),
	.i_uno(uno),
	.o_hand_num(hands_num),
	.o_score(score),
	.o_index(index),
	.o_last_card(prev_card),
	.o_hands(hands[107:0]),
	.o_end(finished),
	.o_player_state(player_state), 
	.o_com0_state(com0_state), 
	.o_com1_state(com1_state), 
	.o_com2_state(com2_state), 
	.o_deck_state_1(deck_state_1), 
	.o_deck_state_2(deck_state_2),
	.o_select(select_color),
	.o_uno_state(uno_state[3:0]),
	.o_reverse(reverse)
);


// Debounce deb1(
// 	.i_in(KEY[1]), // LEFT
// 	.i_rst_n(i_rst_n),
// 	.i_clk(i_clk_1M),
// 	.o_neg(key1down) 
// );

// Debounce deb2(
// 	.i_in(KEY[2]), // PLAY
// 	.i_rst_n(i_rst_n),
// 	.i_clk(i_clk_1M),
// 	.o_neg(key2down) 
// );

// Debounce deb3(
// 	.i_in(KEY[3]), // RIGHT
// 	.i_rst_n(i_rst_n),
// 	.i_clk(i_clk_1M),
// 	.o_neg(key3down)
// );

always_comb begin
	case(state_1_r)
		S_INIT: begin
			if(alter_key_1)	begin
				state_1_w = S_HOLD;
				key1down = 0;
			end
			else begin
				state_1_w = S_INIT;
				key1down = 0;
			end
		end
		S_HOLD: begin
			state_1_w = S_DONE;
			key1down = (prev_key_r == 1) ? 1 : 0;
		end
		S_DONE: begin
			key1down = 0;	
			if(~alter_key_1)	state_1_w = S_INIT;
			else 				state_1_w = S_DONE;
		end
	endcase
	case(state_2_r)
		S_INIT: begin
			if(alter_key_2)	begin
				state_2_w = S_HOLD;
				key2down = 0;
			end
			else begin
				state_2_w = S_INIT;
				key2down = 0;
			end
		end
		S_HOLD: begin
			state_2_w = S_DONE;
			key2down = (prev_key_r == 2) ? 1 : 0;
		end
		S_DONE: begin
			key2down = 0;
			if(~alter_key_2)	state_2_w = S_INIT;
			else 				state_2_w = S_DONE;
		end
	endcase
	case(state_3_r)
		S_INIT: begin
			if(alter_key_3)	begin
				state_3_w = S_HOLD;
				key3down = 0;
			end
			else begin
				state_3_w = S_INIT;
				key3down = 0;
			end
		end
		S_HOLD: begin
			state_3_w = S_DONE;
			key3down = (prev_key_r == 3) ? 1 : 0;
		end
		S_DONE: begin
			key3down = 0;
			if(~alter_key_3)	state_3_w = S_INIT;
			else 				state_3_w = S_DONE;
		end
	endcase
	case(state_4_r)
		S_INIT: begin
			if(start_key)	begin
				state_4_w = S_HOLD;
				start = 0;
			end
			else begin
				state_4_w = S_INIT;
				start = 0;
			end
		end
		S_HOLD: begin
			state_4_w = S_DONE;
			start = (prev_key_r == 4) ? 1 : 0;
		end
		S_DONE: begin
			start = 0;
			if(~start_key)	state_4_w = S_INIT;
			else 			state_4_w = S_DONE;
		end
	endcase
	case(state_5_r)
		S_INIT: begin
			if(uno_key)	begin
				state_5_w = S_HOLD;
				uno = 0;
			end
			else begin
				state_5_w = S_INIT;
				uno = 0;
			end
		end
		S_HOLD: begin
			state_5_w = S_DONE;
			uno = (prev_key_r == 5) ? 1 : 0;
		end
		S_DONE: begin
			uno = 0;
			if(~uno_key)	state_5_w = S_INIT;
			else 			state_5_w = S_DONE;
		end
	endcase
	case(state_6_r)
		S_INIT: begin
			if(reset_key)	begin
				state_6_w = S_HOLD;
				replay = 1;
			end
			else begin
				state_6_w = S_INIT;
				replay = 1;
			end
		end
		S_HOLD: begin
			state_6_w = S_DONE;
			replay = (prev_key_r == 6) ? 0 : 1;
		end
		S_DONE: begin
			replay = 1;
			if(~reset_key)	state_6_w = S_INIT;
			else 			state_6_w = S_DONE;
		end
	endcase
end
always_comb begin
	if(state_1_r == S_HOLD) begin
		prev_key_w = 1;
	end
	else if(state_2_r == S_HOLD) begin
		prev_key_w = 2;
	end
	else if(state_3_r == S_HOLD) begin
		prev_key_w = 3;
	end
	else if(state_4_r == S_HOLD)begin
		prev_key_w = 4;
	end
	else if(state_5_r == S_HOLD)begin
		prev_key_w = 5;
	end
	else if(state_6_r == S_HOLD)begin
		prev_key_w = 6;
	end
	else begin
		prev_key_w = prev_key_r;
	end
end

localparam S_IDLE = 2'b00, S_SORT = 2'b01, S_END = 2'b10;
logic [2:0] state_w, state_r, i_iter_w, i_iter_r, j_iter_w, j_iter_r;
always_comb begin
	for(int i = 0; i < 4; i = i + 1) begin
		sorted_rank_w[i] = sorted_rank_r[i];
	end
	case(state_r)
		S_IDLE: begin
			if(finished) begin
				state_w = S_SORT;
				sorted_rank_w[0] = sorted_rank_r[0];
				sorted_rank_w[1] = sorted_rank_r[1];
				sorted_rank_w[2] = sorted_rank_r[2];
				sorted_rank_w[3] = sorted_rank_r[3];
				i_iter_w = 0;
				j_iter_w = 3;
			end
			else begin
				state_w = S_IDLE;
				i_iter_w = 0;
				j_iter_w = 3;
			end
		end
		S_SORT: begin
			state_w = (j_iter_r == 1) ? S_END : S_SORT;
			i_iter_w = (i_iter_r == j_iter_r - 1) ? 0 : i_iter_r + 1;
			j_iter_w = (i_iter_r == j_iter_r - 1) ? j_iter_r - 1 : j_iter_r;
			if (score[i_iter_r] < score[j_iter_r]) begin
				sorted_rank_w[i_iter_r] = sorted_rank_r[i_iter_r] + 1;
				sorted_rank_w[j_iter_r] = sorted_rank_r[j_iter_r];
			end 
			else if ((score[i_iter_r] > score[j_iter_r])) begin
				sorted_rank_w[i_iter_r] = sorted_rank_r[i_iter_r];
				sorted_rank_w[j_iter_r] = sorted_rank_r[j_iter_r] + 1;
			end
			else begin
				sorted_rank_w[i_iter_r] = sorted_rank_r[i_iter_r] + 1;
				sorted_rank_w[j_iter_r] = sorted_rank_r[j_iter_r] + 1;
			end
		end
		S_END: begin
			state_w = (!finished) ? S_IDLE : S_END;
			i_iter_w = 0;
			j_iter_w = 3;
		end
		default: begin
        	state_w = S_IDLE;  // Add a default assignment for state_w
			i_iter_w = 0;
			j_iter_w = 3;
    	end
	endcase
end
always_ff @(posedge i_clk_1M or negedge i_rst_n) begin
	if(~i_rst_n) begin
		state_r <= S_IDLE;
		state_1_r <= S_INIT;
		state_2_r <= S_INIT;
		state_3_r <= S_INIT;
		state_4_r <= S_INIT;
		state_5_r <= S_INIT;
		state_6_r <= S_INIT;
		for(int i = 0; i < 4; i = i + 1) begin
			sorted_rank_r[i] = 0;
		end
		prev_key_r <= 0;
		j_iter_r <= 3;
		i_iter_r <= 0;
	end
	else begin
		state_r <= state_w;
		state_1_r <= state_1_w;
		state_2_r <= state_2_w;
		state_3_r <= state_3_w;
		state_4_r <= state_4_w;
		state_5_r <= state_5_w;
		state_6_r <= state_6_w;
		for(int i = 0; i < 4; i = i + 1) begin
			sorted_rank_r[i] = sorted_rank_w[i];
		end
		prev_key_r <= prev_key_w;
		j_iter_r <= j_iter_w;
		i_iter_r <= i_iter_w;
	end
end
SevenHexDecoder seven_dec0(
.i_hex(j_iter_r),
// .i_hex(state_r),
.o_seven_ten(HEX1),
.o_seven_one(HEX0)
);
SevenHexDecoder seven_dec1(
.i_hex(state_r),
.o_seven_ten(HEX3),
.o_seven_one(HEX2)
);

SevenHexDecoder seven_dec2(
.i_hex(sorted_rank_r[2]),
.o_seven_ten(HEX5),
.o_seven_one(HEX4)
);

SevenHexDecoder seven_dec3(
.i_hex(sorted_rank_r[3]),
.o_seven_ten(HEX7),
.o_seven_one(HEX6)
);
 

// comment those are use for display
// assign HEX0 = '1;
// assign HEX1 = '1;
//assign HEX2 = '1;
//assign HEX3 = '1;
//assign HEX4 = '1;
//assign HEX5 = '1;
//assign HEX6 = '1;
//assign HEX7 = '1;
endmodule