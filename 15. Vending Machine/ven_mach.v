/*
-->A synchronous logic control unit for Vending machine and.

-->The machine can take only two types of coins of denomination 1 and 2 in any order.
    It delivers only one product that is priced Rs. 3.

-->On receiving Rs. 3 the product is delivered by asserting an output X=1 which 
    otherwise remains 0. If it gets Rs. 4 then the product is delivered by 
    asserting X and also a coin return mechanism is activated by output Y = 1 to return a Re. 1 coin .

-->There are two sensors to sense the denomination of the coins that give binary output 
    as shown in the following table. The clock speed is much higher than human 
    response time, i.e. no two coins can be deposited in same clock cycle.

    I  | J |  Coin
    0  | X |  No coin dropped
    1  | 0 |  One Rupee
    1  | 1 |  Two Rupees

*/

module ven_mach(x,y,coin,reset,clock);

    output reg x,y;
    input [1:0]coin;
    input reset,clock;

    parameter s0 =2'b00,
                s1=2'b01,
                s2=2'b10 ;
    reg [1:0]pre_st,next_st;

    //present state seq logic

    always @(posedge clock) 
        begin
            if(reset)
            pre_st<=s0;
            else
            pre_st<=next_st;
        end

    //next state combinational logic

    always @(pre_st,coin) 
        begin
            next_st=s0;
            case (pre_st)
                s0  : if(coin==2'b10)
                        next_st=s1;
                    else if(coin==2'b11)
                        next_st=s2;
                    else
                        next_st=s0;
                s1  :if(coin==2'b10)
                        next_st=s2;
                    else if(coin==2'b11)
                        next_st=s0;
                    else
                        next_st=s1;
                s2  :if((coin==2'b10)||(coin==2'b11))
                        next_st=s0;
                    else
                        next_st=s2;
                default: next_st=s0;
            endcase       
        end

    //registered outputs sequential always block
    always @(posedge clock) 
        begin
            if(reset)
            begin
              x<=1'b0;
              y<=1'b0;
            end
            else
            begin
            case(pre_st)
                s1: if(coin==2'b11)
                    begin
                    x<=1;
                    y<=0;
                    end
                s2:if (coin==2'b10)
                    begin
                    x<=1;
                    y<=0;
                    end
                    else if(coin==2'b11)
                    begin
                      x<=1;
                      y<=1;
                    end
            endcase
            end
        end
endmodule