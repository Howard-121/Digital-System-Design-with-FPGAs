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

	game: begin
	if ( Rin == 1 && Lin == 0)
		LED = LEDreg >> 1;
	else if ( Lin == 1 && Rin == 0)
		LED = LEDreg << 1;
	else
		LED = LEDreg;
	end
	
	leftwin:
		LED = LEDreg;
	
	rightwin:
		LED = LEDreg;

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
	
	leftwin:
		ns = leftwin;
	
	rightwin:
		ns = rightwin;
		
endcase
end

endmodule


module playfield_testbench();

logic clk, reset, Rin, Lin;
logic [9:0] LED;

playfield dut (clk, reset, Rin, Lin, LED);


// Set up a simulated clock. 
parameter CLOCK_PERIOD=100; 

initial begin 
clk <= 0; 
// Forever toggle the clock 
forever #(CLOCK_PERIOD/2) clk <= ~clk; 
end 


initial begin

repeat(1) @(posedge clk);
reset <= 1; repeat(1) @(posedge clk); 
reset <= 0; Lin <= 0; Rin <= 0;repeat(1) @(posedge clk); 

Rin <= 1; Lin <= 0; repeat(2) @(posedge clk); 
Lin <= 1; Rin <= 0; repeat(1) @(posedge clk); 

Lin <= 1; Rin <= 1; repeat(1) @(posedge clk); 

Lin <= 1; Rin <= 0; repeat(2) @(posedge clk); 

Rin <= 1; Lin <= 0; repeat(5) @(posedge clk); 

end

endmodule
