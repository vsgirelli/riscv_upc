import constants_pkg::*;
import structure_pkg::*;

module fetch_stage (
  input wire clk,
  input wire rst,
  output inst_fetched_t inst_fetched_out,

  input logic stall_fet_in,
  input logic br_tk,
  input logic [ARCH_LEN-1:0] pc_br_tk, 

  output logic [ARCH_LEN-1:0] pc_out,
  instruction_bus.consumer ibus
);

reg [ARCH_LEN-1:0] program_counter;

logic [ARCH_LEN-1:0] nxtPC;

logic [7:0] temp_mem [1024:0];
//initial
const logic [INST_LEN-1:0] addi_1 = 32'b000000000001_00001_000_00001_0010011;  
const logic [INST_LEN-1:0] noop = 32'b000000000000_00000_000_00000_0010011;  

//$readmemh("instruction_memory.hex", temp_mem);

logic out_miss, in_enable;
inst_fetched_t icache_instruction;
assign icache_instruction.valid = 1;
assign in_enable = 1;

icache icache0 (
  .clk,
  .rst,

  .addr(program_counter[PHY_LEN-1:0]),
  .enable(in_enable),

  .instr_data(icache_instruction.inst),
  .miss(out_miss),

  .ibus
);

always_comb begin

    // Default case, PC + 4
    pc_out = program_counter;
    nxtPC = program_counter + 4;
    inst_fetched_out = icache_instruction; //addi_1; //temp_mem[program_counter];

    // if stall, don't change pc and invalidates inst_fetched_out (basically a nop)
    if(stall_fet_in | out_miss) begin
        nxtPC = program_counter;
        inst_fetched_out.valid = 0;
    end

    // if branch taken updates pc
    if(br_tk) begin
        nxtPC = pc_br_tk;
        inst_fetched_out.valid = 1;
    end

    if(rst) begin
        nxtPC = 32'h0000; // BOOT_ADDR;
        inst_fetched_out.inst = {INST_LEN{1'b0}};
        inst_fetched_out.valid = 0;
     end

end

always_ff @(posedge clk) begin
  program_counter = nxtPC;
end

endmodule
