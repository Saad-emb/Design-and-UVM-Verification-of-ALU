class driver extends uvm_driver#(transaction);
`uvm_component_utils(driver)


function new(input string inst = "DRV", uvm_component c);
	super.new(inst,c);
endfunction 
 
transaction data;
virtual alu_if aif; 
virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	data = transaction::type_id::create("TRANS");
    if(!uvm_config_db#(virtual alu_if)::get(this,"","aif",aif))
		`uvm_info("DRV", "Unable to access Interface", UVM_NONE);
endfunction

virtual task run_phase(uvm_phase phase);
	forever begin
	//specify data coming from tlm port
		seq_item_port.get_next_item(data);
		aif.A = data.A;
		aif.B = data.B;
  		aif.op=data.op; 
		`uvm_info("DRV","Send data to DUT", UVM_NONE);
		data.print(uvm_default_line_printer);
		seq_item_port.item_done();
	@(posedge aif.clk);
end
endtask

endclass
