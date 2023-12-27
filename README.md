# README RISC-V core project

## Compilation
To compile, we can do it with the modelsim package (in quartus) in the same terminal.  There is a `Makefile` now that does the compilation and shows errors.  You have to add all new verilog files (`.v`) in the `Makefile` and then just do

```
make *.v
```

or with the specific verilog file you want to compile.

## Simulation
To simulate, we can also go with Modelsim.  **THIS IS A WORK IN PROGRESS** There two components needed:
- Test bench, that includes the componentt that you want to simulate and inserts the needed signals. In the simplest case, the test bench includes the whole core. Right now we have:
    - `tb_proc.v`
- The simulation setup for modelsim, with all the signals configuration and the start/stop logic. I am not very sure of how this works.


