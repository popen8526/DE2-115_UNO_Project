// Reference: https://www.itread01.com/content/1549104121.html
module vga(
    input  i_rst_n,
    input  i_clk_25M,
    input  [7:0] in_pixel[2:0],
    output [7:0] VGA_B,
    output VGA_BLANK_N,
    output VGA_CLK,
    output [7:0] VGA_G,
    output VGA_HS,
    output [7:0] VGA_R,
    output VGA_SYNC_N,
    output VGA_VS
    output [9:0] o_x_cnt,
    output [9:0] o_y_cnt
);
//  If you need RGB data from outside, define i_VGA_R, i_VGA_G, i_VGA_B as input

//  Variable definition
    logic [9:0] x_cnt_r, x_cnt_w;
    logic [9:0] y_cnt_r, y_cnt_w;
    logic hsync_r, hsync_w, vsync_r, vsync_w;
    logic [7:0] vga_r_r, vga_g_r, vga_b_r, vga_r_w, vga_g_w, vga_b_w;
    logic [1:0] state_w, state_r;
//  640*480, refresh rate 60Hz
    // VGA clock rate 25.175MHz
    localparam H_FRONT  =   16;
    localparam H_SYNC   =   96;
    localparam H_BACK   =   48;
    localparam H_ACT    =   640;
    localparam H_BLANK  =   H_FRONT + H_SYNC + H_BACK;
    localparam H_TOTAL  =   H_FRONT + H_SYNC + H_BACK + H_ACT;
    localparam V_FRONT  =   10;
    localparam V_SYNC   =   2;
    localparam V_BACK   =   33;
    localparam V_ACT    =   480;
    localparam V_BLANK  =   V_FRONT + V_SYNC + V_BACK;
    localparam V_TOTAL  =   V_FRONT + V_SYNC + V_BACK + V_ACT;

//  Output assignment
    assign VGA_CLK      =   i_clk_25M;
    assign VGA_HS       =   hsync_r;
    assign VGA_VS       =   vsync_r;
    assign VGA_R        =   vga_r_r;
    assign VGA_G        =   vga_g_r;
    assign VGA_B        =   vga_b_r;
    assign VGA_SYNC_N   =   1'b0;
    assign VGA_BLANK_N  =   ~((x_cnt_r < H_BLANK) || (y_cnt_r < V_BLANK));
    assign o_x_cnt        =   x_cnt_r;
    assign o_y_cnt        =   y_cnt_r;

//  Finite state machine
    localparam [1:0] S_IDLE = 2'b00, S_DISPLAY = 2'b01;
//  Update coordinates
    always_comb begin
        case(state_r)
            S_IDLE: begin
                x_cnt_w = 0;
            end
            S_DISPLAY: begin
                if (x_cnt_r == 800) begin
                    x_cnt_w = 0;
                end
                else begin
                    x_cnt_w = x_cnt_r + 1;
                end
            end
        endcase
    end
    always_comb begin
        case(state_r)
            S_IDLE: begin
                y_cnt_w = 0;
            end
            S_DISPLAY: begin
                if (y_cnt_r == 525) begin
                    y_cnt_w = 0;
                end
                else if (x_cnt_r == 800) begin
                    y_cnt_w = y_cnt_r + 1;
                end
                else begin
                    y_cnt_w = y_cnt_r;
                end
            end
        endcase
    end

//  Sync signals
    always_comb begin
        case(state_r)
            S_IDLE: begin
                hsync_w = 1'b1;
            end
            S_DISPLAY: begin
                if (x_cnt_r == 0) begin
                    hsync_w = 1'b0;
                end
                else if (x_cnt_r == H_SYNC) begin
                    hsync_w = 1'b1;
                end
                else begin
                    hsync_w = hsync_r;
                end
            end
        endcase
    end

    always_comb begin
        case(state_r)
            S_IDLE: begin
                vsync_w = 1'b1;
            end
            S_DISPLAY: begin
                if (y_cnt_r == 0) begin
                    vsync_w = 1'b0;
                end
                else if (y_cnt_r == V_SYNC) begin
                    vsync_w = 1'b1;                 
                end
                else begin
                    vsync_w = vsync_r;
                end
            end
        endcase
    end
    
//  RGB data
    always_comb begin
        case(state_r)
            S_IDLE: begin
                vga_r_w = 8'b0;
                vga_g_w = 8'b0;
                vga_b_w = 8'b0;
            end
            S_DISPLAY: begin
                vga_r_w = {in_pixel[0], in_pixel[1], in_pixel[2], in_pixel[3], in_pixel[4], in_pixel[5], in_pixel[6], in_pixel[7]};
                vga_g_w = {in_pixel[0], in_pixel[1], in_pixel[2], in_pixel[3], in_pixel[4], in_pixel[5], in_pixel[6], in_pixel[7]};
                vga_b_w = {in_pixel[0], in_pixel[1], in_pixel[2], in_pixel[3], in_pixel[4], in_pixel[5], in_pixel[6], in_pixel[7]};
            end
        endcase
    end

//  Flip-flop
    always_ff @(posedge i_clk_25M or negedge i_rst_n) begin
        if (!i_rst_n) begin
            x_cnt_r <= 0;
            y_cnt_r <= 0;
            hsync_r <= 1'b1;
            vsync_r <= 1'b1;
            vga_r_r <= 8'b00000000;
            vga_g_r <= 8'b00000000;
            vga_b_r <= 8'b00000000;
        end
        else begin
            x_cnt_r <= x_cnt_w;
            y_cnt_r <= y_cnt_w;
            hsync_r <= hsync_w;
            vsync_r <= vsync_w;
            vga_r_r <= vga_r_w;
            vga_g_r <= vga_g_w;
            vga_b_r <= vga_b_w;
        end
    end
endmodule