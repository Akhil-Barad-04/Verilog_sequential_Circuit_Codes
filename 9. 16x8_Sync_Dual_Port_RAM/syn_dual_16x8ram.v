module syn_dual_16x8ram(d_out,d_in,clock,reset,wr_en,wr_addr,rd_en,rd_addr);

    parameter RAM_WIDTH = 8,
            RAM_DEPTH = 16,
            ADDR_SIZE = 4;

    output reg[RAM_WIDTH-1:0]d_out;
    input [RAM_WIDTH-1:0]d_in;
    input clock,reset,wr_en,rd_en;
    input [ADDR_SIZE-1:0]wr_addr,rd_addr;
    reg [RAM_WIDTH-1:0]mem[0:RAM_DEPTH-1];

    integer i;

    always @(posedge clock) 
        begin
            if(reset)
            begin
              for (i = 0;i<RAM_DEPTH ;i=i+1 ) 
              begin
              mem[i] <=0;  
              end
            end
            else if(wr_en==1)
            mem[wr_addr]<=d_in; 
        end

    always @(posedge clock) 
        begin
            if(reset)
            d_out<=0;  
            else if(rd_en)
            d_out<=mem[rd_addr];
    end

endmodule