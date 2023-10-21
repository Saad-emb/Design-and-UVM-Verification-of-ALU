module alu(
 		   input clk,
           input [7:0] A,B,  // ALU 8bit Inputs          
  input [2:0] op,// ALU operation Selection
           output [7:0] ALU_Out, // ALU 8bit Output
 
    );
    reg [7:0] ALU_Result;
    assign ALU_Out = ALU_Result; // ALU out

  always @(posedge clk)
    begin
      case(op)
        4'b0000: // Addition
           ALU_Result = A + B ; 
        4'b0001: // Subtraction
           ALU_Result = A - B ;
        4'b0010: // Multiplication
           ALU_Result = A * B;
        4'b0011: // Division
           ALU_Result = A/B;
        4'b0100: // Logical shift left
           ALU_Result = A<<1;
        4'b0101: // Logical shift right
           ALU_Result = A>>1;
        4'b0110: // Rotate left
           ALU_Result = {A[6:0],A[7]};
        4'b0111: // Rotate right
           ALU_Result = {A[0],A[7:1]};
    
          default: ALU_Result = A + B ; 
        endcase
    end

endmodule

interface alu_if();
  logic [7:0] A;
  logic [7:0] B;
  logic [2:0] op;
  logic [7:0] ALU_Out;
  logic clk;

  
endinterface
     
