import rv32i_pkg::*;

module top (
    input logic clk;
)
    logic [31:0] imem_addr, imem_rdata, dmem_addr, dmem_wdata, dmem_rdata;
    logic        we;
    logic [3:0]  dmem_bmask;

    core rv32i (
        .clk(clk),

        .imem_addr(imem_addr),
        .imem_rdata(imem_rdata),

        .dmem_addr(dmem_addr),
        .dmem_wdata(dmem_wdata),
        .dmem_we(we),
        .dmem_bmask(dmem_bmask),
        .dmem_rdata(dmem_rdata)
    );

    instr_mem #(
        .DEPTH(1024),
        .MEM_FILE("program.hex")
    ) instruction (
        .a(imem_addr),
        .instr(imem_rdata)
    );

    data_mem #(
        .DEPTH(1024)
    ) RAM (
        .a(dmem_addr),
        .w(dmem_wdata),
        .bitmask(dmem_bmask),
        .we(we),
        .clk(clk),
        .r(dmem_rdata)
    );

endmodule