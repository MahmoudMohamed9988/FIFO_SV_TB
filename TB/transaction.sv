
class transaction ;
rand logic wrt;
rand logic rd;

rand logic [31:0] data_in;

constraint a{wrt!=rd;}

endclass
