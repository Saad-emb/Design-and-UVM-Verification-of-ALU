class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard)
// first type of data and class where we have impl
uvm_analysis_imp #(transaction,scoreboard) recv;
transaction t;


function new(input string inst = "SCO", uvm_component c);
	super.new(inst,c);
	recv = new("READ",this);
endfunction

virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	t = transaction::type_id::create("TRANS");
endfunction
// write methode and perfom the check
virtual function void write(transaction data);
  t =data;
  
`uvm_info("SCO","Data rcvd from Monitor", UVM_NONE);
t.print(uvm_default_line_printer);                        
  
  case (data.op)
    4'b0000:
      if (data.ALU_Out == data.A + data.B)
        `uvm_info("SCO", "Test  of Addition Passed", UVM_NONE)
      else
        `uvm_info("SCO", "Test of Addition Failed", UVM_NONE)
    4'b0001:
      if (data.ALU_Out == data.A - data.B)
        `uvm_info("SCO", "Test of Subtraction Passed", UVM_NONE)
      else
        `uvm_info("SCO", "Test of Subtraction Failed", UVM_NONE)
     4'b0010:
        if (data.ALU_Out == data.A * data.B)
        `uvm_info("SCO", "Test of Multiplication Passed", UVM_NONE)
      else
        `uvm_info("SCO", "Test of Multiplication Failed", UVM_NONE)
     4'b0011:
        if (data.ALU_Out == data.A / data.B)
        `uvm_info("SCO", "Test of Division Passed", UVM_NONE)
      else
        `uvm_info("SCO", "Test of Division Failed", UVM_NONE)
     4'b0100:
      if (data.ALU_Out == data.A<<1)
        `uvm_info("SCO", "Test of shift left Passed", UVM_NONE)
      else
        `uvm_info("SCO", "Test of shift left Failed", UVM_NONE)
     4'b0101:
      if (data.ALU_Out == data.A >>1)
        `uvm_info("SCO", "Test of shift right Passed", UVM_NONE)
      else
        `uvm_info("SCO", "Test of shift right Failed", UVM_NONE)
     4'b0110:
        if (data.ALU_Out =={data.A[6:0],data.A[7]})
        `uvm_info("SCO", "Test of Rotate left Passed", UVM_NONE)
      else
        `uvm_info("SCO", "Test of Rotate left Failed", UVM_NONE) 
     4'b0111:
        if (data.ALU_Out =={data.A[0],data.A[7:1]})
          `uvm_info("SCO", "Test of Rotate right Passed", UVM_NONE)
      else
        `uvm_info("SCO", "Test of Rotate rigt Failed", UVM_NONE) 

    default:
      `uvm_info("SCO", "Unsupported ALU_Sel value", UVM_NONE)
  endcase  
endfunction
  
  

endclass
