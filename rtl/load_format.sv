/*  LOAD FORMATTER
        shifted_data is data recieved from data mem module
        size is instr[13:12]
        mem_unsigned is instr[14]
*/
import rv32i_pkg::memsize;

module load_format (
    input  logic [31:0] shifted_data,
    input  memsize      size,
    input  logic        mem_unsigned,
    output logic [31:0] load_data
);

    always_comb begin
        unique case (size)
            MEM_BYTE:
                if (mem_unsigned)
                    load_data = {24'b0, shifted_data[7:0]};
                else 
                    load_data = {24{shifted_data[7]}, shifted_data[7:0]};

            MEM_HALF:
                if (mem_unsigned)
                    load_data = {16'b0, shifted_data[15:0]};
                else
                    load_data = {16{shifted_data[15]}, shifted_data[15:0]};
                    
            MEM_WORD:
                load_data = shifted_data;
        endcase
    end
endmodule