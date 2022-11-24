module UA_Receiver( // inputs
        clk,
        rst_n,
	   enable,
        ser_in,
        // outputs
        dout_byte, 
	   dout_byte_rdy,
		dout_byte_temp
	   );
        
// inputs
input clk;
input rst_n;
input enable;
input ser_in;

// outputs
output [7:0] dout_byte;
output dout_byte_rdy;
output [9:0] dout_byte_temp;

//output valid_flag;
//output [1:0] valid_count;

reg [2:0] ser_in_reg;
reg [3:0] bit_count;
reg [3:0] count_sample;
reg [3:0] shift_count;
reg [9:0] dout_byte_temp;

reg [7:0] dout_byte;
wire startbitsync;
reg dout_byte_rdy_r;
        
 // detect input data
always @(posedge clk or negedge rst_n)
begin
    if (~rst_n)
       ser_in_reg <= 0;
    else if (enable)
         ser_in_reg <= {ser_in_reg[1:0],ser_in};
end
//detect negative edge
assign startbitsync = (ser_in_reg[2]&(~ser_in_reg[1])&(~ser_in_reg[0])) ? 1'b1 : 1'b0;

// output logic
always @(posedge clk or negedge rst_n)
begin
	if(~rst_n)
     	count_sample <= 4'd0; 
    	else if (enable)
    		begin
    			if(startbitsync)
        			count_sample <= 4'd0;
			else if(bit_count == 4'd10)
				count_sample <= count_sample;
    			else 
				count_sample <= count_sample+1;
         	end
    	

end

always @(posedge clk or negedge rst_n)
begin
	if(~rst_n)
     	bit_count <=4'd0; 

    	else if(enable)
		begin
			if(startbitsync && (bit_count == 4'd10))
				bit_count <=4'd0;
			 else if(bit_count == 4'd10)
						bit_count <= bit_count;				
			 else if(count_sample == 4'd12)
              				bit_count <= bit_count+1;
		 end
end



// output logic
always @(posedge clk or negedge rst_n)
begin
    if (~rst_n)
    begin
        dout_byte_temp <= 0;
      end
    else if (enable)
    begin
       if(count_sample == 4'd5)
         dout_byte_temp <= {ser_in_reg[2],dout_byte_temp[9:1]}; 
	  else
	    dout_byte_temp <= dout_byte_temp; 
	                    
    end
end

// output logic
always @(posedge clk or negedge rst_n)
begin
    	if (~rst_n)
        	dout_byte <= 0;
	else	if((bit_count == 4'd10)&&(dout_byte_temp[9]==1)&&(dout_byte_temp[0]==0))
		dout_byte<=dout_byte_temp[8:1];
	else
	     dout_byte<=dout_byte;
	             
end


assign dout_byte_rdy= (bit_count == 4'd9)?0:1 ;

endmodule
