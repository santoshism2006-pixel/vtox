/*
 * Tiny Tapeout Project
 * ECDSA Signature Verification (Simplified)
 */

module tt_um_ecdsa_verify (
    input  wire [7:0] ui_in,     // Dedicated inputs
    output wire [7:0] uo_out,    // Dedicated outputs
    input  wire [7:0] uio_in,    // IO Inputs
    output wire [7:0] uio_out,   // IO Outputs
    output wire [7:0] uio_oe,    // IO Output Enable
    input  wire       ena,       // Enable
    input  wire       clk,       // Clock
    input  wire       rst_n      // Reset (active low)
);

    wire hash_match;
    wire sig_valid;

    // Submodule 1: Hash Checker
    hash_checker u1 (
        .data(ui_in),
        .match(hash_match)
    );

    // Submodule 2: Signature Validator
    signature_validator u2 (
        .hash_ok(hash_match),
        .clk(clk),
        .rst_n(rst_n),
        .valid(sig_valid)
    );

    // Output Assignment
    assign uo_out[0] = sig_valid;
    assign uo_out[7:1] = 7'b0000000;

    // Unused bidirectional pins
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

endmodule


// --------------------------------------------------
// Submodule 1 : Hash Checker
// --------------------------------------------------

module hash_checker (
    input  wire [7:0] data,
    output wire match
);

    assign match = (data == 8'hA5);

endmodule


// --------------------------------------------------
// Submodule 2 : Signature Validator
// --------------------------------------------------

module signature_validator (
    input  wire hash_ok,
    input  wire clk,
    input  wire rst_n,
    output reg  valid
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            valid <= 1'b0;
        else
            valid <= hash_ok;
    end

endmodule
