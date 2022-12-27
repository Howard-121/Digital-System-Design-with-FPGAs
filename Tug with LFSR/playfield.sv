module playfield (clk, reset, Rin, Lin, LED);

input logic clk, reset, Rin, Lin;
output logic [9:0] LED;

logic [9:0] LEDreg;
enum {game, leftwin, rightwin} ps, ns;

always_ff @(posedge clk) begin
	if (reset) begin
		ps <= game;
		LEDreg <= 10'd32;
		end
	else begin
		ps <= ns;
		LEDreg <= LED;
		end
end

always_comb begin	
case(ps)

//	game: begin
//	if (LEDreg[9]|LEDreg[1])
//		LED = 10'd32;
//	else begin
//		if ( Rin == 1 && Lin == 0)
//			LED = LEDreg >> 1;
//		else if ( Lin == 1 && Rin == 0)
//			LED = LEDreg << 1;
//		else
//			LED = LEDreg;
//		end
//	end

	game: begin
		if ( Rin == 1 && Lin == 0)
			LED = LEDreg >> 1;
		else if ( Lin == 1 && Rin == 0)
			LED = LEDreg << 1;
		else
			LED = LEDreg;
	end
	
	leftwin:
		LED = 10'd32;
	
	rightwin:
		LED = 10'd32;
	
//	leftwin:
//		LED = LEDreg;
//	
//	rightwin:
//		LED = LEDreg;

endcase	
end


always_comb begin
case(ps)
	
	game: begin
	if (LEDreg == 10'd4 && Rin == 1 && Lin == 0)
		ns = rightwin;
	else if (LEDreg == 10'd256 && Lin == 1 && Rin == 0)
		ns = leftwin;
	else 
		ns = game;
	end
	
	leftwin: ns = game;
	
	rightwin: ns = game;
	
//	leftwin:
//		if (Rin)
//			ns = game;
//		else
//			ns = leftwin;
//	
//	rightwin:
//		if (Rin)
//			ns = game;
//		else
//			ns = rightwin;
		
endcase
end

endmodule
