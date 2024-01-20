import constants_pkg::*;
import structure_pkg::*;

module register_file (
  input logic clk,
  input logic rst,

  // src register 1 and data output
  input logic [$clog2(REG_FILE_LEN)-1:0] src_reg_1,
  output logic [ARCH_LEN-1:0] src_data_1,
  // src register 2 and data output
  input logic [$clog2(REG_FILE_LEN)-1:0] src_reg_2,
  output logic [ARCH_LEN-1:0] src_data_2,

  // write enable signal, dst register and data
  input logic [$clog2(REG_FILE_LEN)-1:0] dst_reg,
  input logic [ARCH_LEN-1:0] dst_reg_data,
  input logic reg_write_enable
);

logic [ARCH_LEN-1:0] registers [REG_FILE_LEN-1:0];
// a second register_file (backup) is needed to be able to check reg_write_enable
logic [ARCH_LEN-1:0] bckp_regs [REG_FILE_LEN-1:0];

// read data from register_file
assign src_data_1 = registers[src_reg_1];
assign src_data_2 = registers[src_reg_2];

always_comb
  bckp_regs[0] = 0;
always_ff @(posedge ~clk)
  registers[0] = bckp_regs[0];

genvar i;
generate 
  // skip register 0
  for (i = 1; i < REG_FILE_LEN-1; i++) begin: register_file_copy
    // need to have the always_comb and a backup register_file to be able 
    // to verify the reg_write_enable signal before writing into the final register_file
    always_comb begin
      if (rst)
         bckp_regs[i] = {ARCH_LEN{1'b0}}; 
      else if (reg_write_enable && dst_reg == i) bckp_regs[i] = dst_reg_data;
      // this needs to be in the for loop because otherwise it conflicts with
      // the register 0
    end

    // update the final register_file if there were any changes
    always_ff @(posedge ~clk) begin
      registers[i] = bckp_regs[i];
    end
  end
endgenerate

endmodule
