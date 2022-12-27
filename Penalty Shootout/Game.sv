module Game(clk, RST, RedPixels, GrnPixels, shoot, left, right, score, defense, shots_num, start, player_x, player_y, goalkeeper_x);

input logic               RST, clk, shoot, left, right, defense, start;
output logic [15:0][15:0] RedPixels; // 16x16 array of red LEDs
output logic [15:0][15:0] GrnPixels; // 16x16 array of green LEDs
output logic [2:0] score;
output logic [2:0] shots_num;

logic [2:0] score_reg;
logic [2:0] shots_num_reg;
logic block, goal;
output logic [3:0] player_x, player_y, goalkeeper_x;
logic [3:0] player_xreg, player_yreg, goalkeeper_xreg;

enum {ini, setup, game, prep} ps, ns;


always_ff @(posedge clk) begin
	if (RST) begin
		ps <= ini;
		player_xreg <= 4'd8;
		player_yreg <= 4'd15;
		goalkeeper_xreg <= 4'd8;
		shots_num_reg <= 3'd0;
		score_reg <= 3'd0;
	end
	else begin
		ps <= ns;
		player_xreg <= player_x;
		player_yreg <= player_y;
		goalkeeper_xreg <= goalkeeper_x;
		shots_num_reg <= shots_num;
		score_reg <= score;
	end	
end


always_comb begin // state
case(ps)
	ini: begin
	if (start)
		ns = setup;
	else
		ns = ini;
	end
	
	setup: begin
	if (shoot)
		ns = game;
	else
		ns = setup;
	end
	
	game: begin
	if ( (block|goal) == 1 )
		ns = prep;
	else
		ns = game;
	end
	
	prep: begin
	if (shots_num == 3'd5)
		ns = ini;
	else begin
	if (shoot)
		ns = game;
	else
		ns = prep;
		end
	end
endcase
end


always_comb begin // goalkeeper's output

case(ps)
	ini: goalkeeper_x = 4'd8;
	
	setup: begin
	if (goalkeeper_xreg == 4'd2)
		goalkeeper_x = 4'd11;
	else if (goalkeeper_xreg == 4'd13)
		goalkeeper_x = 4'd4;
	else begin
		if (defense)
			goalkeeper_x = goalkeeper_xreg + 4'd1;
		else
			goalkeeper_x = goalkeeper_xreg - 4'd1;
	end
	end
	
	game: begin
	if (goalkeeper_xreg == 4'd2)
		goalkeeper_x = 4'd11;
	else if (goalkeeper_xreg == 4'd13)
		goalkeeper_x = 4'd4;
	else begin
		if (defense)
			goalkeeper_x = goalkeeper_xreg + 4'd1;
		else
			goalkeeper_x = goalkeeper_xreg - 4'd1;
	end
	end
	
	prep: begin
	if (goalkeeper_xreg == 4'd2)
		goalkeeper_x = 4'd11;
	else if (goalkeeper_xreg == 4'd13)
		goalkeeper_x = 4'd4;
	else begin
		if (defense)
			goalkeeper_x = goalkeeper_xreg + 4'd1;
		else
			goalkeeper_x = goalkeeper_xreg - 4'd1;
	end
	end
endcase

end


always_comb begin // player's output

case(ps)
	ini: begin
	player_y = 4'd15; player_x = 4'd8;
	end
	
	setup: begin
	player_y = 4'd15;
	if (left == 1 && right == 0)
		player_x = player_xreg + 4'd1;
	else if (left == 0 && right == 1)
		player_x = player_xreg - 4'd1;
	else
		player_x = player_xreg;
	end
	
	game: begin
	player_y = player_yreg - 4'd1;
	player_x = player_xreg;
	end
	
	prep: begin
	player_y = 4'd15;
	if (left == 1 && right == 0)
		player_x = player_xreg + 4'd1;
	else if (left == 0 && right == 1)
		player_x = player_xreg - 4'd1;
	else
		player_x = player_xreg;
	end
endcase
	
end


always_comb begin // block or goal, score, and shots_num
case(ps)
	ini: begin
	goal = 0; block = 0; score = score_reg; shots_num = shots_num_reg;
	end
	
	setup: begin
	goal = 0; block = 0; score = 3'd0; shots_num = 3'd0;
	end
	
	game:
	begin
	if (player_y == 4'd1) begin
		goal = 1; block = 0; score = score_reg + 3'd1; shots_num = shots_num_reg + 3'd1;
		end
	else if (player_y==4'd3&&(goalkeeper_x==player_x || goalkeeper_x==player_x-4'd1 || goalkeeper_x==player_x+4'd1 || goalkeeper_x==player_x-4'd2 || goalkeeper_x==player_x+4'd2))
		begin goal = 0; block = 1; score = score_reg; shots_num = shots_num_reg + 3'd1; end
	else begin
		goal = 0; block = 0; score = score_reg; shots_num = shots_num_reg;
		end
	end
	
	prep: begin
	goal = 0; block = 0; score = score_reg; shots_num = shots_num_reg;
	end
endcase
end


always_ff @(posedge clk) begin // LEDArray display
if (RST) begin
  //                  FEDCBA9876543210
  RedPixels[00] <= 16'd0;
  RedPixels[01] <= 16'd0;
  RedPixels[02] <= 16'd0;
  RedPixels[03] <= 16'd0;
  RedPixels[04] <= 16'd0;
  RedPixels[05] <= 16'd0;
  RedPixels[06] <= 16'd0;
  RedPixels[07] <= 16'd0;
  RedPixels[08] <= 16'd0;
  RedPixels[09] <= 16'd0;
  RedPixels[10] <= 16'd0;
  RedPixels[11] <= 16'd0;
  RedPixels[12] <= 16'd0;
  RedPixels[13] <= 16'd0;
  RedPixels[14] <= 16'd0;
  RedPixels[15] <= 16'b0000000100000000;
  
  //                  FEDCBA9876543210
  GrnPixels[00] <= 16'b1111111111111111;
  GrnPixels[01] <= 16'd0;
  GrnPixels[02] <= 16'b0000011111000000;
  GrnPixels[03] <= 16'd0;
  GrnPixels[04] <= 16'd0;
  GrnPixels[05] <= 16'd0;
  GrnPixels[06] <= 16'd0;
  GrnPixels[07] <= 16'd0;
  GrnPixels[08] <= 16'd0;
  GrnPixels[09] <= 16'd0;
  GrnPixels[10] <= 16'd0;
  GrnPixels[11] <= 16'd0;
  GrnPixels[12] <= 16'd0;
  GrnPixels[13] <= 16'd0;
  GrnPixels[14] <= 16'd0;
  GrnPixels[15] <= 16'd0;
end
else begin
	GrnPixels[02][goalkeeper_xreg] <= 1'b0;
	GrnPixels[02][goalkeeper_xreg+1] <= 1'b0;
	GrnPixels[02][goalkeeper_xreg-1] <= 1'b0;
	GrnPixels[02][goalkeeper_xreg+2] <= 1'b0;
	GrnPixels[02][goalkeeper_xreg-2] <= 1'b0;
	
	GrnPixels[02][goalkeeper_x] <= 1'b1;
	GrnPixels[02][goalkeeper_x+1] <= 1'b1;
	GrnPixels[02][goalkeeper_x-1] <= 1'b1;
	GrnPixels[02][goalkeeper_x+2] <= 1'b1;
	GrnPixels[02][goalkeeper_x-2] <= 1'b1;
	
	RedPixels[player_yreg][player_xreg] <= 1'b0;
	RedPixels[player_y][player_x] <= 1'b1;
end
end

endmodule
