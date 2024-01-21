import constants_pkg::*;
import structure_pkg::*;

// top_level_module.v
module processor_model (
  input wire clk,
  input wire rst
  // ... other input/output ports
);

// Branch
logic pc_fet_out;   // PC+4 out of fetch_stage to forward and calculate BEQ jump
logic pc_br_tk;     // PC+4+immediate in case of branch taken (from execute_stage)
logic kill_exe_out; // Branch taken, needs to kill insts

logic [INST_LEN-1:0]                          inst_fetched_out; // fetch_stage
logic [INST_LEN-1:0] inst_dec, inst_dec_next;                   // decode_stage
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
bypass_t exe_bypass, mem_bypass, ltu_bypass;

// Stalls
logic stall_fet,     stall_dec,     stall_exe,     stall_mul,     stall_mem;
// Backward stalls
logic stall_fet_out, stall_dec_out, stall_exe_out, stall_mul_out, stall_mem_out;

// simply propagate backwards the stall signals
assign stall_mem = stall_mem_out; // in case of dcache miss
assign stall_exe = stall_mem; // backward stall from mem
assign stall_dec = (stall_exe | stall_dec_out); // backward stall from exe or decode load to use hazard
assign stall_fet = (stall_dec | stall_fet_out); // backward stall from decode or icache miss

// stall logic
always_comb begin
  inst_dec_next = (stall_dec ? inst_dec : inst_fetched_out);
  inst_exe_next = (stall_exe ? inst_exe : inst_dec_out);
  inst_mem_next = (stall_mem ? inst_mem : inst_exe_out);
  inst_wb_next  = (~(inst_mem_out.valid & inst_mem_out.reg_data_ready) ? inst_wb :  inst_mem_out);
  // TODO mul?
end

always_ff @(posedge clk) begin
  inst_dec = inst_dec_next; // either I stall, or I get inst_fetched_out
  inst_exe = inst_exe_next; // stall or inst_dec_out
  inst_mul = inst_mul_next; // stall or inst_dec_out
  inst_mem = inst_mem_next; // stall, or inst_exe_out, or inst_mul_out
  inst_wb  = inst_wb_next;
end

hazard_module hazards (
  .clk(clk),
  .rst(rst),
  .inst_dec_out(inst_dec_out),
  .inst_exe_out(inst_exe_out), 
  .inst_mem_out(inst_mem_out),
  .exe_bypass(exe_bypass),
  .mem_bypass(mem_bypass),
  .ltu_bypass(ltu_bypass),
  .load_to_use_hazard(stall_dec_out)
);

fetch_stage fetch_inst (
  .clk(clk),
  .rst(rst),
  .inst_fetched_out(inst_fetched_out),
  .stall_fet_in(stall_fet),
  .pc_out(pc_fet_out)
  //.stall_fet_out(stall_fet_out)
);

decode_stage decode_inst (
  .clk(clk),
  .rst(rst),
  .pc_in(pc_fet_out),
  .inst_fetched_in(inst_dec),
  .inst_dec_out(inst_dec_out),
  .inst_wb_in(inst_wb),
  .stall_dec(stall_dec),
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
