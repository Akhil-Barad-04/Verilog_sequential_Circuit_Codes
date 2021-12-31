module mod_12_counter(d_out,d_in,load,reset,clock);
    output reg [3:0]d_out;
    input [3:0]d_in;
    input load,reset,clock;

    always @(posedge clock) 
     begin
        if(reset)
            d_out<=4'b0000;
        else if(load)
            d_out<=d_in;
        else if(d_out>=4'b1011)
            d_out<=4'b0000;
        else
            d_out<=d_out+1'b1;
        
    end

endmodule