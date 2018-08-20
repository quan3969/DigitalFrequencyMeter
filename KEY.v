/*************************** 按键控制 ***************************/
/* 输入：	CLK		输入50MHz时钟
/*			K			按键接入
/* 输出：	EN			输出控制	
/***************************************************************/
module KEY (CLK, nCLR, KEY, EN);

	input CLK, KEY, nCLR;
	output EN;
	wire EN;
	reg key_rst;
 
	always @(posedge CLK or negedge nCLR)
	begin
		if(nCLR == 0)
			key_rst <= 0;
		else
			key_rst <= KEY; 							//读取当前时刻的按键值
	end
 
	reg key_rst_r;
 
	always @(posedge CLK or negedge nCLR)
	begin
		if(nCLR == 0)
			key_rst_r <= 0;
	else
			key_rst_r <= key_rst;  					//将上一时刻的按键值进行存储
	end
 
	wire key_an = key_rst_r & (~key_rst); 		//当键值从0到1时key_an改变
 
	reg [19:0] cnt; 									//延时用计数器
 
	always @(posedge CLK or negedge nCLR)
	begin
		if(nCLR == 0)
			cnt <= 0;
		else if(key_an)
			cnt <= 0;
		else
			cnt <= cnt + 1;
	end
 
	reg key_value;
 
	always @(posedge CLK or negedge nCLR)
	begin
		if(nCLR == 0)
			key_value <= 0;
		else if(cnt == 20'hfffff) 					//2^20*1/(50MHZ)=20ms
			key_value <= KEY; 						//去抖20ms后读取当前时刻的按键值
	end
 
	reg key_value_r;
 
	always @(posedge CLK or negedge nCLR)
	begin
		if(nCLR == 0)
			key_value_r <= 0;
		else
			key_value_r <= key_value; 				//将去抖前一时刻的按键值进行存储
	end
 
	wire key_ctrl = key_value_r &(~key_value);//当键值从0到1时key_ctrl改变
 
	reg d1;

	always @(posedge  CLK or negedge nCLR)
	begin
		if(nCLR == 0)
		begin 
			d1 <= 1; 
		end
	else
		begin
			if(key_ctrl) d1 <= ~d1;
		end
	end
 
	assign EN = d1? 0:1; 							//此处只是为了将LED输出进行翻转
															//RTL级与下面注释代码无差别
endmodule
