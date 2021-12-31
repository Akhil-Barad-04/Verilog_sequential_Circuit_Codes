module buff_clock(clk,buff_clk);
  input clk;
  output buff_clk;
  
  buf #(5) (buff_clk,clk);
endmodule