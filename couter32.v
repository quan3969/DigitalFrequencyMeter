/************************** 32位计数器 **************************/
/* 输入：	CLK		计数时钟
/*       EN			计数使能
/*			nCLR		异步清零，低电平清零
/* 输出：	DOUT 		输出计数结果
/***************************************************************/
module couter32 (CLK, EN, nCLR, DOUT);

	input CLK, EN, nCLR;
	output DOUT[31:0];
	reg [31:0] DOUT;
	
	always@(posedge CLK or negedge nCLR)
	begin
		if(nCLR == 0)
			begin DOUT = 0; end
		else if(EN == 1)
			begin DOUT = DOUT + 1; end
	end
	
endmodule
