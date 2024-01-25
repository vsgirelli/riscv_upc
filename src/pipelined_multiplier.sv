import structure_pkg::*;
import constants_pkg::*;

// Artificial 5-stage multiplier
module pipelined_multiplier (
  input logic clk,
  input logic rst,
  input inst_decoded_t inst_mul_in,
  output inst_decoded_t inst_mul_out,
  input logic stall_mul_in,
  output logic stall_mul_out
);

inst_decoded_t instMS_ff[3:0];
inst_decoded_t nxInstMS_ff[3:0];
                
logic [2*ARCH_LEN-1:0] mult_result;

genvar i;
generate

for(i = 1; i < 4; i++) begin : ms_ff_cotrol
  always_comb
  begin
    if (stall_mul_in) nxInstMS_ff[i] <= instMS_ff[i];
    else         nxInstMS_ff[i] <= instMS_ff[i-1]; 

    // TODO: convert killMS and analogous to kill (from the graduation
    //       list)
    if (rst) nxInstMS_ff[i].valid <= 0;
  end

  always_ff @(posedge clk)
    instMS_ff[i] = nxInstMS_ff[i];
end
endgenerate

always_comb begin
    nxtInstMS_ff[0] = inst_mul_in;
    nxtInstMS_ff[0].valid = inst_mul_in.is_m & inst_mul_in.valid;
    
    mult_result = instMS_ff[3].src_data_1 * instMS_ff[3].src_data_2;
    inst_mul_out = instMS_ff[3];
    inst_mul_out.dst_reg_data = mult_result[ARCH_LEN-1:0];
    inst_mul_out.reg_data_ready = inst_MS_ff[3];

    stall_mul_out = instMS_ff[0].valid | instMS_ff[1].valid | instMS_ff[2].valid | instMS_ff[3].valid;

endmodule
