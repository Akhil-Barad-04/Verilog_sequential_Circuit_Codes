module syn_dual_16x8ram_tb();

    parameter RAM_WIDTH =8,
            RAM_DEPTH=16,
            ADDR_SIZE=4;

    reg [RAM_WIDTH-1:0]d_in;
    reg clock,reset,wr_en,rd_en;
    reg [ADDR_SIZE-1:0]wr_addr,rd_addr;

    wire [RAM_WIDTH-1:0]d_out;

    syn_dual_16x8ram DUT(d_out,d_in,clock,reset,wr_en,wr_addr,rd_en,rd_addr);

    always
        begin
          clock=1'b0;
          forever #5 clock=~clock;
        end
    
    task initialize;
        begin
          d_in<=0;
          {wr_en,rd_en}=2'b00;
          {wr_addr,rd_addr}=8'h00;
        end
    endtask

    task resetips;
        begin
          @(negedge clock)
          reset=1'b1;
          @(negedge clock)
          reset=1'b0;
        end
    endtask

    task write(input [RAM_WIDTH-1:0]wd,input [ADDR_SIZE-1:0]wa);
        begin
        @(negedge clock)
        wr_en=1'b1;
        d_in<=wd;
        wr_addr<=wa;
        end
    endtask

    task read(input [ADDR_SIZE-1:0]rd);
        begin
          @(negedge clock)
          rd_en=1'b1;
          rd_addr<=rd;
        end
    endtask

    initial begin
        initialize;
        resetips;
        write(8'h10,4'h7);
	    #10;
        read(4'h7);
        #10;
        write(8'hAA,4'hA);
	    #10
        read(4'hA);
	    #10;
	    write(8'hFF,4'hF);
	    #10;
	    read(4'hF);
	    #10;
        resetips;
    end

    initial begin
        $monitor("d_out=%b, d_in=%b, reset=%b, wr_en=%b, wr_addr=%b, rd_en=%b,rd_addr=%b",d_out,d_in,reset,wr_en,wr_addr,rd_en,rd_addr);
    end

    initial begin
        #200 $finish;
    end
endmodule