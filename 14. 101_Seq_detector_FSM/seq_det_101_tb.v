module seq_det_101_tb();

    reg d_in,clock,reset;
    wire d_out;

    seq_det_101 DUT(d_out,d_in,reset,clock);

    initial begin
        clock=1'b0;
        forever #10 clock=~clock;
    end

    task resetip;
        begin
        @(negedge clock)
          reset=1'b1;
        @(negedge clock)
          reset=1'b0;
        end
    endtask
   
   task initialize;
        begin
            d_in<=1'b0;
        end
    endtask

    task stimulus(input j);
        begin
        @(negedge clock)
          d_in<=j;
        end
    endtask

  	
   initial
      begin
         initialize;
	 resetip;
	 stimulus(0);
	 stimulus(1);
	 stimulus(0);
	 stimulus(1);
	 stimulus(0);
	 stimulus(1);
	 stimulus(1);
	 resetip;
	 stimulus(1);
	 stimulus(0);
	 stimulus(1);
	 stimulus(1);   
	
      end  

    initial begin

      $monitor("Reset=%b, state=%b, Din=%b, Output Dout=%b",
	       reset,DUT.state,d_in,d_out);		
    end

    initial begin
        #200 $finish;
    end
endmodule