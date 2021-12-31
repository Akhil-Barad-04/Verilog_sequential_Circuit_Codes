module up_down_counter(d_out,d_in,reset,load,clock,mode);
    output reg [3:0]d_out=0;
    input [3:0]d_in;
    input reset,load,clock,mode;

    always @(posedge clock) 
    begin
      if(reset==1)
        d_out<=4'b0000;
      else if(load==1)
        d_out<=d_in;
      else if(mode==1)
        d_out<=d_out + 1'b1;
      else
        d_out<=d_out - 1'b1;
    end
endmodule