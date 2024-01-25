import constants_pkg::*;
import structure_pkg::*;

module memory_stage (
  input logic clk,
  input logic rst,
  input inst_decoded_t inst_mem_in,
  output inst_decoded_t inst_mem_out,
  output logic stall_mem_out,

  data_bus.consumer dbus
);

logic enable_in, out_miss, out_evict, out_unaligned;
assign enable_in = inst_mem_in.valid & (inst_mem_in.is_l | inst_mem_in.is_s);
logic [ARCH_LEN-1:0] data_loaded;


dcache dcache_l1 (
    .clk,
    .rst,

    .addr(inst_mem_in.dst_reg_data),
    .enable(enable_in),
    
    .i_data(inst_mem_in.src_data_2),
    .width(inst_mem_in.func3),
    .we(inst_mem_in.is_s),

    .o_data(data_loaded),
    .miss(out_miss),
    .evict(out_evict),
    .unaligned(out_unaligned),

    .dbus
);

always_comb begin
    inst_mem_out = inst_mem_in;
    inst_mem_out.valid = inst_mem_in.valid;
    inst_mem_out.dst_reg = inst_mem_in.is_l ? data_loaded : inst_mem_in.dst_reg;
    inst_mem_out.reg_data_ready = inst_mem_in.is_l ? ~out_miss & inst_mem_in.is_l : inst_mem_in.reg_data_ready;
    stall_mem_out = out_miss & inst_mem_in.valid;
end

endmodule
