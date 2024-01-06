import constants_pkg::*;
import instruction_pkg::*;

module memory_stage (
  input logic clk,
  input logic rst,
  input inst_decoded_t inst_mem_in,
  output inst_decoded_t inst_mem_out,
  input logic stall_mem_in,
  output logic stall_mem_out
);
// Assuming a simple memory with read and write ports
reg [31:0] memory [0:1023]; // 1024 words of 32 bits each

assign inst_mem_out = inst_mem_in;

endmodule
