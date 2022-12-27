module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW); 

input logic CLOCK_50; // 50MHz clock. 
output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
output logic [9:0] LEDR;
input logic [3:0] KEY; // True when not pressed, False when pressed 
input logic [9:0] SW; 

// Generate clk off of CLOCK_50, whichClock picks rate. 
logic reset; 
assign reset = SW[9];
//logic [31:0] div_clk;  
//parameter whichClock = 25; // 0.75 Hz clock 

//clock_divider cdiv (.clock(CLOCK_50), 
//.reset(reset), 
//.divided_clocks(div_clk)); 

// Clock selection; allows for easy switching between simulation and board clocks 
//logic clkSelect; 
// Uncomment ONE of the following two lines depending on intention 
//assign clkSelect = CLOCK_50; // for simulation 
//assign clkSelect = div_clk[whichClock]; // for board 


// double d-ff to deal with Metastability
logic R1, R2, L1, L2;
always_ff @(posedge CLOCK_50) begin
	if (reset) begin
		R1 <= 1;
		L1 <= 1;
		R2 <= 1;
		L2 <= 1;
	end
	else begin
		R1 <= KEY[0];
		L1 <= KEY[3];
		R2 <= R1;
		L2 <= L1;
	end
end


logic P1, P2; // PLAYER1: LEFT, PLAYER2: RIGHT
userin Right (.out(P2),.clk(CLOCK_50),.reset(reset),.in(R2));
userin Left (.out(P1),.clk(CLOCK_50),.reset(reset),.in(L2));

playfield GAME (.LED(LEDR),.clk(CLOCK_50),.reset(reset),.Rin(P2),.Lin(P1));

victory outcome (.HEXOUT(HEX0),.LED1(LEDR[1]),.LED9(LEDR[9]));


//// Set up FSM inputs and outputs. 
//logic [1:0] w;
//logic [2:0] out; 
//assign w = SW[1:0]; // input is SW[0] 
//runwaylights s (.clk(clkSelect), .reset, .w, .out); 
//// Show signals on LEDRs so we can see what is happening 
//assign LEDR[9] = clkSelect; 
//assign LEDR[8] = reset; 
//assign LEDR[2:0] = out; 

assign HEX1 = 7'b1111111;
assign HEX2 = 7'b1111111;
assign HEX3 = 7'b1111111;
assign HEX4 = 7'b1111111;
assign HEX5 = 7'b1111111;

endmodule 



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
SW[9] <= 1; repeat(1) @(posedge CLOCK_50); 
SW[9] <= 0; KEY[3] <= 1; KEY[0] <= 1;repeat(1) @(posedge CLOCK_50); 

KEY[0] <= 0; KEY[3] <= 1; repeat(1) @(posedge CLOCK_50); 
KEY[3] <= 1; KEY[0] <= 1;repeat(1) @(posedge CLOCK_50); 
KEY[0] <= 0; KEY[3] <= 1; repeat(1) @(posedge CLOCK_50); 
KEY[3] <= 1; KEY[0] <= 1;repeat(1) @(posedge CLOCK_50); 
KEY[3] <= 0; KEY[0] <= 1; repeat(1) @(posedge CLOCK_50); 
KEY[3] <= 1; KEY[0] <= 1;repeat(1) @(posedge CLOCK_50); 


KEY[3] <= 0; KEY[0] <= 0; repeat(1) @(posedge CLOCK_50); 
KEY[3] <= 1; KEY[0] <= 1;repeat(1) @(posedge CLOCK_50); 

KEY[3] <= 0; KEY[0] <= 1; repeat(1) @(posedge CLOCK_50); 
KEY[3] <= 1; KEY[0] <= 1;repeat(1) @(posedge CLOCK_50); 

KEY[0] <= 0; KEY[3] <= 1; repeat(1) @(posedge CLOCK_50); 
KEY[3] <= 1; KEY[0] <= 1;repeat(1) @(posedge CLOCK_50); 
KEY[0] <= 0; KEY[3] <= 1; repeat(1) @(posedge CLOCK_50); 
KEY[3] <= 1; KEY[0] <= 1;repeat(1) @(posedge CLOCK_50); 
KEY[0] <= 0; KEY[3] <= 1; repeat(1) @(posedge CLOCK_50); 
KEY[3] <= 1; KEY[0] <= 1;repeat(1) @(posedge CLOCK_50); 
KEY[0] <= 0; KEY[3] <= 1; repeat(1) @(posedge CLOCK_50); 
KEY[3] <= 1; KEY[0] <= 1;repeat(1) @(posedge CLOCK_50); 
KEY[0] <= 0; KEY[3] <= 1; repeat(1) @(posedge CLOCK_50); 
KEY[3] <= 1; KEY[0] <= 1;repeat(1) @(posedge CLOCK_50); 

end 
endmodule 
