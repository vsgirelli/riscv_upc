import constants_pkg::*;

interface instruction_bus();
    logic [ARCH_LEN-1:0] addr;

    logic                ldp; // Load petition
    logic                ldr; // Load ready

    logic [ICLLEN-1:0] ldData;
    
    modport consumer( //perspective of the cache
        input ldData, ldr,
        output addr, ldp
        );
    modport producer(  // perspective of the memory
        input addr, ldp,
        output ldData, ldr
        );
endinterface
