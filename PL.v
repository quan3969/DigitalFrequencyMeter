/*************************** 控制装置 ***************************/
/* 输入：	CLK		100MHz
/* 输出：	CLK1		输出1Hz
/*			CLK2		输出1KHz
/*			CLK3		输出1MHz	占空比为 40%
/*			CLK4		输出1KHz	与 CLK2 相位差 36°
/****************************************************************/
module PL (CLK, CLK1, CLK2, CLK3, CLK4);
	input		CLK;
	output 	CLK1, CLK2, CLK3, CLK4;
	wire 		CLK1, CLK2,	CLK3,	CLK4;
	reg [31:0] temp1, temp2, temp3, temp4;
	
	always@(posedge CLK)								//生成CLK1
	begin
		if(temp1 == 99_999_999)
			begin temp1 <= 0; end
		else 
			begin temp1 <= temp1 + 1; end
	end
	assign CLK1 = (temp1 < 50_000_000)? 0 : 1;
	
	always@(posedge CLK)								//生成CLK2
	begin
		if(temp2 == 99_999)
			begin temp2 <= 0; end
		else 
			begin temp2 <= temp2 + 1; end
	end
	assign CLK2 = (temp2 < 50_000)? 0 : 1;
	
	always@(posedge CLK)								//生成CLK3
	begin
		if(temp3 == 99)
			begin temp3 <= 0; end
		else
			begin temp3 <= temp3 + 1; end
	end
	assign CLK3 = (temp3 < 60)? 0 : 1;
	
	always@(posedge CLK)								//生成CLK4
	begin
		if(temp4 == 99_999)
			begin temp4 <= 0; end
		else
			begin temp4 <= temp4 + 1; end
	end
	assign CLK4 = (temp4 >= 10_000 && temp4 < 60_000)? 0 : 1;
	
endmodule
