
//////////////////////////////////////////////////////
import uvm_pkg::*;
`include "uvm_macros.svh"

`include "uvm_macros.svh"
`include "transaction.sv"
`include "driver.sv"
`include "monitor.sv"

`include "scoreboard.sv"
`include "agent.sv"
`include "sequence.sv"
`include "environment.sv"
`include "test.sv"




module alu_tb;

 //import alu_pkg::*;


test t;
alu_if aif();

  alu dut ( .clk(aif.clk), .A(aif.A), .B(aif.B), .op(aif.op), .ALU_Out(aif.ALU_Out) );


initial begin
aif.clk = 0;
end

  
always#10 aif.clk = ~aif.clk;

initial begin
t = new("TEST", null);
  uvm_config_db #(virtual alu_if)::set(null, "*", "aif", aif);
run_test();
end
initial begin
  $dumpfile("dump.vcd");
  $dumpvars;
  #1000;

  $finish;
end 
endmodule


