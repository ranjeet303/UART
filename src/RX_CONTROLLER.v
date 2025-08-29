module RX_CONTROLLER(
    input clk,
    input rst,
    input serial_in,
    input RX_CMP,
    input SAMPLING_DONE,
    output reg shift_en,
    output reg ld_data,
    output reg count_enb,
    output reg RX_DONE
);

reg [2:0] ps, ns;
parameter idle  = 3'b000;
parameter check_bit_count = 3'b001;
parameter wait_for_sample = 3'b010;
parameter shift_data = 3'b011;
//parameter wait_for_shift = 3'b100;  
parameter check_stop_bit = 3'b101;
parameter load_data = 3'b110;


always @(posedge clk or posedge rst) begin
    if (rst) begin
        ps <= idle;
    end
    else begin
        ps <= ns;
    end
end

always @(*) begin
    case (ps)
    idle: ns = serial_in ? idle : check_bit_count ;
    check_bit_count: ns = RX_CMP ? check_stop_bit : wait_for_sample ;
    wait_for_sample: ns = SAMPLING_DONE ? shift_data : wait_for_sample ;
    shift_data: ns = check_bit_count;
   // wait_for_shift: ns = check_bit_count ;
    check_stop_bit: ns = load_data;
    load_data: ns = idle;
    default: ns = idle;
    endcase
end

always @(*) begin
    case (ps)
    idle: begin
        shift_en = 0;
        ld_data = 0;
        count_enb = 0;
        RX_DONE = 0;
    end
    check_bit_count: begin
        shift_en = 0;
        ld_data = 0;
        count_enb = 0;
        RX_DONE = 0;
    end
    wait_for_sample: begin
        shift_en = 0;
        ld_data = 0;
        count_enb = 1;
        RX_DONE = 0;
    end
    shift_data: begin
        shift_en = 1;
        ld_data = 0;
        count_enb = 0;
        RX_DONE = 0;
    end
    check_stop_bit: begin
        shift_en = 0;
        ld_data = 0;
        count_enb = 0;
        RX_DONE = 0;
    end
    load_data: begin
        shift_en = 0;
        ld_data = 1;
        count_enb = 0;
        RX_DONE = 1;
    end
    default: begin
        shift_en = 0;
        ld_data = 0;
        count_enb = 0;
        RX_DONE = 0;
    end
    endcase
end
endmodule