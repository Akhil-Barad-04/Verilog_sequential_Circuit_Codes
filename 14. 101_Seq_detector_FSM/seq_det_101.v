module seq_det_101(d_out,d_in,reset,clock);

	input d_in,reset,clock;
	output  d_out;

	parameter s0 =2'b00,
				s1 =2'b01,
				s2 =2'b10,
				s3 =2'b11 ;
								 
  	reg [1:0]state,next_state;

	always @(posedge clock) 
		begin
			if(reset)
			state<=s0;
			else
			state<=next_state;
		end

   	always @(state,d_in) 
   		begin
			case (state)
				s0 :if(d_in) 
			 			next_state<=s1;
					else
						next_state<=s0;
				s1 :if(d_in) 
						next_state<=s1;
					else
						next_state<=s2;
				 s2 :if(d_in) 
						next_state<=s3;
					else
						next_state<=s0;
				 s3 :if(d_in) 
						next_state<=s1;
					else
						next_state<=s2;
					 default: next_state<=s0;
			endcase
		end

		assign d_out=(state==s3);
		
   	endmodule


