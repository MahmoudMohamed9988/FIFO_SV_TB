
import pkg_1::*;
`include"FIFO_design.v"
module tb_top;

dut_if intf();

FIFO F1(intf.clk1,intf.clk2,intf.rst,intf.wrt,intf.rd,intf.data_in,intf.data_out);
initial begin
env env1;
env1=new(intf);
env1.run();
end

initial begin 

intf.clk1=1'b0;
forever  #1 intf.clk1 = ~intf.clk1; 

end

initial begin 
intf.clk2=1'b0;
forever #2 intf.clk2 = ~intf.clk2;
end
endmodule
