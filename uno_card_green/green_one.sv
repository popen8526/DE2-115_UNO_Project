module green_one(
	input [7:0] addr,
	output [239:0] data
);
parameter [0:149][239:0] picture = {
	240'b111100111111111111101111101001111001111010101001101010101010101010101010101010101010101110101011101010111010101110101011101010101010101010101010101010101010101010101011101010111010101110101011101010001001101010101010111011001111000111110101,
	240'b111101011111001111000001110100101110110111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111111001111110001110100011001001101111101110101111110110,
	240'b111100011100000111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110011100000111110100,
	240'b110000001101011111111111111100011010110110010011100100111001001110010011100100111001001110010011100100111001001110010011100100111001001110010011100100111001001110010011100100111001001110010000100100001011101011111011111111111100011111000000,
	240'b101000011111011011111100100100100100111001001111010100000101000001010000010100000101000001010000010100000101000001010000010100000101000001010000010100000101000001010000010100000100111101110111011110100101000110101111111111111110011010011010,
	240'b101011111111111111100101010111110101001001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101000101010011000110111110101000100001110010111110001111001110101111,
	240'b101101011111111111011010010111000101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101000101010011000101111010101011111001110000111100011111010010110111,
	240'b101101011111111111011010010111000101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101000101010011001001101101100111000001110010111100101111010010110111,
	240'b101101011111111111011010010111000101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101000101010011001001101100110100110001101110111100101111010010110111,
	240'b101101011111111111011010010111000101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101000101010011001001101101000100111001101110111100101111010010110111,
	240'b101101011111111111011010010111000101010001010011010100000100111101001111010100000101000101010010010101000101010101010101010101010101010101010101010101010101010101010101010101000101010011001001101101000100111001101110111100101111010010110111,
	240'b101101001111111111011010010111000101000001100011100100011010011110100011100110011000010001101100010110100101000001010010010101000101010101010101010101010101010101010101010101000101010011001100101101100100111001101110111100101111010010110111,
	240'b101101001111111111011010010110000111110111011110111111111111111111111111111111111111101111110001110100101010010101110001010101000101000101010101010101010101010101010101010101000101010010110010101000010100111101101110111100101111010010110111,
	240'b101101001111111111010111011110011110101011111111111111111111111111111111111111111111111111111111111111111111111111110001101111010111001101010001010100110101010101010101010101010101010101011001010110000101001001101110111100101111010010110111,
	240'b101101001111111111011001110001001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111000010100011010110100101001001010101010101010101010101010100010101000101001001101110111100101111010010110111,
	240'b101101001111111111101000111100001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110001110110011101010001010101010101010101010101010101010101001001101110111100101111010010110111,
	240'b101101011111111111110000111110101111111111111111111111111111111111111111111111111111111111111111111111111111000011100011111010001111111111111111111111111101101101101110010100010101010101010101010101010101001001101110111100101111010010110111,
	240'b101101011111111111110001111110011111111111111111111111111111111111111111111111111111111111111111111111111010100001011100011000111011101111111111111111111111111111011101011011000101000101010101010101010101001001101110111100101111010010110111,
	240'b101101011111111111101111111110011111111111111111111111111111111111111111111111111111111111111111111111111010000001001110010100010101110011000111111111111111111111111111110100110110000101010010010101010101001001101110111100101111010010110111,
	240'b101101011111111111101010111101011111111111111111111111111111111111111111111111111111111111111111111111111010000101010000010101010100111101100101111000011111111111111111111111111011100001010100010101000101001001101110111100101111010010110111,
	240'b101101011111111111100011111001101111111111111111111111111111111111111111111111111111111111111111111111111010000101001110011011000111100001010001110010111111111111111111111111111111101110001011010100000101001001101110111100101111010010110111,
	240'b101101011111111111011011110100011111111111111111111111111111111111111111111111111111111111111111111111111010000101001100011110111101111001110110110010001111111111111111111111111111111111011110011000010101000001101110111100101111010010110111,
	240'b101101001111111111010101101100001111111111111111111111111111111111111111111111111111111111111111111111111010000101001100011101111111101111011110110111101111111111111111111111111111111111111111101000000100110101101110111100101111010010110111,
	240'b101101001111111111010110100010101111110011111111111111111111111111111111111111111111111111111111111111111010000101001100011101111111011111111111111111111111111111111111111111111111111111111111111000010101110101101100111100101111010010110111,
	240'b101101001111111111011000011010001110001111111111111111111111111111111111111111111111111111111111111111111010000101001100011101111111011111111111111111111111111111111111111111111111111111111111111111101000110001101001111100101111010010110111,
	240'b101101001111111111011010010110001011010011111111111111111111111111111111111111111111111111111111111111111010000101001100011101111111011111111111111111111111111111111111111111111111111111111111111111111100000101101101111100011111010010110111,
	240'b101101001111111111011010010110000111100011111000111111111111111111111111111111111111111111111111111111111010000101001100011101111111011111111111111111111111111111111111111111111111111111111111111111111110100010000000111100001111010010110111,
	240'b101101011111111111011010010110110101010011000111111111111111111111111111111111111111111111111111111111111010000101001100011101111111011111111111111111111111111111111111111111111111111111111111111111111111101110011110111011011111010010110111,
	240'b101101011111111111011010010111000100111101111011111101111111111111111111111111111111111111111111111111111010000101001100011101111111011111111111111111111111111111111111111111111111111111111111111111111111111110111110111011011111010010110111,
	240'b101101011111111111011010010111000101001101010011101101001111111111111111111111111111111111111111111111111010000101001100011101111111011111111111111111111111111111111111111111111111111111111111111111111111111111011010111011111111001110110111,
	240'b101101011111111111011010010111000101010001010010011001001101111111111111111111111111111111111111111111111010000101001100011101111111011111111111111111111111111111111111111111111111111111111111111111111111111111101011111100101111001110110111,
	240'b101101011111111111011010010111000101010001010101010100010111110111110001111111111111111111111111111111111010000001001011011101101111011111111111111111111111111111111111111111111111111111111111111111111111111111110001111101011111001110110111,
	240'b101101011111111111011010010111000101010001010101010101010101000110010001111101111111111111111111111111111010010001010001011110111111011111111111111111111111111111111111111111111111111111111111111111111111111111110011111101111111001110110111,
	240'b101101001111111111011010010111000101010001010101010101010101010001010001100101011111010111111111111111111110011111010000110111001111110111111111111111111111111111111111111111111111111111111111111111111111111111110100111101111111001110110111,
	240'b101101001111111111011010010111000101010001010101010101010101010101010100010100011000100011101010111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101011111100101111001110110111,
	240'b101101001111111111011010010111000101010001010100010101010101010101010101010101010101000101110001110001111111111011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110111111111011101111010010110111,
	240'b101101001111111111011010010111000101010001010101010101010101010101010101010101010101010101010001010110011001000111011001111111101111111111111111111111111111111111111111111111111111111111111111111111111101110101111111111100001111010010110111,
	240'b101101001111111111011010010110110101010110101100100011100101000101010101010101010101010101010101010101000101000001011111100011111100100011101011111111111111111111111111111111111111111111111111110111110111011001101010111100101111010010110111,
	240'b101101011111111111011010010110110101011011010111101010110100111101010101010101010101010101010101010101010101010101010011010100000101010101101010100001101010000010110101101111111011111010011010011001010100111001101110111100101111010010110111,
	240'b101101011111111111011010010110110101011011010011101010000100111101010101010101010101010101010101010101010101010101010101010101010101010001010010010100000101000101010001010100010101000101010000010100110101001001101110111100101111010010110111,
	240'b101101011111111111011010010110110101011011010011101010000100111101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101001001101110111100101111010010110111,
	240'b101101011111111111011010010110100101010011010011101010000100111101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101001001101110111100101111010010110111,
	240'b101101011111111111011001011000110110101011010001101010000100111101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101001001101110111100101111010010110111,
	240'b101101011111111111011000011011011100110011101010101001100100111101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101001001101110111100101111010010110111,
	240'b101100011111111111100001010111111011010011111111101001100100111101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101000101110010111101111111010010110010,
	240'b101000011111100011111010100000110101010110010011011100110100111001010000010100000101000001010000010100000101000001010000010100000101000001010000010100000101000001010000010100000101000001010000010100000100111010100010111111111110100110011011,
	240'b101101101101111011111111111001111001010101111001011111011000000001111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111111010010011110100111111111100110010110100,
	240'b111011001100000011110001111111111111111111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111111001111111111111111111000111011110011110000,
	240'b111110011110011110111011110111111111100011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010011010111101111101110110111111000,
	240'b111110111111001011100000101000001001101110110010101101001011010010110100101101001011010010110100101101001011010010110100101101001011010010110100101101001011010010110100101101001011010010110100101011111001011110110101111110001111111111111001,
	240'b111100111111111111101111101001111001111010101001101010101010101010101010101010101010101110101011101010111010101110101011101010101010101010101010101010101010101010101011101010111010101110101011101010001001101010101010111011001111000111110101,
	240'b111101011111001111000001110100101110110111111000111110001111100011111000111110001111100011111000111110001111100011111000111110001111100011111000111110001111100011111000111110001111100011111000111110001110100011001001101111101110101111110110,
	240'b111100011100000111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110011100000111110100,
	240'b110000001101011111111111111110001101011011001001110010011100100111001001110010011100100111001001110010011100100111001001110010011100100111001001110010011100100111001001110010011100100111000111110010001101110111111101111111111100011111000000,
	240'b101000011111010111111110110010011010011110100111101001111010011110100111101001111010011110100111101001111010011110100111101001111010011110100111101001111010011110100111101001111010011110111011101111001010100011010111111111111110011010011010,
	240'b101011111111111111110010101011111010100110101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100111100011111111001100001110111000111111001111001110101111,
	240'b101101011111111111101101101011011010100110101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100111100010111101001101111010110111111110011111001110110111,
	240'b101101011111111111101101101011011010100110101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100111100100110110101011011110111000111110011111001110110111,
	240'b101101011111111111101101101011011010100110101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100111100100110110011010010110110110111110011111001110110111,
	240'b101101011111111111101101101011011010100110101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100111100100110110011010011010110110111110011111001110110111,
	240'b101101011111111111101101101011011010100110101001101010001010011110100111101001111010100010101001101010011010101010101010101010101010101010101010101010101010101010101010101010101010100111100100110110011010011010110110111110011111001110110111,
	240'b101101001111111111101101101011011010011110110001110010001101001111010001110011001100000110110101101011001010100010101000101010101010101010101010101010101010101010101010101010101010100111100101110110101010011010110110111110011111001110110111,
	240'b101101001111111111101101101010111011111011101110111111111111111111111111111111111111110111111000111010001101001010111000101010011010100010101010101010101010101010101010101010101010100111011001110100001010011110110110111110011111001110110111,
	240'b101101001111111111101011101111001111010011111111111111111111111111111111111111111111111111111111111111111111111111111000110111101011100110101000101010011010101010101010101010101010101010101100101011001010100010110110111110011111001110110111,
	240'b101101001111111111101100111000101111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111011111010001101011001010100010101010101010101010101010101010101010101010100010110110111110011111001110110111,
	240'b101101001111111111110011111110001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111000111011001110101000101010101010101010101010101010101010100010110110111110011111001110110111,
	240'b101101011111111111111000111111001111111111111111111111111111111111111111111111111111111111111111111111111111100011110001111100111111111111111111111111111110110110110111101010001010101010101010101010101010100010110110111110011111001110110111,
	240'b101101011111111111111000111111001111111111111111111111111111111111111111111111111111111111111111111111111101001110101101101100011101110111111111111111111111111111101110101101101010100010101010101010101010100010110110111110011111001110110111,
	240'b101101011111111111110111111111001111111111111111111111111111111111111111111111111111111111111111111111111100111110100111101010001010111011100011111111111111111111111111111010011011000010101001101010101010100010110110111110011111001110110111,
	240'b101101011111111111110101111110101111111111111111111111111111111111111111111111111111111111111111111111111101000010101000101010101010011110110010111100001111111111111111111111111101110010101010101010101010100010110110111110011111001110110111,
	240'b101101011111111111110001111100111111111111111111111111111111111111111111111111111111111111111111111111111101000010100111101101101011110010101000111001011111111111111111111111111111110111000101101010001010100010110110111110011111001110110111,
	240'b101101011111111111101101111010001111111111111111111111111111111111111111111111111111111111111111111111111101000010100110101111011110111110111010111001001111111111111111111111111111111111101111101100001010011110110110111110011111001110110111,
	240'b101101001111111111101010110110001111111111111111111111111111111111111111111111111111111111111111111111111101000010100110101110111111110111101110111011101111111111111111111111111111111111111111110011111010011010110110111110011111001110110111,
	240'b101101001111111111101010110001011111110111111111111111111111111111111111111111111111111111111111111111111101000010100110101110111111101111111111111111111111111111111111111111111111111111111111111100001010111010110110111110011111001110110111,
	240'b101101001111111111101100101101001111000111111111111111111111111111111111111111111111111111111111111111111101000010100110101110111111101111111111111111111111111111111111111111111111111111111111111111111100010110110100111110011111001110110111,
	240'b101101001111111111101100101011001101101011111111111111111111111111111111111111111111111111111111111111111101000010100110101110111111101111111111111111111111111111111111111111111111111111111111111111111110000010110110111110011111001110110111,
	240'b101101001111111111101101101010111011110011111100111111111111111111111111111111111111111111111111111111111101000010100110101110111111101111111111111111111111111111111111111111111111111111111111111111111111010010111111111110001111001110110111,
	240'b101101011111111111101101101011011010101011100011111111111111111111111111111111111111111111111111111111111101000010100110101110111111101111111111111111111111111111111111111111111111111111111111111111111111110111001110111101111111001110110111,
	240'b101101011111111111101101101011011010011110111101111110111111111111111111111111111111111111111111111111111101000010100110101110111111101111111111111111111111111111111111111111111111111111111111111111111111111111011111111101111111001110110111,
	240'b101101011111111111101101101011011010100110101001110110011111111111111111111111111111111111111111111111111101000010100110101110111111101111111111111111111111111111111111111111111111111111111111111111111111111111101100111110001111001010110111,
	240'b101101011111111111101101101011011010100110101001101100011110111111111111111111111111111111111111111111111101000010100110101110111111101111111111111111111111111111111111111111111111111111111111111111111111111111110101111110011111001010110111,
	240'b101101011111111111101101101011011010100110101010101010001011111011111000111111111111111111111111111111111101000010100101101110111111101111111111111111111111111111111111111111111111111111111111111111111111111111111000111110111111001010110111,
	240'b101101011111111111101101101011011010100110101010101010101010100011001000111110111111111111111111111111111101000110101000101111011111101111111111111111111111111111111111111111111111111111111111111111111111111111111001111111001111001010110111,
	240'b101101001111111111101101101011011010100110101010101010101010101010101000110010101111101011111111111111111111001111101000111011011111111011111111111111111111111111111111111111111111111111111111111111111111111111111001111111001111001010110111,
	240'b101101001111111111101101101011011010100110101010101010101010101010101010101010001100001111110100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110101111110011111001010110111,
	240'b101101001111111111101101101011011010100110101010101010101010101010101010101010101010100010111000111000111111111011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111011111111101111111001110110111,
	240'b101101001111111111101101101011011010100110101010101010101010101010101010101010101010101010101000101011001100100011101100111111111111111111111111111111111111111111111111111111111111111111111111111111111110111010111111111110001111001110110111,
	240'b101101001111111111101101101011011010101011010101110001111010100010101010101010101010101010101010101010011010100010101111110001111110010011110101111111111111111111111111111111111111111111111111111011111011101010110100111110011111001110110111,
	240'b101101011111111111101101101011011010101011101011110101011010011110101010101010101010101010101010101010101010101010101001101010001010101010110100110000101101000011011010110111111101111011001101101100101010011010110110111110011111001110110111,
	240'b101101011111111111101101101011011010101011101001110101001010011110101010101010101010101010101010101010101010101010101010101010101010101010101001101010001010100010101000101010001010100010101000101010011010100010110110111110011111001110110111,
	240'b101101011111111111101101101011011010101011101001110101001010011110101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100010110110111110011111001110110111,
	240'b101101011111111111101101101011011010100111101001110101001010011110101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100010110110111110011111001110110111,
	240'b101101011111111111101100101100011011010011101000110101001010011110101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100010110110111110011111001110110111,
	240'b101101011111111111101100101101101110010111110101110100101010011110101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100010110110111110011111001110110111,
	240'b101100011111111111110000101011111101100111111111110100111010011110101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100010111001111111001111001110110010,
	240'b101000011111100011111101110000011010101011001001101110011010011110101000101010001010100010101000101010001010100010101000101010001010100010101000101010001010100010101000101010001010100010101000101001111010011111010001111111111110100110011011,
	240'b101101101101111011111111111100111100101010111100101111101011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111101001011111010111111111100110010110100,
	240'b111011001100000011110001111111111111111111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111101111111111111111111000111011110011110000,
	240'b111110011110011110111011110111111111100011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010011010111101111101110110111111000,
	240'b111110111111001011100000101000001001101110110010101101001011010010110100101101001011010010110100101101001011010010110100101101001011010010110100101101001011010010110100101101001011010010110100101011111001011110110101111110001111111111111001,
	240'b111100111111111111101111101001111001111010101001101010101010101010101010101010101010101110101011101010111010101110101011101010101010101010101010101010101010101010101011101010111010101110101011101010001001101010101010111011001111000111110101,
	240'b111101011111001111000001110100101110110111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111111001111110001110100011001001101111101110101111110110,
	240'b111100011100000111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110011100000111110100,
	240'b110000001101011111111111111100011010110110010011100100111001001110010011100100111001001110010011100100111001001110010011100100111001001110010011100100111001001110010011100100111001001110010000100100001011101011111011111111111100011111000000,
	240'b101000011111011011111100100100100100111001001111010100000101000001010000010100000101000001010000010100000101000001010000010100000101000001010000010100000101000001010000010100000100111101110111011110100101000110101111111111111110011010011010,
	240'b101011111111111111100101010111110101001001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101000101010011000110111110101000100001110010111110001111001110101111,
	240'b101101011111111111011010010111000101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101000101010011000101111010101011111001110000111100011111010010110111,
	240'b101101011111111111011010010111000101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101000101010011001001101101100111000001110010111100101111010010110111,
	240'b101101011111111111011010010111000101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101000101010011001001101100110100110001101110111100101111010010110111,
	240'b101101011111111111011010010111000101010001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101000101010011001001101101000100111001101110111100101111010010110111,
	240'b101101011111111111011010010111000101010001010011010100000100111101001111010100000101000101010010010101000101010101010101010101010101010101010101010101010101010101010101010101000101010011001001101101000100111001101110111100101111010010110111,
	240'b101101001111111111011010010111000101000001100011100100011010011110100011100110011000010001101100010110100101000001010010010101000101010101010101010101010101010101010101010101000101010011001100101101100100111001101110111100101111010010110111,
	240'b101101001111111111011010010110000111110111011110111111111111111111111111111111111111101111110001110100101010010101110001010101000101000101010101010101010101010101010101010101000101010010110010101000010100111101101110111100101111010010110111,
	240'b101101001111111111010111011110011110101011111111111111111111111111111111111111111111111111111111111111111111111111110001101111010111001101010001010100110101010101010101010101010101010101011001010110000101001001101110111100101111010010110111,
	240'b101101001111111111011001110001001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111000010100011010110100101001001010101010101010101010101010100010101000101001001101110111100101111010010110111,
	240'b101101001111111111101000111100001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110001110110011101010001010101010101010101010101010101010101001001101110111100101111010010110111,
	240'b101101011111111111110000111110101111111111111111111111111111111111111111111111111111111111111111111111111111000011100011111010001111111111111111111111111101101101101110010100010101010101010101010101010101001001101110111100101111010010110111,
	240'b101101011111111111110001111110011111111111111111111111111111111111111111111111111111111111111111111111111010100001011100011000111011101111111111111111111111111111011101011011000101000101010101010101010101001001101110111100101111010010110111,
	240'b101101011111111111101111111110011111111111111111111111111111111111111111111111111111111111111111111111111010000001001110010100010101110011000111111111111111111111111111110100110110000101010010010101010101001001101110111100101111010010110111,
	240'b101101011111111111101010111101011111111111111111111111111111111111111111111111111111111111111111111111111010000101010000010101010100111101100101111000011111111111111111111111111011100001010100010101000101001001101110111100101111010010110111,
	240'b101101011111111111100011111001101111111111111111111111111111111111111111111111111111111111111111111111111010000101001110011011000111100001010001110010111111111111111111111111111111101110001011010100000101001001101110111100101111010010110111,
	240'b101101011111111111011011110100011111111111111111111111111111111111111111111111111111111111111111111111111010000101001100011110111101111001110110110010001111111111111111111111111111111111011110011000010101000001101110111100101111010010110111,
	240'b101101001111111111010101101100001111111111111111111111111111111111111111111111111111111111111111111111111010000101001100011101111111101111011110110111101111111111111111111111111111111111111111101000000100110101101110111100101111010010110111,
	240'b101101001111111111010110100010101111110011111111111111111111111111111111111111111111111111111111111111111010000101001100011101111111011111111111111111111111111111111111111111111111111111111111111000010101110101101100111100101111010010110111,
	240'b101101001111111111011000011010001110001111111111111111111111111111111111111111111111111111111111111111111010000101001100011101111111011111111111111111111111111111111111111111111111111111111111111111101000110001101001111100101111010010110111,
	240'b101101001111111111011010010110001011010011111111111111111111111111111111111111111111111111111111111111111010000101001100011101111111011111111111111111111111111111111111111111111111111111111111111111111100000101101101111100011111010010110111,
	240'b101101001111111111011010010110000111100011111000111111111111111111111111111111111111111111111111111111111010000101001100011101111111011111111111111111111111111111111111111111111111111111111111111111111110100010000000111100001111010010110111,
	240'b101101011111111111011010010110110101010011000111111111111111111111111111111111111111111111111111111111111010000101001100011101111111011111111111111111111111111111111111111111111111111111111111111111111111101110011110111011011111010010110111,
	240'b101101011111111111011010010111000100111101111011111101111111111111111111111111111111111111111111111111111010000101001100011101111111011111111111111111111111111111111111111111111111111111111111111111111111111110111110111011011111010010110111,
	240'b101101011111111111011010010111000101001101010011101101001111111111111111111111111111111111111111111111111010000101001100011101111111011111111111111111111111111111111111111111111111111111111111111111111111111111011010111011111111001110110111,
	240'b101101011111111111011010010111000101010001010010011001001101111111111111111111111111111111111111111111111010000101001100011101111111011111111111111111111111111111111111111111111111111111111111111111111111111111101011111100101111001110110111,
	240'b101101011111111111011010010111000101010001010101010100010111110111110001111111111111111111111111111111111010000001001011011101101111011111111111111111111111111111111111111111111111111111111111111111111111111111110001111101011111001110110111,
	240'b101101011111111111011010010111000101010001010101010101010101000110010001111101111111111111111111111111111010010001010001011110111111011111111111111111111111111111111111111111111111111111111111111111111111111111110011111101111111001110110111,
	240'b101101001111111111011010010111000101010001010101010101010101010001010001100101011111010111111111111111111110011111010000110111001111110111111111111111111111111111111111111111111111111111111111111111111111111111110100111101111111001110110111,
	240'b101101001111111111011010010111000101010001010101010101010101010101010100010100011000100011101010111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101011111100101111001110110111,
	240'b101101001111111111011010010111000101010001010100010101010101010101010101010101010101000101110001110001111111111011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110111111111011101111010010110111,
	240'b101101001111111111011010010111000101010001010101010101010101010101010101010101010101010101010001010110011001000111011001111111101111111111111111111111111111111111111111111111111111111111111111111111111101110101111111111100001111010010110111,
	240'b101101001111111111011010010110110101010110101100100011100101000101010101010101010101010101010101010101000101000001011111100011111100100011101011111111111111111111111111111111111111111111111111110111110111011001101010111100101111010010110111,
	240'b101101011111111111011010010110110101011011010111101010110100111101010101010101010101010101010101010101010101010101010011010100000101010101101010100001101010000010110101101111111011111010011010011001010100111001101110111100101111010010110111,
	240'b101101011111111111011010010110110101011011010011101010000100111101010101010101010101010101010101010101010101010101010101010101010101010001010010010100000101000101010001010100010101000101010000010100110101001001101110111100101111010010110111,
	240'b101101011111111111011010010110110101011011010011101010000100111101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101001001101110111100101111010010110111,
	240'b101101011111111111011010010110100101010011010011101010000100111101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101001001101110111100101111010010110111,
	240'b101101011111111111011001011000110110101011010001101010000100111101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101001001101110111100101111010010110111,
	240'b101101011111111111011000011011011100110011101010101001100100111101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101001001101110111100101111010010110111,
	240'b101100011111111111100001010111111011010011111111101001100100111101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101000101110010111101111111010010110010,
	240'b101000011111100011111010100000110101010110010011011100110100111001010000010100000101000001010000010100000101000001010000010100000101000001010000010100000101000001010000010100000101000001010000010100000100111010100010111111111110100110011011,
	240'b101101101101111011111111111001111001010101111001011111011000000001111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111111010010011110100111111111100110010110100,
	240'b111011001100000011110001111111111111111111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111111001111111111111111111000111011110011110000,
	240'b111110011110011110111011110111111111100011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010011010111101111101110110111111000,
	240'b111110111111001011100000101000001001101110110010101101001011010010110100101101001011010010110100101101001011010010110100101101001011010010110100101101001011010010110100101101001011010010110100101011111001011110110101111110001111111111111001,
};
assign data = picture[addr];
endmodule