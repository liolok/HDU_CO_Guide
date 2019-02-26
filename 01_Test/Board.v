`timescale 1ns / 1ps
// 通过数据输入输出测试开关、LED、数码管；通过数码管使能测试按钮。
module Board(sw, led, swb, clk, which, seg, enable);
    input [1:32] sw; // 开关输入数据
    output [1:32] led;
    assign led = sw; // 直接输出到 LED

    input clk; // 数码管相关
    output [2:0] which;
    output [7:0] seg;
    output reg enable = 1; // 默认开启数码管使能
    Display Display_Instance( // 实例化数码管模块
        .clk(clk),      // 系统时钟
        .data(led),     // 显示数据
        .which(which),  // 片选编码
        .seg(seg));     // 段选信号

    input [1:6] swb;
    assign toggle = |swb; // 按下任意按钮切换数码管使能
    always @(posedge toggle) enable <= ~enable;

endmodule // Board
