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
logic [ARCH_LEN-1:0] pc_br_tk;     // PC+immediate in case of branch taken (from execute_stage)
logic br_tk_out; // Branch taken, needs to kill insts

inst_fetched_t                                inst_fetched_out; // fetch_stage
inst_fetched_t       inst_dec, inst_dec_next;                   // decode_stage
inst_decoded_t                                inst_dec_out;     // decode_stage
inst_decoded_t       inst_exe, inst_exe_next, inst_exe_out;     // execute_stage
inst_decoded_t       inst_mul, inst_mul_next, inst_mul_out;     // pipelined_multiplier
inst_decoded_t       inst_mem, inst_mem_next, inst_mem_out;     // memory_stage
inst_decoded_t       inst_wb,  inst_wb_next;                    // write_back_stage

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
assign stall_dec = (stall_exe | load_to_use_hazard); // backward stall from exe, decode load to use hazard,
                   //(inst_dec_out.is_m & inst_mul_next.valid & ~inst_mul.reg_data_ready)); // or if is mull and inst didn't end (easier to stall)
//assign stall_mul = (inst_mul.valid & ~inst_mul_out.reg_data_ready);
assign stall_fet = (stall_dec);   // backward stall from decode

always_comb begin
  // stall logic
  inst_dec_next = (stall_dec ? inst_dec : inst_fetched_out);
  inst_exe_next = (stall_exe ? inst_exe : inst_dec_out); // if load_to_use_hazard, inst_dec_out.valid = 0
                                                         // we don't "stall" the exe, we run an invalid instruction
                                                         // that doesn't change the machine state
                                                         // this is inserting a bubble
  //inst_mul_next = (stall_mul ? inst_mul : inst_dec_out);
  inst_mem_next = (stall_mem ? inst_mem : inst_exe_out);
  inst_wb_next  = inst_mem_out;
  // TODO mul?

  if (stall_mem)    inst_wb_next.valid = 0;

  // choosing the right path for mul instructions
  // if inst_dec_out.is_m, then we kill inst_exe_next and send inst_mul_next
  //if (inst_dec_out.valid & inst_dec_out.is_m) inst_exe_next.valid <= 0;
  //else inst_mul_next.valid <= 0;

  // branch taken logic
  if (br_tk_out) inst_mem_next.valid = 0;
  if (br_tk_out) inst_exe_next.valid = 0;
  //if (br_tk_out) inst_mul_next.valid = 0;
  if (br_tk_out) inst_dec_next.valid = 0;
end

always_ff @(posedge clk) begin
  inst_dec = inst_dec_next; // either I stall, or I get inst_fetched_out
  inst_exe = inst_exe_next; // stall or inst_dec_out
  //inst_mul = inst_mul_next; // stall or inst_dec_out
  inst_mem = inst_mem_next; // stall, or inst_exe_out, or inst_mul_out
  inst_wb  = inst_wb_next;

  if(rst) begin
      inst_dec.valid = 0;
      inst_exe.valid = 0;
      inst_mul.valid = 0;
      inst_mem.valid = 0;
      inst_wb.valid = 0;
  end
end

instruction_bus ibus();
data_bus        dbus();
data_bus        main_bus();

main_memory mem0 (
    .clk,
    .rst,

    .bus(main_bus)
);


memory_controller mctrl (
    .clk,
    .rst,

    .icache_bus(ibus),
    .dcache_bus(dbus),

    .main_bus
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
  .br_tk(br_tk_out),
  .pc_br_tk(pc_br_tk),
  .pc_out(pc_fet_out),
  .ibus(ibus)
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
  .br_tk_out(br_tk_out),
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
  .stall_mem_out(stall_mem_out),

  .dbus
);


endmodule
