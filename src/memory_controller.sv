import constants_pkg::*;

module memory_controller (
    input logic clk,
    input logic rst,

    instruction_bus.producer icache_bus,
    data_bus.producer        dcache_bus,

    data_bus.consumer        main_bus
);


logic main_srp, main_ldp;
logic [PHY_LEN-1:0] main_addr;

typedef enum { IDLE, BUSY } bus_state_t;
typedef enum { DATA, INST } source_state_t;

bus_state_t bstate, next_bstate;
source_state_t sstate, next_sstate;

assign main_bus.addr = main_addr;
assign main_bus.ldp  = bstate == BUSY ? main_ldp : 0;
assign main_bus.srp  = bstate == BUSY ? main_srp : 0;
assign main_bus.srData = dcache_bus.srData;


assign dcache_bus.ldr = sstate == DATA ? main_bus.ldr : 0;
assign dcache_bus.srr = sstate == DATA ? main_bus.srr : 0;
assign icache_bus.ldr = sstate == INST ? main_bus.ldr : 0;
assign dcache_bus.ldData = main_bus.ldData;
assign icache_bus.ldData = main_bus.ldData;

always_comb begin
    case(sstate)
        DATA: main_addr = dcache_bus.addr;
        INST: main_addr = icache_bus.addr;
        default: main_addr = 20'b0;
    endcase

    case(sstate)
        DATA: main_ldp = dcache_bus.ldp;
        INST: main_ldp = icache_bus.ldp;
        default: main_ldp = 0;
    endcase

    case(sstate)
        DATA: main_srp = dcache_bus.srp;
        INST: main_srp = 0;
        default main_srp = 0;
    endcase
end

always_ff @(posedge clk) begin
    bstate = next_bstate;
    sstate = next_sstate;
end

always_comb begin
    next_bstate = bstate;
    next_sstate = sstate;

    case(bstate)
        IDLE: begin
            if(dcache_bus.ldp | dcache_bus.srp) begin
                next_sstate = DATA;
                next_bstate = BUSY;
            end else if(icache_bus.ldp) begin
                next_sstate = INST;
                next_bstate = BUSY;
            end
        end

        BUSY: begin
            case(sstate)
                DATA: if(dcache_bus.ldr | dcache_bus.srr) next_bstate = IDLE;
                INST: if(icache_bus.ldr) next_bstate = IDLE;
                default: begin
                    next_bstate = IDLE;
                    next_sstate = DATA;
                end
            endcase
        end
        default: next_bstate = IDLE;
    endcase
end

endmodule

