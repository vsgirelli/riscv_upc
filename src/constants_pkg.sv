package constants_pkg;

    parameter integer ICLN = 4; // Instruction Cache number of lines
    parameter integer ICLLEN = 128; // Instruction cache length of lines in bits
    

    parameter integer ILEN = 32; // Maximum instruciton length (as in spec)
    parameter integer XLEN = 32; // Architectural width (width of int register)
    
    parameter integer BOOT_ADDR = 32'h0000_1000;
    parameter integer EXCEPTION_ADDR = 32'h0000_2000;

endpackage
