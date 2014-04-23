module lights (
   //50 MHz clock
	input CLOCK_50,
	//4 blue buttons
	input [3:0] KEY,
	
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

	//////////////////////// VGA ////////////////////////////
	output VGA_CLK,//VGA Clock
	output VGA_HS,//VGA H_SYNC
	output VGA_VS,//VGA V_SYNC
	output VGA_BLANK,//VGA BLANK
	output VGA_SYNC,//VGA SYNC
	output [9:0] VGA_R,//VGA Red[9:0]
	output [9:0] VGA_G,//VGA Green[9:0]
	output [9:0] VGA_B//VGA Blue[9:0]
	);
	
	////////////////////// PREVIOUS MATERIAL //////////////////////
	wire clk_0;
	wire [2:0] in_port_to_the_keys;
	//wire [25:0] out_port_from_the_leds;
	wire reset_n;
	wire sdram_clk;
	wire sys_clk;
	
	//LAB2
	assign FL_RST_N = 1'b1;
	
	//LAB1
	assign DRAM_CLK = sdram_clk;
	
	//assigns the clock to 50MHz
	assign clk_0 = CLOCK_50;
	assign reset_n = KEY[0];
	assign in_port_to_the_keys = KEY[3:1];
	
nios_system DUT(

	//NEW ADDITIONS FOR LAB2

	.VGA_BLANK_from_the_video_vga_controller_0 (VGA_BLANK),
	.VGA_B_from_the_video_vga_controller_0 (VGA_B),
	.VGA_CLK_from_the_video_vga_controller_0 (VGA_CLK),
	.VGA_G_from_the_video_vga_controller_0 (VGA_G),
	.VGA_HS_from_the_video_vga_controller_0 (VGA_HS),
	.VGA_R_from_the_video_vga_controller_0 (VGA_R),
	.VGA_SYNC_from_the_video_vga_controller_0 (VGA_SYNC),
	.VGA_VS_from_the_video_vga_controller_0 (VGA_VS),

	.clk_0 (clk_0),
	.in_port_to_the_keys (in_port_to_the_keys),
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