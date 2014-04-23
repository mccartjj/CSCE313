/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'cpu_2' in SOPC Builder design 'nios_system'
 * SOPC Builder design path: ../../nios_system.sopcinfo
 *
 * Generated: Wed Apr 23 18:35:27 EDT 2014
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x1820
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 2
#define ALT_CPU_CPU_ID_VALUE 0x2
#define ALT_CPU_CPU_IMPLEMENTATION "fast"
#define ALT_CPU_DATA_ADDR_WIDTH 0x19
#define ALT_CPU_DCACHE_LINE_SIZE 32
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_DCACHE_SIZE 1024
#define ALT_CPU_EXCEPTION_ADDR 0xd00020
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 50000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 1
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 1
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 32
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_ICACHE_SIZE 4096
#define ALT_CPU_INITDA_SUPPORTED
#define ALT_CPU_INST_ADDR_WIDTH 0x18
#define ALT_CPU_NAME "cpu_2"
#define ALT_CPU_NUM_OF_SHADOW_REG_SETS 0
#define ALT_CPU_RESET_ADDR 0xd00000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x1820
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 2
#define NIOS2_CPU_ID_VALUE 0x2
#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_DATA_ADDR_WIDTH 0x19
#define NIOS2_DCACHE_LINE_SIZE 32
#define NIOS2_DCACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_SIZE 1024
#define NIOS2_EXCEPTION_ADDR 0xd00020
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 1
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 1
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 32
#define NIOS2_ICACHE_LINE_SIZE_LOG2 5
#define NIOS2_ICACHE_SIZE 4096
#define NIOS2_INITDA_SUPPORTED
#define NIOS2_INST_ADDR_WIDTH 0x18
#define NIOS2_NUM_OF_SHADOW_REG_SETS 0
#define NIOS2_RESET_ADDR 0xd00000


/*
 * Custom instruction macros
 *
 */

#define ALT_CI_ALTERA_NIOS_CUSTOM_INSTR_FLOATING_POINT_INST(n,A,B) __builtin_custom_inii(ALT_CI_ALTERA_NIOS_CUSTOM_INSTR_FLOATING_POINT_INST_N+(n&ALT_CI_ALTERA_NIOS_CUSTOM_INSTR_FLOATING_POINT_INST_N_MASK),(A),(B))
#define ALT_CI_ALTERA_NIOS_CUSTOM_INSTR_FLOATING_POINT_INST_N 0xfc
#define ALT_CI_ALTERA_NIOS_CUSTOM_INSTR_FLOATING_POINT_INST_N_MASK ((1<<2)-1)


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_MAILBOX
#define __ALTERA_AVALON_NEW_SDRAM_CONTROLLER
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PERFORMANCE_COUNTER
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SYSID
#define __ALTERA_NIOS2
#define __ALTERA_NIOS_CUSTOM_INSTR_FLOATING_POINT
#define __ALTERA_UP_AVALON_CLOCKS
#define __ALTERA_UP_AVALON_VIDEO_PIXEL_BUFFER_DMA


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "CYCLONEII"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart_2"
#define ALT_STDERR_BASE 0x68
#define ALT_STDERR_DEV jtag_uart_2
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart_2"
#define ALT_STDIN_BASE 0x68
#define ALT_STDIN_DEV jtag_uart_2
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart_2"
#define ALT_STDOUT_BASE 0x68
#define ALT_STDOUT_DEV jtag_uart_2
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "nios_system"


/*
 * clocks_0 configuration
 *
 */

#define ALT_MODULE_CLASS_clocks_0 altera_up_avalon_clocks
#define CLOCKS_0_BASE 0x19030d8
#define CLOCKS_0_IRQ -1
#define CLOCKS_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CLOCKS_0_NAME "/dev/clocks_0"
#define CLOCKS_0_SPAN 2
#define CLOCKS_0_TYPE "altera_up_avalon_clocks"


