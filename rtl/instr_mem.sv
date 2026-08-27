module instr_mem #(
    parameter int DEPTH = 1024,
    parameter string MEM_FILE = "program.hex"
) (
    input  logic [31:0] a,
    output logic [31:0] instr
);

    logic [31:0] ROM [0:DEPTH-1];

    initial begin
        $readmemh(MEM_FILE, ROM);
    end

    assign instr = ROM[a[31:2]];

endmodule