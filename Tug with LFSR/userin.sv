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
