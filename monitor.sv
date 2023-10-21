class monitor extends uvm_monitor;
`uvm_component_utils(monitor)
uvm_analysis_port #(transaction) send;
virtual alu_if aif;
transaction t;

function new(input string inst = "MON", uvm_component c);
	super.new(inst,c);
	send = new("WRITE",this);
endfunction

virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	t = transaction::type_id::create("TRANS");
    if(!uvm_config_db#(virtual alu_if)::get(this,"","aif",aif))
		`uvm_info("MON", "Unable to access Interface", UVM_NONE);
endfunction

virtual task run_phase(uvm_phase phase);
forever begin
  @(posedge aif.clk);  
  t.A = aif.A  ;
  t.B =aif.B ;
  t.op = aif.op;

  // wait clock cycle to send it to scoreboard to not get garbage data  
 @(posedge aif.clk)
t.ALU_Out = aif.ALU_Out ; 
`uvm_info("MON","Send data to Scoreboard", UVM_NONE);
t.print(uvm_default_line_printer);
send.write(t);

end
endtask

endclass