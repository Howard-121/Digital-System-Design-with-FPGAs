module victory(LED1, LED9, HEXOUT);

input logic LED1, LED9;
output logic [6:0] HEXOUT;

logic [1:0] sign;
parameter player1 = 7'b1111001, player2 = 7'b0100100;

assign sign = {LED1, LED9};

always_comb begin
	if (sign == 2'b01)
		HEXOUT = player1;
	else if (sign == 2'b10)
		HEXOUT = player2;
	else
		HEXOUT = 7'b1111111;
end

endmodule


module victory_testbench();

logic LED1, LED9;
logic [6:0] HEXOUT;

victory dut (LED1, LED9, HEXOUT);

initial begin

for (int i = 0; i < 4; i++) begin
	 {LED1, LED9} = i; # 10;
end

end

endmodule
