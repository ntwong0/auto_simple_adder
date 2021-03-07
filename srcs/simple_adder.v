`timescale 1ns / 1ps
module simple_adder(
    input wire signed [31:0] input_a,
    input wire signed [31:0] input_b,
    output wire signed [31:0] output_y,
    output wire overflow
    );
    wire [32:0] sum;
    assign sum = input_a + input_b;
    assign output_y = sum[31:0];
    assign overflow = (input_a[3] & input_b[3] & !sum[3]) | (!input_a[3] & !input_b[3] & sum[3]);
endmodule
