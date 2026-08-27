import rv32i_pkg::*;

module datapath (
    input  logic       clk,

    input  aluop       alucontrol,
    input  immop       immcontrol,

    input  logic       regwrite,
    input  logic       pcor0,
    input  logic       srcA,
    input  logic       srcB,
    input  logic       memtoreg,
    input  logic       jump,
    input  logic       branch,    

    output logic [31:0] pc,
    input  logic [31:0] instr,

    output logic [31:0] mem_addr,
    output logic [31:0] write_data,
    input  logic [31:0] mem_data
);

    logic [31:0] nextpc, currpc, pcadd, pcadderout, pcaddsrc;
    logic [31:0] immout;
    logic [31:0] memtoregout;
    logic        branchout;

    logic [31:0] write_reg, regout1, regout2;

    logic [31:0] srcaout, srcbout, aluout, pcor0out;
    // ======================================================================================================
    //                                              PC LOGIC 
    // ======================================================================================================
    dff   pcreg     ( .d(nextpc), .clk(clk), .q(currpc) );
    adder pcadder   ( .d0(currpc), .d1(pcadd), .y(pcadderout) );

    assign pcadd    = pcaddsrc ? immout      : 32'd4;
    assign nextpc   = jump     ? memtoregout : pcadderout;

    assign pc = currpc;
    // ======================================================================================================
    //                                            REGISTER FILE 
    // ======================================================================================================
    regfile registerfile ( .a1(instr[19:15]),
                           .a2(instr[24:20]),
                           .a3(instr[11:7]),
                           .wd3(write_reg),
                           .we(regwrite),
                           .clk(clk),
                           .r1(regout1),
                           .r2(regout2)
                         );
    
    assign write_reg   = jump     ? pcadderout : memtoregout;
    assign memtoregout = memtoreg ? loadout    : aluout;
    // ======================================================================================================
    //                                              ALU LOGIC 
    // ======================================================================================================
    alu mainalu ( .a(srcaout), 
                  .b(srcbout), 
                  .alucontrol(alucontrol), 
                  .result(aluout) 
                );
    assign srcbout  = srcB  ? immout   : regout2;
    assign srcaout  = srcA  ? pcor0out : regout1;
    assign pcor0out = pcor0 ? currpc   : 32'b0;
    // ======================================================================================================
    //                                         IMMEDIATE GENERATOR 
    // ======================================================================================================
    imm_gen immediategen ( .imm(instr[31:7]), 
                           .immcontrol(immcontrol), 
                           .imm_out(immout)
                         );
    // ======================================================================================================
    //                                          BRANCH CONTROLLER 
    // ======================================================================================================
    br_controller branchcon ( .r1(regout1),
                              .r2(regout2), 
                              .funct(instr[14:12]),
                              .b(branchout)
                            );
    assign pcaddsrc = branch & branchout;  
    // ======================================================================================================  
    //                                             DATA MEMORY 
    // ======================================================================================================
    assign mem_addr = aluout;
    assign write_data = regout2;

    load_format loader ( .data(mem_data),
                         .offset(aluout[1:0]),
                         .size(instr[13:12]),
                         .mem_unsigned(instr[14]),
                         .load_data(loadout)
                       );

        


endmodule