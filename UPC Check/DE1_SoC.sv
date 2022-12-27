// Top-level module that defines the I/Os for the DE1 SoC board

module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
output logic [9:0] LEDR;
input logic [3:0] KEY;
input logic [9:0] SW;

UPC sign (.discounted(LEDR[0]),.stolen(LEDR[1]),.mark(SW[0]),.upc(SW[9:7]));

seg7 display (.leds1(HEX0),.leds2(HEX1),.leds3(HEX2),.leds4(HEX3),.leds5(HEX4),.leds6(HEX5),.bcd(SW[9:7]));

endmodule


module DE1_SoC_testbench();
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
logic [9:0] LEDR;
logic [3:0] KEY;
logic [9:0] SW;

DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR,
.SW);

// Try combinations of inputs.
integer i;
initial begin
for(i = 0; i < 16; i++) begin
{SW[9:7], SW[0]} = i; #10;
end
end

endmodule
