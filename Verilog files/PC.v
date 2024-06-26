module PC_Module(clk,clr,PC,PC_Next,ld,up,PC_start);
    input clk,clr,ld,up;
    input [15:0]PC_Next; // PC_Next is Offset
    input wire [15:0]PC_start;  
    output reg [15:0]PC;
    wire w1,w2;
    wire[15:0] w3,w4,w5;
  
    // Instantiate the ripple adders which keep ready the PC + 1 and PC + offset values
    sixteenbit_ripple_adder a1(.x(PC), .y(16'b0000000000000001),.sel(1'b0),.overflow(w1), .c_out(w2),.sum(w3));
    sixteenbit_ripple_adder a2(.x(PC), .y(16'b0000000000000001),.sel(1'b1),.overflow(w1), .c_out(w2),.sum(w4));  
    sixteenbit_ripple_adder a3(.x(PC_Next), .y(w4),.sel(1'b0),.overflow(w1), .c_out(w2),.sum(w5));
  
    // Initialize PC with PC_start value
    initial begin
        PC <= PC_start;
    end
  
    always @(posedge clk)
    begin
        if(clr)
        // to reset the PC value to PC_start which starts the instructions from specified address
            PC <= PC_start;
        else
            if(up==1)
            begin
            // for jump instructions
                PC=w3;
            end
      
        if(ld==1)
        begin
            PC = w5; // PC_next as PC+offset
        end
    end
endmodule

// created a full adder module to already store the added value of PC (PC+1) and (PC+offset)
module sixteenbit_ripple_adder (
    input wire [15:0] x, y,
    input wire sel,
    output wire overflow, c_out,
    output wire [15:0] sum
);
    
    // same reasoning as in ALU module's full adder
    wire [15:0] c,temp;
    //xor x1(temp[0],y[0],sel);
    xor x0(temp[0], y[0], sel);
    xor x1(temp[1], y[1], sel);
    xor x2(temp[2], y[2], sel);
    xor x3(temp[3], y[3], sel);
    xor x4(temp[4], y[4], sel);
    xor x5(temp[5], y[5], sel);
    xor x6(temp[6], y[6], sel);
    xor x7(temp[7], y[7], sel);
    xor x8(temp[8], y[8], sel);
    xor x9(temp[9], y[9], sel);
    xor x10(temp[10], y[10], sel);
    xor x11(temp[11], y[11], sel);
    xor x12(temp[12], y[12], sel);
    xor x13(temp[13], y[13], sel);
    xor x14(temp[14], y[14], sel);
    xor x15(temp[15], y[15], sel);

    FullAdder f0 (.a(x[0]), .b(temp[0]), .cin(sel), .s(sum[0]), .cout(c[0]));
    FullAdder f1 (.a(x[1]), .b(temp[1]), .cin(c[0]), .s(sum[1]), .cout(c[1]));
    FullAdder f2 (.a(x[2]), .b(temp[2]), .cin(c[1]), .s(sum[2]), .cout(c[2]));
    FullAdder f3 (.a(x[3]), .b(temp[3]), .cin(c[2]), .s(sum[3]), .cout(c[3]));
    FullAdder f4 (.a(x[4]), .b(temp[4]), .cin(c[3]), .s(sum[4]), .cout(c[4]));
    FullAdder f5 (.a(x[5]), .b(temp[5]), .cin(c[4]), .s(sum[5]), .cout(c[5]));
    FullAdder f6 (.a(x[6]), .b(temp[6]), .cin(c[5]), .s(sum[6]), .cout(c[6]));
    FullAdder f7 (.a(x[7]), .b(temp[7]), .cin(c[6]), .s(sum[7]), .cout(c[7]));
    FullAdder f8 (.a(x[8]), .b(temp[8]), .cin(c[7]), .s(sum[8]), .cout(c[8]));
    FullAdder f9 (.a(x[9]), .b(temp[9]), .cin(c[8]), .s(sum[9]), .cout(c[9]));
    FullAdder f10 (.a(x[10]), .b(temp[10]), .cin(c[9]), .s(sum[10]), .cout(c[10]));
    FullAdder f11 (.a(x[11]), .b(temp[11]), .cin(c[10]), .s(sum[11]), .cout(c[11]));
    FullAdder f12 (.a(x[12]), .b(temp[12]), .cin(c[11]), .s(sum[12]), .cout(c[12]));
    FullAdder f13 (.a(x[13]), .b(temp[13]), .cin(c[12]), .s(sum[13]), .cout(c[13]));
    FullAdder f14 (.a(x[14]), .b(temp[14]), .cin(c[13]), .s(sum[14]), .cout(c[14]));
    FullAdder f15 (.a(x[15]), .b(temp[15]), .cin(c[14]), .s(sum[15]), .cout(c[15]));

    assign c_out = c[15];
    xor(overflow, c[14], c[15]);

endmodule
