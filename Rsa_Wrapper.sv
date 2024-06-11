module Rsa_Wrapper (
    input         avm_rst,
    input         avm_clk,
    output  [4:0] avm_address,
    output        avm_read,
    input  [31:0] avm_readdata,
    input         avm_waitrequest,
    output [ 7:0] n
);

localparam RX_BASE     = 0*4;
localparam TX_BASE     = 1*4;
localparam STATUS_BASE = 2*4;
localparam TX_OK_BIT   = 6;
localparam RX_OK_BIT   = 7;

// Feel free to design your own FSM!
localparam S_QUERY_RX = 3'd1;
localparam S_READ = 3'd2;

logic [7:0] n_r, n_w;
logic [2:0] state_r, state_w;
logic [4:0] avm_address_r, avm_address_w;
logic avm_read_r, avm_read_w, avm_write_r, avm_write_w;

assign avm_address = avm_address_r;
assign avm_read = avm_read_r;
assign avm_write = avm_write_r;
assign n = n_r;

task StartRead;
    input [4:0] addr;
    begin
        avm_read_w = 1;
        avm_write_w = 0;
        avm_address_w = addr;
    end
endtask
task StartWrite;
    input [4:0] addr;
    begin
        avm_read_w = 0;
        avm_write_w = 1;
        avm_address_w = addr;
    end
endtask

always_comb begin
    // TODO
    case(state_r)
        S_QUERY_RX: begin
            n_w = n_r;
            // only valid when avm_waitrequest == 0 and rrdy == 1.
            if ((!avm_waitrequest) && avm_readdata[RX_OK_BIT]) begin 
                StartRead(RX_BASE);
                state_w = S_READ;
            end
            else begin
                avm_read_w = avm_read_r;
                avm_write_w = avm_write_r;
                avm_address_w = avm_address_r;
                state_w = S_QUERY_RX;
            end
        end
        S_READ: begin
            // state_w = S_QUERY_RX;
            if(!avm_waitrequest) begin
                StartRead(STATUS_BASE);// nxt state is S_QUERY_RX, need to read the r_rdy
                n_w = avm_readdata[7:0];
                state_w = S_QUERY_RX;
            end 
            else begin
                state_w = S_READ; // finished reading the enc_r, n_r, d_r.
                avm_read_w = avm_read_r;
                avm_write_w = avm_write_r;
                avm_address_w = avm_address_r;
                n_w = n_r;
            end       
        end
    endcase
end

always_ff @(posedge avm_clk or posedge avm_rst) begin
    if (avm_rst) begin
        n_r <= 0;
        avm_address_r <= STATUS_BASE;
        avm_read_r <= 1;
        avm_write_r <= 0;
        state_r <= S_QUERY_RX;
    end else begin
        n_r <= n_w;
        avm_address_r <= avm_address_w;
        avm_read_r <= avm_read_w;
        avm_write_r <= avm_write_w;
        state_r <= state_w;
    end
end

endmodule
