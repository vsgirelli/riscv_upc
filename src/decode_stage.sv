import constants_pkg::*;
import structure_pkg::*;

module decode_stage (
  input logic clk,
  input logic rst,

  input logic [ARCH_LEN-1:0] pc_in, // PC+4 out of fetch_stage to forward and calculate BEQ jump

  // instructions in and out of stage
  input  inst_fetched_t inst_fetched_in,
  input  inst_decoded_t inst_wb_in,
  output inst_decoded_t inst_dec_out,

  // stalls
  input logic load_to_use_hazard,

  // bypasses from EXE and MEM
  input inst_decoded_t inst_exe_out,
  input bypass_t exe_bypass,
  input inst_decoded_t inst_mem_out,
  input bypass_t mem_bypass
);

// check if inst_wb_in writes into register_file and sets write enable
logic reg_write_enable;
assign reg_write_enable = (inst_wb_in.valid & inst_wb_in.reg_write_enable & inst_wb_in.reg_data_ready);

logic [6:0] opcode;
logic [2:0] func3;
logic [6:0] func7;

// to read from register_file
logic [$clog2(REG_FILE_LEN)-1:0] src_reg_1;
logic [ARCH_LEN-1:0] src_data_1;
logic [$clog2(REG_FILE_LEN)-1:0] src_reg_2;
logic [ARCH_LEN-1:0] src_data_2;
logic [$clog2(REG_FILE_LEN)-1:0] dst_reg;

// immediate value
logic [ARCH_LEN-1:0] imm;
logic valid, is_r, is_i, is_l, is_u, is_s, is_b, is_j, is_m;

logic [INST_LEN-1:0] instruction;
assign instruction = inst_fetched_in.inst;
// Decoding instruction fields
always_comb begin
    opcode = instruction[6:0];
    valid  = (~load_to_use_hazard & inst_fetched_in.valid) ? 1 : 0;

    is_r = opcode == 7'b0110011;   // ADD,SUB,SLL,SLT,SLTU,XOR,SRL,SRA,OR,AND, MUL*, DIV*
    is_i = opcode == 7'b0010011 |  // ADDI, SLTI, SLTIU, XORI, ORI
           opcode == 7'b0000011 |  // LB, LH, LW, LBU, LHU
           opcode == 7'b1100111;   // JALR

    is_l = opcode == 7'b0000011;

    is_s = opcode == 7'b0100011;   // SB, SH, SW

    is_u = opcode == 7'b0110111 |  // LUI
           opcode == 7'b0010111;   // AUIPC

    is_b = opcode == 7'b1100011;   // BXXx

    is_m = is_r & func7[0]; //opcode == 7'h33 ? 1 : 0;

    is_j = 0;

    dst_reg   = (~(is_b | is_s) ? instruction[11:7] : '0);
    func3     = instruction[14:12];
    src_reg_1 = instruction[19:15];
    src_reg_2 = (~(is_i) ? instruction[24:20] : '0);
    func7     = instruction[31:25];
end

// Immediate calculation logic
always_comb begin
    if(is_i) imm = {{ARCH_LEN-12{instruction[31]}}, instruction[31:20]};
    else if(is_s) imm = {{ARCH_LEN-12{instruction[31]}}, instruction[31:25], instruction[11:8], instruction[7]};
    else if(is_b) imm = {{ARCH_LEN-12{instruction[31]}}, instruction[7], instruction[31:25], instruction[11:8], 1'b0};
    else if(is_u) imm = {instruction[31], instruction[30:20], instruction[19:12], 12'b0};
    else if(is_j) imm = {{ARCH_LEN-20{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:25], instruction[24:21], 1'b0};
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

assign inst_dec_out.valid      = valid;
assign inst_dec_out.pc         = pc_in;

assign inst_dec_out.src_reg_1  = src_reg_1;
assign inst_dec_out.src_reg_2  = src_reg_2;
assign inst_dec_out.dst_reg    = dst_reg;
assign inst_dec_out.dst_reg_data     = {ARCH_LEN{1'b0}};
assign inst_dec_out.reg_write_enable = is_r | is_i | is_u;
assign inst_dec_out.reg_data_ready   = 0;

assign inst_dec_out.func3      = func3;
assign inst_dec_out.func7      = func7;
assign inst_dec_out.immediate  = imm;

assign inst_dec_out.is_i       = is_i;
assign inst_dec_out.is_l       = is_l;
assign inst_dec_out.is_r       = is_r;
assign inst_dec_out.is_s       = is_s;
assign inst_dec_out.is_u       = is_u;
assign inst_dec_out.is_b       = is_b;
assign inst_dec_out.is_j       = is_j;
assign inst_dec_out.is_m       = is_m;

// checking the need to perform bypasses
// if no bypasses, then uses data from reg_file 
always_comb begin
  if (mem_bypass.dep_src1 & inst_mem_out.reg_data_ready) begin
    inst_dec_out.src_data_1 = inst_mem_out.dst_reg_data;
  end else if (exe_bypass.dep_src1 & inst_exe_out.reg_data_ready) begin
    inst_dec_out.src_data_1 = inst_exe_out.dst_reg_data;
  end else begin
    inst_dec_out.src_data_1 = src_data_1;
  end
end

always_comb begin
  if (mem_bypass.dep_src2 & inst_mem_out.reg_data_ready) begin
    inst_dec_out.src_data_2 = inst_mem_out.dst_reg_data;
  end else if (exe_bypass.dep_src1 & inst_exe_out.reg_data_ready) begin
    inst_dec_out.src_data_2 = inst_exe_out.dst_reg_data;
  end else begin
    inst_dec_out.src_data_2 = (~(is_i) ? src_data_2 : {ARCH_LEN{1'b0}});
  end
end

endmodule
