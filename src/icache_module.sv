import constants_pkg::*;

module icache (

    input logic clk,
    input logic rst,

    input logic [PHY_LEN-1:0] addr,
    input logic enable,

    output logic [INST_LEN-1:0] instr_data,
    output logic miss,

    instruction_bus.consumer ibus
);

localparam integer indexBits = $clog2(ICLN);
localparam integer offsetBits = $clog2(ICLLEN/8); // Bits to address byte inside word, and word inside line
localparam integer tagBits = PHY_LEN - indexBits - offsetBits;

logic [ICLLEN-1:0]  data  [0:ICLN-1];
logic [tagBits-1:0] tags  [0:ICLN-1];
logic               valid [0:ICLN-1];

logic [ICLLEN-1:0]  nextData  [0:ICLN-1];
logic [tagBits-1:0] nextTags  [0:ICLN-1];
logic               nextValid [0:ICLN-1];

logic [ICLLEN-1:0]  selectedData;
logic [tagBits-1:0] selectedTag;
logic               selectedValid;

logic [PHY_LEN-1:0] current_addr;

// These two are needed to store the address while the state machine is
// waiting for the memory request
logic [PHY_LEN-1:0] addr_buff;
logic [PHY_LEN-1:0] next_addr_buff;


logic [indexBits-1:0] i_index;
assign i_index = current_addr[indexBits+offsetBits-1:offsetBits]; // index coming from address

logic is_hit;

logic [(ICLLEN/INST_LEN)-1:0][INST_LEN-1:0] selLine;

assign instr_data = selectedData;

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
            end else if(ibus.ldr) begin // If load is ready in bus to memory, we put it
                if(i == i_index) begin
                    nextValid[i] <= 1;
                    nextTags[i] <= current_addr[19:19-tagBits];
                    nextData[i] <= ibus.ldData;
                end
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
    selectedValid = valid[i_index];
    
    selLine = data[i_index];
    case(current_addr[3:2])
        2'b00: selectedData = selLine[0];
        2'b01: selectedData = selLine[1];
        2'b10: selectedData = selLine[2];
        2'b11: selectedData = selLine[3];
    endcase
        
end

always_comb
    is_hit = selectedValid & (selectedTag == current_addr[19:19-tagBits]);
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
            ibus.ldp = ~is_hit & enable;
        end
        MEM: begin 
            miss = 1;
            if (ibus.ldr) begin
                nextState = IDLE;
            end
            ibus.ldp = 1;
        end
    endcase  
end

always_ff @(posedge clk) begin
    state <= nextState;
    addr_buff <= next_addr_buff;
end

always_comb begin
    case(state)
        IDLE: current_addr = addr;
        MEM: current_addr = addr_buff;
    endcase
end

assign ibus.addr = {current_addr[PHY_LEN-1:4], 4'b0};

endmodule
