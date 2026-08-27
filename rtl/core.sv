import rv32i_pkg::*;

module core (
    input  logic clk,

    output logic [31:0] imem_addr,
    input  logic [31:0] imem_rdata,

    output logic [31:0] dmem_addr,
    output logic [31:0] dmem_wdata,
    output logic        dmem_we,
    output logic [3:0]  dmem_bmask,
    input  logic [31:0] dmem_rdata
);

    aluop alucontrol;
    immop immcontrol;
    logic regwrite, pcor0, scrA, srcB, memtoreg, jump, branch;

    datapath dp (
        .clk(clk),

        .alucontrol(alucontrol),
        .immcontrol(immcontrol),

        .regwrite(regwrite),
        .pcor0(pcor0),
        .scrA(scrA),
        .srcB(srcB),
        .memtoreg(memtoreg),
        .jump(jump),
        .branch(branch),

        .pc(imem_addr),
        .instr(imem_rdata),

        .mem_addr(dmem_addr),
        .write_data(dmem_wdata),
        .mem_data(dmem_rdata)
    );

    controller ctrl (
        .opcode(imem_rdata[6:0]),
        .funct3(imem_rdata[14:12]),
        .funct7_5(imem_rdata[30]),
        
        .alucontrol(alucontrol),
        .immcontrol(immcontrol),

        .regwrite(regwrite),
        .pcor0(pcor0),
        .scrA(scrA),
        .srcB(srcB),
        .memwrite(dmem_we),
        .memtoreg(memtoreg),
        .jump(jump),
        .branch(branch),
        .bitmask(dmem_bmask)
    );

endmodule