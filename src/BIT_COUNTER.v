`timescale 1ns/1ps
module BIT_COUNTER(
    input clk,
    input rst,
    input bit_enb,
    output RX_CMP
);

reg [3:0] count_value;
reg rx_cmp_reg;

always@(posedge clk or posedge rst)
begin
    if(rst)
        count_value <= 0;
    else if(bit_enb)
        count_value <= count_value + 1;
end

always@(posedge clk or posedge rst)
begin
    if(rst)
        rx_cmp_reg <= 0;
    else
        rx_cmp_reg <= (count_value == 4'd9);
end

assign RX_CMP = rx_cmp_reg;

endmodule
