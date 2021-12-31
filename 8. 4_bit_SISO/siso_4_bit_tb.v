module siso_4_bit_tb();

    reg sin,clock,reset;
    wire [3:0]q;
    wire sout;
    integer i;

    siso_4_bit DUT(sout,sin,q,clock,reset);

    always
    begin
      clock=1'b0;
      forever #5 clock=~clock;
    end

    task initialize;
        begin
          sin=1'b0;
        end
    endtask

    task resetop;
        begin
          @(negedge clock);
          reset=1'b1;
          @(negedge clock);
          reset=1'b0;
        end
    endtask

    initial begin
        initialize;
        resetop;
        for (i =0;i<16 ;i=i+1 ) 
        begin
            @(negedge clock)
            sin={$random} %2;
            #10;   
        end

    end

    initial begin
        $monitor("clock=%b,reset=%b,ser_in=%b,output q=%b,ser_out=%b",clock,reset,sin,q,sout);
    end

    initial begin
        #200 $finish;
    end


endmodule