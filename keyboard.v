module keyboard(input clock,
                input dataClock,
					 input data,
					 output reg en,
					 output reg [7:0]currKey);
					  

reg [3:0]index;					  
reg [7:0]prevKey;
reg [25:0]counter;


reg [2:0]S;
reg [2:0]NS;



parameter startBit = 3'd0,
          getData = 3'd1,
			 update = 3'd2;

          			 
			 


always@(negedge dataClock) begin
    if (counter >= 26'd0_250_000 & S == update) begin
        en <= 1'b1;	 
	     counter <= 0;
		  
	 end else begin
	     en <= 1'b0;
		  counter <= counter + 1'b1;
		  
	 end
	 
	 case(S)
	      
	      startBit: begin
			    index <= 0;
		   end
			getData: begin
			    currKey[index] <= data;
				 index <= index + 1'b1;
				    
			end
			update: begin
			    
				 prevKey <= currKey;
		      
			end
		   
			
	 endcase
    
end

always @(*) begin
    case(S) 
	     
	     startBit:
		     NS <= getData;
		  getData: begin
		     if (index < 8)
              NS <= getData;
           else 
              NS <= update; 
	     end		  
		  update:
		     NS <= startBit;
		  
		endcase
		
end

// can not add more states



always @(negedge dataClock) begin
   
		 
    S <= NS;
end

/*always @(posedge clock) begin
	 if (counter >= 26'd0_250_000 & S == update) begin
        en <= 1'b1;	 
	     counter <= 0;
		  
	 end else begin
	     en <= 1'b0;
		  counter <= counter + 1'b1;
		  
	 end
	 
   
end
*/

   
	 
endmodule 
    
					  
					  