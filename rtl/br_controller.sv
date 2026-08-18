import rv32i_pkg::branchop;

module br_controller (
    input  logic [31:0] r1, r2,
    input  branchop     funct,
    output logic        b
);
    
    always_comb begin
        b = 0;

        unique case (funct)
            BR_EQ:  b = (r1 === r2) ? 1 : 0;
            BR_NE:  b = (r1 !== r2) ? 1 : 0;
            BR_LT:  b = ($signed(r1) < $signed(r2)) ? 1 : 0;
            BR_GE:  b = ($signed(r1) < $signed(r2)) ? 0 : 1;
            BR_LTU: b = (r1 < r2) ? 1 : 0;
            BR_GEU: b = (r1 < r2) ? 0 : 1;
            default: b = 0;
        endcase
    end

endmodule