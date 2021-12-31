module jk_ff(q,j,k,clock,rst);
    input j,k,clock,rst;
    output reg q;

    parameter HOLD = 2'b00,
            RESET=2'b01,
            SET=2'b10,
            TOGGLE=2'b11;

    always @(posedge clock)
    begin
        if(rst)
            q<=2'b00;
        else
            begin
            case({j,k})

                HOLD    :q<=q;
                RESET    :q<=0;
                SET   :q<=1;
                TOGGLE  :q<=~q;
            endcase
             end
    end

    
endmodule