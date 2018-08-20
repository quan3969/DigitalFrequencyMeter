/*************************** D触发器 ***************************/
/* 输入：	CLK		输入时钟
/*			D			输入控制
/*       TCLK		被测信号
/*			nCLR		异步清零，低电平复位
/* 输出：	EN			计数使能	
/***************************************************************/
module DFF1 (CLK, D, nCLR, EN);

	input CLK, D, nCLR;
	output EN;
	reg EN;
	
	always@(posedge CLK or negedge nCLR)
	begin 
		if(nCLR == 0)
			begin EN <= 0; end
		else if(D == 1)
			begin EN <= 1; end				
		else if(D == 0)			
			begin EN = 0; end		
	end	
	
endmodule
	