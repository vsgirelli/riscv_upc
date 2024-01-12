import constants_pkg::*;

module icache (

    input logic clk,
    input logic rst,

    input logic [ARCH_LEN-1:0] addr,
    input logic enable,

    output logic [INST_LEN-1:0] instr_data,
    output logic miss,

    instruction_bus.consumer bus
);

localparam integer indexBits = $clog2(ICLN);
localparam integer offsetBits = $clog2(ICLLEN/8); // Bits to address byte inside word, and word inside line
localparam integer tagBits = ARCH_LEN - indexBits - offsetBits;

logic [ICLLEN-1:0]  data  [0:ICLN-1];
logic [tagBits-1:0] tags  [0:ICLN-1];
logic               valid [0:ICLN-1];

logic [ICLLEN-1:0]  nextData  [0:ICLN-1];
logic [tagBits-1:0] nextTags  [0:ICLN-1];
logic               nextValid [0:ICLN-1];

logic [ICLLEN-1:0]  selectedData;
logic [tagBits-1:0] selectedTag;
logic               selectedValid;

// These two are needed to store the address while the state machine is
// waiting for the memory request
logic [ARCH_LEN-1:0] addr_buff;
logic [ARCH_LEN-1:0] next_addr_buff;

assign instr_data = selectedData;

logic [indexBits-1:0] i_index = addr[indexBits+offsetBits-1:offsetBits]; // index coming from address

logic is_hit;


// Data logic
genvar i;
generate
    for (i = 0; i < ICLN; i++)
    begin: cache_line_control

        always_comb begin
            nextData[i] <= data[i];
            nextTags[i] <= tags[i];
            nextValid[i] <= valid[i];

            if(rst) begin
                nextData[i] <= {ICLLEN{1'd0}};
                nextTags[i] <= {tagBits{1'd0}};
                nextValid[i] <= 0;
            end else if(bus.ldr) begin // If load is ready in bus to memory, we put it
                
            end
        end

        always_ff @(posedge clk) begin
            data[i] <= nextData[i];
            tags[i] <= nextTags[i];
            valid[i] <= nextValid[i];
        end
	end
endgenerate

always_comb begin
    selectedTag = tags[i_index];
    selectedData = data[i_index];
    selectedValid = valid[i_index];

    is_hit = selectedValid && selectedTag == addr[31:31-tagBits];
end

// Control logic

typedef enum {IDLE, MEM} cache_state_t;
cache_state_t state, nextState;

always_comb begin
    nextState = state;

    case(state)
        IDLE: begin
            miss = ~is_hit & enable;
            if(miss & enable) begin
                nextState = MEM;
                next_addr_buff = addr;
            end
            bus.ldp = ~is_hit & enable;
        end
        MEM: begin 
            miss = 1;
            if (bus.ldr) begin
                nextState = IDLE;
            end
        end
    endcase  
end

always_ff @(posedge clk) begin
    state <= nextState;
    addr_buff <= next_addr_buff;
end

always_comb begin
    case(state)
        IDLE: bus.addr = addr;
        MEM: bus.addr = addr_buff;
    endcase
end

endmodule
