module asyn_dual_8x16ram(d_out,d_in,clear,wr_clk,rd_clk,we,re,wr_addr,rd_addr);

    parameter DATA_WIDTH =16,
            DATA_DEPTH=8,
            DATA_ADDR=3 ;

    output reg [DATA_WIDTH-1:0]d_out;

    input [DATA_WIDTH-1:0]d_in;
    input [DATA_ADDR-1:0]wr_addr,rd_addr;
    input clear,wr_clk,rd_clk,we,re;

    reg [DATA_WIDTH-1:0]ram[0:DATA_DEPTH-1];

    integer i;
    // write operation
    always @(posedge wr_clk,posedge clear) 
        begin
        if (clear==1)
            begin
              for(i=0;i<DATA_DEPTH;i=i+1)
                ram[i]<=0;
            end
        else if(we==1)
            ram[wr_addr]<=d_in;

        end
    //read operation
    always @(posedge rd_clk,posedge clear) 
        begin
            if(clear==1)
                 d_out<=16'h0000;
            else if (re==1) 
            begin
                d_out<=ram[rd_addr];    
            end
        end
endmodule