module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW); 

input logic CLOCK_50; // 50MHz clock. 
output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
output logic [9:0] LEDR;
input logic [3:0] KEY; // True when not pressed, False when pressed 
input logic [9:0] SW; 

logic clk;
logic reset;
logic [7:0] inputA;
logic [7:0] memout;
//logic [4:0] address;
logic [4:0] location;
logic [4:0] locationtemp;
logic start;
logic found;

assign start = SW[9];
assign reset = ~KEY[0];
assign LEDR[9] = found;
assign inputA = SW[7:0];

logic [31:0] divided_clocks;
assign clk = CLOCK_50;
//clock_divider dut (.clock(CLOCK_50),.reset(reset),.divided_clocks(divided_clocks));
//assign clk = divided_clocks[15];
//assign clk = ~KEY[3];


ram32x8 RAM (.address(location),.clock(clk), 
.data(8'd0),.wren(0),.q(memout));

enum {s1,s2,s3} ps, ns;


always_ff @(posedge clk) begin
	if (reset)
		ps <= s1;
	else
		ps <= ns;
end


logic [4:0] calloc, calloctemp;

always_ff @(posedge clk) begin
	if (reset) begin
		location <= 5'd16;
		locationtemp <= 5'd16;
		end
	else begin
		if (start == 0) begin
			location <= 5'd16;
			locationtemp <= 5'd16;
			end
		else begin
			if (calloc != 0) begin
				if (inputA < memout) begin
					location <= locationtemp - calloc;
					locationtemp <= location;
					end
				else if (inputA > memout) begin
					location <= locationtemp + calloc;
					locationtemp <= location;
					end
				else begin
					location <= location;
					locationtemp <= locationtemp;
					end
			end
			else // calloc == 0; lastly compare address0
				location <= 5'd0;
		end
	end
end

always_ff @(posedge clk) begin
	if (reset) begin
		calloc <= 5'd8;
		calloctemp <= 5'd8;
		end
	else begin 
		if (start == 0) begin
			calloc <= 5'd8;
			calloctemp <= 5'd8;
			end
		else begin
		if (inputA == memout) begin
			calloctemp <= calloc;
			calloc <= calloctemp;
			end
		else begin
			calloctemp <= calloc >> 1;
			calloc <= calloctemp;
			end
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
	if (inputA == memout)
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


always_comb begin
case(ps)
s1: found = 0;

s2: found = 0;
	
s3: begin 
if (inputA == memout)
	found = 1;
else 
	found = 0;
end
	
endcase
end


always_comb begin
case(location[3:0])
	4'd0: HEX0 = 7'b1000000; // 0
	4'd1: HEX0 = 7'b1111001; // 1
	4'd2: HEX0 = 7'b0100100; // 2
	4'd3: HEX0 = 7'b0110000; // 3
	4'd4: HEX0 = 7'b0011001; // 4
	4'd5: HEX0 = 7'b0010010; // 5
	4'd6: HEX0 = 7'b0000010; // 6
	4'd7: HEX0 = 7'b1111000; // 7
	4'd8: HEX0 = 7'b0000000; // 8
	4'd9: HEX0 = 7'b0010000; // 9
	4'd10: HEX0 = 7'b0001000; // a
	4'd11: HEX0 = 7'b0000011; // b
	4'd12: HEX0 = 7'b1000110; // c
	4'd13: HEX0 = 7'b0100001; // d
	4'd14: HEX0 = 7'b0000110; // e
	4'd15: HEX0 = 7'b0001110; // f
	default: HEX0 = 7'b1111111;
endcase
end

always_comb begin
	if (location[4])
		HEX1 = 7'b1111001; // 1
	else if (location[4] == 0)
		HEX1 = 7'b1000000; // 0
	else
		HEX1 = 7'b1111111;
end

assign HEX2 = 7'b1111111;
assign HEX3 = 7'b1111111;
assign HEX4 = 7'b1111111;
assign HEX5 = 7'b1111111;

//always_comb begin
//case(memout[3:0])
//	4'd0: HEX4 = 7'b1000000; // 0
//	4'd1: HEX4 = 7'b1111001; // 1
//	4'd2: HEX4 = 7'b0100100; // 2
//	4'd3: HEX4 = 7'b0110000; // 3
//	4'd4: HEX4 = 7'b0011001; // 4
//	4'd5: HEX4 = 7'b0010010; // 5
//	4'd6: HEX4 = 7'b0000010; // 6
//	4'd7: HEX4 = 7'b1111000; // 7
//	4'd8: HEX4 = 7'b0000000; // 8
//	4'd9: HEX4 = 7'b0010000; // 9
//	4'd10: HEX4 = 7'b0001000; // a
//	4'd11: HEX4 = 7'b0000011; // b
//	4'd12: HEX4 = 7'b1000110; // c
//	4'd13: HEX4 = 7'b0100001; // d
//	4'd14: HEX4 = 7'b0000110; // e
//	4'd15: HEX4 = 7'b0001110; // f
//	default: HEX4 = 7'b1111111;
//endcase
//end
//
//always_comb begin
//case(memout[7:4])
//	4'd0: HEX5 = 7'b1000000; // 0
//	4'd1: HEX5 = 7'b1111001; // 1
//	4'd2: HEX5 = 7'b0100100; // 2
//	4'd3: HEX5 = 7'b0110000; // 3
//	4'd4: HEX5 = 7'b0011001; // 4
//	4'd5: HEX5 = 7'b0010010; // 5
//	4'd6: HEX5 = 7'b0000010; // 6
//	4'd7: HEX5 = 7'b1111000; // 7
//	4'd8: HEX5 = 7'b0000000; // 8
//	4'd9: HEX5 = 7'b0010000; // 9
//	4'd10: HEX5 = 7'b0001000; // a
//	4'd11: HEX5 = 7'b0000011; // b
//	4'd12: HEX5 = 7'b1000110; // c
//	4'd13: HEX5 = 7'b0100001; // d
//	4'd14: HEX5 = 7'b0000110; // e
//	4'd15: HEX5 = 7'b0001110; // f
//	default: HEX5 = 7'b1111111;
//endcase
//end

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
SW[7:0] <= 8'd100; repeat(1) @(posedge CLOCK_50);
KEY[0] <= 1; repeat(3) @(posedge CLOCK_50); 
SW[9] <= 1; repeat(10) @(posedge CLOCK_50); 

SW[9] <= 0; repeat(1) @(posedge CLOCK_50); 
SW[7:0] <= 8'd64; repeat(1) @(posedge CLOCK_50);
SW[9] <= 1; repeat(10) @(posedge CLOCK_50); 
SW[9] <= 0; repeat(1) @(posedge CLOCK_50); 

end 
endmodule 

