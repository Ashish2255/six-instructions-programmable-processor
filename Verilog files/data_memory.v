
// this module creates data memory   
module Data_Memory(clk,addr,rd,wr,W_data,R_data);
    // Inputs
    input clk, rd, wr;
    input [7:0] addr;
    // Outputs
    output reg [15:0] R_data;
    // Inputs
    input [15:0] W_data;

    // Memory declaration
    reg [15:0] mem [256:0];
  
    // Initialize memory values
    initial begin
        mem[0] = 16'b0000000000000011;  // 3
        mem[1] = 16'b0000000000001100;  // 12
    end

    // Memory read/write logic
    always @ (*)
    begin
        if (wr)
            mem[addr] <= W_data;
        else if (rd)
            R_data <= mem[addr];
    end
endmodule