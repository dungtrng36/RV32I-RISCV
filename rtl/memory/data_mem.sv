/* DATA MEMORY MODULE
    FOR STORE OPERATION:
        - Recieves data
        - Shift bitmask and data to account for alignment
        - Write into memory for each activated bitmask
    FOR LOAD OPERATION:
        - Recieves address
        - Fetch and send data out to formatter
*/

module data_mem #(
    parameter int DEPTH = 1024
)

(
    input  logic [31:0] a, w,
    input  logic [3:0]  bitmask,
    input  logic        we, clk,
    output logic [31:0] r
);

    logic [31:0] RAM [0:DEPTH-1];
    logic [3:0] shifted_mask;
    logic [31:0] shifted_w;

    // LOAD
    assign r = RAM[a[31:2]];

    // STORE
    assign shifted_mask = bitmask << a[1:0];
    assign shifted_w = w << (a[1:0] * 8);

    always_ff @ (posedge clk) begin
        if (we) begin
            if (shifted_mask[0])
                RAM[a[31:2]][7:0] <= shifted_w[7:0];
            
            if (shifted_mask[1])
                RAM[a[31:2]][15:8] <= shifted_w[15:8];
    
            if (shifted_mask[2])
                RAM[a[31:2]][23:16] <= shifted_w[23:16];
    
            if (shifted_mask[3])
                RAM[a[31:2]][31:24] <= shifted_w[31:24];  
        end             
    end
endmodule