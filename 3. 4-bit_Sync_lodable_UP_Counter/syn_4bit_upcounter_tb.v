module syn_4bit_upcounter_tb();
    reg [3:0]d_in;
    reg load,reset,clk;
    wire [3:0]d_out;

    syn_4bit_upcounter DUT(d_out,d_in,load,reset,clk);

    always 
        begin
        clk=1'b0;
        forever #5 clk=~clk; 
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
        @(negedge clk)
        load=1'b1;
        @(negedge clk)
        load=1'b0;
    end
    endtask

    task resetips;
        begin
          @(negedge clk)
          reset=1'b1;
          @(negedge clk)
          reset =1'b0;
        end
    endtask

    task dataip(input [3:0]d);
        begin
          @(negedge clk)
          d_in<=d;
        end
    endtask

    initial begin
        initialize;
	    resetips;
	    dataip(4'b0011);
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
         $monitor("clock=%b,reset=%b , load=%b, d_in=%b  %d ,d_out=%b  %d",clk,reset,load,d_in,d_in,d_out,d_out);
     end
    initial begin
        #200 $finish;
    end

endmodule