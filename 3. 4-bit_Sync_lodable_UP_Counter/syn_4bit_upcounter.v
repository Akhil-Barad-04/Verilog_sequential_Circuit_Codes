module syn_4bit_upcounter(d_out,d_in,load,reset,clk);
    output reg [3:0]d_out;
    input [3:0]d_in;
    input load,reset,clk;

    always @(posedge clk)
     begin
     if(reset)
     d_out<=4'b0000;
     else if(load)
     d_out<=d_in;
     else
     d_out<=d_out+1'b1;
        
    end

endmodule