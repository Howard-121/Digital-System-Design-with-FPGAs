module counter(clk, reset, win, count);

input logic reset, win, clk;
output logic [2:0] count;

always_ff @(posedge clk) begin

	if (reset)
		count <= 3'd0;
	else begin
		if (count == 3'd7)
			count <= count;
		else begin
			if (win)
				count <= count + 1'b1;
			else
				count <= count;
		end
	end
end

endmodule