/*
 * hal configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none


/*
 * jtag_uart_2 configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart_2 altera_avalon_jtag_uart
#define JTAG_UART_2_BASE 0x68
#define JTAG_UART_2_IRQ 1
#define JTAG_UART_2_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_2_NAME "/dev/jtag_uart_2"
#define JTAG_UART_2_READ_DEPTH 64
#define JTAG_UART_2_READ_THRESHOLD 8
#define JTAG_UART_2_SPAN 8
#define JTAG_UART_2_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_2_WRITE_DEPTH 64
#define JTAG_UART_2_WRITE_THRESHOLD 8


/*
 * keys configuration
 *
 */

#define ALT_MODULE_CLASS_keys altera_avalon_pio
#define KEYS_BASE 0x1903010
#define KEYS_BIT_CLEARING_EDGE_REGISTER 0
#define KEYS_BIT_MODIFYING_OUTPUT_REGISTER 0
#define KEYS_CAPTURE 1
#define KEYS_DATA_WIDTH 3
#define KEYS_DO_TEST_BENCH_WIRING 0
#define KEYS_DRIVEN_SIM_VALUE 0x0
#define KEYS_EDGE_TYPE "RISING"
#define KEYS_FREQ 50000000u
#define KEYS_HAS_IN 1
#define KEYS_HAS_OUT 0
#define KEYS_HAS_TRI 0
#define KEYS_IRQ -1
#define KEYS_IRQ_INTERRUPT_CONTROLLER_ID -1
#define KEYS_IRQ_TYPE "NONE"
#define KEYS_NAME "/dev/keys"
#define KEYS_RESET_VALUE 0x0
#define KEYS_SPAN 16
#define KEYS_TYPE "altera_avalon_pio"


/*
 * mailbox_0 configuration
 *
 */

#define ALT_MODULE_CLASS_mailbox_0 altera_avalon_mailbox
#define MAILBOX_0_BASE 0x40
#define MAILBOX_0_IRQ -1
#define MAILBOX_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define MAILBOX_0_MAILBOX_MEMORY_ADDR 0x3000
#define MAILBOX_0_MAILBOX_MEMORY_OFFSET 0u
#define MAILBOX_0_MAILBOX_MEMORY_SIZE 512u
#define MAILBOX_0_NAME "/dev/mailbox_0"
#define MAILBOX_0_SLAVE "onchip_memory2_0/s1"
#define MAILBOX_0_SPAN 16
#define MAILBOX_0_TYPE "altera_avalon_mailbox"


/*
 * mailbox_1 configuration
 *
 */

#define ALT_MODULE_CLASS_mailbox_1 altera_avalon_mailbox
#define MAILBOX_1_BASE 0x50
#define MAILBOX_1_IRQ -1
#define MAILBOX_1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define MAILBOX_1_MAILBOX_MEMORY_ADDR 0x4000
#define MAILBOX_1_MAILBOX_MEMORY_OFFSET 0u
#define MAILBOX_1_MAILBOX_MEMORY_SIZE 512u
#define MAILBOX_1_NAME "/dev/mailbox_1"
#define MAILBOX_1_SLAVE "onchip_memory2_1/s1"
#define MAILBOX_1_SPAN 16
#define MAILBOX_1_TYPE "altera_avalon_mailbox"


/*
 * mailbox_2 configuration
 *
 */

#define ALT_MODULE_CLASS_mailbox_2 altera_avalon_mailbox
#define MAILBOX_2_BASE 0x70
#define MAILBOX_2_IRQ -1
#define MAILBOX_2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define MAILBOX_2_MAILBOX_MEMORY_ADDR 0x6000
#define MAILBOX_2_MAILBOX_MEMORY_OFFSET 0u
#define MAILBOX_2_MAILBOX_MEMORY_SIZE 512u
#define MAILBOX_2_NAME "/dev/mailbox_2"
#define MAILBOX_2_SLAVE "onchip_memory2_2/s1"
#define MAILBOX_2_SPAN 16
#define MAILBOX_2_TYPE "altera_avalon_mailbox"


