module asyn_single_8x16ram_tb();
   wire [15:0] data;
   reg  [2:0] addr_in;
   reg  we_in,en_in;
   reg  [15:0] tempd;

   integer l;

   asyn_single_8x16ram DUT(data,addr_in,we_in,en_in);

   assign data=(we_in && !en_in) ? tempd : 8'hzz;

   task initialize();
      begin
	 we_in=1'b0; en_in=1'b0; tempd=8'h00;
      end
   endtask

      begin
        addr_in=i;
        tempd=j;
      end
   endtask
  
   task write();
      begin
	 we_in=1'b1;
	 en_in=1'b0;
      end
   endtask

   task read();
      begin
	 we_in=1'b0;
	 en_in=1'b1;
      end
   endtask

   task delay;
      begin
	 #10;
      end
   endtask
		
   //Process to generate stimulus using for loop
   initial
      begin
	   initialize;
	   delay;
	    write;
	      for(l=0;l<8;l=l+1)
	          begin
	         stimulus(l,l);
	          delay;
	          end
	   initialize;
	    delay;
	    read;
	      for(l=0;l<8;l=l+1)
	          begin
	         stimulus(l,l);
	          delay;
	         end
	   delay;
      end
			
   initial begin
      $monitor("we_in=%b , en_in=%b , addr_in=%b  %d, data=%b  %d",we_in,en_in,addr_in,addr_in,data,data);
   end

   initial begin
      #200 $finish;
   end
endmodule
