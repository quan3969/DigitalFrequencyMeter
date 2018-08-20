/*************************** 显示模块 ***************************/
/* 输入：	CLK		输入时钟 50MHz
/*			SEL		选择显示高位低位
/*			DIN		输入要显示的数据
/* 输出：	LED 		输出到数码管
/* 		TURN		数码管轮转显示
/***************************************************************/

module SMG (DIN, CLK, SEL, LED, TURN);

	input [31:0] DIN;
	input CLK, SEL;
	output [7:0] LED;
	output [3:0] TURN;
	reg ACLK;
	reg [3:0] data, TURN;
	reg [7:0] LED;
	reg [1:0] trn;
	reg [15:0] temp;
	
	always@(posedge CLK)									//将50MHz分频1KHz
	begin														//用于数码管刷新
		if(temp == 50_000)
			begin temp = 0; ACLK = 1; end
		else
			begin temp = temp + 1; ACLK = 0; end
	end
	
	always@(posedge ACLK)
	begin
		if(trn == 3)
			begin trn <= 0; end
		else
			begin trn = trn + 1; end;
	end
	
	always@(trn)											//用于控制四个数码管暗灭
	case(trn)
		0 : TURN <= 4'B0111;
		1 : TURN <= 4'B1011;
		2 : TURN <= 4'B1101;
		3 : TURN <= 4'B1110;
		default : TURN <= 4'B1111;
	endcase
	
	always@(SEL, trn)										//按键选择输出
	case(SEL)
		0 : case(trn)										//按键按下：显示高位
				0 : data <= DIN[31:28];
				1 : data <= DIN[27:24];
				2 : data <= DIN[23:20];
				3 : data <= DIN[19:16];
				default : data <= 0;
				endcase
		1 : case(trn)										//按键抬起：显示低位
				0 : data <= DIN[15:12];
				1 : data <= DIN[11:8];
				2 : data <= DIN[7:4];
				3 : data <= DIN[3:0];
				default : data <= 0;
				endcase
	endcase

	always@(data)											//共阳数码管
	case(data)
		4'b0000 : LED = 8'hc0;							//0
		4'b0001 : LED = 8'hf9;							//1
		4'b0010 : LED = 8'ha4;							//2
		4'b0011 : LED = 8'hb0;							//3
		4'b0100 : LED = 8'h99;							//4
		4'b0101 : LED = 8'h92;							//5
		4'b0110 : LED = 8'h82;							//6
		4'b0111 : LED = 8'hf8;							//7
		4'b1000 : LED = 8'h80;							//8
		4'b1001 : LED = 8'h90;							//9
		4'b1010 : LED = 8'h88;							//A
		4'b1011 : LED = 8'h83;							//B
		4'b1100 : LED = 8'hc6;							//C
		4'b1101 : LED = 8'ha1;							//D
		4'b1110 : LED = 8'h86;							//E
		4'b1111 : LED = 8'h8e;							//F
		default:LED = 8'hff;
		endcase

endmodule
