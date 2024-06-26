// this module creates the Register File for the processor

module Register_File(
    input clk, W_wr, Rp_rd, Rq_rd,
    input [3:0] W_addr, Rp_addr1, Rq_addr2,
    input [15:0] W_data,
    output reg [15:0] Rp_data1, Rq_data2
);

    reg [15:0] Register [15:0]; // Array of registers

    always @ (posedge clk or W_wr or posedge Rp_rd or posedge Rq_rd)
    begin
        if (Rp_rd) // Read operation for Rp_data1
        begin
            Rp_data1 = Register[Rp_addr1]; // Read data from register
        end
        if (Rq_rd) // Read operation for Rq_data2
        begin
            Rq_data2 = Register[Rq_addr2]; // Read data from register
        end
        if (W_wr) // Write operation
        begin
            Register[W_addr] = W_data; // Write data to register
        end      
    end

endmodule
