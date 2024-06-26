module Instruction_Memory(addr,RD,instr);

  input [15:0]addr;
  input RD;
  output reg [15:0]instr;
  initial begin
    //TESTCASE 1
    	mem[0] = 16'b0000000000000000; // load : reg0 = data[0] = 3
    	mem[1] = 16'b0000000100000001; // load : reg1 = data[1] = 12
   	 	mem[2] = 16'b0010001000000001; // add  : reg2 = reg0 + reg1  
    	mem[3] = 16'b0001001000001001; // store : mem[9] = reg[2]
    	mem[4] = 16'b0011001100000000; // load constant: reg[3] = 0 ; 
   		mem[5] = 16'b0101001100000011; // JUMP: if(reg[3] == 0) go to instruction IM[8]
    	mem[8] = 16'b0100011000010000; // SUBTRACT: reg[6] = reg[1] - reg[0] ; 
    	mem[9] = 16'b0000001100001001; // load : reg[3] = mem[9]
  
      //TESTCASE 2
      mem[11] = 16'b0011001111111100; // load constant: reg[3] = -4 ;
      mem[12] = 16'b0011010000000001; // load constant: reg[4] = 1 ;
      mem[13] = 16'b0011010100000000; // load constant: reg[5] = 0 ;
      mem[14] = 16'b0000000000000000; // load : reg0 = data[0] = 3
      mem[15] = 16'b0000000100000001; // load : reg1 = data[1] = 12
         //FOR LOOP START
      mem[16] = 16'b0010000100000001; // add  : reg1 = reg0 + reg1
      mem[17] = 16'b0010001101000011; // add : reg3 = reg3 + reg4
      mem[18] = 16'b0101001100000010; // if(reg[3] == 0)JUMP 2 places to mem[9];    
      mem[19] = 16'b0101010111111101; // GOTO mem[5] 
         //FOR LOOP END
      mem[20] = 16'b0001000100001010; // store : mem[10] = reg[1]
    
  end

  reg [15:0] mem [255:0];
  
  always @(posedge RD) begin
 	if (RD) begin
    	 instr = mem[addr];
  	end
  end

endmodule