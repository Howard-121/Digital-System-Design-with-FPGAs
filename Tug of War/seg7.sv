
module seg7 (bcd, leds1, leds2, leds3, leds4, leds5, leds6); 
	input logic [2:0] bcd; 
	output logic [6:0] leds1, leds2, leds3, leds4, leds5, leds6; 

always_comb begin 
	case (bcd) 
		// pen
		3'b000: begin 
		leds1 = 7'b1001000; //N
		leds2 = 7'b0000110; //E
		leds3 = 7'b0001100; //P
		leds4 = 7'b1111111;
		leds5 = 7'b1111111;
		leds6 = 7'b1111111;
		end
		
		// glasses
		3'b001: begin 
		leds6 = 7'b1111111;
		leds5 = 7'b0000010; //G
		leds4 = 7'b1000111; //L
		leds3 = 7'b0001000; //A
		leds2 = 7'b0010010; //S
		leds1 = 7'b0010010; //S
		end
		
		// bottle
		3'b011: begin 
		leds6 = 7'b0000011; //b
		leds5 = 7'b0100011; //o
		leds4 = 7'b0000111; //t
		leds3 = 7'b0000111; //t
		leds2 = 7'b1000111; //L
		leds1 = 7'b0000110; //E
		end
		
		// cup
		3'b100: begin 
		leds6 = 7'b1111111;
		leds5 = 7'b1111111;
		leds4 = 7'b1111111;
		leds3 = 7'b1000110; //C
		leds2 = 7'b1000001; //U
		leds1 = 7'b0001100; //P
		end
		
		// spoon
		3'b101: begin 
		leds6 = 7'b1111111;
		leds5 = 7'b0010010; //S
		leds4 = 7'b0001100; //P
		leds3 = 7'b0100011; //o
		leds2 = 7'b0100011; //o
		leds1 = 7'b1001000; //N
		end
		
		// apple
		3'b110: begin 
		leds6 = 7'b1111111; 
		leds5 = 7'b0001000; //A
		leds4 = 7'b0001100; //P
		leds3 = 7'b0001100; //P
		leds2 = 7'b1000111; //L
		leds1 = 7'b0000110; //E
		end
		
		default: begin 
		leds1 = 7'bX;
		leds2 = 7'bX;
		leds3 = 7'bX;
		leds4 = 7'bX;
		leds5 = 7'bX;
		leds6 = 7'bX;
		end

	endcase 
end 

endmodule
