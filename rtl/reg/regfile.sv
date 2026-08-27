module regfile (
    input  logic [4:0]  a1, a2, a3,
    input  logic [31:0] wd3,
    input  logic        we,
    input  logic        clk,
    output logic [31:0] r1, r2
);

    logic [31:0] register [0:31];

    assign r1 = (a1 == 5'd0) ? 32'b0 : register[a1];
    assign r2 = (a2 == 5'd0) ? 32'b0 : register[a2];

    always_ff @( posedge clk ) begin 
        if (we && (a3 != 5'd0)) 
            register[a3] <= wd3; 
    end
    
endmodule