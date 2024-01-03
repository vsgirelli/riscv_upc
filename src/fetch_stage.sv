module fetch_stage (
  input wire clk,
  input wire rst,
  output wire [31:0] instruction
);

reg [31:0] program_counter;

always @(posedge clk or posedge rst) begin
  if (rst) begin
    program_counter <= 0; // Reset the program counter TODO
  end else begin
    // Fetch the instruction from memory based on the current program counter
    // TODO instruction <= memory_read(program_counter); // Increment the program counter for the next instruction
    program_counter <= program_counter + 4;
  end
end

endmodule
