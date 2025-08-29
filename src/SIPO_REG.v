module SIPO_REG #(
    parameter DATA_WIDTH = 8
)(
    input wire clk,
    input wire reset,
    input wire serial_in,
    input wire shift_en,
    output reg [DATA_WIDTH-1:0] parallel_out
);

    reg [DATA_WIDTH-1:0] shift_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= {DATA_WIDTH{1'b0}};
            parallel_out <= {DATA_WIDTH{1'b0}};
        end else if (shift_en) begin
            shift_reg <= {shift_reg[DATA_WIDTH-2:0], serial_in};
            parallel_out <= shift_reg;
        end
    end

endmodule