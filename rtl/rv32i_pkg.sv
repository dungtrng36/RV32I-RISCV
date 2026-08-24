package rv32i_pkg;

    parameter int XLEN = 32;

    typedef enum logic [3:0] {
        ALU_ADD,
        ALU_SUB,
        ALU_AND,
        ALU_OR,
        ALU_XOR,
        ALU_SLL,
        ALU_SRL,
        ALU_SRA,
        ALU_SLT,
        ALU_SLTU
    } aluop;

    typedef enum logic [2:0] { 
        IMM_I;
        IMM_S;
        IMM_B;
        IMM_U;
        IMM_J;
    } immop;

    typedef enum logic [2:0] { 
        BR_EQ,
        BR_NE,
        BR_LT,
        BR_GE,
        BR_LTU,
        BR_GEU
    } branchop;

    typedef enum logic [1:0] { 
        MEM_BYTE
        MEM_HALF
        MEM_WORD
    } memsize;

endpackage