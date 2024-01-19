import constants_pkg::*;
import instruction_pkg::*;

module decode_stage (
  input logic clk,
  input logic rst,

  // instructions in and out of stage
  input logic [INST_LEN-1:0] inst_fetched_in,
  output inst_decoded_t inst_dec_out,
  input inst_decoded_t inst_wb_in,

  // stalls
  output logic stall_dec_out,

  // bypasses from EXE and MEM
  input inst_decoded_t exe_bypass,
  input inst_decoded_t mem_bypass
);

// check if inst_wb_in writes into register_file and sets write enable
logic reg_write_enable;
assign reg_write_enable = (inst_wb_in.valid & inst_wb_in.reg_write_enable & inst_wb_in.reg_data_ready);

logic [6:0] opcode;
logic [2:0] func3;
logic [6:0] func7;

logic hazard;
assign stall_dec_out = hazard;

// to read from register_file
logic [$clog2(REG_FILE_LEN)-1:0] src_reg_1; 
logic [ARCH_LEN-1:0] src_data_1;
logic [$clog2(REG_FILE_LEN)-1:0] src_reg_2; 
logic [ARCH_LEN-1:0] src_data_2;
logic [$clog2(REG_FILE_LEN)-1:0] dst_reg; 

// immediate value
logic [ARCH_LEN-1:0] imm;
logic is_r, is_i, is_u, is_s, is_b, is_j;

// Decoding instruction fields // TODO just based on their code to implement the bypass logic
always_comb begin
    opcode    = inst_fetched_in[6:0];
    dst_reg   = inst_fetched_in[11:7];
    func3     = inst_fetched_in[14:12];
    func7     = inst_fetched_in[31:25];
    src_reg_1 = inst_fetched_in[19:15];
    src_reg_2 = inst_fetched_in[24:20];

    is_r = opcode == 7'b0110011;   // ADD,SUB,SLL,SLT,SLTU,XOR,SRL,SRA,OR,AND, MUL*, DIV*
    is_i = opcode == 7'b0010011 |  // ADDI, SLTI, SLTIU, XORI, ORI
           opcode == 7'b0000011 |  // LB, LH, LW, LBU, LHU
           opcode == 7'b1100111;   // JALR

    is_s = opcode == 7'b0100011;   // SB, SH, SW

    is_u = opcode == 7'b0110111 |  // LUI
           opcode == 7'b0010111;   // AUIPC

    is_b = opcode == 7'b1100011;   // BXXx

    is_j = 0;

end
  
