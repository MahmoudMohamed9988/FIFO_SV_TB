import pkg_1::*;


class env;
transaction trans;
generator gen;
driver drv;
check chk1;
monitor_in mon1;
mailbox #(transaction) env_box;
mailbox chk_box;

function new(virtual dut_if intf);
this.env_box=new();
this.chk_box=new();

this.trans=new();
this.gen=new(this.env_box,trans);
this.drv=new(this.env_box,intf);
this.mon1=new(intf,this.chk_box);
this.chk1=new(this.chk_box,this.env_box);

endfunction

task test();
$display("at enviro the mail handle = %0d ",this.env_box);
$display("at enviro the chk mail handle = %0d ",this.chk_box);

fork
drv.rst();
this.gen.generation(5);
this.drv.drive(5);
mon1.monitor(5);
chk1.check_inout(5);
join_none
endtask

task run();
this.test();

endtask


endclass
