module runwaylights (clk, reset, w, out); 

input logic clk, reset;
input logic [1:0] w; 
output logic [2:0] out; 

// State variables 
enum { calm1, calm2, rtol1, rtol2, rtol3, ltor1, ltor2, ltor3} ps, ns;
 
// Next State logic 
always_comb begin 
case (ps) 
	calm1: begin
	if (w == 2'b00) begin ns = calm2; out = 3'b010; end
	else if (w == 2'b01) begin ns = rtol1; out = 3'b001; end
	else begin ns = ltor1; out = 3'b100; end
	end
	
	calm2: begin
	if (w == 2'b00) begin ns = calm1; out = 3'b101; end
	else if (w == 2'b01) begin ns = rtol1; out = 3'b001; end
	else begin ns = ltor1; out = 3'b100; end
	end
	
	rtol1: begin
	if (w == 2'b00) begin ns = calm1; out = 3'b101; end
	else if (w == 2'b01) begin ns = rtol2; out = 3'b010; end
	else begin ns = ltor1; out = 3'b100; end
	end
	
	rtol2: begin
	if (w == 2'b00) begin ns = calm1; out = 3'b101; end
	else if (w == 2'b01) begin ns = rtol3; out = 3'b100; end
	else begin ns = ltor1; out = 3'b100; end
	end
	
	rtol3: begin
	if (w == 2'b00) begin ns = calm1; out = 3'b101; end
	else if (w == 2'b01) begin ns = rtol1; out = 3'b001; end
	else begin ns = ltor1; out = 3'b100; end
	end
	
	ltor1: begin
	if (w == 2'b00) begin ns = calm1; out = 3'b101; end
	else if (w == 2'b01) begin ns = rtol1; out = 3'b001; end
	else begin ns = ltor2; out = 3'b010; end
	end
	
	ltor2: begin
	if (w == 2'b00) begin ns = calm1; out = 3'b101; end
	else if (w == 2'b01) begin ns = rtol1; out = 3'b001; end
	else begin ns = ltor3; out = 3'b001; end
	end
	
	ltor3: begin
	if (w == 2'b00) begin ns = calm1; out = 3'b101; end
	else if (w == 2'b01) begin ns = rtol1; out = 3'b001; end
	else begin ns = ltor1; out = 3'b100; end
	end
	
endcase 
end 

// DFFs 
always_ff @(posedge clk) begin 
if (reset) 
ps <= calm1; 
else 
ps <= ns; 
end 
endmodule


module runwaylights_testbench(); 
logic clk, reset;
logic [1:0] w;
logic [2:0] out; 

runwaylights dut (clk, reset, w, out); 

// Set up a simulated clock. 
parameter CLOCK_PERIOD=100; 

initial begin 
clk <= 0; 
//Forever toggle the clock 
forever #(CLOCK_PERIOD/2) clk <= ~clk; 
end 

// Set up the inputs to the design. Each line is a clock cycle. 
initial begin 
@(posedge clk); 
reset <= 1; @(posedge clk); // Always reset FSMs at start 
reset <= 0; w <= 2'b00; @(posedge clk); 
@(posedge clk); 
@(posedge clk); 
@(posedge clk); 
w <= 2'b10; @(posedge clk); 
@(posedge clk); 
@(posedge clk); 
@(posedge clk); 
w <= 2'b01; @(posedge clk); 
@(posedge clk); 
@(posedge clk); 
@(posedge clk); 
w <= 2'b10; @(posedge clk); 
@(posedge clk); 
w <= 2'b00; @(posedge clk); 
@(posedge clk); 
@(posedge clk); 
w <= 2'b10; @(posedge clk); 
@(posedge clk); 
$stop; // End the simulation. 
end 
endmodule 


