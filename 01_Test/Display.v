`timescale 1ns / 1ps
// 8位七段数码管扫描显示模块
module Display(clk, data, which, seg);
    input clk; // 接入系统时钟
    input [32:1] data; // 32位显示数据
    output reg [2:0] which; // 片选编码（8位中的哪一位）
    output reg [7:0] seg; // 段选信号（七段中的哪些笔划）

    integer count = 0; // 分频扫描，循环遍历片选编码。
    always @(posedge clk) begin
        count <= count + 1;
        if (count == 2000) begin
            which <= which + 1;
            count <= 0;
        end
    end

    reg [3:0] digit; // 片选后的4位二进制数据 => 1位十六进制数码
    always @(*) case (which)
        0: digit = data[04:01]; // 最低位
        1: digit = data[08:05];
        2: digit = data[12:09];
        3: digit = data[16:13];
        4: digit = data[20:17];
        5: digit = data[24:21];
        6: digit = data[28:25];
        7: digit = data[32:29]; // 最高位
    endcase

    always @(*) case (digit) // 十六进制数码 => 段选信号（a,b,c,...g,dp）
        4'h0: seg = 8'b0000_0011;
        4'h1: seg = 8'b1001_1111;
        4'h2: seg = 8'b0010_0101;
        4'h3: seg = 8'b0000_1101;
        4'h4: seg = 8'b1001_1001;
        4'h5: seg = 8'b0100_1001;
        4'h6: seg = 8'b0100_0001;
        4'h7: seg = 8'b0001_1111;
        4'h8: seg = 8'b0000_0001;
        4'h9: seg = 8'b0000_1001;
        4'hA: seg = 8'b0001_0001;
        4'hB: seg = 8'b1100_0001;
        4'hC: seg = 8'b0110_0011;
        4'hD: seg = 8'b1000_0101;
        4'hE: seg = 8'b0110_0001;
        4'hF: seg = 8'b0111_0001;
        default: seg = 0; // 数码超出定义范围，全亮。
    endcase

endmodule
