module d_ff(q,rst,clk,d_in);
        output reg q;
        input rst,clk,d_in;

        always @(posedge clk)
        begin
            if(rst)
            q<=0;
            else
            q<=d_in;
		end

endmodule