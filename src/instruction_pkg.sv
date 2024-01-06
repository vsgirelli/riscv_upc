package instruction_pkg;

  typedef struct {
    logic [INST_LEN-1:0] inst;
  } inst_fetched_t;

  typedef struct {
    // TODO remember about graduation list or whatever
    // to assign to the instruction an ID

    logic [ARCH_LEN-1:0] src_data_1; // this is data from reg 
    logic [ARCH_LEN-1:0] src_data_2; // this is either data from register or immediate
    logic [$clog2(REG_FILE_LEN)-1:0] dst_reg;  
    logic [ARCH_LEN-1:0] dst_reg_data;
    logic reg_write_enable;
    logic reg_data_ready; // for R instructions data is ready on stage EXE
                          // but for M instructions only on stage WB

    logic is_load;
    logic is_store;
    logic is_reg_reg;
    logic is_mul;
    // is immediate??

  } inst_decoded_t;

endpackage
