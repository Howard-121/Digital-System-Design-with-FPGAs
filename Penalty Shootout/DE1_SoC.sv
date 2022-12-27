module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_1, CLOCK_50, player_x, player_y, goalkeeper_x, check);
output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
output logic [9:0]  LEDR;
input  logic [3:0]  KEY;
input  logic [9:0]  SW;
output logic [35:0] GPIO_1;
input logic CLOCK_50;

logic [31:0] clk;
logic SYSTEM_CLOCK;
// Set up system base clock to 1526 Hz (50 MHz / 2**(14+1))
assign SYSTEM_CLOCK = clk[14]; // increase freq for no-flicker, lower for brighter

//assign clkSelect = clk[20]; // for FPGA demo
assign clkSelect = CLOCK_50; // for simulation

logic [15:0][15:0]RedPixels; // 16 x 16 array representing red LEDs
logic [15:0][15:0]GrnPixels; // 16 x 16 array representing green LEDs
logic RST;                   // reset - toggle this on startup
logic start;

assign RST = SW[9];
assign start = ~KEY[3];

clock_divider divider (.clock(CLOCK_50), .divided_clocks(clk));

logic shoot1, left1, right1, shoot2, left2, right2;
logic shoot, left, right;
logic [2:0] score;
logic [2:0] shots_num;

// double d-ff to deal with Metastability
always_ff @(posedge clkSelect) begin
	if (RST) begin
		right1 <= 1;
		left1 <= 1;
		shoot1 <= 1;
		right2 <= 1;
		left2 <= 1;
		shoot2 <= 1;
	end
	else begin
		right1 <= KEY[0];
		right2 <= right1;
		
		left1 <= KEY[2];
		left2 <= left1;
		
		shoot1 <= KEY[1];
		shoot2 <= shoot1;
	end
end

userin Left (.out(left),.clk(clkSelect),.reset(RST),.in(left2));
userin Right (.out(right),.clk(clkSelect),.reset(RST),.in(right2));
userin Shoot (.out(shoot),.clk(clkSelect),.reset(RST),.in(shoot2));


// Generate random number by LFSR
logic [9:0] randnum;
output logic [9:0] check;
assign check = randnum;
LFSR goalkeeper (.out(randnum),.clk(clkSelect),.reset(RST));

// Determine goalkeeper's movements
logic defense;
comparator comp (.out(defense),.A(randnum),.clk(clkSelect),.reset(RST));


output logic [3:0] player_x, player_y, goalkeeper_x;
Game PenaltyShootout (.clk(clkSelect),.RST(RST),.RedPixels(RedPixels),.GrnPixels(GrnPixels),
								.right(right),.left(left),.shoot(shoot),.score(score),.defense(defense),
								.shots_num(shots_num),.start(start),
								.player_x(player_x),.player_y(player_y),.goalkeeper_x(goalkeeper_x));


LEDDriver Driver (.CLK(SYSTEM_CLOCK), .RST, .EnableCount(1'b1), .RedPixels, .GrnPixels, .GPIO_1);


always_comb begin
case(score)
	3'd0: HEX0 = 7'b1000000; // 0
	3'd1: HEX0 = 7'b1111001; // 1
	3'd2: HEX0 = 7'b0100100; // 2
	3'd3: HEX0 = 7'b0110000; // 3
	3'd4: HEX0 = 7'b0011001; // 4
	3'd5: HEX0 = 7'b0010010; // 5
	default: HEX0 = 7'b1000000; // 0
endcase
end

always_comb begin
case(shots_num)
	3'd0: HEX5 = 7'b1000000; // 0
	3'd1: HEX5 = 7'b1111001; // 1
	3'd2: HEX5 = 7'b0100100; // 2
	3'd3: HEX5 = 7'b0110000; // 3
	3'd4: HEX5 = 7'b0011001; // 4
	3'd5: HEX5 = 7'b0010010; // 5
	default: HEX5 = 7'b1000000; // 0
endcase
end

assign HEX1 = 7'b1111111;
assign HEX2 = 7'b1111111;
assign HEX3 = 7'b1111111;
assign HEX4 = 7'b1111111;

endmodule


module DE1_SoC_testbench(); 
logic CLOCK_50; 
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
logic [9:0] LEDR; 
logic [3:0] KEY; 
logic [9:0] SW; 
logic [3:0] player_x, player_y, goalkeeper_x;
logic [9:0] check;

DE1_SoC dut (.CLOCK_50(CLOCK_50), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3),
 .HEX4(HEX4), .HEX5(HEX5), .KEY(KEY), .LEDR(LEDR), .SW(SW), .player_x(player_x), 
 .player_y(player_y), .goalkeeper_x(goalkeeper_x), .check(check)); 

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
 
SW[9] <= 1; repeat(1) @(posedge CLOCK_50); 
SW[9] <= 0; KEY[3] <= 0; repeat(1) @(posedge CLOCK_50); 
KEY[3] <= 1; repeat(1) @(posedge CLOCK_50);

KEY[0] <= 0; repeat(1) @(posedge CLOCK_50);
KEY[0] <= 1; repeat(1) @(posedge CLOCK_50);
KEY[0] <= 0; repeat(1) @(posedge CLOCK_50);
KEY[0] <= 1; repeat(1) @(posedge CLOCK_50);

KEY[2] <= 0; repeat(1) @(posedge CLOCK_50);
KEY[2] <= 1; repeat(1) @(posedge CLOCK_50);

KEY[1] <= 0; repeat(1) @(posedge CLOCK_50);
KEY[1] <= 1; repeat(15) @(posedge CLOCK_50);

KEY[2] <= 0; repeat(1) @(posedge CLOCK_50);
KEY[2] <= 1; repeat(1) @(posedge CLOCK_50);
KEY[2] <= 0; repeat(1) @(posedge CLOCK_50);
KEY[2] <= 1; repeat(1) @(posedge CLOCK_50);

KEY[2] <= 0; repeat(1) @(posedge CLOCK_50);
KEY[2] <= 1; repeat(1) @(posedge CLOCK_50);
KEY[2] <= 0; repeat(1) @(posedge CLOCK_50);
KEY[2] <= 1; repeat(1) @(posedge CLOCK_50);

KEY[1] <= 0; repeat(1) @(posedge CLOCK_50);
KEY[1] <= 1; repeat(16) @(posedge CLOCK_50);

$stop;

end 
endmodule 




