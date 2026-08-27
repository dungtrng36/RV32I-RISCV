import rv32i_pkg::*;

module controller (
    input  logic [6:0] opcode,
    input  logic [2:0] funct3,
    input  logic       funct7_5,

    output aluop       alucontrol,
    output immop       immcontrol,

    output logic       regwrite,
    output logic       pcor0,
    output logic       scrA,
    output logic       srcB,
    output logic       memwrite,
    output logic       memtoreg,
    output logic       jump,
    output logic       branch,
    output logic [3:0] bitmask 
);

    always_comb begin

        alucontrol = ALU_ADD;
        immcontrol = IMM_I;

        regwrite = 1'b0;
        pcor0    = 1'b0;
        scrA     = 1'b0;
        srcB     = 1'b0;
        memwrite = 1'b0;
        memtoreg = 1'b0;
        jump     = 1'b0;
        branch   = 1'b0;
        bitmask  = 4'b0;

        case (opcode)
            
            7'b0110111: begin // LUI
                regwrite   = 1'b1;
                srcA       = 1'b1;
                srcB       = 1'b1;
                immcontrol = IMM_U;
            end

            7'b0010111: begin // AUIPC
                regwrite = 1'b1;
                pcor0 = 1'b1;
                srcA = 1'b1;
                srcB = 1'b1;
                immcontrol = IMM_U;
            end

            7'b1101111: begin // JAL
                regwrite = 1'b1;
                pcor0 = 1'b1;
                srcA = 1'b1;
                srcB = 1'b1;
                immcontrol = IMM_J;
                jump = 1'b1;
            end

            7'b1100111: begin // JALR
                regwrite = 1'b1;
                srcB = 1'b1;
                jump = 1'b1;
            end

            7'b1100011: begin // BRANCHES
                immcontrol = IMM_B;
                branch = 1'b1;
            end

            7'b0000011: begin // LOAD
                regwrite = 1'b1;
                srcB = 1'b1;
                memtoreg = 1'b1;
            end

            7'b100011: begin // STORE
                srcB = 1'b1;
                memwrite = 1'b1;
                immcontrol = IMM_S;
                
                case (funct3)
                    3'b000: bitmask = 4'b0001;
                    3'b001: bitmask = 4'b0011;
                    3'b010: bitmask = 4'b1111;
                endcase
            end

            7'b0010011: begin // I-TYPE
                regwrite = 1'b1;
                srcB = 1'b1;

                case (funct3) 
                    3'b000: alucontrol = ALU_ADD;
                    3'b001: alucontrol = ALU_SLL;
                    3'b010: alucontrol = ALU_SLT;
                    3'b011: alucontrol = ALU_SLTU;
                    3'b100: alucontrol = ALU_XOR;
                    3'b101: begin
                        if (funct7_5)
                            alucontrol = ALU_SRA;
                        else 
                            alucontrol = ALU_SRL;
                    end
                    3'b110: alucontrol = ALU_OR;
                    3'b111: alucontrol = ALU_AND;
                endcase
            end

            7'b0110011: begin // R-TYPE
                regwrite = 1'b1;

                case (funct3) 
                    3'b000: begin 
                        if (funct7_5)
                            alucontrol = ALU_SUB;
                        else
                            alucontrol = ALU_ADD
                    end
                    3'b001: alucontrol = ALU_SLL;
                    3'b010: alucontrol = ALU_SLT;
                    3'b011: alucontrol = ALU_SLTU;
                    3'b100: alucontrol = ALU_XOR;
                    3'b101: begin
                        if (funct7_5)
                            alucontrol = ALU_SRA;
                        else 
                            alucontrol = ALU_SRL;
                    end
                    3'b110: alucontrol = ALU_OR;
                    3'b111: alucontrol = ALU_AND;
                endcase
            end
        endcase
    end
    
endmodule