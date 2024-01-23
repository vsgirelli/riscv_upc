import constants_pkg::*;
import structure_pkg::*;

// top_level_module.v
module processor_model (
  input wire clk,
  input wire rst
  // ... other input/output ports
);

// Branch
logic [ARCH_LEN-1:0] pc_fet_out;   // PC+4 out of fetch_stage to forward and calculate BEQ jump
logic [ARCH_LEN-1:0] pc_br_tk;     // PC+4+immediate in case of branch taken (from execute_stage)
logic kill_exe_out; // Branch taken, needs to kill insts

inst_fetched_t                                inst_fetched_out; // fetch_stage
inst_fetched_t       inst_dec, inst_dec_next;                   // decode_stage
inst_decoded_t                                inst_dec_out;     // decode_stage
inst_decoded_t       inst_exe, inst_exe_next, inst_exe_out;     // execute_stage
inst_decoded_t       inst_mul, inst_mul_next, inst_mul_out;     // pipelined_multiplier
inst_decoded_t       inst_mem, inst_mem_next, inst_mem_out;     // memory_stage
inst_decoded_t       inst_wb,  inst_wb_next;                    // write_back_stage
// For all this control signals that travel throught the pipeline,
// it would be great to create specific structs for each one, so we don't
// carry useless signals. Like doinv a specific "decoupling_control_dec_exe"
// for example.

// bypass signals
bypass_t exe_bypass, mem_bypass;
logic load_to_use_hazard;

// Stalls
logic stall_fet,     stall_dec,     stall_exe,     stall_mul,     stall_mem;
// Backward stalls
logic stall_fet_out, stall_dec_out, stall_exe_out, stall_mul_out, stall_mem_out;

// simply propagate backwards the stall signals
assign stall_mem = stall_mem_out; // in case of dcache miss
assign stall_exe = stall_mem;     // backward stall from mem
assign stall_dec = (stall_exe | load_to_use_hazard); // backward stall from exe or decode load to use hazard
assign stall_fet = (stall_dec);      // backward stall from decode or (TODO) icache miss

always_comb begin
  // stall logic
  // TODO what about stall_fet_out
  inst_dec_next = (stall_dec ? inst_dec : inst_fetched_out);
  inst_exe_next = (stall_exe ? inst_exe : inst_dec_out); // if load_to_use_hazard, inst_dec_out.valid = 0
                                                         // we don't "stall" the exe, we run an invalid instruction
                                                         // that doesn't change the machine state
                                                         // this is inserting a bubble
  inst_mem_next = (stall_mem ? inst_mem : inst_exe_out);
  inst_wb_next  = (stall_mem ? inst_wb  : inst_mem_out);
  // TODO mul?

  // branch logic // there are more things to kill here, check waves, but
  // branch more or less working
  if (kill_exe_out) inst_mem_next.valid <= 0;
  if (kill_exe_out) inst_exe_next.valid <= 0;
  if (kill_exe_out) inst_dec_next.valid <= 0;
end

always_ff @(posedge clk) begin
  inst_dec = inst_dec_next; // either I stall, or I get inst_fetched_out
  inst_exe = inst_exe_next; // stall or inst_dec_out
  inst_mul = inst_mul_next; // stall or inst_dec_out
  inst_mem = inst_mem_next; // stall, or inst_exe_out, or inst_mul_out
  inst_wb  = inst_wb_next;
end

instruction_bus ibus();

main_memory mem0 (
    .clk,
    .rst,

    .bus(ibus)
);

// TODO comment the inputs and outputs of the stages 
hazard_module hazards (
  .clk(clk),
  .rst(rst),
  .inst_dec_out(inst_dec_out),
  .inst_exe_out(inst_exe_out),
  .inst_mem_out(inst_mem_out),
  .exe_bypass(exe_bypass),
  .mem_bypass(mem_bypass),
  .load_to_use_hazard(load_to_use_hazard)
);

fetch_stage fetch_inst (
  .clk(clk),
  .rst(rst),
  .inst_fetched_out(inst_fetched_out),
  .stall_fet_in(stall_fet),
  .br_tk(kill_exe_out),
  .pc_br_tk(pc_br_tk),
  .pc_out(pc_fet_out),
  .ibus(ibus)
  //.stall_fet_out(stall_fet_out)
);

decode_stage decode_inst (
  .clk(clk),
  .rst(rst),
  .pc_in(pc_fet_out),
  .inst_fetched_in(inst_dec),
  .inst_dec_out(inst_dec_out),
  .inst_wb_in(inst_wb),
  .load_to_use_hazard(load_to_use_hazard),
  .inst_exe_out(inst_exe_out), // current EXE instruction
  .exe_bypass(exe_bypass),     // EXE Bypass signals
  .inst_mem_out(inst_mem_out), // current MEM instruction
  .mem_bypass(mem_bypass)      // MEM Bypass signals
);

execute_stage execute_inst (
  .clk(clk),
  .rst(rst),
  .inst_exe_in(inst_exe),
  .inst_exe_out(inst_exe_out),
  .kill_exe_out(kill_exe_out),
  .pc_br_tk_out(pc_br_tk)
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
);


endmodule
