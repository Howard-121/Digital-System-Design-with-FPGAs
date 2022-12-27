module victory(LED, HEXOUT);

input logic [2:0] LED;
output logic [6:0] HEXOUT;

always_comb begin

case(LED)
	3'd0: HEXOUT = 7'b1000000; // 0
	3'd1: HEXOUT = 7'b1111001; // 1
	3'd2: HEXOUT = 7'b0100100; // 2
	3'd3: HEXOUT = 7'b0110000; // 3
	3'd4: HEXOUT = 7'b0011001; // 4
	3'd5: HEXOUT = 7'b0010010; // 5
	3'd6: HEXOUT = 7'b0000010; // 6
	3'd7: HEXOUT = 7'b1111000; // 7
	default: HEXOUT = 7'b1000000; // 0
endcase

end

endmodule