/*
 * mailbox_3 configuration
 *
 */

#define ALT_MODULE_CLASS_mailbox_3 altera_avalon_mailbox
#define MAILBOX_3_BASE 0x80
#define MAILBOX_3_IRQ -1
#define MAILBOX_3_IRQ_INTERRUPT_CONTROLLER_ID -1
#define MAILBOX_3_MAILBOX_MEMORY_ADDR 0x7000
#define MAILBOX_3_MAILBOX_MEMORY_OFFSET 0u
#define MAILBOX_3_MAILBOX_MEMORY_SIZE 512u
#define MAILBOX_3_NAME "/dev/mailbox_3"
#define MAILBOX_3_SLAVE "onchip_memory2_3/s1"
#define MAILBOX_3_SPAN 16
#define MAILBOX_3_TYPE "altera_avalon_mailbox"


/*
 * onchip_memory2_0 configuration
 *
 */

#define ALT_MODULE_CLASS_onchip_memory2_0 altera_avalon_onchip_memory2
#define ONCHIP_MEMORY2_0_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_MEMORY2_0_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_MEMORY2_0_BASE 0x3000
#define ONCHIP_MEMORY2_0_CONTENTS_INFO ""
#define ONCHIP_MEMORY2_0_DUAL_PORT 0
#define ONCHIP_MEMORY2_0_GUI_RAM_BLOCK_TYPE "Automatic"
#define ONCHIP_MEMORY2_0_INIT_CONTENTS_FILE "onchip_memory2_0"
#define ONCHIP_MEMORY2_0_INIT_MEM_CONTENT 1
#define ONCHIP_MEMORY2_0_INSTANCE_ID "NONE"
#define ONCHIP_MEMORY2_0_IRQ -1
#define ONCHIP_MEMORY2_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ONCHIP_MEMORY2_0_NAME "/dev/onchip_memory2_0"
#define ONCHIP_MEMORY2_0_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_MEMORY2_0_RAM_BLOCK_TYPE "Auto"
#define ONCHIP_MEMORY2_0_READ_DURING_WRITE_MODE "DONT_CARE"
#define ONCHIP_MEMORY2_0_SINGLE_CLOCK_OP 0
#define ONCHIP_MEMORY2_0_SIZE_MULTIPLE 1
#define ONCHIP_MEMORY2_0_SIZE_VALUE 512u
#define ONCHIP_MEMORY2_0_SPAN 512
#define ONCHIP_MEMORY2_0_TYPE "altera_avalon_onchip_memory2"
#define ONCHIP_MEMORY2_0_WRITABLE 1


/*
 * onchip_memory2_1 configuration
 *
 */

#define ALT_MODULE_CLASS_onchip_memory2_1 altera_avalon_onchip_memory2
#define ONCHIP_MEMORY2_1_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_MEMORY2_1_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_MEMORY2_1_BASE 0x4000
#define ONCHIP_MEMORY2_1_CONTENTS_INFO ""
#define ONCHIP_MEMORY2_1_DUAL_PORT 0
#define ONCHIP_MEMORY2_1_GUI_RAM_BLOCK_TYPE "Automatic"
#define ONCHIP_MEMORY2_1_INIT_CONTENTS_FILE "onchip_memory2_1"
#define ONCHIP_MEMORY2_1_INIT_MEM_CONTENT 1
#define ONCHIP_MEMORY2_1_INSTANCE_ID "NONE"
#define ONCHIP_MEMORY2_1_IRQ -1
#define ONCHIP_MEMORY2_1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ONCHIP_MEMORY2_1_NAME "/dev/onchip_memory2_1"
#define ONCHIP_MEMORY2_1_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_MEMORY2_1_RAM_BLOCK_TYPE "Auto"
#define ONCHIP_MEMORY2_1_READ_DURING_WRITE_MODE "DONT_CARE"
#define ONCHIP_MEMORY2_1_SINGLE_CLOCK_OP 0
#define ONCHIP_MEMORY2_1_SIZE_MULTIPLE 1
#define ONCHIP_MEMORY2_1_SIZE_VALUE 512u
#define ONCHIP_MEMORY2_1_SPAN 512
#define ONCHIP_MEMORY2_1_TYPE "altera_avalon_onchip_memory2"
#define ONCHIP_MEMORY2_1_WRITABLE 1


