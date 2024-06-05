module blue_reverse(
	input [7:0] addr,
	output [239:0] data
);
parameter [0:149][239:0] picture = {
	240'b111111111111111111011110100111111001111110110000101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101011111001110010101100111100111111111111111111,
	240'b111111111110011010111000111001001111110011111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111101111011110101111001110111111111111,
	240'b111101001011111111110100111111111111111111111000111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111110001111111111111111111011011100000011111001,
	240'b101111101110001011111111111000111001001101111011011110110111101101111011011110110111101101111011011110110111101101111011011110110111101101111011011110110111101101111011011101110111011101111010011111001001101111101011111111111101100110111101,
	240'b101001101111101111111000011111110100110101010001010100010101000101010001010100010101000101010001010100010101000101010001010100010101000101010001010100010101000001011010100111001010000101100010010011110100110110010000111111011111010110011111,
	240'b101100101111111111011110010110110101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101001001101000111101001111101001111111010100000101001001100110111010111111111010110001,
	240'b101101101111111111010101010110010101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101001001100110110011011111110111100001011011000100111101100011111001011111111010110101,
	240'b101101101111111111010110010110010101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010001011000100101101100010011111111110100110110000101100001111001011111111010110101,
	240'b101101101111111111010110010110010101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010001011000110101111100110011001001111111111010101101011110111001011111111010110101,
	240'b101101101111111111010110010110010101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010011110000011111111110111111110101111100010101011111111001011111111010110101,
	240'b101101101111111111010110010110010101010001010010010100000101001001010001010011110101000001010001010100110101010101010101010101010101010101010101010101010101010101010010011011001110000111111101101111111000101101100011111001011111111010110110,
	240'b101101101111111111010110010110010101000001101100100111011011010010110001101001111001001101111000010111110101001001010001010101000101010101010101010101010101010101010101010100000111100011101010111110001011111001101011111001001111111010110110,
	240'b101101101111111111010110010101101000110011101000111111111111111111111111111111111111111111110111110111111011011110000000010110000101000101010100010101010101010101010101010101010100111110001111111111111110000001101011111001001111111010110110,
	240'b101101101111111111010010011111111111001011111111111111111111111111111111111111111111111111111111111111111111111111111001110010111000000001010011010100110101010101010101010101010101001101101101101000111001000001100111111001011111111010110110,
	240'b101101101111111111010110110010111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111011110110011011000010101000101010101010101010101010101010100010100010101000001100011111001011111111010110110,
	240'b101101101111111111100111111100111111111111111111111111111111111111111111111111111111100111111000111110011111100011110111111111111111111111111111110101010111000101010001010101010101010101010101010101010101001101100011111001011111111010110110,
	240'b101101101111111111110000111110101111111111111111111111111111111111111111111101111001000101111011011111010111110010111101111111101111111111111111111111111110010101111011010100000101010101010101010101010101001101100011111001011111111010110101,
	240'b101101101111111111110000111110101111111111111111111111111111111111111111111101010110110001001110010011100110011011101001111111111111111111111111111111111111111111101000011110000101000001010101010101010101001101100011111001011111111010110101,
	240'b101101101111111111101110111110011111111111111111111111111111111111111111111101010110111101010010010101000101011010100011111111011111111111111111111111111111111111111111111000010110100101010010010101010101001101100011111001011111111010110101,
	240'b101101101111111111101001111101101111111111111111111111111111111111111111111101010110110101001110010101010101010001010101101100001111111111111111111111111111111111111111111111111100011101011001010101000101001101100011111001011111111010110101,
	240'b101101101111111111100001111010001111111111111111111111111111111111111111111100101000011010010001010101100101010001010011010110011011111111111111111111111111111111111111111111111111111010011011010100000101001101100011111001011111111010110101,
	240'b101101101111111111010111110100111111111111111111111111111111111111111111111110001101111011101100100110100101000101010101010100100101111111001101111111111111111111111111111111111111111111101010011010100101000001100011111001011111111010110110,
	240'b101101101111111111010001101100111111111111111111111111111111111111111111111111111101010101111001110110001000111101010000010101010101000101100111110110101111111111111111111111111111111111111111101100000100111101100010111001011111111010110110,
	240'b101101101111111111010001100011011111110111111111111111111111111111111111111111111010100001001010011111001101101110000000010100000101010101010000011110001111001011111111111111111111111111111111111011000110011101100000111001011111111010110110,
	240'b101101101111111111010011011010011110100011111111111111111111111111111111111111111001101101001111010100001000100111011010011101000101000101010100010100111100100111111111111111111111111111111111111111111001110101011110111001011111111010110110,
	240'b101101101111111111010101010101111011101011111111111111111111111111111111111111111010111001001111010101010101000010011000110101010110100101010001010100011011000011111111111111111111111111111111111111111101000101100110111001001111111010110110,
	240'b101101101111111111010110010101010111111011111010111111111111111111111111111111111101111101100000010100100101010001010010101001101100110101100001010011101011011111111111111111111111111111111111111111111111001001111111111000101111111010110110,
	240'b101101101111111111010110010110000101011011001101111111111111111111111111111111111111111110111000010101100101001101010100010101011011010011000001011001001101110011111111111111111111111111111111111111111111111010100010111000001111111010110101,
	240'b101101101111111111010110010110010100111110000001111110011111111111111111111111111111111111111110101010000101001101010100010100110101101010111101110111101110011111111100111111111111111111111111111111111111111111000100111000101111110110110101,
	240'b101101101111111111010110010110010101001101010101101110111111111111111111111111111111111111111111111110111001101001010001010101010101001001100010101011101001100111111001111111111111111111111111111111111111111111011111111001111111110110110101,
	240'b101101101111111111010110010110010101010001010010011010011110010111111111111111111111111111111111111111111111011010001110010100000101010101010100010011110111111111111100111111111111111111111111111111111111111111101111111010111111110010110101,
	240'b101101101111111111010110010110010101010001010101010100011000010111110101111111111111111111111111111111111111111111110000100000100101001001010101010011111000000011111100111111111111111111111111111111111111111111110100111100001111110010110101,
	240'b101101101111111111010110010110010101010001010101010101010101000110011011111110101111111111111111111111111111111111111111110110110101110001010001010011100111111011111100111111111111111111111111111111111111111111110110111100111111110010110110,
	240'b101101101111111111010110010110010101010001010101010101010101010001010011101000001111101011111111111111111111111111111101101011000110010101100101011000101000110111111100111111111111111111111111111111111111111111110110111101001111110010110110,
	240'b101101101111111111010110010110010101010001010101010101010101010101010100010100111001001111110000111111111111111111111110111011111110111011101110111011101111001111111111111111111111111111111111111111111111111111110001111011011111110010110110,
	240'b101101101111111111010110010110000100111101010000010101000101010101010101010101000101000001111100110101111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111001101111001001111110110110110,
	240'b101101101111111111010101010111100111111110000101011000010101010001010101010101010101010101010001011000001010001111101000111111111111111111111111111111111111111111111111111111111111111111111111111111111111000110000111111000011111111010110110,
	240'b101101101111111111010011011010111110111011111000011110000101000001010101010101010101010101010101010100110101000101101000100111111101011111110110111111111111111111111111111111111111111111111111111100101001000101100000111001011111111010110110,
	240'b101101101111111111010011011010111101110011111111110011010101111101010010010101010101010101010101010101010101010101010010010100000101110001110110100110101011010011000111110100001101000010110110011110100101000001100010111001011111111010110101,
	240'b101101101111111111010101011000001001000011010010111111111011111001011010010101000101010101010101010101010101010101010101010101010101010001010001010100000101000101010111010110100101101001010010010100010101001101100011111001011111111010110101,
	240'b101101101111111111010101010110111100110011000010110101111111111110011111010100010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100010101000101010001010101010101010101001101100011111001011111111010110101,
	240'b101101101111111111010101010110011100101011111100101101101110010011001010010101000101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101001101100011111001011111111010110101,
	240'b101101101111111111010110010101100111101111110000111101001011100010011000010101000101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101001101100011111001011111111010110101,
	240'b101101101111111111010110010110010100111110001011111101111110111110110010010111000101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101001101100011111001011111111010110110,
	240'b101101001111111111011010010110010101001101010001100111011111111111100111010111000101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101001101100100111010001111111010110011,
	240'b101001111111110111110010011100010100111001010000011011101011110110101010010101110101001001010011010100110101001101010011010100110101001101010011010100110101001101010011010100110101001101010011010100110100110110000001111110101111100010100001,
	240'b101101011110100111111111110100100111100001100101011001100110001101100011011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001010111111111011101111111111101111110110000,
	240'b111011011100001011111011111111111111010111101011111011001110101111101100111011001110110011101100111011001110110011101100111011001110110011101100111011001110110011101100111011001110110011101100111011001111100011111111111101101100000111110011,
	240'b111110111101011011000010111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101110101111011101111111111011,
	240'b111011111111001111011111101010011010010010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101010001010101000110110101111001011101111,
	240'b111111111111111111011110100111111001111110110000101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101011111001110010101100111100111111111111111111,
	240'b111111111110011010111000111001001111110011111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111101111011110101111001110111111111111,
	240'b111101001011111111110100111111111111111111111000111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111110001111111111111111111011011100000011111001,
	240'b101111101110001011111111111000111001001101111011011110110111101101111011011110110111101101111011011110110111101101111011011110110111101101111011011110110111101101111011011101110111011101111010011111001001101111101011111111111101100110111101,
	240'b101001101111101111111000011111110100110101010001010100010101000101010001010100010101000101010001010100010101000101010001010100010101000101010001010100010101000001011010100111001010000101100010010011110100110110010000111111011111010110011111,
	240'b101100101111111111011110010110110101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101001001101000111101001111101001111111010100000101001001100110111010111111111010110001,
	240'b101101101111111111010101010110010101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101001001100110110011011111110111100001011011000100111101100011111001011111111010110101,
	240'b101101101111111111010110010110010101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010001011000100101101100010011111111110100110110000101100001111001011111111010110101,
	240'b101101101111111111010110010110010101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010001011000110101111100110011001001111111111010101101011110111001011111111010110101,
	240'b101101101111111111010110010110010101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010011110000011111111110111111110101111100010101011111111001011111111010110101,
	240'b101101101111111111010110010110010101010001010010010100000101001001010001010011110101000001010001010100110101010101010101010101010101010101010101010101010101010101010010011011001110000111111101101111111000101101100011111001011111111010110110,
	240'b101101101111111111010110010110010101000001101100100111011011010010110001101001111001001101111000010111110101001001010001010101000101010101010101010101010101010101010101010100000111100011101010111110001011111001101011111001001111111010110110,
	240'b101101101111111111010110010101101000110011101000111111111111111111111111111111111111111111110111110111111011011110000000010110000101000101010100010101010101010101010101010101010100111110001111111111111110000001101011111001001111111010110110,
	240'b101101101111111111010010011111111111001011111111111111111111111111111111111111111111111111111111111111111111111111111001110010111000000001010011010100110101010101010101010101010101001101101101101000111001000001100111111001011111111010110110,
	240'b101101101111111111010110110010111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111011110110011011000010101000101010101010101010101010101010100010100010101000001100011111001011111111010110110,
	240'b101101101111111111100111111100111111111111111111111111111111111111111111111111111111100111111000111110011111100011110111111111111111111111111111110101010111000101010001010101010101010101010101010101010101001101100011111001011111111010110110,
	240'b101101101111111111110000111110101111111111111111111111111111111111111111111101111001000101111011011111010111110010111101111111101111111111111111111111111110010101111011010100000101010101010101010101010101001101100011111001011111111010110101,
	240'b101101101111111111110000111110101111111111111111111111111111111111111111111101010110110001001110010011100110011011101001111111111111111111111111111111111111111111101000011110000101000001010101010101010101001101100011111001011111111010110101,
	240'b101101101111111111101110111110011111111111111111111111111111111111111111111101010110111101010010010101000101011010100011111111011111111111111111111111111111111111111111111000010110100101010010010101010101001101100011111001011111111010110101,
	240'b101101101111111111101001111101101111111111111111111111111111111111111111111101010110110101001110010101010101010001010101101100001111111111111111111111111111111111111111111111111100011101011001010101000101001101100011111001011111111010110101,
	240'b101101101111111111100001111010001111111111111111111111111111111111111111111100101000011010010001010101100101010001010011010110011011111111111111111111111111111111111111111111111111111010011011010100000101001101100011111001011111111010110101,
	240'b101101101111111111010111110100111111111111111111111111111111111111111111111110001101111011101100100110100101000101010101010100100101111111001101111111111111111111111111111111111111111111101010011010100101000001100011111001011111111010110110,
	240'b101101101111111111010001101100111111111111111111111111111111111111111111111111111101010101111001110110001000111101010000010101010101000101100111110110101111111111111111111111111111111111111111101100000100111101100010111001011111111010110110,
	240'b101101101111111111010001100011011111110111111111111111111111111111111111111111111010100001001010011111001101101110000000010100000101010101010000011110001111001011111111111111111111111111111111111011000110011101100000111001011111111010110110,
	240'b101101101111111111010011011010011110100011111111111111111111111111111111111111111001101101001111010100001000100111011010011101000101000101010100010100111100100111111111111111111111111111111111111111111001110101011110111001011111111010110110,
	240'b101101101111111111010101010101111011101011111111111111111111111111111111111111111010111001001111010101010101000010011000110101010110100101010001010100011011000011111111111111111111111111111111111111111101000101100110111001001111111010110110,
	240'b101101101111111111010110010101010111111011111010111111111111111111111111111111111101111101100000010100100101010001010010101001101100110101100001010011101011011111111111111111111111111111111111111111111111001001111111111000101111111010110110,
	240'b101101101111111111010110010110000101011011001101111111111111111111111111111111111111111110111000010101100101001101010100010101011011010011000001011001001101110011111111111111111111111111111111111111111111111010100010111000001111111010110101,
	240'b101101101111111111010110010110010100111110000001111110011111111111111111111111111111111111111110101010000101001101010100010100110101101010111101110111101110011111111100111111111111111111111111111111111111111111000100111000101111110110110101,
	240'b101101101111111111010110010110010101001101010101101110111111111111111111111111111111111111111111111110111001101001010001010101010101001001100010101011101001100111111001111111111111111111111111111111111111111111011111111001111111110110110101,
	240'b101101101111111111010110010110010101010001010010011010011110010111111111111111111111111111111111111111111111011010001110010100000101010101010100010011110111111111111100111111111111111111111111111111111111111111101111111010111111110010110101,
	240'b101101101111111111010110010110010101010001010101010100011000010111110101111111111111111111111111111111111111111111110000100000100101001001010101010011111000000011111100111111111111111111111111111111111111111111110100111100001111110010110101,
	240'b101101101111111111010110010110010101010001010101010101010101000110011011111110101111111111111111111111111111111111111111110110110101110001010001010011100111111011111100111111111111111111111111111111111111111111110110111100111111110010110110,
	240'b101101101111111111010110010110010101010001010101010101010101010001010011101000001111101011111111111111111111111111111101101011000110010101100101011000101000110111111100111111111111111111111111111111111111111111110110111101001111110010110110,
	240'b101101101111111111010110010110010101010001010101010101010101010101010100010100111001001111110000111111111111111111111110111011111110111011101110111011101111001111111111111111111111111111111111111111111111111111110001111011011111110010110110,
	240'b101101101111111111010110010110000100111101010000010101000101010101010101010101000101000001111100110101111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111001101111001001111110110110110,
	240'b101101101111111111010101010111100111111110000101011000010101010001010101010101010101010101010001011000001010001111101000111111111111111111111111111111111111111111111111111111111111111111111111111111111111000110000111111000011111111010110110,
	240'b101101101111111111010011011010111110111011111000011110000101000001010101010101010101010101010101010100110101000101101000100111111101011111110110111111111111111111111111111111111111111111111111111100101001000101100000111001011111111010110110,
	240'b101101101111111111010011011010111101110011111111110011010101111101010010010101010101010101010101010101010101010101010010010100000101110001110110100110101011010011000111110100001101000010110110011110100101000001100010111001011111111010110101,
	240'b101101101111111111010101011000001001000011010010111111111011111001011010010101000101010101010101010101010101010101010101010101010101010001010001010100000101000101010111010110100101101001010010010100010101001101100011111001011111111010110101,
	240'b101101101111111111010101010110111100110011000010110101111111111110011111010100010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100010101000101010001010101010101010101001101100011111001011111111010110101,
	240'b101101101111111111010101010110011100101011111100101101101110010011001010010101000101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101001101100011111001011111111010110101,
	240'b101101101111111111010110010101100111101111110000111101001011100010011000010101000101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101001101100011111001011111111010110101,
	240'b101101101111111111010110010110010100111110001011111101111110111110110010010111000101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101001101100011111001011111111010110110,
	240'b101101001111111111011010010110010101001101010001100111011111111111100111010111000101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101001101100100111010001111111010110011,
	240'b101001111111110111110010011100010100111001010000011011101011110110101010010101110101001001010011010100110101001101010011010100110101001101010011010100110101001101010011010100110101001101010011010100110100110110000001111110101111100010100001,
	240'b101101011110100111111111110100100111100001100101011001100110001101100011011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001010111111111011101111111111101111110110000,
	240'b111011011100001011111011111111111111010111101011111011001110101111101100111011001110110011101100111011001110110011101100111011001110110011101100111011001110110011101100111011001110110011101100111011001111100011111111111101101100000111110011,
	240'b111110111101011011000010111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101110101111011101111111111011,
	240'b111011111111001111011111101010011010010010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101010001010101000110110101111001011101111,
	240'b111111111111111111011110100111111001111110110000101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101011111001110010101100111100111111111111111111,
	240'b111111111110011010111000111001001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111110111111101111011110101111001110111111111111,
	240'b111101001011111111110100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111011011100000011111001,
	240'b101111101110000111111111111111111111111011111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111111011111111111111111101100110111101,
	240'b101001101111101011111111111111101111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111101111111011111101111111011111110111111110111111111111010010011111,
	240'b101100101111111111111110111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111111111111111111101111111011111110111111101111111111111101110110001,
	240'b101101101111111111111110111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111101111111111111111111111011111110111111101111111111111101110110101,
	240'b101101101111111111111110111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111101111111011111111111111111111110111111101111111111111101110110101,
	240'b101101101111111111111110111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111111111111011111110111111111111111011111101111111111111101110110101,
	240'b101101101111111111111110111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111101111111111111110111111101111111011111101111111111111101110110101,
	240'b101101101111111111111110111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111111111111111111111101111111011111101111111111111101110110110,
	240'b101101101111111111111110111111011111110111111101111111101111111011111110111111101111111011111110111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111111111111111111111011111101111111111111101110110110,
	240'b101101101111111111111110111111011111111011111111111111111111111111111111111111111111111111111111111111111111111011111101111111011111110111111101111111011111110111111101111111011111110111111110111111111111111111111101111111111111101110110110,
	240'b101101101111111111111110111111011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101111110111111101111111011111110111111101111111011111110111111101111111101111111011111101111111111111101110110110,
	240'b101101101111111111111110111111101111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110111111011111110111111101111111011111110111111101111111011111110111111101111111111111101110110110,
	240'b101101101111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110111111101111111011111110111111101111111011111110111111101111111111111101110110110,
	240'b101101101111111111111111111111111111111111111111111111111111111111111111111111111111111011111110111111101111111011111110111111111111111111111111111111111111111111111101111111011111110111111101111111011111110111111101111111111111101110110101,
	240'b101101101111111111111111111111111111111111111111111111111111111111111111111111111111110111111101111111011111110111111111111111111111111111111111111111111111111111111111111111011111110111111101111111011111110111111101111111111111101110110101,
	240'b101101101111111111111111111111111111111111111111111111111111111111111111111111111111110111111101111111011111110111111110111111111111111111111111111111111111111111111111111111111111110111111101111111011111110111111101111111111111101110110101,
	240'b101101101111111111111111111111111111111111111111111111111111111111111111111111111111110111111101111111011111110111111101111111101111111111111111111111111111111111111111111111111111111011111101111111011111110111111101111111111111101110110101,
	240'b101101101111111111111111111111111111111111111111111111111111111111111111111111111111111011111110111111011111110111111101111111011111111011111111111111111111111111111111111111111111111111111110111111011111110111111101111111111111101110110101,
	240'b101101101111111111111110111111101111111111111111111111111111111111111111111111111111111111111111111111101111110111111101111111011111110111111110111111111111111111111111111111111111111111111111111111011111110111111101111111111111101110110110,
	240'b101101101111111111111110111111101111111111111111111111111111111111111111111111111111111011111101111111111111111011111101111111011111110111111101111111111111111111111111111111111111111111111111111111101111110111111101111111111111101110110110,
	240'b101101101111111111111110111111101111111111111111111111111111111111111111111111111111111011111101111111011111111111111101111111011111110111111101111111011111111111111111111111111111111111111111111111111111110111111101111111111111101110110110,
	240'b101101101111111111111110111111011111111111111111111111111111111111111111111111111111111011111101111111011111110111111111111111011111110111111101111111011111111011111111111111111111111111111111111111111111111011111101111111111111101110110110,
	240'b101101101111111111111110111111011111111011111111111111111111111111111111111111111111111011111101111111011111110111111110111111111111110111111101111111011111111011111111111111111111111111111111111111111111111011111101111111111111101110110110,
	240'b101101101111111111111110111111011111111011111111111111111111111111111111111111111111111111111101111111011111110111111101111111101111111111111101111111011111111011111111111111111111111111111111111111111111111111111101111111111111101110110110,
	240'b101101101111111111111110111111011111110111111111111111111111111111111111111111111111111111111110111111011111110111111101111111011111111011111110111111011111111111111111111111111111111111111111111111111111111111111110111111111111101110110101,
	240'b101101101111111111111110111111011111110111111101111111111111111111111111111111111111111111111111111111101111110111111101111111011111110111111110111111111111111111111111111111111111111111111111111111111111111111111110111111111111101110110101,
	240'b101101101111111111111110111111011111110111111101111111101111111111111111111111111111111111111111111111111111111011111101111111011111110111111101111111101111111011111111111111111111111111111111111111111111111111111111111111111111101110110101,
	240'b101101101111111111111110111111011111110111111101111111011111111111111111111111111111111111111111111111111111111111111101111111011111110111111101111111011111111011111111111111111111111111111111111111111111111111111111111111111111101110110101,
	240'b101101101111111111111110111111011111110111111101111111011111111011111111111111111111111111111111111111111111111111111111111111011111110111111101111111011111111011111111111111111111111111111111111111111111111111111111111111111111101110110101,
	240'b101101101111111111111110111111011111110111111101111111011111110111111110111111111111111111111111111111111111111111111111111111111111110111111101111111011111111011111111111111111111111111111111111111111111111111111111111111111111101110110110,
	240'b101101101111111111111110111111011111110111111101111111011111110111111101111111101111111111111111111111111111111111111111111111101111110111111101111111011111111011111111111111111111111111111111111111111111111111111111111111111111101110110110,
	240'b101101101111111111111110111111011111110111111101111111011111110111111101111111011111111011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101110110110,
	240'b101101101111111111111110111111011111110111111101111111011111110111111101111111011111110111111101111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110111111111111101110110110,
	240'b101101101111111111111110111111011111111011111110111111011111110111111101111111011111110111111101111111011111111011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101111111111111101110110110,
	240'b101101101111111111111110111111011111111111111111111111011111110111111101111111011111110111111101111111011111110111111101111111101111111111111111111111111111111111111111111111111111111111111111111111111111111011111101111111111111101110110110,
	240'b101101101111111111111110111111011111111111111111111111101111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111101111111011111110111111101111111011111110111111011111110111111101111111111111101110110101,
	240'b101101101111111111111110111111011111111011111111111111111111111011111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111111111101110110101,
	240'b101101101111111111111110111111011111111111111110111111111111111111111110111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111111111101110110101,
	240'b101101101111111111111110111111011111111011111111111111101111111111111110111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111111111101110110101,
	240'b101101101111111111111110111111011111110111111111111111111111111011111110111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111111111101110110101,
	240'b101101101111111111111110111111011111110111111110111111111111111111111110111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111111111101110110110,
	240'b101101001111111111111110111111011111110111111101111111101111111111111111111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111111111101110110011,
	240'b101001111111110011111111111111011111110111111101111111011111111011111110111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111111111011110100001,
	240'b101101011110100011111111111111111111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111111111111111101111110110000,
	240'b111011011100001011111011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101101100000111110011,
	240'b111110111101011011000010111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101110101111011101111111111011,
	240'b111011111111001111011111101010011010010010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101010001010101000110110101111001011101111,
};
assign data = picture[addr];
endmodule