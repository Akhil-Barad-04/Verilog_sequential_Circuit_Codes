module ven_mach_tb();

    reg [1:0]coin;
    reg reset,clock;

    wire x,y;

    ven_mach DUT(x,y,coin,reset,clock);

    initial begin
        clock=1'b0;
        forever #5 clock=~clock;
    end

    task initialize;
        begin
          coin=2'b00;
        end
    endtask

    task clear;
        begin
          reset=1'b1;
          @(negedge clock)
          reset=1'b0;
        end
    endtask

    task coinip(input a,input b);
        begin
          @(negedge clock)
          begin
          coin[1]<=a;
          coin[0]<=b;
          end
        end
    endtask

    initial begin
        initialize;
        clear;
        coinip(0,0);
        coinip(0,1);
        coinip(1,0);
        coinip(0,1);
        coinip(1,0);
        coinip(1,0);
        coinip(1,0);
        coinip(1,1);
        coinip(1,1);
        coinip(0,1);
        coinip(1,1);
	clear;

    end
    initial begin
        $monitor("reset=%b, state=%b, coin_in=%b, x=%b ,y=%b ",reset,DUT.pre_st,coin,x,y);
    end

    initial begin
        #250 $finish;
    end
endmodule