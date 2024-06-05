from PIL import Image


def resize_and_convert_to_rgb(image_path, verilog_output_file, resized_image_output_file, width=30, height=50):
    img = Image.open(image_path)
    img = img.convert('RGB')
    img = img.resize((width, height))
    pixels = list(img.getdata())

    with open(verilog_output_file, 'w') as f:
        f.write('module wild_draw_four(\n')
        f.write('\tinput [7:0] addr,\n')
        f.write('\toutput [239:0] data\n')
        f.write(');\n')
        f.write('parameter [0:149][239:0] picture = {\n')
        for color_index in range(3):
            for i in range(0, len(pixels), width):
                f.write('\t240\'b')
                for j in range(i, min(i + width, len(pixels))):
                    color = pixels[i +
                                   min(i + width, len(pixels))-j-1][color_index]
                    f.write(f'{color:08b}')
                f.write(',\n')
        f.write('};\n')
        f.write('assign data = picture[addr];\n')
        f.write('endmodule')
    img.save(resized_image_output_file)

    print(
        f"Image resized to {width}x{height} and converted to Verilog format, saved to {verilog_output_file}")
    print(f"Resized image saved to {resized_image_output_file}")


image_path = 'wd_d4.png'
verilog_output_file = 'wild_draw_four.sv'
resized_image_output_file = 'wild_draw_four.png'

resize_and_convert_to_rgb(
    image_path, verilog_output_file, resized_image_output_file)
