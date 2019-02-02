`timescale 1ns / 1ps
// 通过数据输入输出测试开关、LED、数码管；通过数码管使能测试按钮。
module Board(sw, led, swb,
    clk, which, seg, enable); // 数码管
    parameter X = 32; // 数据位宽
    input [X:1] sw; // 开关输入数据
    output [X:1] led;
    assign led[X:1] = sw[X:1]; // 直接输出到 LED

    input clk;
    output [2:0] which;
    output [7:0] seg;
    output reg enable = 1; // 默认开启数码管使能
    Display Display_Instance( // 实例化数码管模块
        .clk(clk),      // 系统时钟
        .data(led),     // 显示数据
        .which(which),  // 片选编码
        .seg(seg));     // 段选信号

    parameter N = 6; //按钮个数
    input [N:1] swb;
    assign toggle = |swb[N:1]; // 按下任意按钮切换数码管使能
    always @(posedge toggle) enable <= ~enable;

endmodule
