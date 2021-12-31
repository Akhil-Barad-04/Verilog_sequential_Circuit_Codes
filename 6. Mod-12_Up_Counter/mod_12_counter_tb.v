module mod_12_counter_tb();
    reg [3:0]d_in;
    reg load,reset,clock;
    wire [3:0]d_out;

    mod_12_counter DUT(d_out,d_in,load,reset,clock);

    always 
        begin
        clock=1'b0;
        forever #5 clock=~clock; 
        end

    task initialize;
        begin
            d_in=4'b0000;
            load=1'b0;
	    reset=1'b0;
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
	    dataip(4'b0111);
        loadip;
        #40;
        resetips;
        dataip(4'b1011);
        loadip;
        #20;
        loadip;
        #30;
	resetips;
	initialize;

     end
     initial begin
         $monitor("clock=%b,reset=%b , load=%b, d_in=%b  %d ,d_out=%b  %d",clock,reset,load,d_in,d_in,d_out,d_out);
     end
    initial begin
        #200 $finish;
    end

endmodule