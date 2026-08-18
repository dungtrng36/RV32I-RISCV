import rv32i_pkg::*;

module alu (
    input  logic [31:0] a, b,
    input  aluop        alucontrol,
    output logic [31:0] result
);
    
    always_comb begin : alulogic
        result = '0;

        unique case (alucontrol)
            ALU_ADD: result = a + b;
            ALU_SUB: result = a - b;
            ALU_AND: result = a & b;
            ALU_OR:  result = a | b;
            ALU_XOR: result = a ^ b;

            ALU_SLL:  result = a << b[4:0];
            ALU_SRL:  result = a >> b[4:0];
            ALU_SRA:  result = $signed(a) >>> b[4:0];

            ALU_SLT:  result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
            ALU_SLTU: result = (a < b) ? 32'd1 : 32'd0;

            default: '0;
        endcase
    end

endmodule