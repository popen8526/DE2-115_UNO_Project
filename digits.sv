module digits(
    input [3:0] number,
    input [9:0] x_cnt,
    input [9:0] y_cnt,
    input [9:0] x_pin,
    input [9:0] y_pin,
    input [9:0] x_width,
    input [9:0] y_width,
    input [7:0] bg_r_pixel,
    input [7:0] bg_g_pixel,
    input [7:0] bg_b_pixel,
    input [7:0] sb_r_pixel,
    input [7:0] sb_g_pixel,
    input [7:0] sb_b_pixel,
    input i_finished,
    output [7:0] r_data,
    output [7:0] g_data,
    output [7:0] b_data
);
logic [6:0] exist;
/*************************************
                0
        __________________
        |               |
        |               |
    3   |               |   4
        |       1       |
        ________________
        |               |
        |               |
    5   |               |   6
        |       2       |
        _________________
                

*************************************/
always_comb begin
    exist[0] = (number == 0 || number == 2 || number == 3 || number == 5 || number == 6 || number == 7 || number == 8 || number == 9);
    exist[1] = (number == 2 || number == 3 || number == 4 || number == 5 || number == 6 || number == 8 || number == 9);
    exist[2] = (number == 0 || number == 2 || number == 3 || number == 5 || number == 6 || number == 8);
    exist[3] = (number == 0 || number == 4 || number == 5 || number == 6 || number == 8 || number == 9);
    exist[4] = (number == 0 || number == 1 || number == 2 || number == 3 || number == 4 || number == 7 || number == 8 || number == 9);
    exist[5] = (number == 0 || number == 2 || number == 6 || number == 8);
    exist[6] = (number == 0 || number == 1 || number == 3 || number == 4 || number == 5 || number == 6 || number == 7 || number == 8 || number == 9);
	if((x_pin <= x_cnt && x_cnt <= x_pin + x_width) && (y_pin <= y_cnt && y_cnt <= y_pin + y_width)) begin
        if(exist[0]&&(x_pin + 8 <= x_cnt && x_cnt <= x_pin + 22) && (y_pin + 9 <= y_cnt && y_cnt <= y_pin + 11)) begin
            r_data = 8'b11111111;
            g_data = 8'b11111111;
            b_data = 8'b11111111;
        end
        else if(exist[1]&&(x_pin + 8 <= x_cnt && x_cnt <= x_pin + 22) && (y_pin + 24 <= y_cnt && y_cnt <= y_pin + 26)) begin
            r_data = 8'b11111111;
            g_data = 8'b11111111;
            b_data = 8'b11111111;
        end
        else if(exist[2]&&(x_pin + 8 <= x_cnt && x_cnt <= x_pin + 22) && (y_pin + 40 <= y_cnt && y_cnt <= y_pin + 42)) begin
            r_data = 8'b11111111;
            g_data = 8'b11111111;
            b_data = 8'b11111111;
        end
        else if(exist[3]&&(x_pin + 7 <= x_cnt && x_cnt <= x_pin + 9) && (y_pin + 10 <= y_cnt && y_cnt <= y_pin + 25)) begin
            r_data = 8'b11111111;
            g_data = 8'b11111111;
            b_data = 8'b11111111;
        end
        else if(exist[4]&&(x_pin + 21 <= x_cnt && x_cnt <= x_pin + 23) && (y_pin + 10 <= y_cnt && y_cnt <= y_pin + 25)) begin
            r_data = 8'b11111111;
            g_data = 8'b11111111;
            b_data = 8'b11111111;
        end
        else if(exist[5]&&(x_pin + 7 <= x_cnt && x_cnt <= x_pin + 9) && (y_pin + 25 <= y_cnt && y_cnt <= y_pin + 41)) begin
            r_data = 8'b11111111;
            g_data = 8'b11111111;
            b_data = 8'b11111111;
        end
        else if(exist[6]&&(x_pin + 21 <= x_cnt && x_cnt <= x_pin + 23) && (y_pin + 25 <= y_cnt && y_cnt <= y_pin + 41)) begin
            r_data = 8'b11111111;
            g_data = 8'b11111111;
            b_data = 8'b11111111;
        end
        else begin
            if(i_finished) begin
                r_data = sb_r_pixel;
                g_data = sb_g_pixel;
                b_data = sb_b_pixel;
			end
            else begin
                r_data = bg_r_pixel;
                g_data = bg_g_pixel;
                b_data = bg_b_pixel;
            end
        end
	end
	else begin
		if(i_finished) begin
            r_data = sb_r_pixel;
            g_data = sb_g_pixel;
            b_data = sb_b_pixel;
		end
        else begin
                r_data = bg_r_pixel;
                g_data = bg_g_pixel;
                b_data = bg_b_pixel;
        end
	end
end
endmodule