class transaction extends uvm_sequence_item;

rand bit [7:0] A;
rand bit [7:0] B;
rand bit [2:0] op;
bit [7:0] ALU_Out;

  //constraint addr_C {op > 3; op < 5;};

function new(input string inst = "TRANS");
	super.new(inst);
endfunction
// register to factory
`uvm_object_utils_begin(transaction)
`uvm_field_int(A,UVM_DEFAULT)
`uvm_field_int(B,UVM_DEFAULT)
`uvm_field_int(op,UVM_DEFAULT)
`uvm_field_int(ALU_Out,UVM_DEFAULT)
`uvm_object_utils_end

endclass