module asyn_single_8x16ram(data,addr_in,we_in,en_in);

   parameter DATA_WIDTH =16,
            DATA_DEPTH=8,
            DATA_ADDR=3 ;
   
      input we_in,en_in;
	   input [DATA_ADDR-1:0]addr_in;
	   inout [DATA_WIDTH-1:0]data;
					
		reg [DATA_WIDTH-1:0]ram[0:DATA_DEPTH-1];	 
  
   always@(data,we_in,en_in,addr_in)
      begin
      if(we_in && !en_in)
	   ram[addr_in]<=data;
      end
   assign data= (en_in && !we_in) ? ram[addr_in] : 16'hzz;

endmodule 

