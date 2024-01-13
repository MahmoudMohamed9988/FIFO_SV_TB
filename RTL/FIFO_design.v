module FIFO(
input clk1,clk2,rst, wrt, rd,
input [31:0] data_in,
output reg [31:0] data_out


);

reg [7:0] fifo_reg [31:0];
reg [2:0] wrt_p=0;
reg [2:0] rd_p=0;
wire full;
wire empty;
integer i ;

//-----------------------------------
always @(posedge clk1 )begin
 if(rst == 1)begin
	data_out <= 0;
	wrt_p <= 0;
	rd_p <= 0;
	for(i=0;i<8;i=i+1 )begin
 	    fifo_reg[i] <= 0;
	end
 end 
 else if((wrt == 1) && (full == 0))begin
    fifo_reg[wrt_p] <= data_in;
    wrt_p <= wrt_p+1;
 end 
 else begin 
   wrt_p <= wrt_p;
 end 
end

//------------------------------------
always @(posedge clk2) begin
if(rst == 1)begin
	data_out <= 0;
	wrt_p <= 0;
	rd_p <= 0;
	for(i=0;i<8;i=i+1 )begin
 	    fifo_reg[i] <= 0;
	end
 end 

 else if((rd == 1 )&& (empty == 0))begin
   data_out <= fifo_reg[rd_p] ;
   rd_p <= rd_p+1;
 end

else begin 
   rd_p <= rd_p;
 end
//-------------------------------------

end

assign empty = ((wrt_p - rd_p)==0)  ? 1'b1:1'b0;
assign full  = ((wrt_p - rd_p)==32 )  ? 1'b1:1'b0;

endmodule
