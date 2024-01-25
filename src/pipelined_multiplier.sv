import structure_pkg::*;
import constants_pkg::*;

// Artificial 5-stage multiplier
module pipelined_multiplier (
  input logic clk,
  input logic rst,
  input inst_decoded_t inst_mul_in,
  output inst_decoded_t inst_mul_out,
  input logic kill_mul,
  input logic stall_mul_in,
  output logic stall_mul_out
);
assign stall_mul_out = 0;
inst_decoded_t instMS_ff[3:0];
inst_decoded_t nxInstMS_ff[3:0];
                
genvar i;
generate

for(i = 1; i < 4; i++) begin : ms_ff_cotrol
  always_comb
  begin
    if (stall_mul_in) nxInstMS_ff[i] <= instMS_ff[i];
    else         nxInstMS_ff[i] <= instMS_ff[i-1]; 

    // TODO: convert killMS and analogous to kill (from the graduation
    //       list)
    if (rst | kill_mul) nxInstMS_ff[i].valid <= 0;
  end

  always_ff @(posedge clk)
    instMS_ff[i] = nxInstMS_ff[i];
end
endgenerate

always_comb begin
    nxInstMS_ff[0] = inst_mul_in;
    nxInstMS_ff[0].valid = inst_mul_in.is_m;
end 
    

endmodule
