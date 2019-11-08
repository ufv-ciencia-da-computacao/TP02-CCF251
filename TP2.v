/*
	Trabalho 2 - Logica Sequencial 
	Maquina de estados finito
	
	Dener Vieira Ribeiro
	Fabio Trindade Ramos
	Germano Barcelos dos Santos
	Jhonata Miranda da Costa
*/

module TP2(clk, reset, ok, tom, nota, fim, tipo, display);
	input ok, tom, reset, clk;
	input [2:0] nota;
	output fim;
	output reg [1:0] tipo;
	output [6:0] display;
	
	enum 
	
	display7seg d7s(tom, nota, display);
	
	reg [4:0] state = 0;
	
	always @(posedge clk) begin
		
		if(reset) begin
			state = 0;
			tipo = 0;
		end
		
		case(state)
			0: begin
				if(ok && ) begin
					
				end
			end
			1: begin
				state = state << 1;
			end
			2: begin
				state = state << 2;
			end
			16: begin
				state = 0;
			end
		endcase
	
	end

endmodule
