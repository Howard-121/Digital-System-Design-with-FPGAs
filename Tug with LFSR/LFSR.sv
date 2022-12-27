module LFSR(clk, reset, out);

input logic clk, reset;
output logic [9:0] out;

always_ff @(posedge clk) begin

	if (reset)
		out <= 10'd0;
	else
		out[0] <= ~(out[9]^out[6]);
		out[1] <= out[0];
		out[2] <= out[1];
		out[3] <= out[2];
		out[4] <= out[3];
		out[5] <= out[4];
		out[6] <= out[5];
		out[7] <= out[6];
		out[8] <= out[7];
		out[9] <= out[8];
end

endmodule
