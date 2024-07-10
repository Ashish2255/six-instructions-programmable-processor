# Six-Instruction Processor in Verilog

## Overview

This project involves the design and implementation of a six-instruction processor using Verilog. The processor features a controller with instruction memory, program counter, and registers, along with a datapath that includes data memory, a register file, and a gate-level ALU.

## Features

- **Controller**: Manages the flow of instructions and controls the operation of the datapath components.
  - **Instruction Memory**: Stores the instructions to be executed by the processor.
  - **Program Counter (PC)**: Keeps track of the address of the next instruction to be executed.
  - **Registers**: Temporary storage for data and addresses.

- **Datapath**: Performs the data processing operations.
  - **Data Memory**: Stores the data used and produced by the instructions.
  - **Register File**: A set of registers used to store intermediate values and operands.
  - **ALU (Arithmetic Logic Unit)**: Performs arithmetic and logic operations at the gate level.

## Instructions

The processor supports the following six instructions:

1. `MOV Ra, d`: Move data `d` to register `Ra`.
2. `MOV d, Ra`: Move data from register `Ra` to memory location `d`.
3. `ADD Ra, Rb, Rc`: Add the values in registers `Rb` and `Rc`, and store the result in register `Ra`.
4. `MOV Ra, #C`: Move constant `C` to register `Ra`.
5. `SUB Ra, Rb, Rc`: Subtract the value in register `Rc` from the value in register `Rb`, and store the result in register `Ra`.
6. `JMPZ Ra, offset`: Jump to the instruction at the address `PC + offset` if the value in register `Ra` is zero.

## Simulation and Testing

Comprehensive simulation tests were conducted to validate the processor's functionality. These tests involved:

- Setting specific values in the instruction and data memories.
- Executing a variety of instruction scenarios.
- Verifying the expected outcomes for each scenario.

