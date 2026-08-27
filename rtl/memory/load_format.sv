/*  LOAD FORMATTER
        shifted_data is data recieved from data mem module
        size is instr[13:12]
        mem_unsigned is instr[14]
*/
import rv32i_pkg::memsize;

module load_format (
    input  logic [31:0] data,
    input  logic [1:0]  offset,
    input  memsize      size,
    input  logic        mem_unsigned,
    output logic [31:0] load_data
);

    logic [31:0] shifted_data;

    assign shifted_data = data >> (offset * 8);

    always_comb begin
        unique case (size)
            MEM_BYTE: begin
                if (mem_unsigned)
                    load_data = {24'b0, shifted_data[7:0]};
                else 
                    load_data = {{24{shifted_data[7]}}, shifted_data[7:0]};
            end

            MEM_HALF: begin
                if (mem_unsigned)
                    load_data = {16'b0, shifted_data[15:0]};
                else
                    load_data = {{16{shifted_data[15]}}, shifted_data[15:0]};
            end

            MEM_WORD: begin
                load_data = shifted_data;
            end

            default: begin
                load_data = 32'b0;
            end

        endcase
    end
endmodule