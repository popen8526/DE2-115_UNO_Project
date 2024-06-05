module yellow_two(
	input [9:0] x_cnt,
	input [9:0] y_cnt,
	input [9:0] x_pin,
	input [9:0] y_pin,
	output [7:0] r_data,
	output [7:0] g_data,
	output [7:0] b_data
);
localparam X_WIDTH = 30;
localparam Y_WIDTH = 50;
localparam [0:149][239:0] picture = {
	240'b111110011111011111011100100100111001011010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101010111001000110100001111011011111110011111001,
	240'b111111011110010010111010110011011110001011101101111011101110110111101101111011011110110111101101111011011110110111101101111011011110110111101101111011011110110111101101111011011110110111101110111011001101111111001010110001111111100111111111,
	240'b111101101011100111101000111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110111011100011111111110,
	240'b110010011101100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111100111111001101,
	240'b101010111111101011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111000010100001,
	240'b101100011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110101101,
	240'b101100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110011,
	240'b101100101111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010110000,
	240'b101010111111110111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111011010100010,
	240'b101110011110011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101101110110111,
	240'b111010111011101111111001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111100101011111111110101,
	240'b111111011101010110111101111010111111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111110111100100101111001110100111111110,
	240'b111101001111111111100101101010001010001010101001101010101010101010101010101010101010101010101011101010111010101110101011101010101010101010101010101010101010101010101011101010111010101110101011101010011010000010101000111000101111010011110010,
	240'b111110011111011111011100100100111001011010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101010111001000110100001111011011111110011111001,
	240'b111111011110010010111010110011011110001011101101111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011001101111111001010110001111111100111111111,
	240'b111101101011100111101000111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110111011100011111111110,
	240'b110010011101100111111111111110011101101011001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111011001101110011101101111111111100111111111100111111001101,
	240'b101010111111101011111101110001111010011110100111101001111010011110100111101001111010011110100111101001111010011110100111101001111010011110100111101001111010011110100111101001101011000110111011101011101010011111010010111111111111000110100001,
	240'b101100011111111111101101101011001010100110101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101000101111111111001111111011111011101011100010110001111101111111111010101101,
	240'b101100111111111111100110101010111010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100110101101111010111110010111000000111011011110010010101111111100011111111110110011,
	240'b101101001111111111100110101010111010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100110110010111101011100010010100010110001001101110110110010111100001111111110110011,
	240'b101101001111111111100110101010111010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100110101101111010111110001010101100101010001010101010110000111100011111111110110011,
	240'b101101001111111111100110101010111010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101000101111001111010011100110101101001010011010110000111100011111111110110011,
	240'b101101001111111111100110101010111010101010101001101010001010011110101000101010001010100010101001101010101010101010101010101010101010101010101010101010101010101010101011101011101011101011101011111100011100001010101111111100011111111110110011,
	240'b101101001111111111100110101010111010100010101111110000101100110011001011110001111011101110110010101010101010100010101001101010101010101010101010101010101010100110110010111011111101100111011000111111101110111110110100111100001111111110110011,
	240'b101101001111111111100110101010011011110111101100111111101111111111111111111111111111110011110011111000101100101110110100101010001010100110101010101010101010100110110010111010101111001011110001111100011110001010110011111100001111111110110011,
	240'b101101001111111111100100101110101111010011111111111111111111111111111111111111111111111111111111111111111111111111110100110110001011010110101000101010011010101010101011101100001011000110110001101100011010111010110000111100011111111110110011,
	240'b101101001111111111100110111000101111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010011001100101010111010100110101010101010011010100110101001101010011010100010110000111100011111111110110011,
	240'b101101001111111111110000111110011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111000001011001010101000101010101010101010101010101010101010100110110000111100011111111110110011,
	240'b101101001111111111110110111111011111111111111111111111111111111111111111111111111111111111111111111111111111111111111011111101111111110011111111111111111110101110110110101010001010101010101010101010101010100110110000111100011111111110110011,
	240'b101101001111111111110111111111011111111111111111111111111111111111111111111111111111111111111111111101111101001110111011101101111011111011011011111110111111111111101110101101101010100010101010101010101010100110110000111100011111111110110011,
	240'b101101001111111111110110111111001111111111111111111111111111111111111111111111111111111111110101101111101010011110100110101001101010011110101000110010001111101111111111111010101011000010101001101010101010100110110000111100011111111110110011,
	240'b101101001111111111110011111110111111111111111111111111111111111111111111111111111111111011001001101001111010100110110110110000001011001010101000101010001101100011111111111111111101110110101010101010101010100110110000111100011111111110110011,
	240'b101101001111111111101111111101111111111111111111111111111111111111111111111111111110111110101110101001111100010011110110111111101111000010111010101001111011011111111001111111111111110111001000101010001010100110110000111100011111111110110011,
	240'b101101001111111111101001111011011111111111111111111111111111111111111111111111111101111010101000101011101110111011111111111111111111111111100000101001111010101011101100111111111111111111110010101100111010100010110000111100011111111110110011,
	240'b101101001111111111100100110111101111111111111111111111111111111111111111111111111101100110100110101100111111011111111111111111111111111111101110101101011011001111101001111111111111111111111111110101011010011110110000111100011111111110110011,
	240'b101101001111111111100100110010111111111111111111111111111111111111111111111111111110000010101000101011001110100111111111111111111111111111111101111101111111011111111101111111111111111111111111111101001011001010101110111100011111111110110011,
	240'b101101001111111111100101101101111111011111111111111111111111111111111111111111111111001010110000101001111100001011111000111111111111111111111111111111111111111111111111111111111111111111111111111111111100110110101101111100011111111110110011,
	240'b101101001111111111100110101010111110001111111111111111111111111111111111111111111111111111010011101010001010100011000000111100101111111111111111111111111111111111111111111111111111111111111111111111111110100010110001111100011111111110110011,
	240'b101101001111111111100110101010011100010011111110111111111111111111111111111111111111111111111100110011001010100010100111101101101110010011111111111111111111111111111111111111111111111111111111111111111111100110111111111011111111111110110011,
	240'b101101001111111111100110101010101010110111101011111111111111111111111111111111111111111111111111111111001101000010101010101001111010110111010011111110101111111111111111111111111111111111111111111111111111111111010000111011101111111110110011,
	240'b101101001111111111100110101010111010011111000101111111101111111111111111111111111111111111111111111111111111111011011100101100001010011110101000110000001110111011111111111111111111111111111111111111111111111111100010111011111111111110110011,
	240'b101101001111111111100110101010111010100110101011111000101111111111111111111111111110101111010010110110101111111111111111111011001011110010101010101001111011010011101111111111111111111111111111111111111111111111101111111100101111111110110011,
	240'b101101001111111111100110101010111010101010101000101101101111010011111111111111111101011010100100101011101101100011011101110111111101001010101111101010011010100111100100111111111111111111111111111111111111111111111000111101011111111110110011,
	240'b101101001111111111100110101010111010101010101010101010001100010111111011111111111101011110100111101010011010011110100111101001111010100010101010101010101010101011100101111111111111111111111111111111111111111111111011111101111111111010110011,
	240'b101101001111111111100110101010111010101010101010101010101010100011010000111111101101011110100110101010011010100110101001101010011010100110101001101010011010100111100101111111111111111111111111111111111111111111111011111110011111111010110011,
	240'b101101001111111111100110101010111010101010101010101010101010101010101001110100101111000111100100111001001110010011100100111001001110010011100100111001001110010011110111111111111111111111111111111111111111111111111011111110011111111010110011,
	240'b101101001111111111100110101010111010101010101010101010101010101010101001101010011100110011111011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111001111101101111111010110011,
	240'b101101001111111111100110101010111010101010101010101010101010101010101010101010101010100010111101111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111100110111100001111111110110011,
	240'b101101001111111111100110101010111010100110101000101010001010100010101001101010101010101010101000101011101100110111110001111111111111111111111111111111111111111111111111111111111111111111111111111111111111100011000010111011111111111110110011,
	240'b101101001111111111100101101100101101100111011111111000011110000111010011101011001010100110101010101010011010100010110010110010111110100011111001111111111111111111111111111111111111111111111111111101101100010110101110111100011111111110110011,
	240'b101101001111111111100101101110001111101111111010111001101111001111101110101011011010100110101010101010101010101010101001101010001010110010111000110010001101011111100000111001011110010111010111101110011010011110110000111100011111111110110011,
	240'b101101001111111111100101101011111101111111111010110100011011011110111110101010111010101010101010101010101010101010101010101010101010100110101000101010001010100010101001101010111010101010101000101010001010100110110000111100011111111110110011,
	240'b101101001111111111100110101010101010101111010000111110101101101010101011101010011010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100110110000111100011111111110110011,
	240'b101101001111111111100110101010111010011110100111110000101111011111010011101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100110110000111100011111111110110011,
	240'b101101001111111111100110101100011100101110110010101001001101011011101100101011001010100110101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100110110000111100011111111110110011,
	240'b101101001111111111100101101100101111010111010010101011011110000011100111101010111010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100110110000111100011111111110110011,
	240'b101100101111111111101001101010101101001011111011111100111111101011000100101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100110110000111101001111111110110000,
	240'b101010111111111011111000101110001010100011000101110101001011111110101000101010001010100010101000101010001010100010101000101010001010100010101000101010001010100010101000101010001010100010101000101010001010011011000011111111011111011010100010,
	240'b101110011110011111111111111010111100001010110111101110001011100010111010101110101011101010111010101110101011101010111010101110101011101010111010101110101011101010111010101110101011101010111010101110101100011111110010111111111101101110110111,
	240'b111010111011101111111001111111111111110111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111111111111111111100101011111111110101,
	240'b111111011101010110111101111010111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110111100100101111001110100111111110,
	240'b111101001111111111100101101010001010001010101001101010101010101010101010101010101010101010101011101010111010101110101011101010101010101010101010101010101010101010101011101010111010101110101011101010011010000010101000111000101111010011110010,
	240'b111110011111011111011100100100111001011010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101010111001000110100001111011011111110011111001,
	240'b111111011110010010111010110011011110001011101101111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011001101111111001010110001111111100111111111,
	240'b111101101011100111101000111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110111011100011111111110,
	240'b110010011101100111111111111011001001000101101111011011110110111101101111011011110110111101101111011011110110111101101111011011110110111101101111011011110110111101101111011011110110110001101000011011011001111111110110111111111100111111001101,
	240'b101010111111101011110111010101110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001010000110100000011100000000001111000111111101111000110100001,
	240'b101100011111111111001001000001110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000011101100111110011110011010010101000010110111001011111111110101101,
	240'b101100111111111110110100000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001001110000111011001001000101110010101010110100010000110101001111111110110011,
	240'b101101001111111110110100000000110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011001111000100100111100000000010011111001100000011010110100111111111110110011,
	240'b101101001111111110110100000000110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001001110000101010100000001011000000000000001100010010110101011111111110110011,
	240'b101101001111111110110100000000110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001110001101111010110011000111110000000000010010110101011111111110110011,
	240'b101101001111111110110100000000110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011000100000011000011000100110101000100101000010000110101001111111110110011,
	240'b101101001111111110110100000000110000000000001111010010000110011101100011010101010011010000011000000000000000000000000000000000000000000000000000000000000000000000011001110011111000111010001001111111001101000000011110110100101111111110110011,
	240'b101101001111111110110100000000000011101011000100111111001111111111111111111111101111011011011010101010010110010000011101000000000000000000000000000000000000000000010111110000011101100111010100110101011010100100011101110100111111111110110011,
	240'b101101001111111110101111001100011101111111111111111111111111111111111111111111111111111111111111111111111111111111011111100010000010000100000000000000000000000000000010000100100001010100010101000101010000111100010011110101011111111110110011,
	240'b101101001111111110110101101010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101111001100110000001010000000000000000000000000000000000000000000000000000000000010010110101011111111110110011,
	240'b101101001111111111010010111011001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110101000100001100000000000000000000000000000000000000000000000000000010010110101011111111110110011,
	240'b101101001111111111100101111110001111111111111111111111111111111111111111111111111111111111111111111111111111111111110010111001111111011011111111111111111100001000100101000000000000000000000000000000000000000000010010110101011111111110110011,
	240'b101101001111111111100111111110001111111111111111111111111111111111111111111111111111111111111111111001110111110000110011001001110011101110010010111101001111111111001011001001010000000000000000000000000000000000010010110101011111111110110011,
	240'b101101001111111111100011111101111111111111111111111111111111111111111111111111111111111111100000001111000000000000000000000000000000000000000000010110101111001111111111110000000001010100000000000000000000000000010010110101011111111110110011,
	240'b101101001111111111011010111101001111111111111111111111111111111111111111111111111111110001011110000000000000000000100100010000110001100100000000000000001000100011111111111111111001101000000100000000000000000000010010110101011111111110110011,
	240'b101101001111111111001101111001011111111111111111111111111111111111111111111111111101000000001101000000000100111011100011111110111101001000101111000000000010011111101100111111111111101101011011000000000000000000010010110101011111111110110011,
	240'b101101001111111110111110110010001111111111111111111111111111111111111111111111111001110000000000000011001100101011111111111111111111111110100010000000000000000111000110111111111111111111011000000110100000000000010010110101011111111110110011,
	240'b101101001111111110101111100111001111111111111111111111111111111111111111111111111000110000000000000110101110011011111111111111111111111111001101000111110001100110111100111111111111111111111111100000000000000000010001110101011111111110110011,
	240'b101101001111111110101101011000101111111111111111111111111111111111111111111111111010001000000000000001111011110011111111111111111111111111111010111010001110011111110111111111111111111111111111111000000001100000001110110101011111111110110011,
	240'b101101001111111110110000001001101110011111111111111111111111111111111111111111111101100000010011000000000100011111101011111111111111111111111111111111111111111111111111111111111111111111111111111111110110100000001010110101011111111110110011,
	240'b101101001111111110110011000001001010101011111111111111111111111111111111111111111111111001111001000000000000000001000010110101111111111111111111111111111111111111111111111111111111111111111111111111111011100100010110110100111111111110110011,
	240'b101101001111111110110100000000000100110111111100111111111111111111111111111111111111111111110100011001110000000000000000001001011010111111111111111111111111111111111111111111111111111111111111111111111110111000111110110100001111111110110011,
	240'b101101001111111110110100000000010000101111000011111111111111111111111111111111111111111111111111111101100111001000000010000000000000101001111010111100001111111111111111111111111111111111111111111111111111111101110100110011011111111110110011,
	240'b101101001111111110110100000000110000000001010000111110111111111111111111111111111111111111111111111111111111110010010101000100110000000000000000010001001100111011111111111111111111111111111111111111111111111110101000110100001111111110110011,
	240'b101101001111111110110100000000110000000000000110101001101111111111111111111111111100010001111011100100001111111111111111110001110011100000000001000000000001111011010000111111111111111111111111111111111111111111001110110110011111111110110011,
	240'b101101001111111110110100000000110000000000000000001001001101111011111111111111111000010000000000000011011000110010011001100111100111100100010000000000000000000010110001111111111111111111111111111111111111111111101001111000011111111110110011,
	240'b101101001111111110110100000000110000000000000000000000000101000111110100111111111000011000000000000000000000000000000000000000000000000000000000000000000000000010110011111111111111111111111111111111111111111111110010111010001111111110110011,
	240'b101101001111111110110100000000110000000000000000000000000000000001110001111111011000100100000000000000000000000000000000000000000000000000000000000000000000000010110010111111111111111111111111111111111111111111110100111010111111111110110011,
	240'b101101001111111110110100000000110000000000000000000000000000000000000001011110011101011010110000101011101010110110101101101011011010110110101101101011011010111011100111111111111111111111111111111111111111111111110101111011001111111110110011,
	240'b101101001111111110110100000000110000000000000000000000000000000000000000000000000110011011110011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101101111001001111111110110011,
	240'b101101001111111110110100000000110000000000000000000000000000000000000000000000000000000000111011101111101111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110011110100111111111110110011,
	240'b101101001111111110110100000000100000000000000000000000000000000000000000000000000000000000000000000011110110101111010101111111111111111111111111111111111111111111111111111111111111111111111111111111111110100101000111110011111111111110110011,
	240'b101101001111111110110001000110011000110010100000101001001010010001111011000001010000000000000000000000000000000000011010011000111011101011101101111111111111111111111111111111111111111111111111111001010101001000001101110101011111111110110011,
	240'b101101001111111110110000001010001111001111110000101101011101101011001011000010000000000000000000000000000000000000000000000000000000011100101011010111001000011010100011101011111011000010000111001011010000000000010001110101011111111110110011,
	240'b101101001111111110110010000011111001111111110000011101000010011000111110000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000100000000000000000000000000010010110101011111111110110011,
	240'b101101001111111110110100000000010000010101110010111011111000111100000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010010110101011111111110110011,
	240'b101101001111111110110100000000100000000000000000010010001110011101111010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010010110101011111111110110011,
	240'b101101001111111110110010000101000110010000011001000000001000010011000111000001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010010110101011111111110110011,
	240'b101101001111111110110000000110001110000101111000000100011010010010111001000000110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010010110101001111111110110011,
	240'b101100101111111110111101000000000111100111110100110110101111000001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010011110111011111111110110000,
	240'b101010111111111011101010001010100000000001010011011111110011111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001001011111110011111011110100010,
	240'b101110011110011111111111110001000100100000101001001010110010101000110000001100000011000000110000001100000011000000110000001100000011000000110000001100000011000000110000001100000011000000110000001100000101011111011001111111111101101110110111,
	240'b111010111011101111111001111111111111100111101101111011011110110111101101111011011110110111101101111011011110110111101101111011011110110111101101111011011110110111101101111011011110110111101101111011101111110111111111111100101011111111110101,
	240'b111111011101010110111101111010111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111011100100101111001110100111111110,
	240'b111101001111111111100101101010001010001010101001101010101010101010101010101010101010101010101011101010111010101110101011101010101010101010101010101010101010101010101011101010111010101110101011101010011010000010101000111000101111010011110010,
};
always_comb begin
	if((x_pin <= x_cnt && x_cnt <= x_pin + X_WIDTH) && (y_pin <= y_cnt && y_cnt <= y_pin + Y_WIDTH)) begin
		r_data = picture[(y_cnt - y_pin)][(x_cnt - x_pin)<<3 +: 8];
		g_data = picture[(y_cnt - y_pin) + Y_WIDTH][(x_cnt - x_pin)<<3 +: 8];
		b_data = picture[(y_cnt - y_pin) + 2*Y_WIDTH][(x_cnt - x_pin)<<3 +: 8];
	end
	else begin
		r_data = 8'b0;
		g_data = 8'b0;
		b_data = 8'b0;
	end
end
endmodule