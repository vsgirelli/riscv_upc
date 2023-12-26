// ALU module
module alu #(parameter WIDTH = 32)(
  input wire clk,               // Clock input
  input wire rst,               // Reset input
  input wire [31:0] operand1,   // 32-bit input operand operand1
  input wire [31:0] operand2,   // 32-bit input operand operand2
  input wire [6:0] alu_op,       // 7-bit ALU control input
  output reg [31:0] alu_result, // 32-bit output result
  output reg zero,              // Zero flag output
  output reg overflow,          // Overflow flag output
  output reg negative           // Negative flag output
);

reg [2*WIDTH-1:0] mult_result;  // Temporary variable for multiplication result 64-bit

always @(posedge clk or negedge rst) begin
  if (!rst)
    alu_result <= 32'h0;  // Reset result to zero
  else begin
    case (alu_op)
      7'b0000000: alu_result = operand1 + operand2; // ADD
      7'b0000001: alu_result = operand1 - operand2; // SUB
      7'b0000010: // MUL multiplier module
        pipelined_multiplier #(WIDTH) mult_inst (.operand1(operand1), .operand2(operand2), .mult_result(mult_result));
      alu_result = mult_result[WIDTH-1:0]; // Extract lower 32 bits as the result
      7'b0000100: alu_result = operand1 & operand2; // AND
      7'b0000101: alu_result = operand1 | operand2; // OR
      7'b0000110: alu_result = operand1 ^ operand2; // XOR
      // Add more operations as needed (e.g., SLT, SLTU, SLL, SRL, SRA) TODO
      default: alu_result = 32'h0; // Default to zero for unknown operations
    endcase

    // Set flags based on the result
    zero = (alu_result == 32'h0);
    negative = (alu_result[31] == 1);

    // Overflow flag for ADD and SUB operations
    overflow = ((operand1[31] & operand2[31] & ~alu_result[31]) | (~operand1[31] & ~operand2[31] & alu_result[31])) ? 1'b1 : 1'b0;
  end
end

endmodule

