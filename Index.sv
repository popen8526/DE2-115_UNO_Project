module Index(
	input [9:0] x_cnt,
	input [9:0] y_cnt,
	input [9:0] x_pin,
	input [9:0] y_pin,
	input [9:0] x_width,
	input [9:0] y_width,
	output [7:0] r_data,
	output [7:0] g_data,
	output [7:0] b_data
);

always_comb begin
	if((x_pin <= x_cnt && x_cnt <= x_pin + x_width) && (y_pin <= y_cnt && y_cnt <= y_pin + y_width)) begin
		r_data = 8'b11111111;
		g_data = 8'b11111111;
		b_data = 8'b00000000;
	end
	else begin
		r_data = 8'b0;
		g_data = 8'b0;
		b_data = 8'b0;
	end
end
endmodule