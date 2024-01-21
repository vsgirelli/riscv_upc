
package structure_pkg;
  import constants_pkg::*;

  typedef struct {
    // TODO remember about graduation list or whatever
    // to assign to the instruction an ID
    logic valid;
    logic [ARCH_LEN-1:0] pc;

    logic [$clog2(REG_FILE_LEN)-1:0] src_reg_1;
    logic [ARCH_LEN-1:0] src_data_1; // this is data from reg 1
    logic [$clog2(REG_FILE_LEN)-1:0] src_reg_2;
    logic [ARCH_LEN-1:0] src_data_2; // this is either data from reg 2 or immediate
    logic [$clog2(REG_FILE_LEN)-1:0] dst_reg;
    logic [ARCH_LEN-1:0] dst_reg_data;
    logic reg_write_enable;
    logic reg_data_ready; // for R instructions data is ready on stage EXE
                          // but for M instructions only on stage WB

    logic [2:0] func3;
    logic [6:0] func7;
    logic is_load;
    logic is_store;
    logic is_reg_reg;
    logic is_mul;

    logic [ARCH_LEN-1:0] immediate; // The immediate value

    logic is_i, is_r, is_u, is_s, is_b, is_j; //instruction type

  } inst_decoded_t;

  typedef struct {
    logic dep_src1;
    logic dep_src2;
  } bypass_t;

endpackage
