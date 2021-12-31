module up_down_counter_tb();
    reg [3:0]d_in;
    reg load,reset,clock,mode;
    wire [3:0]d_out;

    up_down_counter DUT(d_out,d_in,reset,load,clock,mode);

    always 
        begin
        clock=1'b0;
        forever #5 clock=~clock; 
        end

    task initialize;
        begin
	@(negedge clock)
            d_in<=4'b0000;
            load=0;
		reset=0;
            mode=1;
        end
    endtask

    task loadip;
    begin
        @(negedge clock)
        load=1'b1;
        @(negedge clock)
        load=1'b0;
    end
    endtask

    task modeip(input i);
        begin
        @(negedge clock)
          mode<=i;
        end
    endtask

    task resetips;
        begin
          @(negedge clock)
          reset=1'b1;
          @(negedge clock)
          reset =1'b0;
        end
    endtask

    task dataip(input [3:0]d);
        begin
          @(negedge clock)
          d_in<=d;
        end
    endtask

    initial begin
        initialize;
	resetips;
	modeip(1'b1);
        
	    dataip(4'b0111);
        loadip;
        modeip(1'b0);
        dataip(4'b1011);
        
        #60;
        modeip(1'b1);
        loadip;
        #30;
	    resetips;
	    initialize;

     end
     initial begin
         $monitor("clock=%b,reset=%b ,mode=%b, load=%b, d_in=%b  %d ,d_out=%b  %d",clock,reset,mode,load,d_in,d_in,d_out,d_out);
     end
    initial begin
        #200 $finish;
    end

endmodule