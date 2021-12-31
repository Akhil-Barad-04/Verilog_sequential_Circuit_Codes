module asyn_dual_8x16ram_tb();

    parameter DATA_WIDTH =16,
                DATA_DEPTH=8,
                DATA_ADDR=3 ;

    reg [DATA_WIDTH-1:0]d_in;
    reg [DATA_ADDR-1:0]wr_addr,rd_addr;
    reg clear,wr_clk,rd_clk,we,re;

    wire [DATA_WIDTH-1:0]d_out;

    asyn_dual_8x16ram DUT(d_out,d_in,clear,wr_clk,rd_clk,we,re,wr_addr,rd_addr);

    //write clock t=10
    always begin
        wr_clk=1'b0;
        forever #5 wr_clk=~wr_clk;
    end

    //read clock t=20
    always begin
      rd_clk=1'b0;
      forever #10 rd_clk=~rd_clk;
    end

    task initialize;
        begin
          d_in=16'h0000;
          {we,re}=2'b00;
          {wr_addr,rd_addr}=6'b000000;
        end
    endtask

    task clearip;
        begin
            clear=1'b1;
            #20;
            clear=1'b0;
        end
    endtask

    task write(input [DATA_WIDTH-1:0]wd,input [DATA_ADDR-1:0]wa);
        begin
          @(negedge wr_clk)
          we=1'b1;
          d_in<=wd;
          wr_addr<=wa;
        end
    endtask

    task read(input [DATA_ADDR-1:0]ra);
        begin
        @(negedge rd_clk)
          re=1'b1;
          rd_addr<=ra;
        end
    endtask

    initial begin
        initialize;
        clearip;
        write(16'h1111,3'b111);
        #10; read(3'b111);

       #10; write(16'hFFFF,3'b100);
        #10; read(3'b100);

      
        write(16'h1010,3'b101);
        #10;
        read(3'b101);
	clearip;

    end

    initial begin
        $monitor("clear=%b ,wr_clk=%b ,rd_clk=%b, we=%b, wr_addr=%d, re=%b, rd_addr=%d, d_in=%d, d_out=%d ",clear,wr_clk,rd_clk,we,wr_addr,re,rd_addr,d_in,d_out);
    end

    initial begin
        #300 $finish;
    end
endmodule                                                     