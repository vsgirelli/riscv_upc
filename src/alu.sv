// ALU module
import constants_pkg::*;

module alu #(parameter WIDTH = 32)(
  input wire clk,               // Clock input
  input wire [31:0] operand1,   // 32-bit input operand operand1
  input wire [31:0] operand2,   // 32-bit input operand operand2
  input wire [2:0] alu_op3,       // 3-bit func3 
  input wire [6:0] alu_op7,       // 7-bit func7 
  output reg [31:0] alu_result, // 32-bit output result
  output reg zero,              // Zero flag output
  output reg overflow,          // Overflow flag output
  output reg negative           // Negative flag output
);

reg [2*WIDTH-1:0] mult_result;  // Temporary variable for multiplication result 64-bit
logic [ARCH_LEN:0] result;
assign alu_result = result[ARCH_LEN-1:0];

/*
pipelined_multiplier mult_inst (
  .clk(clk),
  .rst(rst),
  .operand1(operand1),
  .operand2(operand2),
  .mult_result(mult_result)
);
*/

logic   signed [ARCH_LEN-1:0] sA;
logic   signed [ARCH_LEN-1:0] sB;
logic unsigned [ARCH_LEN-1:0] uA;
logic unsigned [ARCH_LEN-1:0] uB;

assign sA =   signed'(operand1);
assign sB =   signed'(operand2);
assign uA = unsigned'(operand1);
assign uB = unsigned'(operand2);

always_comb  begin
    case (alu_op3)
      3'b000: result = sA + sB; // ADD, SUB

      3'b001: result = sA << sB[4:0]; // SLL

      3'b010: result = {{ARCH_LEN-1{1'b0}}, (sA < sB)}; // SLT
      3'b011: result = {{ARCH_LEN-1{1'b0}}, (uA < uB)}; // SLTU

      3'b100: result = sA ^ sB; // XOR

      3'b101: begin 
        if(alu_op7[5]) result = uA >>> sB[4:0]; // SRA
        else result = uA >> sB[4:0]; // SRL
      end
      
      3'b101: result = sA | sB; // OR
      3'b111: result = sA & sB; // AND

      // Add more operations as needed (e.g., SLT, SLTU, SLL, SRL, SRA) TODO
      default: result = 32'h0; // Default to zero for unknown operations
    endcase

    // Set flags based on the result
    zero = (alu_result == 32'h0);
    negative = (alu_result[31] == 1);

    // Overflow flag for ADD and SUB operations
    overflow = ((operand1[31] & operand2[31] & ~alu_result[31]) | (~operand1[31] & ~operand2[31] & alu_result[31])) ? 1'b1 : 1'b0;
end

endmodule

