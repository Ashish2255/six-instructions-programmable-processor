module Controller(
    input clk,
    input wire [15:0] instr, // Instruction input
    input [3:0]Op,
    input rst ,
    output reg   D_rd, // Data read control signal
    output reg   D_wr, // Data write control signal
    output reg   RF_s1, // Register file select signal 1
    output reg   RF_s0, // Register file select signal 0
    output reg   RF_W_wr, // Register file write control signal
    output reg   RF_Rp_rd, // Register file read control signal for Rp
    output reg   RF_Rq_rd, // Register file read control signal for Rq
    output reg   alu_s1, // ALU select signal 1
    output reg   alu_s0, // ALU select signal 0
    input  RF_Rp_zero, // Zero flag for Rp register
    output reg PC_ld, // Program counter load control signal
    output reg   PC_clr, // Program counter clear control signal
    output reg   PC_inc, // Program counter increment control signal
    output reg   I_rd, // Instruction read control signal
    output reg   IR_ld, // Instruction register load control signal
    output reg   [3:0]RF_Rp_addr, // Register file address for Rp
    output reg   [3:0]RF_Rq_addr, // Register file address for Rq
    output reg   [3:0]RF_W_addr // Register file address for write
);

// Define opcode constants
parameter OP_MOV_Ra_d = 4'b0000;
parameter OP_MOV_d_Ra = 4'b0001;
parameter OP_ADD = 4'b0010;
parameter OP_MOV_Ra_C = 4'b0011;
parameter OP_SUB = 4'b0100;
parameter OP_JMPZ = 4'b0101;

// Define states
parameter INIT_STATE = 3'b000;
parameter FETCH_STATE = 3'b001;
parameter MOV_Ra_d_STATE = 3'b010;
parameter MOV_d_Ra_STATE = 3'b011;
parameter ADD_STATE = 3'b100;
parameter MOV_Ra_C_STATE = 3'b101;
parameter SUB_STATE = 3'b110;
parameter JMPZ_STATE = 3'b111;
  
// Delay States
parameter WAIT_STATE = 1'b1;
parameter READY_STATE = 1'b0;

// Define current state
reg [2:0] current_state;
reg delay_state;

initial begin
    current_state=INIT_STATE;
    // Default control signals
    D_rd=0;
    D_wr=0;
    RF_s1=0;
    RF_s0=0;
    RF_W_wr=0;
    RF_Rp_rd=0;
    RF_Rq_rd=0;
    RF_W_wr=0;
    alu_s1=0;
    alu_s0=0;
    IR_ld=0;
    I_rd=0;
    PC_ld = 0;
    PC_inc = 0;
    // RF_Rp_zero=0;
end

// Decode the opcode from the instruction
always @(*) begin
    case (current_state)
        INIT_STATE: begin
            PC_clr=1; // Clear program counter
        end
        FETCH_STATE: begin
            begin
                PC_clr = 0; // Clear program counter
                I_rd=1; // Enable instruction read
                PC_inc=1; // Increment program counter
                IR_ld=1; // Load instruction into IR
            end
        end
        MOV_Ra_d_STATE: begin
            D_rd=1; // Enable data read
            RF_s1=0; // Select register file bank 0
            RF_s0=1; // Select register file bank 1
            RF_W_wr=1; // Enable register file write
            RF_W_addr = instr[11:8]; // Set register file write address
        end
        MOV_d_Ra_STATE: begin
            D_wr=1; // Enable data write
            RF_Rp_rd=1; // Enable register file read for Rp
            RF_Rp_addr=instr[11:8]; // Set register file read address for Rp
        end
        ADD_STATE: begin
            RF_Rp_rd=1; // Enable register file read for Rp
            RF_Rp_addr=instr[7:4]; // Set register file read address for Rp
            RF_s1=0; // Select register file bank 0
            RF_s0=0; // Select register file bank 0
            RF_Rq_rd=1; // Enable register file read for Rq
            RF_Rq_addr=instr[3:0]; // Set register file read address for Rq
            RF_W_wr=1; // Enable register file write
            RF_W_addr=instr[11:8]; // Set register file write address
            alu_s1=0; // Select ALU operation 0
            alu_s0=1; // Select ALU operation 1
        end
        MOV_Ra_C_STATE: begin
            RF_s1=1; // Select register file bank 1
            RF_s0=0; // Select register file bank 0
            RF_W_wr=1; // Enable register file write
            RF_W_addr=instr[11:8]; // Set register file write address
        end
        SUB_STATE: begin
            RF_Rp_rd=1; // Enable register file read for Rp
            RF_Rp_addr=instr[7:4]; // Set register file read address for Rp
            RF_s1=0; // Select register file bank 0
            RF_s0=0; // Select register file bank 0
            RF_Rq_rd=1; // Enable register file read for Rq
            RF_Rq_addr=instr[3:0]; // Set register file read address for Rq
            RF_W_wr=1; // Enable register file write
            RF_W_addr=instr[11:8]; // Set register file write address
            alu_s1=1; // Select ALU operation 1
            alu_s0=0; // Select ALU operation 0
        end
        JMPZ_STATE: begin
            RF_Rp_rd=1; // Enable register file read for Rp
            RF_Rp_addr=instr[11:8]; // Set register file read address for Rp
          
            if(RF_Rp_zero) begin
                PC_ld=1; // Load program counter
            end
        end
        default: begin
            // Unknown opcode, do nothing
        end
    endcase
end

// Always block for state transitions
always @(posedge clk or posedge rst) begin
    if (rst) begin
        current_state <= INIT_STATE; // Reset to init state
    end else begin
        case (current_state)
            INIT_STATE: begin
                current_state <= FETCH_STATE; // Transition to fetch state after initialization
            end
            FETCH_STATE: begin
                case (instr[15:12])
                    OP_MOV_Ra_d: current_state = MOV_Ra_d_STATE;
                    OP_MOV_d_Ra: current_state = MOV_d_Ra_STATE;
                    OP_ADD: current_state = ADD_STATE;
                    OP_MOV_Ra_C: current_state = MOV_Ra_C_STATE;
                    OP_SUB: current_state = SUB_STATE;
                    OP_JMPZ: current_state = JMPZ_STATE;
                    default: current_state = FETCH_STATE; // Stay in fetch state if opcode is not recognized
                endcase 
                I_rd=0; // Disable instruction read
                PC_inc=0; // Disable program counter increment
                IR_ld=0; // Disable instruction register load
            end
            MOV_Ra_d_STATE, MOV_d_Ra_STATE, ADD_STATE, MOV_Ra_C_STATE, SUB_STATE, JMPZ_STATE: begin
                // Reset control signals
                D_rd=0;
                D_wr=0;
                RF_W_wr=0;
                RF_Rp_rd=0;
                RF_Rq_rd=0;
                RF_W_wr=0;
                alu_s1=0;
                alu_s0=0;
                IR_ld=0;
                I_rd=0;
                PC_ld = 0;
                PC_inc = 0;
                current_state <= FETCH_STATE; // Transition back to fetch state
            end
            default: begin
                // Unknown state, do nothing
            end
        endcase
    end
end

endmodule
