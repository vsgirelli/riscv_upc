import constants_pkg::*;

module main_memory (
    input logic clk,
    input logic rst,

    instruction_bus.producer bus
);

typedef enum {IDLE, SERVING} tb_state_t;
tb_state_t state, nextState;
const logic [ICLLEN-1:0] line = 128'h00408093_00308093_00208093_00108093;


always_comb begin
   case(state)
       IDLE: begin 
           if(bus.ldp) nextState = SERVING;
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
