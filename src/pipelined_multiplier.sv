import structure_pkg::*;
import constants_pkg::*;

// Artificial 5-stage multiplier
module pipelined_multiplier (
  input logic clk,
  input logic rst,
  input inst_decoded_t inst_mul_in,
  output inst_decoded_t inst_mul_out
);

reg [2*ARCH_LEN-1:0] stage1, stage2, stage3, stage4, stage5;

always @(posedge clk or negedge rst) begin
  if (!rst) begin
    // Reset all pipeline stages
    stage1 <= 2*{ARCH_LEN{1'b0}};
    stage2 <= 2*{ARCH_LEN{1'b0}};
    stage3 <= 2*{ARCH_LEN{1'b0}};
    stage4 <= 2*{ARCH_LEN{1'b0}};
    stage5 <= 2*{ARCH_LEN{1'b0}};
  end else begin
    stage1 = inst_mul_in.src_data_1 * inst_mul_in.src_data_2;
    stage2 = stage1;
    stage3 = stage2;
    stage4 = stage3;
    inst_mul_out = inst_mul_in;
    inst_mul_out.dst_reg_data = stage4;
    inst_mul_out.reg_data_ready = 1;
  end
end

endmodule
