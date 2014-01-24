module lights (
   //50 MHz clock
	input CLOCK_50,
	//4 blue buttons
	input [3:0] KEY,
	//18 black switches
	input [17:0] SW,
	
	//8 7-segment LEDs
	output[6:0] HEX0,
	output[6:0] HEX1,
	output[6:0] HEX2,
	output[6:0] HEX3,
	output[6:0] HEX4,
	output[6:0] HEX5,
	output[6:0] HEX6,
	output[6:0] HEX7,
	
	//9 green LEDs
	output[8:0] LEDG,
	
	//18 red LEDs
	output[17:0] LEDR,
	
	//DRAM interface signals
	inout [15:0] DRAM_DQ,
	output [11:0] DRAM_ADDR,
	output DRAM_LDQM,
	output DRAM_UDQM,
	output DRAM_WE_N,
	output DRAM_CAS_N,
	output DRAM_RAS_N,
	output DRAM_CS_N,
	output DRAM_BA_0,
	output DRAM_BA_1,
	output DRAM_CLK,
	output DRAM_CKE,
	
	//LCD interface signals
	inout [7:0] LCD_DATA,
	output LCD_ON,
	output LCD_BLON,
	output LCD_RW,
	output LCD_EN,
	output LCD_RS);
	
	wire clk_0;
	wire [2:0] in_port_to_the_keys;
	wire [25:0] out_port_from_the_leds;
	wire reset_n;
	wire sdram_clk;
	wire sys_clk;
	
	assign LCD_ON = 1'b1;
	assign LCD_BLON = 1'b1;
	assign LEDR = out_port_from_the_leds[25:8];
	assign LEDG = out_port_from_the_leds[7:0];
	assign DRAM_CLK = sdram_clk;
	
	assign clk_0 = CLOCK_50;
	assign reset_n = KEY[0];
	assign in_port_to_the_keys = KEY[3:1];
	
nios_system DUT(

	.out_port_from_the_HEX0(HEX0),
	.out_port_from_the_HEX1(HEX1),
	.out_port_from_the_HEX2(HEX2),
	.out_port_from_the_HEX3(HEX3),
	.out_port_from_the_HEX4(HEX4),
	.out_port_from_the_HEX5(HEX5),
	.out_port_from_the_HEX6(HEX6),
	.out_port_from_the_HEX7(HEX7),
	
	.LCD_E_from_the_lcd_0 (LCD_EN),
	.LCD_RS_from_the_lcd_0 (LCD_RS),
	.LCD_RW_from_the_lcd_0 (LCD_RW),
	.LCD_data_to_and_from_the_lcd_0 (LCD_DATA),
	.clk_0 (clk_0),
	.in_port_to_the_keys (in_port_to_the_keys),
	.out_port_from_the_leds (out_port_from_the_leds),
	.reset_n (reset_n),
	.sdram_clk (sdram_clk),
	.sys_clk (sys_clk),
	.zs_addr_from_the_sdram_0 (DRAM_ADDR),
	.zs_ba_from_the_sdram_0 ({DRAM_BA_1, DRAM_BA_0}),
	.zs_cas_n_from_the_sdram_0 (DRAM_CAS_N),
	.zs_cke_from_the_sdram_0 (DRAM_CKE),
	.zs_cs_n_from_the_sdram_0 (DRAM_CS_N),
	.zs_dq_to_and_from_the_sdram_0 (DRAM_DQ),
	.zs_dqm_from_the_sdram_0 ({DRAM_UDQM, DRAM_LDQM}),
	.zs_ras_n_from_the_sdram_0 (DRAM_RAS_N),
	.zs_we_n_from_the_sdram_0 (DRAM_WE_N)
);
endmodule