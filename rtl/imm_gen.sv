import rv32i_pkg::immop;

module imm_gen (
    input  logic [24:0] imm,
    input  immop        immcontrol,
    output logic [31:0] imm_out
);

    always_comb begin : immlogic
        imm_out = '0;

        unique case (immcontrol)
            IMM_I: imm_out = {21{imm[24]}, imm[23:13]};
            IMM_S: imm_out = {21{imm[24]}, imm[23:18], imm[4:0]};
            IMM_B: imm_out = {20{imm[24]}, imm[0],     imm[23:18], imm[4:1],   1'b0};
            IMM_U: imm_out = {   imm[24],  imm[23:13], imm[12:5],  12'b0};
            IMM_J: imm_out = {12{imm[24]}, imm[12:5],  imm[13],    imm[23:14], 1'b0};
            default: imm_out = '0;      
        endcase
    end
endmodule