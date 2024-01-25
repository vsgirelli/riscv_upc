import constants_pkg::*;

module dcache (

    input logic clk,
    input logic rst,

    input logic [PHY_LEN-1:0] addr,
    input logic enable,

    input logic [ARCH_LEN-1:0] i_data,
    input logic [2:0] width,
    input logic we,

    output logic [ARCH_LEN-1:0] o_data,
    output logic miss,
    output logic evict,
    output logic unaligned,

    data_bus.consumer dbus
);

localparam integer indexBits = $clog2(DCLN);
localparam integer offsetBits = $clog2(DCLLEN/8); // Bits to address byte inside word, and word inside line
localparam integer tagBits = PHY_LEN - indexBits - offsetBits;

logic [DCLLEN-1:0]  data  [0:DCLN-1];
logic [tagBits-1:0] tags  [0:DCLN-1];
logic               valid [0:DCLN-1];
logic               dirty [0:DCLN-1];

logic [DCLLEN-1:0]  nextData  [0:DCLN-1];
logic [tagBits-1:0] nextTags  [0:DCLN-1];
logic               nextValid [0:DCLN-1];
logic               nextDirty [0:DCLN-1];

logic [DCLLEN-1:0]  selectedData;
logic [tagBits-1:0] selectedTag;
logic               selectedValid;
logic               selectedDirty;

logic [PHY_LEN-1:0] current_addr;

// These two are needed to store the address while the state machine is
// waiting for the memory request
logic [PHY_LEN-1:0] addr_buff;
logic [PHY_LEN-1:0] next_addr_buff;


logic [indexBits-1:0] i_index;
assign i_index = current_addr[indexBits+offsetBits-1:offsetBits]; // index coming from address

logic is_hit;

logic [(DCLLEN/8)-1:0][7:0] selLine;

assign instr_data = selectedData;

// Data logic
genvar i;
generate
    for (i = 0; i < DCLN; i++)
    begin: cache_line_control

        always_comb begin
            nextData[i] <= data[i];
            nextTags[i] <= tags[i];
            nextValid[i] <= valid[i];
            nextDirty[i] <= dirty[i];

            if(rst) begin
                nextData[i] <= {DCLLEN{1'd0}};
                nextTags[i] <= {tagBits{1'd0}};
                nextValid[i] <= 0;
                nextDirty[i] <= 0;
            end else if(dbus.ldr) begin // If load is ready in bus to memory, we put it
                if(i == i_index) begin
                    nextValid[i] <= 1;
                    nextTags[i] <= current_addr[19:19-tagBits];
                    nextData[i] <= dbus.ldData;
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
    selectedDirty = dirty[i_index];
    
    selLine = data[i_index];
    case(width)
        0: selectedData = {{24{selLine[current_addr[3:0]][7]}}, selLine[current_addr[3:0]]};
        1: selectedData = {{16{selLine[current_addr[3:0] + 1][7]}}, selLine[current_addr[3:0] + 1], selLine[current_addr[3:0]]};
        2: selectedData = {selLine[current_addr[3:0] + 3], selLine[current_addr[3:0] + 2], selLine[current_addr[3:0] + 1], selLine[current_addr[3:0]]};
        4: selectedData = {24'b0, selLine[current_addr[3:0]]};
        5: selectedData = {16'b0, selLine[current_addr[3:0] + 1], selLine[current_addr[3:0]]};
        default: selectedData = {selLine[current_addr[3:0] + 3], selLine[current_addr[3:0] + 2], selLine[current_addr[3:0] + 1], selLine[current_addr[3:0]]};
    endcase
        
end

always_comb
    is_hit = selectedValid & (selectedTag == current_addr[19:19-tagBits]);


// Control logic
typedef enum {IDLE, LDP, SRP} dcache_state_t;
dcache_state_t state, nextState;

always_comb begin
    nextState = state;

    case(state)
        IDLE: begin
            miss = ~is_hit & enable;
            evict = ~is_hit & enable & selectedDirty;
            if(miss & enable) begin

                nextState = selectedDirty ? SRP : LDP;
                next_addr_buff = ~evict ? addr : {selectedTag, i_index, 4'b0};
            end
            else begin
              next_addr_buff = addr_buff;
              nextState = IDLE;
            end
            dbus.srp = evict;
            dbus.ldp = ~is_hit & enable;
        end
        LDP: begin 
            miss = 1;
            evict = 0;
            if (dbus.ldr) begin
                nextState = IDLE;
            end
            else nextState = LDP;
            next_addr_buff = addr_buff;
            dbus.ldp = 1;
            dbus.srp = 0;
        end

        SRP: begin 
            evict = 1;
            miss = 1;
            if (dbus.srr) begin
                nextState = LDP;
                next_addr_buff = addr;
            end
            else nextState = SRP;

            next_addr_buff = addr_buff;
            dbus.srp = 1;
            dbus.ldp = 0;
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
        LDP: current_addr = addr_buff;
        SRP: current_addr = addr_buff;
    endcase
end

assign dbus.addr = {current_addr[PHY_LEN-1:4], 4'b0};

endmodule
