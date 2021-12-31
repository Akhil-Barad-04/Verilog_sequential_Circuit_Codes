module buff_clk_tb();
  reg clk;
  wire buff_clk;
  time t1,t2,t3,t4;
  real freq1,freq2;
  integer a,tp,pd;
  buff_clock DUT(clk,buff_clk);
  
  initial
  begin
      clk=1'b0;
      forever #10 clk=~clk;
  end
  
  
  initial
  begin
  fork 
  begin
    @(posedge clk)
      t1=$time;
    @(posedge clk)
      t2=$time;
  end 
  begin 
    @(posedge buff_clk)
    t3 = $time;
    @(posedge buff_clk)
    t4 = $time;
  end
  join
  assign pd= (t1-t2);
  assign tp = (t2-t1);
  assign freq1=(1.0)/(t2-t1);
    assign freq2=(1.0)/(t4-t3);
    
end
  initial 
  begin 
  $monitor("m_clk=%b,t1=%t,t2=%t,t3=%t,t4=%t,pd=%d,tp=%d,frq1=%g,freq2=%g",clk,t1,t2,t3,t4,pd,tp,freq1,freq2);
  end

  initial begin
      #200 $finish;
  end

  endmodule