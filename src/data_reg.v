`timescale 1ns/1ps
module Reg_out #(DATA_WIDTH = 8)(
    input clk, 
    input rst,
    input [DATA_WIDTH-1:0] Parallel_in,
    input ld_data,
    output [DATA_WIDTH-1:0] RX_DATA
    );

reg [DATA_WIDTH-1:0]temp_out;

always @(posedge clk or posedge rst) begin

    if (rst) begin
        temp_out <= 1'd0; // 
    end else if (ld_data) begin
        temp_out <= Parallel_in;
    end
end


assign RX_DATA = temp_out;
endmodule
