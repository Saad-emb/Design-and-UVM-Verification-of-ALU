class generator extends uvm_sequence#(transaction); //type of data object
`uvm_object_utils(generator)

transaction t;
integer i;

function new(input string inst = "GEN");
	super.new(inst);
endfunction

//no phases in generator 
virtual task body();
	t = transaction::type_id::create("TRANS");
	for(i =0; i< 15; i++) begin
		start_item(t);
		t.randomize();
		`uvm_info("GEN", "Data send to Driver", UVM_NONE);
		t.print(uvm_default_line_printer);
 		#10;
		finish_item(t);
	end  
endtask
  
endclass