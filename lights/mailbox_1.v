//Legal Notice: (C)2014 Altera Corporation. All rights reserved.  Your
//use of Altera Corporation's design tools, logic functions and other
//software and tools, and its AMPP partner logic functions, and any
//output files any of the foregoing (including device programming or
//simulation files), and any associated documentation or information are
//expressly subject to the terms and conditions of the Altera Program
//License Subscription Agreement or other applicable license agreement,
//including, without limitation, that your use is for the sole purpose
//of programming logic devices manufactured by Altera and sold by Altera
//or its authorized distributors.  Please refer to the applicable
//agreement for further details.

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module mailbox_1 (
                   // inputs:
                    address,
                    chipselect,
                    clk,
                    data_from_cpu,
                    read,
                    reset_n,
                    write,

                   // outputs:
                    data_to_cpu
                 )
;

  output  [ 31: 0] data_to_cpu;
  input   [  1: 0] address;
  input            chipselect;
  input            clk;
  input   [ 31: 0] data_from_cpu;
  input            read;
  input            reset_n;
  input            write;

  wire    [ 31: 0] data_to_cpu;
  reg     [ 31: 0] mutex0;
  reg     [ 31: 0] mutex1;
  wire             mutex_free0;
  wire             mutex_free1;
  wire             mutex_own0;
  wire             mutex_own1;
  wire             mutex_write_enable0;
  wire             mutex_write_enable1;
  reg              reset_reg0;
  reg              reset_reg1;
  wire             reset_write_enable0;
  wire             reset_write_enable1;
  wire             select_mutex0;
  wire             select_mutex1;
  wire             select_reset_reg0;
  wire             select_reset_reg1;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          mutex0 <= 32'b0;
      else if (mutex_write_enable0)
          mutex0 <= data_from_cpu;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          mutex1 <= 32'b0;
      else if (mutex_write_enable1)
          mutex1 <= data_from_cpu;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          reset_reg0 <= 1'b1;
      else if (reset_write_enable0)
          reset_reg0 <= 1'b0;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          reset_reg1 <= 1'b1;
      else if (reset_write_enable1)
          reset_reg1 <= 1'b0;
    end


  assign mutex_free0 = mutex0[15 : 0] == 0;
  assign mutex_free1 = mutex1[15 : 0] == 0;
  assign mutex_own0 = mutex0[31 : 16] == data_from_cpu[31 : 16];
  assign mutex_own1 = mutex1[31 : 16] == data_from_cpu[31 : 16];
  assign select_mutex0 = chipselect & (address == 0);
  assign select_mutex1 = chipselect & (address == 2);
  assign select_reset_reg0 = chipselect & (address == 1);
  assign select_reset_reg1 = chipselect & (address == 3);
  assign mutex_write_enable0 = (mutex_free0 | mutex_own0) & select_mutex0 & write;
  assign mutex_write_enable1 = (mutex_free1 | mutex_own1) & select_mutex1 & write;
  assign reset_write_enable0 = chipselect & write & select_reset_reg0;
  assign reset_write_enable1 = chipselect & write & select_reset_reg1;
  assign data_to_cpu = select_mutex0     ? mutex0 : 
    select_mutex1     ? mutex1 : 
    select_reset_reg0 ? reset_reg0 : 
    reset_reg1;

  //s1, which is an e_avalon_slave

endmodule

