module t_ff_using_d_ff(q,t_in,rst,clk);
    output wire q;
    input t_in,rst,clk;
    wire w;

    d_ff D(q,rst,clk,w);
    xor(w,q,t_in);

endmodule