/*************************** 数据处理 ***************************/
/* 输入：	Q1			计数器1计数结果
/*     	Q2			计数器2计数结果
/*			Q3			计数器3计数结果
/*			Q4			计数器4计数结果
/*			SEL		选择输出的结果：
/*							频率（K1,K2不按）
/*							占空比（K1按下）
/*							相位差（K2按下）
/* 输出：	DATA 		处理后的结果
/***************************************************************/
module process (Q1, Q2, Q3, Q4, SEL, DATA);
	
	input [31:0] Q1, Q2, Q3, Q4;
	input [1:0] SEL;
	output DATA[31:0];
	reg [31:0] DATA;
	wire [31:0] PL, ZKB, XWC;
	
	always@(SEL)
	case(SEL)
		3 : DATA <= PL;
		1 : DATA <= ZKB;
		2 : DATA <= XWC;
		default : DATA <= 0;
	endcase
	
	assign PL = (100_000_000 * Q2) / Q1;			//计算频率，单位Hz 
	assign ZKB = (Q3 * 100) / Q1;					//计算占空比 显示格式：XXXX 为 XX.X％
	assign XWC = (180 * Q4) / Q3;						//计算相位差 单位Hz	
	
endmodule
