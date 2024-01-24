import constants_pkg::*;

interface data_bus();
    logic [ARCH_LEN-1:0] addr;

    logic                ldp; // Load petition
    logic                ldr; // Load ready

    logic [DCLLEN-1:0] ldData;

    logic                srp; // Store petition
    logic                srr; // Store ready
    
    logic [DCLLEN-1:0] srData;

    
    modport consumer( //perspective of the cache
        input ldData, ldr, srr,
        output addr, ldp, srp, srData
        );
    modport producer(  // perspective of the memory
        input addr, ldp, srp, srData,
        output ldData, ldr, srr
        );
endinterface

