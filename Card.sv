module Card(
    input [5:0] card,
    input [9:0] x_cnt,
	input [9:0] y_cnt,
	input [9:0] x_pin,
	input [9:0] y_pin,
	output [7:0] r_data,
	output [7:0] g_data,
	output [7:0] b_data,
    output [5:0] x_index,
    output [5:0] y_index
);
    localparam X_WIDTH = 30;
    localparam Y_WIDTH = 50;
    logic [5:0] x_index, y_index; // given to the image in order to determine the pixel.
    assign y_index = y_cnt - y_pin;
    always_comb begin
        if((x_pin <= x_cnt && x_cnt <= x_pin + X_WIDTH) && (y_pin <= y_cnt && y_cnt <= y_pin + Y_WIDTH)) begin
            x_index = (x_cnt - x_pin)[9:4];
        end
        else begin
            x_index = 6'b0;
        end
    end

endmodule