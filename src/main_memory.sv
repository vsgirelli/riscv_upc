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

localparam integer NLINES = ((2**PHY_LEN)/(MBLEN/8));

logic [MBLEN-1:0] ROM   [0:NLINES-1];
logic [MBLEN-1:0] MEM   [0:NLINES-1];
logic [MBLEN-1:0] MEMFF [0:NLINES-1];

// memory initialization

integer i;
initial
begin
$readmemh("../memory.mem",ROM);
end

logic ldr, nextLdr, srr, nextSrr;

logic [15:0] eff_addr;
assign eff_addr = bus.addr[19:4]; 

assign bus.ldData = MEM[eff_addr];

always_ff @(posedge clk)
MEM = MEMFF;

genvar j;
generate
for (j=0;j!=NLINES;j++) begin : memory_block_control
  always_comb
  begin 
    MEMFF[j] <= MEM[j];
    if ( eff_addr == j & bus.srp & srr) MEMFF[j] <= bus.srData;
    if ( rst )                     MEMFF[j] <= ROM[j];
  end
end
endgenerate


// State machine control
//
typedef enum {IDLE, GET1, GET2, GET3, GET4, SERVE1, SERVE2, SERVE3, SERVE4} tb_state_t;
tb_state_t state, nextState;

assign bus.ldr = ldr;
assign bus.srr = srr;

always_comb begin

    nextState = state;
    nextLdr = 0;
    nextSrr = 0;

   case(state)
       IDLE: begin 
           if(bus.ldp | bus.srp) begin
               nextState = GET1;
           end
       end
       GET1: nextState = GET2;
       GET2: nextState = GET3;
       GET3: nextState = GET4;
       GET4: nextState = SERVE1;
       SERVE1: nextState = SERVE2;
       SERVE2: nextState = SERVE3;
       SERVE3: begin 
           nextState = SERVE4;
           nextLdr   = bus.ldp;
           nextSrr   = bus.srp;
       end
       SERVE4: begin
           nextState = IDLE;
           nextLdr   = 0;
           nextSrr   = 0;
       end

       default:
            if ( ~ (bus.ldp | bus.srp ) ) begin
              nextState = IDLE;
            end
   endcase

   if(rst) begin
       nextState = IDLE;
       nextLdr   = 0;
       nextSrr   = 0;
   end
end

always_ff @(posedge clk) begin
    state = nextState;
    ldr   = nextLdr;
    srr   = nextSrr;
end

endmodule
