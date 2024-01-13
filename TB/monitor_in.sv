
import pkg_1::*;
class monitor_in ;
virtual dut_if mon_if;
mailbox mon_out;
logic [31:0] get_out;

function new(virtual dut_if mon_if,mailbox mon_out);
this.mon_out=mon_out;
this.mon_if=mon_if;
endfunction

task monitor(int count);
repeat (count)begin
$display("at monitor the chk mail handle = %0d ",this.mon_out);
this.get_out=mon_if.data_out;
$display("at monitor output = %0d ",this.mon_if.data_out);
mon_out.put(get_out);

end
endtask

endclass
