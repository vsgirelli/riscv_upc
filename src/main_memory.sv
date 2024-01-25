import constants_pkg::*;

module main_memory (
    input logic clk,
    input logic rst,

    data_bus.producer bus
);

typedef enum {IDLE, SERVING} tb_state_t;
tb_state_t state, nextState;      //     sw      add      mul      addi
const logic [ICLLEN-1:0] line   = 128'h001080A3_003100B3_021081B3_00108093;
//const logic [ICLLEN-1:0] line   = 128'h001080A3_003100B3_00108183_00108263;
                                // beq x1,x2,-16 lw x2  sw   add x1,x2,1024
//const logic [ICLLEN-1:0] line = 128'h00408093_001080A3_001100B3_00108093;
//       imm        rs1   f3   rt    op  addi
//32'b000000000001_00001_000_00001_0010011
//    f7      rs2    rs1   f3  rt    mul 
//32'b0000001_00001_00001_000_00011_0110011
//    f3      rs2    rs1   f3  rt     op  add
//32'b0000000_00011_00010_000_00001_0110011
//    im      rs2    rs1   f3  im     op   sw
//32'b0000000_00001_00001_000_00001_0100011

//       imm        rs1   f3   rt    op  lw 
//32'b000000000001_00001_000_00011_0000011


// State machine control
//
always_comb begin
   case(state)
       IDLE: begin 
           if(bus.ldp) nextState = SERVING;
           else nextState = IDLE;
           bus.ldData = 128'h0;
           bus.ldr = 0;
       end
       SERVING: begin
           bus.ldr = 1;
           bus.ldData = line;
           nextState = IDLE;
       end
   endcase
end

always_ff @(posedge clk) begin
    state = nextState;
end

endmodule