/*
 * onchip_memory2_2 configuration
 *
 */

#define ALT_MODULE_CLASS_onchip_memory2_2 altera_avalon_onchip_memory2
#define ONCHIP_MEMORY2_2_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_MEMORY2_2_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_MEMORY2_2_BASE 0x6000
#define ONCHIP_MEMORY2_2_CONTENTS_INFO ""
#define ONCHIP_MEMORY2_2_DUAL_PORT 0
#define ONCHIP_MEMORY2_2_GUI_RAM_BLOCK_TYPE "Automatic"
#define ONCHIP_MEMORY2_2_INIT_CONTENTS_FILE "onchip_memory2_2"
#define ONCHIP_MEMORY2_2_INIT_MEM_CONTENT 1
#define ONCHIP_MEMORY2_2_INSTANCE_ID "NONE"
#define ONCHIP_MEMORY2_2_IRQ -1
#define ONCHIP_MEMORY2_2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ONCHIP_MEMORY2_2_NAME "/dev/onchip_memory2_2"
#define ONCHIP_MEMORY2_2_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_MEMORY2_2_RAM_BLOCK_TYPE "Auto"
#define ONCHIP_MEMORY2_2_READ_DURING_WRITE_MODE "DONT_CARE"
#define ONCHIP_MEMORY2_2_SINGLE_CLOCK_OP 0
#define ONCHIP_MEMORY2_2_SIZE_MULTIPLE 1
#define ONCHIP_MEMORY2_2_SIZE_VALUE 512u
#define ONCHIP_MEMORY2_2_SPAN 512
#define ONCHIP_MEMORY2_2_TYPE "altera_avalon_onchip_memory2"
#define ONCHIP_MEMORY2_2_WRITABLE 1


/*
 * onchip_memory2_3 configuration
 *
 */

#define ALT_MODULE_CLASS_onchip_memory2_3 altera_avalon_onchip_memory2
#define ONCHIP_MEMORY2_3_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_MEMORY2_3_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_MEMORY2_3_BASE 0x7000
#define ONCHIP_MEMORY2_3_CONTENTS_INFO ""
#define ONCHIP_MEMORY2_3_DUAL_PORT 0
#define ONCHIP_MEMORY2_3_GUI_RAM_BLOCK_TYPE "Automatic"
#define ONCHIP_MEMORY2_3_INIT_CONTENTS_FILE "onchip_memory2_3"
#define ONCHIP_MEMORY2_3_INIT_MEM_CONTENT 1
#define ONCHIP_MEMORY2_3_INSTANCE_ID "NONE"
#define ONCHIP_MEMORY2_3_IRQ -1
#define ONCHIP_MEMORY2_3_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ONCHIP_MEMORY2_3_NAME "/dev/onchip_memory2_3"
#define ONCHIP_MEMORY2_3_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_MEMORY2_3_RAM_BLOCK_TYPE "Auto"
#define ONCHIP_MEMORY2_3_READ_DURING_WRITE_MODE "DONT_CARE"
#define ONCHIP_MEMORY2_3_SINGLE_CLOCK_OP 0
#define ONCHIP_MEMORY2_3_SIZE_MULTIPLE 1
#define ONCHIP_MEMORY2_3_SIZE_VALUE 512u
#define ONCHIP_MEMORY2_3_SPAN 512
#define ONCHIP_MEMORY2_3_TYPE "altera_avalon_onchip_memory2"
#define ONCHIP_MEMORY2_3_WRITABLE 1