// Immediate calculation logic
always_comb begin
    if(is_i) imm = {{ARCH_LEN-12{inst_fetched_in[31]}}, inst_fetched_in[31:20]};
    else if(is_s) imm = {{ARCH_LEN-12{inst_fetched_in[31]}}, inst_fetched_in[31:25], inst_fetched_in[11:8], inst_fetched_in[7]};
    else if(is_b) imm = {{ARCH_LEN-12{inst_fetched_in[31]}}, inst_fetched_in[7], inst_fetched_in[31:25], inst_fetched_in[11:8], 1'b0};
    else if(is_u) imm = {inst_fetched_in[31], inst_fetched_in[30:20], inst_fetched_in[19:12], 12'b0};
    else if(is_j) imm = {{ARCH_LEN-20{inst_fetched_in[31]}}, inst_fetched_in[19:12], inst_fetched_in[20], inst_fetched_in[30:25], inst_fetched_in[24:21], 1'b0};
    else imm = '0;
end

register_file reg_file (
  .clk(clk),
  .rst(rst),

  // requested data 1
  .src_reg_1(src_reg_1), // src reg 1 decoded from inst
  .src_data_1(src_data_1),
  // requested data 2
  .src_reg_2(src_reg_2), // src reg 2 decoded from inst
  .src_data_2(src_data_2),

  // write data from inst_wb_in if reg_write_enable
  .dst_reg(inst_wb_in.dst_reg), // dst register
  .dst_reg_data(inst_wb_in.dst_reg_data), // data to be written
  .reg_write_enable(reg_write_enable)
);

always_comb begin
    inst_dec_out.valid      = ~hazard ? 1 : 0; // TODO
    inst_dec_out.is_load    = opcode == 7'h03 ? 1 : 0;
    inst_dec_out.is_store   = opcode == 7'h23 ? 1 : 0;
    inst_dec_out.is_reg_reg = opcode == 7'h33 ? 1 : 0;
    inst_dec_out.is_mul     = is_r & func7[0]; //opcode == 7'h33 ? 1 : 0;
//assign inst_dec_out.isBr  = opcode == 7'h63 ? inst_dec_out.valid : 0;
//assign inst_dec_out.isRrw = opcode == 7'h3b ? inst_dec_out.valid : 0;
//assign inst_dec_out.isIm  = opcode == 7'h13 | opcode == 7'h37 ? inst_dec_out.valid : 0;
//assign inst_dec_out.isSys = opcode == 7'h73 ? inst_dec_out.valid : 0;
end

assign inst_dec_out.dst_reg    = dst_reg;
assign inst_dec_out.func3      = func3;
assign inst_dec_out.dst_reg_data     = {ARCH_LEN{1'b0}};
assign inst_dec_out.reg_write_enable = is_r | is_i | is_u; // TODO do we add a dependency check here? not in the way I'm thinking about this field. MC: I would leave it simple here, like only checking if it writes to regfile
assign inst_dec_out.reg_data_ready   = 0;
assign inst_dec_out.immediate = imm;
assign inst_dec_out.func7     = func7;

assign inst_dec_out.is_r      = is_r;
assign inst_dec_out.is_i      = is_i;
assign inst_dec_out.is_s      = is_s;
assign inst_dec_out.is_u      = is_u;
assign inst_dec_out.is_b      = is_b;
assign inst_dec_out.is_j      = is_j;

// TODO there is also dependency if the exe_bypass is a load and the current
  // instruction is using the loaded value (load.to.use), which will have
  // to sall for one cycle because bypassing doesn't work (the processor
  // updated)
  // TODO what if there's a load s1 . . followed by a store s1 . .?
    // (slide 34 of extended processor)

// Verifying hazard between inst_dec.src_data_1/src_data_2 and inst_exe.dst_reg
// The flag reg_write_enable guarantees that is a is_reg_reg inst executing on the execute_stage
assign dep_src1_exe = exe_bypass.valid & exe_bypass.reg_write_enable & (src_reg_1 == exe_bypass.dst_reg); 
assign dep_src2_exe = exe_bypass.valid & exe_bypass.reg_write_enable & (src_reg_2 == exe_bypass.dst_reg);
assign dep_dst_exe  = exe_bypass.valid & exe_bypass.reg_write_enable & (dst_reg   == exe_bypass.dst_reg); 
assign exe_hazard = dep_src1_exe | dep_src2_exe | dep_dst_exe;

// Verifying hazard between inst_dec.src_data_1/src_data_2 and inst_mem.dst_reg
// The flag reg_write_enable guarantees that is a load executing on the memory_stage
assign dep_src1_mem = mem_bypass.valid & mem_bypass.reg_write_enable & (src_reg_1 == mem_bypass.dst_reg); 
assign dep_src2_mem = mem_bypass.valid & mem_bypass.reg_write_enable & (src_reg_2 == mem_bypass.dst_reg);
assign dep_dst_mem  = mem_bypass.valid & mem_bypass.reg_write_enable & (dst_reg   == mem_bypass.dst_reg); 
assign mem_hazard = dep_src1_mem | dep_src2_mem | dep_dst_mem;

// Bypass logic to verify between mem and exe hazards
// If there's a hazard then perform the data updates on inst_dec_out
logic m_hazard, e_hazard;
always_comb begin
  m_hazard = mem_hazard;
  e_hazard = exe_hazard;
  
  if (exe_hazard | mem_hazard) begin
    if (mem_hazard & mem_bypass.reg_data_ready) begin
      if (dep_src1_mem) inst_dec_out.src_data_1 = mem_bypass.dst_reg_data;
      if (dep_src2_mem) inst_dec_out.src_data_2 = mem_bypass.dst_reg_data;
      m_hazard = 0;
    end

    // If we have mem_hazard and also exe_hazard, we can override the mem_bypass
    // Since the exe_bypass would override the register in question anyway
    if (exe_hazard & exe_bypass.reg_data_ready) begin
      if (dep_src1_exe) inst_dec_out.src_data_1 = exe_bypass.dst_reg_data;
      if (dep_src2_exe) inst_dec_out.src_data_2 = exe_bypass.dst_reg_data;
      e_hazard = 0;
      
      if (mem_hazard) begin
        // If there was a memory hazard that wasn't solved (~reg_data_ready)
        // we need to kill the mem instruction because it's data is wrong
        // TODO for now just eliminating hazard
        m_hazard = 0;
      end
       
    end
  
  end else begin
    // If there's no hazards, just use register file data
    inst_dec_out.src_data_1 = src_data_1;
    inst_dec_out.src_data_2 = src_data_2;
    m_hazard = 0;
    e_hazard = 0;

  end
end

// If there was one of the hazards and it wasn't solved above
// (basically because the data wasn't readdy - ~reg_data_ready)
// the hazard flag is set and we need to stall and inst_dec_out.valid is set
// to zero (TODO solve it)
// assign hazard = m_hazard | e_hazard;
assign hazard = 0;

endmodule
