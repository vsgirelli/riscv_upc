import constants_pkg::*;
import instruction_pkg::*;

// top_level_module.v
module processor_model (
  input wire clk,
  input wire rst
  // ... other input/output ports
);

logic [INST_LEN-1:0]                          inst_fetched_out; // fetch_stage
logic [INST_LEN-1:0] inst_dec, inst_dec_next;                   // decode_stage
inst_decoded_t                                inst_dec_out;     // decode_stage
inst_decoded_t       inst_exe, inst_exe_next, inst_exe_out;     // execute_stage
inst_decoded_t       inst_mul, inst_mul_next, inst_mul_out;     // pipelined_multiplier
inst_decoded_t       inst_mem, inst_mem_next, inst_mem_out;     // memory_stage
inst_decoded_t       inst_wb,  inst_wb_next;                    // write_back_stage

// Stalls
logic stall_fet,     stall_dec,     stall_exe,     stall_mul,     stall_mem;
// Backward stalls
logic stall_fet_out, stall_dec_out, stall_exe_out, stall_mul_out, stall_mem_out;

// to stall is to have the same input:
// inst_x = inst_x

assign stall_dec = stall_dec_out;
assign stall_fet = stall_dec;

assign inst_dec_next = stall_dec_out ? inst_dec : inst_fetched_out;
assign inst_exe_next = stall_dec_out

always_ff @(posedge clk) begin
  inst_dec = inst_dec_next; // either I stall, or I get inst_fetched_out
  inst_exe = inst_exe_next; // stall or inst_dec_out
  inst_mul = inst_mul_next; // stall or inst_dec_out
  inst_mem = inst_mem_next; // stall, or inst_exe_out, or inst_mul_out
end

fetch_stage fetch_inst (
  .clk(clk),
  .rst(rst),
  .inst_fetched_out(inst_fetched_out),
  .stall_fet_in(stall_fet)
  // ... other inputs/outputs
);

decode_stage decode_inst (
  .clk(clk),
  .rst(rst),
  .inst_fetched_in(inst_dec),
  .inst_dec_out(inst_dec_out),
  .inst_wb_in(inst_wb),
  .stall_dec_out(stall_dec_out),
  .exe_bypass(inst_exe_out), // current EXE instruction
  .mem_bypass(inst_mem_out)  // current MEM instruction
  // ... other inputs/outputs
);

execute_stage execute_inst (
  .clk(clk),
  .rst(rst),
  .inst_exe_in(inst_exe),
  .inst_exe_out(inst_exe_out)
  // ... other inputs/outputs
);

pipelined_multiplier multiplier_inst (
  .clk(clk),
  .rst(rst),
  .inst_mul_in(inst_mul),
  .inst_mul_out(inst_mul_out)
);

memory_stage memory_inst (
  .clk(clk),
  .rst(rst),
  .inst_mem_in(inst_mem),
  .inst_mem_out(inst_mem_out),
  .stall_mem_in(stall_mem),
  .stall_mem_out(stall_mem_out)
  // ... other inputs/outputs
);

// maybe we don't need the wb stage, because it is basically just leaving the
// execute_stage or leaving the memory_stage

// Connect pipeline stages
//   // ...

endmodule
