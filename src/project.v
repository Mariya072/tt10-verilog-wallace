/*
 * Copyright (c) 2024 Mariya Manoj P
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

// Wallace Tree Multiplier (4-bit x 4-bit → 8-bit output)
module tt_um_wallace(
    input [3:0] A, B,
    output [7:0] product
);
    wire [7:0] pp0 = {{4{1'b0}}, A & {4{B[0]}}};         // B[0] (no shift)
    wire [7:0] pp1 = {{3{1'b0}}, A & {4{B[1]}}, 1'b0};    // B[1] (<<1)
    wire [7:0] pp2 = {{2{1'b0}}, A & {4{B[2]}}, 2'b0};    // B[2] (<<2)
    wire [7:0] pp3 = {1'b0, A & {4{B[3]}}, 3'b0};         // B[3] (<<3)

    wire [7:0] row1 = pp0;
    wire [7:0] row2 = pp1;
    wire [7:0] row3 = pp2 + pp3;

    wire [7:0] sum_stage2 = row1 ^ row2 ^ row3;
    wire [7:0] carry_stage2 = (row1 & row2) | (row2 & row3) | (row1 & row3);

    assign product = sum_stage2 + (carry_stage2 << 1);
endmodule

// Top Module required by TinyTapeout
module tt_um_mariya_wallace (
    input  wire [7:0] ui_in,    // 4 bits for A, 4 bits for B
    output wire [7:0] uo_out,   // 8-bit output product
    input  wire [7:0] uio_in,   // unused
    output wire [7:0] uio_out,  // unused
    output wire [7:0] uio_oe,   // unused
    input  wire       ena,      // can be ignored
    input  wire       clk,      // can be ignored
    input  wire       rst_n     // can be ignored
);
    wire [3:0] A = ui_in[3:0];      // Lower 4 bits as A
    wire [3:0] B = ui_in[7:4];      // Upper 4 bits as B
    wire [7:0] product;

    wallace_tree_multiplier uut (
        .A(A),
        .B(B),
        .product(product)
    );

    assign uo_out  = product;
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    // Suppress unused input warnings
    wire _unused = &{ena, clk, rst_n};
endmodule
