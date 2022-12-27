module comparator(A, out, clk, reset);

input logic clk, reset;
input logic [9:0] A;
output logic out;

always_ff @(posedge clk) begin

	if (reset)
		out = 1'b0;
	else begin
		if (A[3] == 1)
			out = 1'b1;
		else
			out = 1'b0;
	end
end

endmodule
