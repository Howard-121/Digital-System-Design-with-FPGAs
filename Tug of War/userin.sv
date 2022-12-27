module userin(in, out, clk, reset);
input logic in, clk, reset;
output logic out;

enum {nopress, press} ps, ns;

always_ff @(posedge clk) begin
	if (reset)
		ps <= nopress;
	else
		ps <= ns;
end

always_comb begin
	if (ps == nopress && in == 1) begin
		ns = nopress; out = 0;
	end
	else if (ps == nopress && in == 0) begin
		ns = press; out = 1;
	end
	else if (ps == press && in == 0) begin
		ns = press; out = 0;
	end
	else begin
		ns = nopress; out = 0;
	end
end


endmodule


module userin_testbench();

logic in, clk, reset;
logic out;

userin dut (in, out, clk, reset);


// Set up a simulated clock. 
parameter CLOCK_PERIOD=100; 

initial begin 
clk <= 0; 
// Forever toggle the clock 
forever #(CLOCK_PERIOD/2) clk <= ~clk; 
end 


initial begin

repeat(1) @(posedge clk);
reset <= 1; in <= 1; repeat(1) @(posedge clk); 
reset <= 0; in <= 1; repeat(1) @(posedge clk); 
in <= 0; repeat(2) @(posedge clk);  
in <= 1; repeat(3) @(posedge clk); 
in <= 0; repeat(1) @(posedge clk); 

end

endmodule
