module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW); 

input logic CLOCK_50; // 50MHz clock. 
output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
output logic [9:0] LEDR;
input logic [3:0] KEY; // True when not pressed, False when pressed 
input logic [9:0] SW; 

logic clk;
logic reset;
logic [7:0] inputA;
logic [3:0] result;
logic start;

assign start = SW[9];
assign reset = ~KEY[0];

logic [31:0] divided_clocks;
clock_divider dut (.clock(CLOCK_50),.reset(reset),.divided_clocks(divided_clocks));
assign clk = divided_clocks[15];

enum {s1,s2,s3} ps, ns;

always_ff @(posedge clk) begin
	if (reset)
		ps <= s1;
	else
		ps <= ns;
end


logic a0;
//assign LEDR[7:0] = inputA;

always_ff @(posedge clk) begin
	if (reset) begin
		inputA <= SW[7:0]; a0 <= 0;
		end
	else begin
		if (start) begin
			a0 <= inputA[0];
			inputA[0] <= inputA[1];
			inputA[1] <= inputA[2];
			inputA[2] <= inputA[3];
			inputA[3] <= inputA[4];
			inputA[4] <= inputA[5];
			inputA[5] <= inputA[6];
			inputA[6] <= inputA[7];
			inputA[7] <= 0;
		end
		else begin
			inputA <= SW[7:0];
			a0 <= 0; 
		end
	end
end


always_ff @(posedge clk) begin
	if (reset) 
		result <= 4'd0;
	else begin
		if (start == 0)
			result <= 4'd0;
		else begin
			if (a0) 
				result <= result + 4'd1;
			else
				result <= result;
		end
	end
end


always_comb begin
case(ps)
s1: begin
	if (start == 0)
		ns = s1;
	else
		ns = s2;
end

s2: begin
	if (inputA == 8'd0)
		ns = s3;
	else
		ns = s2;
end	

s3: begin
	if (start)
		ns = s3;
	else
		ns = s1;
end	
endcase
end


logic Done;
assign LEDR[9] = Done;

always_comb begin
case(ps)
s1: Done = 0;

s2: Done = 0;
	
s3: Done = 1;
	
endcase
end


always_comb begin
case(result)
	4'd0: HEX0 = 7'b1000000; // 0
	4'd1: HEX0 = 7'b1111001; // 1
	4'd2: HEX0 = 7'b0100100; // 2
	4'd3: HEX0 = 7'b0110000; // 3
	4'd4: HEX0 = 7'b0011001; // 4
	4'd5: HEX0 = 7'b0010010; // 5
	4'd6: HEX0 = 7'b0000010; // 6
	4'd7: HEX0 = 7'b1111000; // 7
	4'd8: HEX0 = 7'b0000000; // 8
	default: HEX0 = 7'b1111111;
endcase
end

assign HEX1 = 7'b1111111;
assign HEX2 = 7'b1111111;
assign HEX3 = 7'b1111111;
assign HEX4 = 7'b1111111;
assign HEX5 = 7'b1111111;

endmodule 


`timescale 1 ps / 1 ps

module DE1_SoC_testbench(); 
logic CLOCK_50; 
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
logic [9:0] LEDR; 
logic [3:0] KEY; 
logic [9:0] SW; 
DE1_SoC dut (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW); 

// Set up a simulated clock. 
parameter CLOCK_PERIOD=100; 

initial begin 
CLOCK_50 <= 0; 
// Forever toggle the clock 
forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; 
end 

// Test the design. 
initial begin 
repeat(1) @(posedge CLOCK_50); 
KEY[0] <= 0; repeat(1) @(posedge CLOCK_50); 
SW[7:0] <= 8'd3; repeat(1) @(posedge CLOCK_50);
KEY[0] <= 1; repeat(3) @(posedge CLOCK_50); 
SW[9] <= 1; repeat(9) @(posedge CLOCK_50); 

SW[9] <= 0; repeat(1) @(posedge CLOCK_50); 
SW[7:0] <= 8'd7; repeat(1) @(posedge CLOCK_50);
SW[9] <= 1; repeat(9) @(posedge CLOCK_50); 
SW[9] <= 0; repeat(1) @(posedge CLOCK_50); 

end 
endmodule 

