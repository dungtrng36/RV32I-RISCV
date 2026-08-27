// CREATES MULTIPLE OF THE DATA DEPENDING ON THE SELECTED WIDTH
// data is data recieved from RD2
// size is instr[13:12]
// ---------------------------------------------------------------------------------------------------------------
// The data_mem module already handles data shifting, therefore, this module will no longer be needed
// ---------------------------------------------------------------------------------------------------------------

import rv32i_pkg::memsize;
    
module store_proc(
    input  logic [31:0] data,
    input  memsize      size,
    output logic [31:0] out
);
    always_comb begin
        unique case (size)
            MEM_BYTE: out = {4{data[7:0]}};
            MEM_HALF: out = {2{data[15:0]}};
            MEM_WORD: out = data;
        endcase
    end

endmodule