import pkg_1::*;

class check;
mailbox out_box;
transaction check_tran;
mailbox #(transaction) tran_from_gen_to_checker;
logic [31:0] out;


function new(mailbox out_box,mailbox #(transaction) tran_from_gen_to_checker);
this.out_box=out_box;
this.tran_from_gen_to_checker=tran_from_gen_to_checker;
endfunction


task check_inout(int count);
repeat (count)begin
tran_from_gen_to_checker.get(this.check_tran);
$display("at checker the trans handle = %0d",check_tran);
$display("at checker the input data = %0d",check_tran.data_in);
$display("at checker the write data = %0d",check_tran.wrt);
$display("at checker the reade data = %0d",check_tran.rd);
out_box.get(out);
$display("at checker the out data = %0d",out);
$display("the check task goning on");
if((check_tran.wrt == 1))begin
$display("the dut overload");
end
else if((check_tran.rd == 1))begin
$display("the dut reading null");
end 
else begin
$display("the dut doing well");
end
end
endtask



endclass
