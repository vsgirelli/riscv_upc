// ALU module
module RISCV_ALU #(parameter WIDTH = 32)(
    input wire clk,            // Clock input
    input wire rst,            // Reset input
    input wire [31:0] A,        // 32-bit input operand A
    input wire [31:0] B,        // 32-bit input operand B
    input wire [6:0] ALUOp,     // 7-bit ALU control input
    output reg [31:0] result,   // 32-bit output result
    output reg zero,            // Zero flag output
    output reg overflow,        // Overflow flag output
    output reg negative         // Negative flag output
);

reg [2*WIDTH-1:0] mult_result;  // Temporary variable for multiplication result 64-bit

always @(posedge clk or negedge rst) begin
    if (!rst)
        result <= 32'h0;  // Reset result to zero
    else begin
        case (ALUOp)
            7'b0000000: result = A + B; // ADD
            7'b0000001: result = A - B; // SUB
            7'b0000010: // MUL multiplier module
                PipelinedMultiplier #(WIDTH) mult_inst (.A(A), .B(B), .P(mult_result));
                result = mult_result[WIDTH-1:0]; // Extract lower 32 bits as the result
            7'b0000100: result = A & B; // AND
            7'b0000101: result = A | B; // OR
            7'b0000110: result = A ^ B; // XOR
            // Add more operations as needed (e.g., SLT, SLTU, SLL, SRL, SRA) TODO
            default: result = 32'h0; // Default to zero for unknown operations
        endcase

        // Set flags based on the result
        zero = (result == 32'h0);
        negative = (result[31] == 1);

        // Overflow flag for ADD and SUB operations
        overflow = ((A[31] & B[31] & ~result[31]) | (~A[31] & ~B[31] & result[31])) ? 1'b1 : 1'b0;
    end
end

endmodule

