import config_pkg::*;
import instruction_pkg::*;

// top_level_module.v
module processor_model (
  input wire clk,
  input wire rst
  // ... other input/output ports
);

inst_fetched_t                          inst_fetched_out;
inst_fetched_t inst_dec, inst_dec_next;
inst_decoded_t                          inst_dec_out;
inst_decoded_t inst_exe, inst_exe_next, inst_exe_out;
inst_decoded_t inst_mem, inst_mem_next, inst_mem_out;
inst_decoded_t inst_wb,  inst_wb_next;

fetch_stage fetch_inst (
  .clk(clk),
  .rst(rst),
  .inst_fetched_out(inst_fetched_out)
  // ... other inputs/outputs
);


decode_stage decode_inst (
  .clk(clk),
  .rst(rst),
  .inst_fetched_in(inst_fetched_out),
  .inst_dec_out(inst_dec_out)
  // ... other inputs/outputs
);

execute_stage execute_inst (
  .clk(clk),
  .rst(rst),
  .inst_exe_in(inst_dec_out),
  .inst_exe_out(inst_exe_out)
  // ... other inputs/outputs
);

memory_stage memory_inst (
  .clk(clk),
  .rst(rst),
  .inst_mem_in(inst_exe_out),
  .inst_mem_out(inst_mem_out)
  // ... other inputs/outputs
);

write_back_stage write_back_inst (
  .clk(clk),
  .rst(rst),
  .inst_wb_in(inst_mem_out) // what is it? it could be both the ALU's output and the memory load
);

// Connect pipeline stages
//   // ...

endmodule
