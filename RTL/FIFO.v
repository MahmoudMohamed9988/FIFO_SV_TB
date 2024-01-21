module FIFO(input clk , reset , wr , rd , [7:0] wr_data , output reg full , empty , [7:0] rd_data);


reg [7:0] register_file [15 : 0];

reg [3:0] wr_pointer , rd_pointer , wr_pointer_next, rd_pointer_next;

reg full_next , empty_next;












// full, empty and pointers register
always @(posedge clk or negedge reset) begin
    if (~reset) begin
                   wr_pointer <= 0;   
                   rd_pointer <= 0;
                   full <= 0;
                   empty <= 0;
                end
     else begin
            wr_pointer <= wr_pointer_next;   
            rd_pointer <= rd_pointer_next;
            full <= full_next;
            empty <= empty_next;
         end
  
end

always@(*) begin

case ({wr,rd}) 

2'b01 : begin // read 
           wr_pointer_next = wr_pointer;
           full_next = full;
           rd_pointer_next = rd_pointer + 1'b1;
           if (rd_pointer_next == wr_pointer_next)
                  empty_next = 1'b1;       

        end
2'b10 : begin // write
           rd_pointer_next = rd_pointer;
           empty_next = empty;
           wr_pointer_next = wr_pointer + 1'b1;
           if (wr_pointer_next == rd_pointer_next)
                  full_next = 1'b1;       

        end
2'b11 : begin //read and write
            if (~full) begin
                       wr_pointer_next =  wr_pointer + 1'b1;
                      end
            if (~empty) begin
                       rd_pointer_next =  rd_pointer + 1'b1;
                      end
        end
default :  begin
                  full_next = full;
                  empty_next = full;
                  wr_pointer_next = wr_pointer;
                  rd_pointer_next  = rd_pointer;
                 end

endcase

end


//rd_data out
always@ (*)begin
if ((~empty) & rd ) begin
                       rd_data = register_file[rd_pointer] ;
                     end
end

// write data
always@(*) begin
if ((~full) & wr ) begin
                  register_file[wr_pointer] = wr_data;
                     end
end





endmodule
