module yellow_seven(
	input [7:0] addr,
	output [239:0] data
);
parameter [0:149][239:0] picture = {
	240'b111110101111101011101001100111111001000010101011101011011010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101101101001111000101110110101111101111111101111111010,
	240'b111111111111011110111111110001111101111111101100111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111010101101110011000100110101001111111111111111,
	240'b111111101100100111011001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110011001101101011111100,
	240'b110011011100101111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111001100010011001000,
	240'b100101001110101111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101010110011101,
	240'b101000101111001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101110110101101,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101101001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011000000,
	240'b101010001111010011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101111110110011,
	240'b100100001110111011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101011110011100,
	240'b101111001101001011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111100010110111000,
	240'b111110011100001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110001101000011110110,
	240'b111111011110111010111011110110101111011111111000111110001111100011111000111110001111100011111000111110001111100011111000111110001111100011111000111110001111100011111000111110001111100011111000111110001111010011010000110001001111100011111101,
	240'b111011111111011111110101101011011001110010101001101010111010101010101010101010101010101010101011101010111010101110101011101010111010101010101010101010101010101010101010101010111010101110101011101010001001100010110011111011111111000111110000,
	240'b111110101111101011101001100111111001000010101011101011011010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101101101001111000101110110101111101111111101111111010,
	240'b111111111111011110111111110001111101111111101100111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111010101101110011000100110101001111111111111111,
	240'b111111101100100111011001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110011001101101011111100,
	240'b110011011100101111111111111111001101111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111111001110110011001100110011001100110011011110010111111111111111001100010011001000,
	240'b100101001110101111111111110101001010100110100111101001111010011110100111101001111010011110100111101001111010011110100111101001111010011110100111101001111010011110101100101111011011111110111111101111111011101111100010111111111101010110011101,
	240'b101000101111010011111010101101011010100010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100010111011111110111111101111111011111111101101110011000000111111111101111010101101,
	240'b101101001111010111110110101100001010100110101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100110110100111101011100110110110110111001011110000110111010111111111110000111000000,
	240'b101101001111010111110110101100001010100110101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101001111000111101100010100101110000011100001110111011111111111110000111000000,
	240'b101101001111010111110110101100001010100110101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100111110010001111000010101111101010001010011110111100111111111110000111000000,
	240'b101101001111010111110110101100001010100110101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101001101100101111001011000011101010001010100010111100111111111110000111000000,
	240'b101101001111010111110110101100001010100110101001101010001010100010101000101010001010100010101001101010101010101010101010101010101010101010101010101010101010101010101010101010001101111111011110101010001010100010111100111111111110000111000000,
	240'b101101001111010111110110101100001010011110101101110000011100111011001101110010011011111010110011101010101010100010101001101010101010101010101010101010101010101010101010101010001100001111110011101100101010011110111100111111111110000111000000,
	240'b101101001111010111110110101011101011011011100111111111101111111111111111111111111111110111110101111001011100110110110101101010011010100110101010101010101010101010101010101010011011000011100100101111111010011010111100111111111110000111000000,
	240'b101101001111010111110101101101111110110011111111111111111111111111111111111111111111111111111111111111111111111111110101110110001011010110101000101010011010101010101010101010101010101010101110101011011010100010111100111111111110000111000000,
	240'b101101001111010111110100110110011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010011001011101010111010100110101010101010101010101010101001101010101010100010111100111111111110000111000000,
	240'b101101001111010111111001111100101111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110111111011000010101000101010101010101010101010101010101010100010111100111111111110000111000000,
	240'b101101001111010011111111111111001111111111111111111111111111111111111111111110001111001111110011111100111111001111110011111100111111001111110100111101111110011010110011101010001010101010101010101010101010100010111100111111111110000111000000,
	240'b101101001111010011111111111111101111111111111111111111111111111111111111110100111011000110110100101101001011010010110100101101001011010010110011101111101111110011101010101100011010100010101010101010101010100010111100111111111110000111000000,
	240'b101101001111010011111110111110111111111111111111111111111111111111111111110011001010011010101000101001111010011010100110101001101010011110101000101101011111100111111111111000101010110010101001101010101010100010111100111111111110000111000000,
	240'b101101001111010011111100111101101111111111111111111111111111111111111111110011111010011010110000110001101100011111000111110010001011101010101000101101101111100111111111111111111101001110101000101010101010100010111100111111111110000111000000,
	240'b101101001111010111111000111011101111111111111111111111111111111111111111111000101010100110110000111100101111111111111111111111111101100110100110101101101111100111111111111111111111101010111110101010001010100010111100111111111110000111000000,
	240'b101101001111010111110100111000111111111111111111111111111111111111111111111110001011010110100110110110101111111111111111111111111101100110100101101101011111100111111111111111111111111111101000101011001010011110111100111111111110000111000000,
	240'b101101001111010111110100110100101111111111111111111111111111111111111111111111111100110010100101110000001111110111111111111111111111000011011100111000101111110111111111111111111111111111111110110001111010010110111100111111111110000111000000,
	240'b101101001111010111110100110000011111101111111111111111111111111111111111111111111110011110101010101011101110111011111111111111111111111111111111111111111111111111111111111111111111111111111111111010011010101010111100111111111110000111000000,
	240'b101101001111010111110110101100111110110011111111111111111111111111111111111111111111101010111000101001101101010111111111111111111111111111111111111111111111111111111111111111111111111111111111111111011011110110111010111111111110000111000000,
	240'b101101001111010111110110101011011101001111111111111111111111111111111111111111111111111111010001101001011011110011111100111111111111111111111111111111111111111111111111111111111111111111111111111111111101011010111010111111111110000111000000,
	240'b101101001111010111110110101011101011011111111001111111111111111111111111111111111111111111101011101010111010110011101011111111111111111111111111111111111111111111111111111111111111111111111111111111111110110111000000111111111110000111000000,
	240'b101101001111010111110110101011111010100011011101111111111111111111111111111111111111111111111011101111001010010111010001111111111111111111111111111111111111111111111111111111111111111111111111111111111111101011001100111111111110000111000000,
	240'b101101001111010111110110101100001010011110111001111110001111111111111111111111111111111111111111110101011010011010111001111110101111111111111111111111111111111111111111111111111111111111111111111111111111111011011100111111101110000111000000,
	240'b101101001111010111110110101100001010100110101000110101001111111111111111111111111111111111111111111011101010110110101010111001111111111111111111111111111111111111111111111111111111111111111111111111111111111111101000111111101110000111000000,
	240'b101101001111010111110110101100001010100110101001101011111110101111111111111111111111111111111111111111011011111110100101110011011111111111111111111111111111111111111111111111111111111111111111111111111111111111110001111111111110000111000000,
	240'b101101001111010111110110101100001010100110101010101010001011101111110110111111111111111111111111111111111101100110100110101101011111100011111111111111111111111111111111111111111111111111111111111111111111111111110111111111111110000011000000,
	240'b101101001111010111110110101100001010100110101010101010101010100011000101111110101111111111111111111111111111000110110000101010011110001111111111111111111111111111111111111111111111111111111111111111111111111111111010111111111110000011000000,
	240'b101101001111010111110110101100001010100110101010101010101010101010101000110010001111101011111111111111111111111011101101111010001111010011111111111111111111111111111111111111111111111111111111111111111111111111111011111111111110000011000000,
	240'b101101001111010111110110101100001010100110101010101010101010101010101010101010001100001111110100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110010111111111110000111000000,
	240'b101101001111010111110110101100001010100110101010101010101010101010101010101010101010100010110111111000111111111011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111011011100111111101110000111000000,
	240'b101101001111010111110110101100001010100110101010101010011010101010101010101010101010101010101000101011001100100011101101111111111111111111111111111111111111111111111111111111111111111111111111111111111110100011000001111111111110000111000000,
	240'b101101001111010111110110101100001010011111001010110100101010100110101010101010101010101010101010101010011010100010101111110001101110010011110110111111101111111111111111111111111111111111111111111010101011010110111011111111111110000111000000,
	240'b101101001111010111110110101100001010011111000100111101001011001010101001101010101010101010101010101010101010101010101001101010001010101110110101110001001101000111011010110111111101110111001011101100001010011010111100111111111110000111000000,
	240'b101101001111010111110110101100001010100010101111111100001100100010101000101010101010101010101010101010101010101010101010101010101010101010101001101010001010011110101000101010011010100110100111101010011010100010111100111111111110000111000000,
	240'b101101001111010111110110101100001010100110101000110110011110010010101001101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100010111100111111111110000111000000,
	240'b101101001111010111110110101100001010011110100111101111101111010010110101101010011010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100010111100111111111110000111000000,
	240'b101101001111010111110110101100001011111110110010101010111110110011001101101001111010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100010111100111111111110000111000000,
	240'b101101001111010111110110101100101110111111001111101011011101101011101000101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100010111100111111111110000111000000,
	240'b101010001111010111111000101101001110111111111001111100101111100011110100101100001010100110101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100010111111111111111101111110110011,
	240'b100100001110111011111110110010111100010011001110110011101100111011000111101010101010011110101000101010001010100010101000101010001010100010101000101010001010100010101000101010001010100010101000101010001010100011011010111111111101011110011100,
	240'b101111001101001011111111111101111100110110111110101111101011111010111110110000001100000011000000110000001100000011000000110000001100000011000000110000001100000011000000110000001100000011000000110000011101011111111100111111111100010110111000,
	240'b111110011100001111100111111111111111111111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111101111111111111111110110001101000011110110,
	240'b111111011110111010111011110110101111011111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111010011010000110001001111100011111101,
	240'b111011111111011111110101101011011001110010101001101010111010101010101010101010101010101010101011101010111010101110101011101010111010101010101010101010101010101010101010101010111010101110101011101010001001100010110011111011111111000111110000,
	240'b111110101111101011101001100111111001000010101011101011011010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101101101001111000101110110101111101111111101111111010,
	240'b111111111111011110111111110001111101111111101100111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111010101101110011000100110101001111111111111111,
	240'b111111101100100111011001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110011001101101011111100,
	240'b110011011100101111111111111101111001111101101110011011010110111001101110011011100110111001101110011011100110111001101110011011100110111001101110011011100110111001101100011001100110011001100101011010101011000011111110111111001100010011001000,
	240'b100101001110101111111111011111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000101001110010011111000111110001111110011001010101001111111111101010110011101,
	240'b101000101111011011101100001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110100111100111111010011110001111111011001010101000100111111111101111110101101,
	240'b101101001111100011100010000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011111111000010110100000101010101100001010011000101111111111011110001011000000,
	240'b101101001111100011100010000100010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010101010111000101000000000010001100100110000110011111111011110001011000000,
	240'b101101001111100011100010000100010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010110011101001000001111000000000000000000110111111111101110001011000000,
	240'b101101001111100011100010000100010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000101111101100101001010000000000000000000110111111111101110001011000000,
	240'b101101001111100011100010000100010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001001111110011101000000000000000000110111111111101110001011000000,
	240'b101101001111100011100010000100010000000000001010010001100110101101101010010111010011101100011101000000010000000000000000000000000000000000000000000000000000000000000000000000000100110011011100000110010000000000110111111111101110001011000000,
	240'b101101001111100011100010000011000010011010110111111110111111111111111111111111111111101011100000101100010110101000100000000000000000000000000000000000000000000000000000000000000001000110101111010000000000000000110111111111101110001011000000,
	240'b101101001111100011011111001010001100011111111111111111111111111111111111111111111111111111111111111111111111111111100010100010110010001000000000000000000000000000000000000000000000000000001100000010010000000000110111111111101110001011000000,
	240'b101101001111100011011100100011101111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101110101100010000000110000000000000000000000000000000000000000000000000000000000110111111111101110001011000000,
	240'b101101001111011011101100110110011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111100111110001001100000000000000000000000000000000000000000000000000110111111111101110001011000000,
	240'b101101001111010011111100111110001111111111111111111111111111111111111111111010111101110011011101110111011101110111011101110111011101110111011101111001111011010000011011000000000000000000000000000000000000000000110111111111101110001011000000,
	240'b101101001111010011111110111110111111111111111111111111111111111111111111011110100001101100011101000111010001110100011101000111010001110100011011001111011111011010111110000110000000000000000000000000000000000000110111111111101110001011000000,
	240'b101101001111010111111010111100111111111111111111111111111111111111111111011001100000000000000000000000000000000000000000000000000000000000000000001000001110110011111111101010010000101000000000000000000000000000110111111111101110001011000000,
	240'b101101001111010111110011111001001111111111111111111111111111111111111111011011100000000000010001010101010101100101011000010110100011000100000000001000111110101111111111111111110111101100000000000000000000000000110111111111101110001011000000,
	240'b101101001111011111100110110011001111111111111111111111111111111111111111101010010000000100010011110101111111111111111111111111111000111000000000001000011110101111111111111111111111000000111011000000000000000000110111111111101110001011000000,
	240'b101101001111100011011100101010111111111111111111111111111111111111111111111010000010001000000000100100011111111111111111111111111000111000000000001000001110101111111111111111111111111110111001000010000000000000110111111111101110001011000000,
	240'b101101001111100011011011011110001111111111111111111111111111111111111111111111110110011100000000010000101111100111111111111111111101001010010110101001111111011111111111111111111111111111111100010101100000000000110111111111101110001011000000,
	240'b101101001111100011011100010001001111001011111111111111111111111111111111111111111011011100000011000010111100111011111111111111111111111111111111111111111111111111111111111111111111111111111111101111010000001100110101111111101110001011000000,
	240'b101101001111100011100000000110101100011011111111111111111111111111111111111111111110111100101011000000001000001111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000011100000110000111111101110001011000000,
	240'b101101001111100011100010000010100111101111111111111111111111111111111111111111111111111101110100000000000011011111110110111111111111111111111111111111111111111111111111111111111111111111111111111111111000011000110000111111011110001011000000,
	240'b101101001111100011100010000011000010011011101101111111111111111111111111111111111111111111000001000001100000011111000011111111111111111111111111111111111111111111111111111111111111111111111111111111111100100101000100111110111110001011000000,
	240'b101101001111100011100010000100000000000010011011111111111111111111111111111111111111111111110100001101010000000001110110111111111111111111111111111111111111111111111111111111111111111111111111111111111110111001100111111110001110001011000000,
	240'b101101001111100011100010000100010000000000101101111011001111111111111111111111111111111111111111100000010000000000101100111100001111111111111111111111111111111111111111111111111111111111111111111111111111110010010110111101011110001011000000,
	240'b101101001111100011100010000100010000000000000000011111111111111111111111111111111111111111111111110011000000101100000011101110001111111111111111111111111111111111111111111111111111111111111111111111111111111110111010111101101110001011000000,
	240'b101101001111100011100010000100010000000000000000000100001100010011111111111111111111111111111111111110010100000000000000011010011111111111111111111111111111111111111111111111111111111111111111111111111111111111010101111110111110000111000000,
	240'b101101001111100011100010000100010000000000000000000000000011001111100100111111111111111111111111111111111000111000000000001000011110100111111111111111111111111111111111111111111111111111111111111111111111111111101000111111101110000111000000,
	240'b101101001111100011100010000100010000000000000000000000000000000001010010111100001111111111111111111111111101011000010010000000011010101111111111111111111111111111111111111111111111111111111111111111111111111111110010111111111110000111000000,
	240'b101101001111100011100010000100010000000000000000000000000000000000000000010110101110111111111111111111111111110011001001101110111101111011111111111111111111111111111111111111111111111111111111111111111111111111110011111111111110000111000000,
	240'b101101001111100011100010000100010000000000000000000000000000000000000000000000000100101111011110111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111011001111110111110000111000000,
	240'b101101001111100011100010000100010000000000000000000000000000000000000000000000000000000000101010101010111111110111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110010110111101101110001011000000,
	240'b101101001111100011100010000100010000000000000001000000000000000000000000000000000000000000000000000001110101101011001010111111111111111111111111111111111111111111111111111111111111111111111111111111111011100101000100111110111110001011000000,
	240'b101101001111100011100010000100010000000001100001011101110000000000000000000000000000000000000000000000000000000000010010010101101010110111100101111111001111111111111111111111111111111111111111110000000010001000110010111111101110001011000000,
	240'b101101001111100011100010000100010000000001001110110111010001100000000000000000000000000000000000000000000000000000000000000000000000001100100001010011100111011010010001100111101001100101100100000100010000000000110111111111101110001011000000,
	240'b101101001111100011100010000100010000000000001110110100100101101100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110111111111101110001011000000,
	240'b101101001111100011100010000100010000000000000000100011011010110100000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110111111111101110001011000000,
	240'b101101001111100011100010000100010000000000000000001111001101111000100001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110111111111101110001011000000,
	240'b101101001111100011100010000100110100000100011011000001011100011101101001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110111111111101110001011000000,
	240'b101101001111100011100001000101111100111101101101000101001001000010111001000000110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110110111111101110001011000000,
	240'b101010001111011111100111000111111101000011101101110110011110101011011100000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000001111111111110000010110011,
	240'b100100001110111111111100011000100100110101101100011011000110110001010110000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010001111111111111101011110011100,
	240'b101111001101001011111111111001100110101000111100001111000011110000111101010000110100001101000011010000110100001101000011010000110100001101000011010000110100001101000011010000110100001101000011010001011000100011110110111111111100010110111000,
	240'b111110011100001111100111111111111111111111111000111110001111100011111000111110001111100011111000111110001111100011111000111110001111100011111000111110001111100011111000111110001111100011111000111110011111111111111111110110001101000011110110,
	240'b111111011110111010111011110110101111100011111010111110101111101011111010111110101111101011111010111110101111101011111010111110101111101011111010111110101111101011111010111110101111101011111010111110101111010011010000110001001111100011111101,
	240'b111011111111011111110101101011011001110010101001101010111010101010101010101010101010101010101011101010111010101110101011101010111010101010101010101010101010101010101010101010111010101110101011101010001001100010110011111011111111000111110000,
};
assign data = picture[addr];
endmodule