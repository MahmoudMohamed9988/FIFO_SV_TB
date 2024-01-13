import pkg_1::*;
class driver;
transaction drv_tran;
virtual dut_if drv_if;
mailbox #(transaction) gen2drv;

//--------------------------------------------
function new(mailbox #(transaction) gen2drv, virtual dut_if drv_if);
this.gen2drv=gen2drv;
this.drv_if=drv_if;
endfunction
///////////////////////////////////////////////////////////////////////
//----reset--task----------
task rst();
@(posedge drv_if.clk1)
drv_if.rst<=1;
drv_if.data_in <= 0;
drv_if.wrt<=0;
@(posedge drv_if.clk1)
drv_if.rst<=0;
@(posedge drv_if.clk2)
drv_if.rst<=1;
drv_if.rd<=0;
@(posedge drv_if.clk2)
drv_if.rst<=0;
endtask

///////////////////////////////////////////////////////////////////////
task drive(int count ) ;
repeat (count)begin
//-------------------------------------------
gen2drv.get(drv_tran);
$display("at driver ,the mail handle = %0d",gen2drv);

$display("at driver ,the tran handle = %0d",drv_tran); 
 
 repeat(3)@(posedge drv_if.clk1)
 drv_if.data_in<=drv_tran.data_in;
 drv_if.wrt<=drv_tran.wrt;
 


repeat(4) @(posedge drv_if.clk2)
 drv_if.rd<=drv_tran.rd;
 
 

//----------------------------------------------
end
endtask
///////////////////////////////////////////////////////////////////////////



endclass 
