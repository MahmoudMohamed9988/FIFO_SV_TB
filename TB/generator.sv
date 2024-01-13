import pkg_1::*;
class generator ;
transaction gen_tran;
mailbox #(transaction) gen2drv;

function new(mailbox #(transaction) gen2drv,transaction gen_tran);
this.gen2drv = gen2drv;
this.gen_tran=gen_tran;
endfunction

//-------------------------------------------------
task generation(int count);
for(int i =0; i<count+1;i++)begin


  if(! gen_tran.randomize() )begin
         $fatal("Gen:: trans randomization failed");
	
   end
gen2drv.put(gen_tran);

end
$display("at gen the trans handla = %0d",gen_tran);
$display("at gen the mail handla = %0d",gen2drv);
endtask
//-------------------------------------------------

endclass
