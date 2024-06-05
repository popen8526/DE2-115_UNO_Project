module Card(
    input [5:0] card,
    input [9:0] x_cnt,
	input [9:0] y_cnt,
	input [9:0] x_pin,
	input [9:0] y_pin,
	output [7:0] r_data,
	output [7:0] g_data,
	output [7:0] b_data
);

    red_draw_two red_draw_two_instance(
        .x_cnt(x_cnt),
        .y_cnt(y_cnt),
        .x_pin(x_pin),
        .y_pin(y_pin),
        .r_data(r_data),
        .g_data(g_data),
        .b_data(b_data)
    );

endmodule