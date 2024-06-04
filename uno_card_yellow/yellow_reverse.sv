module yellow_reverse(
	input [7:0] addr,
	output [239:0] data
);
parameter [0:149][239:0] picture = {
	240'b111110101111110011101100101000101000111010101010101011011010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101101101011001001001110011010111010011111110111111010,
	240'b111111111111101111000011110001011101111011101100111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011011110000111001101110001011111011011111111,
	240'b111111111100110011010111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111000111100001011111100,
	240'b110011011100101011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101010011001100,
	240'b101000001110100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111011010100100,
	240'b101011101111100011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110101111,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101101001111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110,
	240'b101100011111100111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110010,
	240'b101000001110110111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111100110100100,
	240'b101111011101000011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101110010111110,
	240'b111110111100001111100110111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111100011011111111110111,
	240'b111111011111001010111100110110001111011011111000111110001111100011111000111110001111100011111000111110001111100011111000111110001111100011111000111110001111100011111000111110001111100011111000111110001111100011100000101111001110100111111101,
	240'b111100001111001111110100101100011001110010101001101010111010101010101010101010101010101010101010101010111010101110101011101010111010101110101010101010101010101010101010101010111010101110101011101010101001111110100000111000001111001111110000,
	240'b111110101111110011101100101000101000111010101010101011011010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101101101011001001001110011010111010011111110111111010,
	240'b111111111111101111000011110001011101111011101100111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011011110000111001101110001011111011011111111,
	240'b111111111100110011010111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111000111100001011111100,
	240'b110011011100101011111111111111011110000111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011011100110011001110110011111101101111111010111111111101010011001100,
	240'b101000001110101011111111110101111010100110100111101001111010011110100111101001111010011110100111101001111010011110100111101001111010011110100111101001111010011110101000101110101011111010101111101001111010011111001011111111101111011010100100,
	240'b101011101111100111111011101101111010100010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100110101110111100001111111011000001101001111010100110101111111100101111111110101111,
	240'b101101001111101011110110101100111010100110101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100110101110111010011111111111101011101100101010100010101101111011001111111110110110,
	240'b101101001111101011110110101100111010100110101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101011110001101110010011111111111001011010111010101100111011001111111110110110,
	240'b101101001111101011110110101100111010100110101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101001110111111110010111100111111111111101011010101100111011001111111110110110,
	240'b101101001111101011110110101100111010100110101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101000110110111111111111011110111011001110110010101101111010111111111110110110,
	240'b101101001111101011110110101100111010100110101001101010001010100010101000101010001010100010101001101010011010101010101010101010101010101010101010101010101010101010101001101101111111000111111101110111101100111010101110111010111111111110110110,
	240'b101101001111101011110110101100111010011110101100101111111100110111001110110010101011111110110101101011001010100010101000101010101010101010101010101010101010101010101010101010001011110011110101111110111101110110110100111010111111111110110110,
	240'b101101001111101011110110101100011011010011100100111111011111111111111111111111111111111011110110111010001101001010111001101010101010100010101010101010101010101010101010101010101010011111000100111111111111011110110101111010111111111110110110,
	240'b101101001111101011110100101110011110100111111111111111111111111111111111111111111111111111111111111111111111111111111000110111111011101110101001101010011010101010101010101010101010100110110011110110001101010010110010111010111111111110110110,
	240'b101101001111101011110011110110011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111100111010101101011111010100010101010101010101010101010101010101010001010011110101101111011001111111110110110,
	240'b101101001111101011110111111101001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111010011011100010101000101010101010101010101010101010101010100110101101111011001111111110110110,
	240'b101101001111101011111010111110111111111111111111111111111111111111111111111111111101010011000011110001011100001111011000111111011111111111111111111111111111001010111101101010001010101010101010101010101010100110101101111011001111111110110110,
	240'b101101001111101011111010111110101111111111111111111111111111111111111111111111111011111110100100101001101010110011101010111111111111111111111111111111111111111111110101101111101010100010101010101010101010100110101101111011001111111110110110,
	240'b101101001111101011111001111110101111111111111111111111111111111111111111111111111100000110100111101010101010101011001011111111001111111111111111111111111111111111111111111100101011011010101000101010101010100110101101111011001111111110110110,
	240'b101101001111101011111000111110001111111111111111111111111111111111111111111111111100000010100101101010101010101010101000110100011111111011111111111111111111111111111111111111111110011110101110101010011010100110101101111011001111111110110110,
	240'b101101001111101011110110111011111111111111111111111111111111111111111111111111101100011111000100101011001010100110101001101010101101100111111111111111111111111111111111111111111111111111010010101010001010100110101101111011001111111110110110,
	240'b101101001111101011110100111000111111111111111111111111111111111111111111111111101110110111110101110100111010100110101010101010011010110011100000111111111111111111111111111111111111111111111000101110011010011110101101111011001111111110110110,
	240'b101101001111101011110011110100101111111011111111111111111111111111111111111111111111010110111110111001111100111010101000101010101010100010101111111001111111111111111111111111111111111111111111110111111010100110101101111011001111111110110110,
	240'b101101001111101011110100110000011111100111111111111111111111111111111111111111111110000110100110101101101110101111000111101010001010101010101000101101101111010011111111111111111111111111111111111110101011100110101011111011001111111110110110,
	240'b101101001111101011110101101101011110100011111111111111111111111111111111111111111101101010101000101001111011110011101100110000001010011110101010101001111101101011111111111111111111111111111111111111111101011010101011111011001111111110110110,
	240'b101101001111101011110101101100011100111011111111111111111111111111111111111111111110001110101000101010101010100011000010111011001011101110101000101001111100110111111111111111111111111111111111111111111110111110110010111010111111111110110110,
	240'b101101001111101011110110101100101011001111110110111111111111111111111111111111111111011110111000101010001010101010101000110010001110101110110101101001011101000011111111111111111111111111111111111111111111110111000011111010011111111110110110,
	240'b101101001111101011110110101100111010011111011000111111111111111111111111111111111111111111100111101100001010100110101010101010001100111111100110101100111110010011111111111111111111111111111111111111111111111111010110111010011111111110110110,
	240'b101101001111101011110110101100111010011110110101111101101111111111111111111111111111111111111111111000001010110110101001101010101010100111010101111011111111000111111100111111111111111111111111111111111111111111100111111011001111111110110110,
	240'b101101001111101011110110101100111010100110101000110011101111111111111111111111111111111111111111111111111101101010101010101010011010100110101100110100101100100011111000111111111111111111111111111111111111111111110011111100001111111110110110,
	240'b101101001111101011110110101100111010100110101001101011001110010111111111111111111111111111111111111111111111111011010011101010011010101010101010101001111011011011111001111111111111111111111111111111111111111111111010111101001111111110110110,
	240'b101101001111101011110110101100111010100110101010101010001011011011110010111111111111111111111111111111111111111111111101110011001010100110101010101010001011011111111001111111111111111111111111111111111111111111111011111101101111111110110110,
	240'b101101001111101011110110101100111010100110101010101010101010100010111111111101101111111111111111111111111111111111111111111101011011001110100111101001101011011011111001111111111111111111111111111111111111111111111100111110001111111110110110,
	240'b101101001111101011110110101100111010100110101010101010101010101010101000110000011111011011111111111111111111111111111111110111111011100110111000101101111100001111111010111111111111111111111111111111111111111111111100111110001111111110110110,
	240'b101101001111101011110110101100111010100110101010101010101010101010101010101010001011110011101111111111111111111111111111111110011111100011111000111110001111100111111111111111111111111111111111111111111111111111111010111101001111111110110110,
	240'b101101001111101011110110101100111010011110101000101010011010101010101010101010101010100010110011110111001111110011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111100111111011001111111110110110,
	240'b101101001111101011110101101101001100001011001101101101101010100110101010101010101010101010101001101010101100000111100111111111011111111111111111111111111111111111111111111111111111111111111111111111111111100111000001111010101111111110110110,
	240'b101101001111101011110101101101011110101111111111110010011010011110101010101010101010101010101010101010101010100010101101110000001101111011110011111111011111111111111111111111111111111111111111111101011100011010101100111011001111111110110110,
	240'b101101001111101011110101101101101101111011111100111101011011110010101000101010101010101010101010101010101010101010101001101010001010100110110010110000001100111011011001110111101101111111010011101110001010100010101101111011001111111110110110,
	240'b101101001111101011110101101100111100001011011101111111101111000110110111101010011010101010101010101010101010101010101010101010101010101010101001101010001010011110101000101010011010100110100111101010011010100110101101111011001111111110110110,
	240'b101101001111101011110101101100011101110011101011110111111111111111100011101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100110101101111011001111111110110110,
	240'b101101001111101011110101101100011101000011111111111001011110010111101111101011101010100110101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100110101101111011001111111110110110,
	240'b101101001111101011110110101100101010111011100110111111111110010011001100101011001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100110101101111011001111111110110110,
	240'b101101001111101011110110101100111010011110110011111011001111111011101000101101001010100110101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100110101101111011001111111110110110,
	240'b101100011111101011111001101101011010100010101000101110101111101111111100101101011010100110101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100110101110111011111111111110110010,
	240'b101000001110110111111111110011001010011010100111101011101100101011001010101011011010011110101000101010001010100010101000101010001010100010101000101010001010100010101000101010001010100010101000101010001010011011000001111111001111101010100100,
	240'b101111011101000011111111111110001101000111000000110000001011111010111110110000001100000011000000110000001100000011000000110000001100000011000000110000001100000011000000110000001100000011000000110000001100101111110011111111111101110010111110,
	240'b111110111100001111100110111111111111111111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111110111111101111111011111111111111111111100011011111111110111,
	240'b111111011111001010111100110110001111011011111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100111111001111110011111100011100000101111001110100111111101,
	240'b111100001111001111110100101100011001110010101001101010111010101010101010101010101010101010101010101010111010101110101011101010111010101110101010101010101010101010101010101010111010101110101011101010101001111110100000111000001111001111110000,
	240'b111110101111110011101100101000101000111010101010101011011010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101100101011001010110010101101101011001001001110011010111010011111110111111010,
	240'b111111111111101111000011110001011101111011101100111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011101110111011011110000111001101110001011111011011111111,
	240'b111111111100110011010111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111000111100001011111100,
	240'b110011011100101011111111111110011010010001101111011011010110111001101110011011100110111001101110011011100110111001101110011011100110111001101110011011100110111001101101011010000110011001101011011011101001010111110000111111111101010011001100,
	240'b101000001110101011111111100001110000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001011110011110100001111000000000000000001100100111110111111011110100100,
	240'b101011101111101111101111001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001100110100101111110001000101000000000000000000001111110101101111111110101111,
	240'b101101001111110111100010000110110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001101101111011111111111000100000110010000000000001001110001001111111110110110,
	240'b101101001111110111100010000111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000101010100111010111011111111101100000000111100000111110001011111111110110110,
	240'b101101001111110111100010000111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100111101011001010110110111111111000010100000101110001001111111110110110,
	240'b101101001111110111100010000111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100101011111111110011101110010001100011100001010110001001111111110110110,
	240'b101101001111110111100010000111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001001111101011011111010100111000110101100001100110001001111111110110110,
	240'b101101001111110111100010000111000000000000000111010000000110101001101011010111110100000000100001000001010000000000000000000000000000000000000000000000000000000000000000000000000011011011100010111100111001100000011111110000101111111110110110,
	240'b101101001111110111100010000101110001111110101110111110011111111111111111111111111111110011100101101110100111100000101100000000000000000000000000000000000000000000000000000000000000000001001101111111101110100000100011110000011111111110110110,
	240'b101101001111110111011111001011011011110111111111111111111111111111111111111111111111111111111111111111111111111111101011101000010011010000000000000000000000000000000000000000000000000000011100100010110111111000010111110000111111111110110110,
	240'b101101001111110111011011100011101111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110110000010000100000000000000000000000000000000000000000000000000000000000000001000110001011111111110110110,
	240'b101101001111110011100101110111011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101111100010110000000000000000000000000000000000000000000000000000001001110001011111111110110110,
	240'b101101001111101111101110111100101111111111111111111111111111111111111111111111101000000001001110010100000100111010001001111110011111111111111111111111111101100100111100000000000000000000000000000000000000000000001001110001011111111110110110,
	240'b101101001111101111101111111100101111111111111111111111111111111111111111111111100100000000000000000000000000010110111111111111111111111111111111111111111111111111100000001110110000000000000000000000000000000000001001110001011111111110110110,
	240'b101101001111101111101100111011111111111111111111111111111111111111111111111111100100011000000000000000000000001101100101111101101111111111111111111111111111111111111111110110000010011000000000000000000000000000001001110001011111111110110110,
	240'b101101001111101111101000111010011111111111111111111111111111111111111111111111100100010000000000000000000000000000000000011101011111110111111111111111111111111111111111111111111011011100001101000000000000000000001001110001011111111110110110,
	240'b101101001111110011100010110100001111111111111111111111111111111111111111111111000101011001010000000001110000000000000000000001001000111011111111111111111111111111111111111111111111111101111001000000000000000000001001110001011111111110110110,
	240'b101101001111110111011100101010111111111111111111111111111111111111111111111110111100100111100010011111000000000000000000000000000000100110100010111111111111111111111111111111111111111111101010001011010000000000001001110001011111111110110110,
	240'b101101001111110111011001011110011111110111111111111111111111111111111111111111111110000000111100101101100110110000000000000000000000000000010010101101101111111111111111111111111111111111111111100111010000000100001000110001011111111110110110,
	240'b101101001111110111011101010001111110110011111111111111111111111111111111111111111010010000000000001001011100001001010110000000000000000000000000001000111101111111111111111111111111111111111111111011110010110000000100110001011111111110110110,
	240'b101101001111110111100000001000011011101011111111111111111111111111111111111111111001000000000000000000000011010111000111010000110000000000000000000000001001000011111111111111111111111111111111111111111000010100000011110001001111111110110110,
	240'b101101001111110111100001000101000110110011111111111111111111111111111111111111111010110000000000000000000000000001000111110001100011001100000000000000000110100111111111111111111111111111111111111111111101000000011001110000101111111110110110,
	240'b101101001111110111100010000101110001101111100101111111111111111111111111111111111110011100101001000000000000000000000000010110111100001000100011000000000111010011111111111111111111111111111111111111111111100101001011101111101111111110110110,
	240'b101101001111110111100010000110110000000010001011111111111111111111111111111111111111111110110111000100110000000000000000000000000111000010110101000111111010111111111111111111111111111111111111111111111111111110000101101111011111111110110110,
	240'b101101001111110111100010000111000000000000100001111000101111111111111111111111111111111111111111101000100000101000000000000000000000000010000001110100001101011111110110111111111111111111111111111111111111111110110110110001011111111110110110,
	240'b101101001111110111100010000111000000000000000000011011011111111011111111111111111111111111111111111111111000111000000011000000000000000000000110011110000101101111101010111111111111111111111111111111111111111111011010110100011111111110110110,
	240'b101101001111110111100010000111000000000000000000000010001011000111111111111111111111111111111111111111111111110101111010000000000000000000000000000000000010010111101110111111111111111111111111111111111111111111101110110111001111111110110110,
	240'b101101001111110111100010000111000000000000000000000000000010010111010111111111111111111111111111111111111111111111111000011001110000001000000000000000000010100011101110111111111111111111111111111111111111111111110011111001011111111110110110,
	240'b101101001111110111100010000111000000000000000000000000000000000000111111111001011111111111111111111111111111111111111111111000100001110000000000000000000010010011101110111111111111111111111111111111111111111111110101111010011111111110110110,
	240'b101101001111110111100010000111000000000000000000000000000000000000000000010001011110010011111111111111111111111111111110100111110010111000101100001010100100110111110001111111111111111111111111111111111111111111110110111010101111111110110110,
	240'b101101001111110111100010000111000000000000000000000000000000000000000000000000000011011111001110111111111111111111111111111011001110101011101011111010101110111011111110111111111111111111111111111111111111111111101111110111011111111110110110,
	240'b101101001111110111100010000111000000000000000000000000000000000000000000000000000000000000011100100101101111011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110111110001101111111110110110,
	240'b101101001111110111100001000111110100100101101000001001010000000000000000000000000000000000000000000000010100011010110111111110011111111111111111111111111111111111111111111111111111111111111111111111111110110101000101101111111111111110110110,
	240'b101101001111110111100000001000111100001111111111010111010000000000000000000000000000000000000000000000000000000000001001010001001001110011011011111110101111111111111111111111111111111111111111111000100101010000000101110001001111111110110110,
	240'b101101001111110111100000001001001001110011110110111000100011011000000000000000000000000000000000000000000000000000000000000000000000000000011000010000110110110110001100100110111001111001111010001010010000000000001000110001011111111110110110,
	240'b101101001111110111100001000111000100100110011011111110111101010100101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001001110001011111111110110110,
	240'b101101001111110111100001000101011001010111000101101000001111111110101001000000110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001001110001011111111110110110,
	240'b101101001111110111100001000101010111001111111111101100101011000011001110000010110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001001110001011111111110110110,
	240'b101101001111110111100010000110010001000010110101111111111010111001100111000001110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001001110001011111111110110110,
	240'b101101001111110111100001000111000000000000011100110001011111110110111000000111010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001001110001001111111110110110,
	240'b101100011111110011101011001000010000000000000000001100011111000111110101001000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001011110011111111111110110010,
	240'b101000001110111011111110011010000000000000000000000011000110000101011111000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000101111101011111101110100100,
	240'b101111011101000011111111111010110111010101000011010000100011110100111101010000100100001101000011010000110100001101000011010000110100001101000011010000110100001101000011010000110100001101000011010000100110010011011011111111111101110110111110,
	240'b111110111100001111100110111111111111111111111001111110001111100011111000111110001111100011111000111110001111100011111000111110001111100011111000111110001111100011111000111110001111100011111000111110001111111111111111111100011011111111110111,
	240'b111111011111001010111100110110001111011111111010111110101111101011111010111110101111101011111010111110101111101011111010111110101111101011111010111110101111101011111010111110101111101011111010111110101111100111100000101111001110100111111101,
	240'b111100001111001111110100101100011001110010101001101010111010101010101010101010101010101010101010101010111010101110101011101010111010101110101010101010101010101010101010101010111010101110101011101010101001111110100000111000001111001111110000,
};
assign data = picture[addr];
endmodule