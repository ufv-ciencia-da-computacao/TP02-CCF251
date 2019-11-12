/*
	Trabalho 2 - Logica Sequencial 
	Maquina de estados finito
	
	Dener Vieira Ribeiro
	Fabio Trindade Ramos
	Germano Barcelos dos Santos
	Jhonata Miranda da Costa
*/

module TP2(clk, reset, ok, tone, note, finish, type, display);
	input ok, tone, reset, clk;
	input [2:0] note;
	output reg finish;
	output reg [1:0] type;
	output [6:0] display;

	reg prev_ok;
	
	/* Initializing output display */
	display7seg d7s(tone, note, display);

	/* Define possible states for the Moore Machine */
	localparam [4:0]	state_inicial = 5'b00000,
							state_n1      = 5'b00001,
							state_n2_p    = 5'b00010,
							state_n2_i    = 5'b00011,
							state_n2_f    = 5'b00100,
							state_n3_p    = 5'b00101,
							state_n3_i    = 5'b00110,
							state_n3_f    = 5'b00111,
							state_n4_p    = 5'b01000,
							state_n4_i    = 5'b01001,
							state_n4_f    = 5'b01010,
							state_n5_p    = 5'b01011,
							state_n5_i    = 5'b01100,
							state_n5_f    = 5'b01101,
							state_final_p = 5'b01110,
							state_final_i = 5'b01111,
							state_final_f = 5'b10000,
							state_error   = 5'b10001;

	/* Define the Notes */
	localparam [2:0]	note_x  = 3'b000,
							note_c  = 3'b001,
							note_d  = 3'b010,
							note_e  = 3'b011,
							note_f  = 3'b100,
							note_g  = 3'b101,
							note_a  = 3'b110,
							note_b  = 3'b111;
	
	/* Define possible outputs */
	localparam [1:0]	type_none       = 2'b00,
							type_past       = 2'b01,
							type_infinitive = 2'b10,
							type_future     = 2'b11;

	/* Define possible finish outputs */
	localparam	process_finished      = 1'b1,
					process_not_finished  = 1'b0;
	
	/* save current state and next state*/
	reg [4:0] state;
	reg [4:0] next_state;

	/* Synchronous Process - Update State*/
	always @(posedge clk) begin
		if(reset) 
			state <= state_inicial;
		else 
			state <= next_state;
		prev_ok <= ok;
	end
	
	/* calculate next state */
	always @(ok, note, tone, state) begin
		next_state = state;
		
		if(ok && ~prev_ok) begin
			case(state)
			
				state_inicial: begin
					if(~tone && note == note_f) 
						next_state = state_n1;
					else 
						next_state = state_error;
				end

				state_n1: begin
					if(tone && note == note_c)
						next_state = state_n2_p;
					else if(tone && note == note_f)
						next_state = state_n2_i;
					else if(tone && note == note_b)
						next_state = state_n2_f;
					else
						next_state = state_error;
				end

				state_n2_p: begin
					if(note != note_x)
						next_state = state_n3_p;
					else
						next_state = state_error;
				end

				state_n2_i: begin
					if(note != note_x)
						next_state = state_n3_i;
					else
						next_state = state_error;
				end

				state_n2_f: begin
					if(note != note_x)
						next_state = state_n3_f;
					else
						next_state = state_error;
				end

				state_n3_p: begin
					if(note != note_x)
						next_state = state_n4_p;
					else
						next_state = state_error;
				end

				state_n3_i: begin
					if(note != note_x)
						next_state = state_n4_i;
					else
						next_state = state_error;
				end

				state_n3_f: begin
					if(note != note_x)
						next_state = state_n4_f;
					else
						next_state = state_error;
				end

				state_n4_p: begin
					if(~tone && note == note_g)
						next_state = state_n5_p;
					else
						next_state = state_error;
				end

				state_n4_i: begin
					if(~tone && note == note_g)
						next_state = state_n5_i;
					else
						next_state = state_error;
				end

				state_n4_f: begin
					if(~tone && note == note_g)
						next_state = state_n5_f;
					else
						next_state = state_error;
				end

				state_n5_p: begin
					if(note == note_x)
						next_state = state_final_p;
					else
						next_state = state_error;
				end

				state_n5_i: begin
					if(note == note_x)
						next_state = state_final_i;
					else
						next_state = state_error;
				end

				state_n5_f: begin
					if(note == note_x)
						next_state = state_final_f;
					else
						next_state = state_error;
				end

				state_final_p: begin
					next_state = state;
				end

				state_final_i: begin
					next_state = state;
				end

				state_final_f: begin
					next_state = state;
				end

				state_error: begin
					next_state = state;
				end

				default: begin
					next_state = state_inicial;
				end	
				
			endcase
		end
	end
	
	
	/* calculate outputs */
	always @(state) begin
		case(state)
			
			state_final_p: begin
				finish = process_finished;
				type = type_past;
			end
			
			state_final_i: begin
				finish = process_finished;
				type = type_infinitive;
			end
			
			state_final_f: begin
				finish = process_finished;
				type = type_future;
			end
			
			state_error: begin
				finish = process_finished;
				type = type_none;
			end
			
			default: begin
				finish = process_not_finished;
				type = type_none;
			end
			
		endcase
	end

endmodule
