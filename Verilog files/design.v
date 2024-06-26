// Code your design here
`include "controller.v" // Include the controller module
`include "data_memory.v" // Include the data memory module
`include "IM.v" // Include the instruction memory module
`include "PC.v" // Include the program counter module
`include "ALU.v" // Include the ALU module
`include "register_file.v" // Include the register file module
`include "MUX.v" // Include the multiplexer module

module top(
    input clk, // Clock input
    input rst, // Reset input
    input [15:0] PC_start // Start address for the program counter
);

wire [15:0] PC, IR, R_data, W_data, Rp_data, Rq_data, alu_data; // Declare wires for various signals
wire W_wr, Rp_rd, Rq_rd, RF_s1, RF_s0, alu_s1, alu_s0, D_rd, D_wr, I_rd, RF_Rp_zero, PC_ld, PC_inc, PC_clr; // Declare control signals
wire [3:0] RF_Rp_addr, RF_Rq_addr, RF_W_addr; // Declare register file address signals

// Instantiate the modules
PC_Module PC1 (
    .clk(clk),
    .PC(PC),
    .ld(PC_ld),
    .clr(PC_clr),
    .up(PC_inc),
    .PC_Next({{8{IR[7]}}, IR[7:0]}),
    .PC_start(PC_start)
);

Instruction_Memory IM(
    .addr(PC),
    .RD(I_rd),
    .instr(IR)
);

Register_File registerFile(
    .clk(clk),
    .W_wr(RF_W_wr),
    .Rp_rd(RF_Rp_rd),
    .Rq_rd(RF_Rq_rd),
    .W_addr(RF_W_addr),
    .Rp_addr1(RF_Rp_addr),
    .Rq_addr2(RF_Rq_addr),
    .W_data(W_data),
    .Rp_data1(Rp_data),
    .Rq_data2(Rq_data)
);

ALU ALU86(
    .A(Rp_data),
    .B(Rq_data),
    .C(alu_data),
    .s1(alu_s1),
    .s0(alu_s0)
);

comparator comp1(
    .data(Rp_data),
    .equal_zero(RF_Rp_zero)
);

Controller controller1 (
    .clk(clk),
    .instr(IR),
    .Op(IR[15:12]),
    .D_rd(D_rd),
    .D_wr(D_wr),
    .RF_s1(RF_s1),
    .RF_s0(RF_s0),
    .RF_W_wr(RF_W_wr),
    .RF_Rp_rd(RF_Rp_rd),
    .RF_Rq_rd(RF_Rq_rd),
    .alu_s1(alu_s1),
    .alu_s0(alu_s0),
    .RF_Rp_zero(RF_Rp_zero),
    .I_rd(I_rd),
    .IR_ld(IR_ld),
    .RF_Rp_addr(RF_Rp_addr),
    .RF_Rq_addr(RF_Rq_addr),
    .RF_W_addr(RF_W_addr),
    .rst(rst),
    .PC_ld(PC_ld),
    .PC_inc(PC_inc),
    .PC_clr(PC_clr)
);

Data_Memory data_mem(
    .clk(clk),
    .addr(IR[7:0]),
    .rd(D_rd),
    .wr(D_wr),
    .W_data(Rp_data),
    .R_data(R_data)
);

// Mux
wire [15:0] Mux1to2;
MUX_16to1 muxOne (alu_data, R_data, RF_s0, Mux1to2);
MUX_16to1 muxTwo (Mux1to2, {{8{IR[7]}}, IR[7:0]}, RF_s1, W_data);

endmodule

// comparator module to check if the input data is equal to zero
module comparator(
    input [15:0] data, // Input data to be checked
    output equal_zero // Output indicating if data is equal to zero
);

wire w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15; // Declare intermediate wires for the gates

or one (w1, data[0], data[1]); // Perform OR operation on data[0] and data[1]
or two (w2, w1, data[2]); // Perform OR operation on w1 and data[2]
or three (w3, w2, data[3]); // Perform OR operation on w2 and data[3]
or four (w4, w3, data[4]); // Perform OR operation on w3 and data[4]
or five (w5, w4, data[5]); // Perform OR operation on w4 and data[5]
or six (w6, w5, data[6]); // Perform OR operation on w5 and data[6]
or seven (w7, w6, data[7]); // Perform OR operation on w6 and data[7]
or eight (w8, w7, data[8]); // Perform OR operation on w7 and data[8]
or nine (w9, w8, data[9]); // Perform OR operation on w8 and data[9]
or ten (w10, w9, data[10]); // Perform OR operation on w9 and data[10]
or eleven (w11, w10, data[11]); // Perform OR operation on w10 and data[11]
or twelve (w12, w11, data[12]); // Perform OR operation on w11 and data[12]
or thirteen (w13, w12, data[13]); // Perform OR operation on w12 and data[13]
or fourteen (w14, w13, data[14]); // Perform OR operation on w13 and data[14]
or fifteen (w15, w14, data[15]); // Perform OR operation on w14 and data[15]
not sixteen (equal_zero, w15); // Perform NOT operation on w15 to get the output equal_zero indicating if data is equal to zero

endmodule
