module t_ff_using_d_ff_tb();
    reg clk,rst,t_in;
    wire q;
    t_ff_using_d_ff DUT(q,t_in,rst,clk);

    always
     begin
        clk=1'b0;
        forever #5 clk=~clk;
     end
	task initialize;
		begin
		t_in<=0;
		end
    endtask
    task t_inps(input k);
        begin
          @(negedge clk)
          t_in=k;
        end
    endtask
    task rstip;
        begin

            //@(negedge clk)
            rst=1'b1;
            @(negedge clk)
            rst=1'b0;
        end
    endtask

    initial begin
    	initialize;
        rstip;
        t_inps(1'b1);
        #100;
        t_inps(1'b0);
        #40;
        t_inps(1'b1);
        t_inps(1'b1);
       end

       initial begin
           $monitor("Data_in t_in = %b, clock=%b, Reset=%b, output=%b",t_in,clk,rst,q);
       end
       initial begin
           #200 $finish;
       end
endmodule


