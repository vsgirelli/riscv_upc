package constants_pkg;

    parameter integer ICLN = 4; // Instruction Cache number of lines
    parameter integer ICLLEN = 128; // Instruction cache length of lines in bits
    
    parameter integer DCLN = 4; // Data Cache number of lines
    parameter integer DCLLEN = 128; // Data cache length of lines in bits

    parameter integer ARCH_LEN = 32; // Architectural width (width of int register)
    parameter integer PHY_LEN = 20; // Physical address width
    parameter integer INST_LEN = 32; // Maximum instruciton length (as in spec)
    parameter integer REG_FILE_LEN = 32;
    
    parameter integer BOOT_ADDR = 32'h0000_1000;
    parameter integer EXCEPTION_ADDR = 32'h0000_2000;

endpackage
