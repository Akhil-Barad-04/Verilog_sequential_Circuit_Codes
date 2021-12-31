module d_ff_tb();
    reg clk,rst,d_in;
    wire q;
    d_ff TUF(q,rst,clk,d_in);

    always
     begin
        #5 clk=1'b0;
         #5 clk=~clk;
     end
	task initialize;
		begin
		d_in<=0;
		end
          endtask
    task d_inps(input k);
        begin
          @(negedge clk)
          d_in=k;
        end
    endtask
    task rstip;
        begin
            @(negedge clk)
            rst=1'b1;
            @(negedge clk)
            rst=1'b0;
        end
    endtask

    initial begin
    	initialize;
        rstip;
        d_inps(1'b1);
        #20;
        d_inps(1'b0);
        d_inps(1'b1);
        rstip;
        d_inps(1'b1);
       end

       initial begin
           $monitor("Data_in = %b, clock=%b, Reset=%b, output=%b",d_in,clk,rst,q);
       end
       initial begin
           #150 $finish;
       end
endmodule