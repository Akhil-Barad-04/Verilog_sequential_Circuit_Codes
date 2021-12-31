module sr_latch_tb();
    reg s,r,en;
    wire q,qb;
    sr_latch DUT(s,r,en,q,qb);
    integer i;

    task initialize;
        begin
          {s,r,en}=3'b001;
        end
    endtask


    initial begin
    initialize;
        for (i = 0;i<8;i=i+1 ) 
        begin
            {en,s,r}=i;
            #10;   
        end
    end

    initial begin
        $monitor("Input Enable=%b, S=%b, R=%b, Output Q=%b, Qb=%b",en,s,r,q,qb);
    end

    initial begin
        #100 $finish;
    end
endmodule