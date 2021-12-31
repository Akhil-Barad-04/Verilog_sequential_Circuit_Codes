module siso_4_bit(sout,sin,q,clock,reset);

    output reg [3:0]q;
    output  sout;
    input sin,clock,reset;

    always @(posedge clock) 
    begin
        if(reset)
        q<=4'b0000;
        else
        q<={sin,q[3],q[2],q[1]};

    end
    assign sout=q[0];

endmodule