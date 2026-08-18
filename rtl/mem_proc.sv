import rv32i_pkg::memsize

module mem_proc (
    input  logic [31:0] in,
    input  memsize  funct,
    output logic [31:0] out
);
    
    always_comb begin
        out = '0;
        unique case (funct)
            MEM_WORD:  out = in;
            MEM_HALF:  out = {16{in[15]}, in[15:0]};
            MEM_BYTE:  out = {24{in[7]},  in[7:0]};
            MEM_UHALF: out = {16'b0,      in[15:0]};
            MEM_UBYTE: out = {24'b0,      in[7:0]};
            default:   out = '0;
        endcase
    end
endmodule