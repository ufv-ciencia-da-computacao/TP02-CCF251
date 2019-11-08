/*
	MODULO DISPLAY 7 SEGMENTOS
*/

module display7seg(tom, nota, saida);
	input 	tom;
	input 	[2:0] nota;
	output 	[6:0] saida;
	
	assign saida[0] = (~tom                                 ) |
							(       ~nota[0] & ~nota[1] & ~nota[2]);
	
	assign saida[1] = (                  ~nota[1] & ~nota[2]) |
							( tom &            ~nota[1]           ) |
							(       ~nota[0] & ~nota[1]           ) |
							( tom &  nota[0] &            ~nota[2]) |
							(~tom & ~nota[0] &            ~nota[2]);
							
	assign saida[2] = (                  ~nota[1] & ~nota[2]) |
							(~tom &            ~nota[1]           ) |
							(~tom &                        nota[2]) |
							(        nota[0] &  nota[1] &  nota[2]);
	
	assign saida[3] = ( tom &                        nota[2]) |
							( tom &             nota[1]           ) |
							(        nota[0] &  nota[1] & ~nota[2]) |
							(       ~nota[0] & ~nota[1] & ~nota[2]);
	
	assign saida[4] = ( tom & ~nota[0] &  nota[1] &  nota[2]) |
							(                  ~nota[1] & ~nota[2]) |
							(~tom &  nota[0] &  nota[1]           ) |
							(        nota[0] &  nota[1] & ~nota[2]);
	
	assign saida[5] = (       ~nota[0] & ~nota[1]           ) |
							(       ~nota[0] &             nota[2]) |
							( tom &            ~nota[1] & ~nota[2]) |
							(~tom &             nota[1] & ~nota[2]);
	
	assign saida[6] = (       ~nota[0] & ~nota[1] & ~nota[2]) |
							(        nota[0] & ~nota[1] &  nota[2]) |
							( tom & ~nota[0] &  nota[1]           );

endmodule