/*
 * performance_counter_0 configuration
 *
 */

#define ALT_MODULE_CLASS_performance_counter_0 altera_avalon_performance_counter
#define PERFORMANCE_COUNTER_0_BASE 0x0
#define PERFORMANCE_COUNTER_0_HOW_MANY_SECTIONS 2
#define PERFORMANCE_COUNTER_0_IRQ -1
#define PERFORMANCE_COUNTER_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PERFORMANCE_COUNTER_0_NAME "/dev/performance_counter_0"
#define PERFORMANCE_COUNTER_0_SPAN 64
#define PERFORMANCE_COUNTER_0_TYPE "altera_avalon_performance_counter"


/*
 * sdram_0 configuration
 *
 */

#define ALT_MODULE_CLASS_sdram_0 altera_avalon_new_sdram_controller
#define SDRAM_0_BASE 0x800000
#define SDRAM_0_CAS_LATENCY 3
#define SDRAM_0_CONTENTS_INFO ""
#define SDRAM_0_INIT_NOP_DELAY 0.0
#define SDRAM_0_INIT_REFRESH_COMMANDS 2
#define SDRAM_0_IRQ -1
#define SDRAM_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SDRAM_0_IS_INITIALIZED 1
#define SDRAM_0_NAME "/dev/sdram_0"
#define SDRAM_0_POWERUP_DELAY 100.0
#define SDRAM_0_REFRESH_PERIOD 15.625
#define SDRAM_0_REGISTER_DATA_IN 1
#define SDRAM_0_SDRAM_ADDR_WIDTH 0x16
#define SDRAM_0_SDRAM_BANK_WIDTH 2
#define SDRAM_0_SDRAM_COL_WIDTH 8
#define SDRAM_0_SDRAM_DATA_WIDTH 16
#define SDRAM_0_SDRAM_NUM_BANKS 4
#define SDRAM_0_SDRAM_NUM_CHIPSELECTS 1
#define SDRAM_0_SDRAM_ROW_WIDTH 12
#define SDRAM_0_SHARED_DATA 0
#define SDRAM_0_SIM_MODEL_BASE 0
#define SDRAM_0_SPAN 8388608
#define SDRAM_0_STARVATION_INDICATOR 0
#define SDRAM_0_TRISTATE_BRIDGE_SLAVE ""
#define SDRAM_0_TYPE "altera_avalon_new_sdram_controller"
#define SDRAM_0_T_AC 5.5
#define SDRAM_0_T_MRD 3
#define SDRAM_0_T_RCD 20.0
#define SDRAM_0_T_RFC 70.0
#define SDRAM_0_T_RP 20.0
#define SDRAM_0_T_WR 14.0


/*
 * sysid configuration
 *
 */

#define ALT_MODULE_CLASS_sysid altera_avalon_sysid
#define SYSID_BASE 0x19030c0
#define SYSID_ID 0u
#define SYSID_IRQ -1
#define SYSID_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSID_NAME "/dev/sysid"
#define SYSID_SPAN 8
#define SYSID_TIMESTAMP 1398290119u
#define SYSID_TYPE "altera_avalon_sysid"


/*
 * video_pixel_buffer_dma_0 configuration
 *
 */

#define ALT_MODULE_CLASS_video_pixel_buffer_dma_0 altera_up_avalon_video_pixel_buffer_dma
#define VIDEO_PIXEL_BUFFER_DMA_0_BASE 0x19030b0
#define VIDEO_PIXEL_BUFFER_DMA_0_IRQ -1
#define VIDEO_PIXEL_BUFFER_DMA_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define VIDEO_PIXEL_BUFFER_DMA_0_NAME "/dev/video_pixel_buffer_dma_0"
#define VIDEO_PIXEL_BUFFER_DMA_0_SPAN 16
#define VIDEO_PIXEL_BUFFER_DMA_0_TYPE "altera_up_avalon_video_pixel_buffer_dma"

#endif /* __SYSTEM_H_ */
