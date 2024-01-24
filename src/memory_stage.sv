import constants_pkg::*;
import structure_pkg::*;

module memory_stage (
  input logic clk,
  input logic rst,
  input inst_decoded_t inst_mem_in,
  output inst_decoded_t inst_mem_out,
  input logic stall_mem_in,
  output logic stall_mem_out,

  data_bus.comsumer dbus
);
// Assuming a simple memory with read and write ports
reg [31:0] memory [0:1023]; // 1024 words of 32 bits each

// TODO always check if inst_mem_in.valid == 1

assign inst_mem_out = inst_mem_in;
assign stall_mem_out = 0;
// assign stall_mem_out = ((inst_mem_out.valid & inst_mem_out.reg_data_ready) ? 0 : 1);

// TODO if cache miss set inst_mem_out.reg_data_ready = 0
// because this bit is checked at the decode stage when we check the bypasses
// and check what to do with the stall_mem_out

endmodule
