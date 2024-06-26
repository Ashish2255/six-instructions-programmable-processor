module testbench();
  reg clk;
  reg rst;
  reg[15:0] PC_start;
  
  top main(
    .clk(clk),
    .rst(rst),
    .PC_start(PC_start)
  );
  
  initial    
    begin
      $dumpfile("dump.vcd");
      $dumpvars(0, testbench);
      PC_start = 11;
      clk <= 0;
      rst = 1;
      #10 rst = 0;
      #1000 $finish;
    end
  
  always
	begin
      #5 clk = ~clk;
    end
endmodule