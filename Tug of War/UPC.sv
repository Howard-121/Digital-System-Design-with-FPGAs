
module UPC(discounted, stolen, upc, mark);
input logic mark;
input logic [2:0] upc;
output logic discounted, stolen;

always_comb
begin
	// discounted signal
	discounted = upc[1]|(upc[2]&upc[0]); 
	
	// stolen signal
	stolen = (upc[2]|~upc[0])&~upc[1]&~mark;
end

endmodule
