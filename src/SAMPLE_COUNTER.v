module sample_counter(
    input clk,
    input reset,
    input count_enb, // it will start count when count_enb// baud rate is high
    output SAMPLING_DONE
);
    reg temp_sampling;
    reg [3:0] count;




    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0;
            temp_sampling <= 1'b0;
        end else if (count_enb) begin // Counting only when count_enb is high
            if (count == 4'd15) begin
                temp_sampling <= 1'b1;
            end else begin
                count <= count + 1;
                temp_sampling <= 1'b0;
            end
        end
    end
    assign SAMPLING_DONE = temp_sampling;
endmodule