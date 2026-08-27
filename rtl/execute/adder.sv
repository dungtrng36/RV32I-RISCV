module adder (
    input  logic [31:0] d0, d1,
    output logic [31:0] y
);
    
    assign y = d0 + d1;  

endmodule