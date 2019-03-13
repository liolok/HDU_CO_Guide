`timescale 1ns / 1ps
// 数码管扫描显示模块仿真测试
module Display_Test();
    reg clk = 0;
    reg [32:1] data; // input
    wire [2:0] which;
    wire [7:0] seg; // output
    wire [10:0] count;
    wire [3:0] digit; // output for debug

    // Instantiate a display module
    Display Display_Instance(.clk(clk), .data(data),
        .which(which), .seg(seg),
        .count(count), .digit(digit));

    always #0.01 clk = ~clk; // 0.01ns == 10ps
    initial begin
        data = 32'hfedc_ba98; #500;
        data = 32'h7654_3210; #500;
    end

endmodule // Display_Test
