module jk_ff_tb(); 
    reg clock; 
    reg j,k,rst; 
    wire q; 
    jk_ff DUT(q,j,k,clock,rst); 
 
    initial  
    begin 
        clock=1'b0; 
    forever #5 clock = ~clock; 
    end 
 
    task initialize; 
        begin 
            {j,k}=2'b00;
            rst = 1'b1;
        end 
    endtask

    task resetip; 
        begin 
            @(negedge clock) 
            rst=1'b1; 
            @(negedge clock) 
            rst=1'b0; 
        end
    endtask

    task jkip(input x,y); 
        begin 
        @(negedge clock) 
            j=x; 
            k=y; 
        end  
    endtask 
 
initial 
       begin 
        initialize; 
     resetip; 
     jkip(1'b0,1'b0); 
     #10; 
      jkip(1'b0,1'b1); 
     #10; 
      jkip(1'b0,1'b0); 
     #10; 
      jkip(1'b1,1'b0); 
     #10; 
      jkip(1'b0,1'b0); 
     #10; 
      jkip(1'b1,1'b1); 
     #10; 
     jkip(1'b0,1'b0); 
     #10; 
     jkip(1'b0,1'b1); 
     #10; 
 end 
  
initial 
$monitor("J=%b,K=%b ,Reset=%b  q=%b, ",j,k,rst,q); 
 
initial begin
  #200 $finish; 
end 
      
endmodule