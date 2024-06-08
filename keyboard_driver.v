module keyboard_driver(
	input CLOCK_50,
    input PS2_CLK,
	input i_rst_n,
	inout PS2_DAT,
	output [8:0] LEDG,
	output [17:0] LEDR,
	output [7:0] char
);
 
	reg [4:0]done; // for when data tranfer is done
	wire rst;  // not really needed for kb
	wire en;  // for delay

	reg [17:0]i; // for testing
	
	assign rst_n = i_rst_n;
	assign LEDG = char;
	assign LEDR[17:0] = i;
	
	reg [1:0]S;
	reg [1:0]NS;
	
	parameter start = 2'd0,
			delay = 2'd1,
				update = 2'd2;
				  
	
	keyboard typer(CLOCK_50, PS2_CLK, PS2_DAT, en, char);
				  
	 
	 always @(posedge CLOCK_50 or negedge rst) begin
	     if (rst == 1'b0) begin
		      i <= 1;
		  end else begin
		  
	     case (S) 
		      start: begin
				   i <= 1;
				end
				delay: begin
				   
				end
				update: begin
				    if (char == 8'h1D) begin
					     i <= i + 1;
						  
					 end else if (char == 8'h1B) begin
					     i <= i - 1;
					 end else begin 
					     i <= i;
					 end
				    	 
				end
				
		  endcase
		  
		  end
	 end
	 
	 
	 always @(*) begin
	     case (S) 
		      start: begin
				end
				delay: begin
				    if (en == 1'b1) 
					     NS <= update;
					 else
					     NS <= delay;
				end
				update: begin
				    NS <= delay;
				end
		  endcase
		  
	 end
	 
	 always @(posedge CLOCK_50 or negedge rst) begin
	     if(rst == 1'b0)
	         S <= start;
		  else 
		      S <= NS;
	 end
	 
	 
endmodule

				
				
				
							 