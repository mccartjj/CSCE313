//megafunction wizard: %Altera SOPC Builder%
//GENERATION: STANDARD
//VERSION: WM1.0


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

module HEX0_s1_arbitrator (
                            // inputs:
                             HEX0_s1_readdata,
                             clk,
                             cpu_0_data_master_address_to_slave,
                             cpu_0_data_master_latency_counter,
                             cpu_0_data_master_read,
                             cpu_0_data_master_write,
                             cpu_0_data_master_writedata,
                             reset_n,

                            // outputs:
                             HEX0_s1_address,
                             HEX0_s1_chipselect,
                             HEX0_s1_readdata_from_sa,
                             HEX0_s1_reset_n,
                             HEX0_s1_write_n,
                             HEX0_s1_writedata,
                             cpu_0_data_master_granted_HEX0_s1,
                             cpu_0_data_master_qualified_request_HEX0_s1,
                             cpu_0_data_master_read_data_valid_HEX0_s1,
                             cpu_0_data_master_requests_HEX0_s1,
                             d1_HEX0_s1_end_xfer
                          )
;

  output  [  1: 0] HEX0_s1_address;
  output           HEX0_s1_chipselect;
  output  [ 31: 0] HEX0_s1_readdata_from_sa;
  output           HEX0_s1_reset_n;
  output           HEX0_s1_write_n;
  output  [ 31: 0] HEX0_s1_writedata;
  output           cpu_0_data_master_granted_HEX0_s1;
  output           cpu_0_data_master_qualified_request_HEX0_s1;
  output           cpu_0_data_master_read_data_valid_HEX0_s1;
  output           cpu_0_data_master_requests_HEX0_s1;
  output           d1_HEX0_s1_end_xfer;
  input   [ 31: 0] HEX0_s1_readdata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] HEX0_s1_address;
  wire             HEX0_s1_allgrants;
  wire             HEX0_s1_allow_new_arb_cycle;
  wire             HEX0_s1_any_bursting_master_saved_grant;
  wire             HEX0_s1_any_continuerequest;
  wire             HEX0_s1_arb_counter_enable;
  reg     [  2: 0] HEX0_s1_arb_share_counter;
  wire    [  2: 0] HEX0_s1_arb_share_counter_next_value;
  wire    [  2: 0] HEX0_s1_arb_share_set_values;
  wire             HEX0_s1_beginbursttransfer_internal;
  wire             HEX0_s1_begins_xfer;
  wire             HEX0_s1_chipselect;
  wire             HEX0_s1_end_xfer;
  wire             HEX0_s1_firsttransfer;
  wire             HEX0_s1_grant_vector;
  wire             HEX0_s1_in_a_read_cycle;
  wire             HEX0_s1_in_a_write_cycle;
  wire             HEX0_s1_master_qreq_vector;
  wire             HEX0_s1_non_bursting_master_requests;
  wire    [ 31: 0] HEX0_s1_readdata_from_sa;
  reg              HEX0_s1_reg_firsttransfer;
  wire             HEX0_s1_reset_n;
  reg              HEX0_s1_slavearbiterlockenable;
  wire             HEX0_s1_slavearbiterlockenable2;
  wire             HEX0_s1_unreg_firsttransfer;
  wire             HEX0_s1_waits_for_read;
  wire             HEX0_s1_waits_for_write;
  wire             HEX0_s1_write_n;
  wire    [ 31: 0] HEX0_s1_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_HEX0_s1;
  wire             cpu_0_data_master_qualified_request_HEX0_s1;
  wire             cpu_0_data_master_read_data_valid_HEX0_s1;
  wire             cpu_0_data_master_requests_HEX0_s1;
  wire             cpu_0_data_master_saved_grant_HEX0_s1;
  reg              d1_HEX0_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_HEX0_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 24: 0] shifted_address_to_HEX0_s1_from_cpu_0_data_master;
  wire             wait_for_HEX0_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~HEX0_s1_end_xfer;
    end


  assign HEX0_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_HEX0_s1));
  //assign HEX0_s1_readdata_from_sa = HEX0_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign HEX0_s1_readdata_from_sa = HEX0_s1_readdata;

  assign cpu_0_data_master_requests_HEX0_s1 = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h0) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //HEX0_s1_arb_share_counter set values, which is an e_mux
  assign HEX0_s1_arb_share_set_values = 1;

  //HEX0_s1_non_bursting_master_requests mux, which is an e_mux
  assign HEX0_s1_non_bursting_master_requests = cpu_0_data_master_requests_HEX0_s1;

  //HEX0_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign HEX0_s1_any_bursting_master_saved_grant = 0;

  //HEX0_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign HEX0_s1_arb_share_counter_next_value = HEX0_s1_firsttransfer ? (HEX0_s1_arb_share_set_values - 1) : |HEX0_s1_arb_share_counter ? (HEX0_s1_arb_share_counter - 1) : 0;

  //HEX0_s1_allgrants all slave grants, which is an e_mux
  assign HEX0_s1_allgrants = |HEX0_s1_grant_vector;

  //HEX0_s1_end_xfer assignment, which is an e_assign
  assign HEX0_s1_end_xfer = ~(HEX0_s1_waits_for_read | HEX0_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_HEX0_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_HEX0_s1 = HEX0_s1_end_xfer & (~HEX0_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //HEX0_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign HEX0_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_HEX0_s1 & HEX0_s1_allgrants) | (end_xfer_arb_share_counter_term_HEX0_s1 & ~HEX0_s1_non_bursting_master_requests);

  //HEX0_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX0_s1_arb_share_counter <= 0;
      else if (HEX0_s1_arb_counter_enable)
          HEX0_s1_arb_share_counter <= HEX0_s1_arb_share_counter_next_value;
    end


  //HEX0_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX0_s1_slavearbiterlockenable <= 0;
      else if ((|HEX0_s1_master_qreq_vector & end_xfer_arb_share_counter_term_HEX0_s1) | (end_xfer_arb_share_counter_term_HEX0_s1 & ~HEX0_s1_non_bursting_master_requests))
          HEX0_s1_slavearbiterlockenable <= |HEX0_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master HEX0/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = HEX0_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //HEX0_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign HEX0_s1_slavearbiterlockenable2 = |HEX0_s1_arb_share_counter_next_value;

  //cpu_0/data_master HEX0/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = HEX0_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //HEX0_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign HEX0_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_HEX0_s1 = cpu_0_data_master_requests_HEX0_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_HEX0_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_HEX0_s1 = cpu_0_data_master_granted_HEX0_s1 & cpu_0_data_master_read & ~HEX0_s1_waits_for_read;

  //HEX0_s1_writedata mux, which is an e_mux
  assign HEX0_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_HEX0_s1 = cpu_0_data_master_qualified_request_HEX0_s1;

  //cpu_0/data_master saved-grant HEX0/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_HEX0_s1 = cpu_0_data_master_requests_HEX0_s1;

  //allow new arb cycle for HEX0/s1, which is an e_assign
  assign HEX0_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign HEX0_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign HEX0_s1_master_qreq_vector = 1;

  //HEX0_s1_reset_n assignment, which is an e_assign
  assign HEX0_s1_reset_n = reset_n;

  assign HEX0_s1_chipselect = cpu_0_data_master_granted_HEX0_s1;
  //HEX0_s1_firsttransfer first transaction, which is an e_assign
  assign HEX0_s1_firsttransfer = HEX0_s1_begins_xfer ? HEX0_s1_unreg_firsttransfer : HEX0_s1_reg_firsttransfer;

  //HEX0_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign HEX0_s1_unreg_firsttransfer = ~(HEX0_s1_slavearbiterlockenable & HEX0_s1_any_continuerequest);

  //HEX0_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX0_s1_reg_firsttransfer <= 1'b1;
      else if (HEX0_s1_begins_xfer)
          HEX0_s1_reg_firsttransfer <= HEX0_s1_unreg_firsttransfer;
    end


  //HEX0_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign HEX0_s1_beginbursttransfer_internal = HEX0_s1_begins_xfer;

  //~HEX0_s1_write_n assignment, which is an e_mux
  assign HEX0_s1_write_n = ~(cpu_0_data_master_granted_HEX0_s1 & cpu_0_data_master_write);

  assign shifted_address_to_HEX0_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //HEX0_s1_address mux, which is an e_mux
  assign HEX0_s1_address = shifted_address_to_HEX0_s1_from_cpu_0_data_master >> 2;

  //d1_HEX0_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_HEX0_s1_end_xfer <= 1;
      else 
        d1_HEX0_s1_end_xfer <= HEX0_s1_end_xfer;
    end


  //HEX0_s1_waits_for_read in a cycle, which is an e_mux
  assign HEX0_s1_waits_for_read = HEX0_s1_in_a_read_cycle & HEX0_s1_begins_xfer;

  //HEX0_s1_in_a_read_cycle assignment, which is an e_assign
  assign HEX0_s1_in_a_read_cycle = cpu_0_data_master_granted_HEX0_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = HEX0_s1_in_a_read_cycle;

  //HEX0_s1_waits_for_write in a cycle, which is an e_mux
  assign HEX0_s1_waits_for_write = HEX0_s1_in_a_write_cycle & 0;

  //HEX0_s1_in_a_write_cycle assignment, which is an e_assign
  assign HEX0_s1_in_a_write_cycle = cpu_0_data_master_granted_HEX0_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = HEX0_s1_in_a_write_cycle;

  assign wait_for_HEX0_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //HEX0/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module HEX1_s1_arbitrator (
                            // inputs:
                             HEX1_s1_readdata,
                             clk,
                             cpu_0_data_master_address_to_slave,
                             cpu_0_data_master_latency_counter,
                             cpu_0_data_master_read,
                             cpu_0_data_master_write,
                             cpu_0_data_master_writedata,
                             reset_n,

                            // outputs:
                             HEX1_s1_address,
                             HEX1_s1_chipselect,
                             HEX1_s1_readdata_from_sa,
                             HEX1_s1_reset_n,
                             HEX1_s1_write_n,
                             HEX1_s1_writedata,
                             cpu_0_data_master_granted_HEX1_s1,
                             cpu_0_data_master_qualified_request_HEX1_s1,
                             cpu_0_data_master_read_data_valid_HEX1_s1,
                             cpu_0_data_master_requests_HEX1_s1,
                             d1_HEX1_s1_end_xfer
                          )
;

  output  [  1: 0] HEX1_s1_address;
  output           HEX1_s1_chipselect;
  output  [ 31: 0] HEX1_s1_readdata_from_sa;
  output           HEX1_s1_reset_n;
  output           HEX1_s1_write_n;
  output  [ 31: 0] HEX1_s1_writedata;
  output           cpu_0_data_master_granted_HEX1_s1;
  output           cpu_0_data_master_qualified_request_HEX1_s1;
  output           cpu_0_data_master_read_data_valid_HEX1_s1;
  output           cpu_0_data_master_requests_HEX1_s1;
  output           d1_HEX1_s1_end_xfer;
  input   [ 31: 0] HEX1_s1_readdata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] HEX1_s1_address;
  wire             HEX1_s1_allgrants;
  wire             HEX1_s1_allow_new_arb_cycle;
  wire             HEX1_s1_any_bursting_master_saved_grant;
  wire             HEX1_s1_any_continuerequest;
  wire             HEX1_s1_arb_counter_enable;
  reg     [  2: 0] HEX1_s1_arb_share_counter;
  wire    [  2: 0] HEX1_s1_arb_share_counter_next_value;
  wire    [  2: 0] HEX1_s1_arb_share_set_values;
  wire             HEX1_s1_beginbursttransfer_internal;
  wire             HEX1_s1_begins_xfer;
  wire             HEX1_s1_chipselect;
  wire             HEX1_s1_end_xfer;
  wire             HEX1_s1_firsttransfer;
  wire             HEX1_s1_grant_vector;
  wire             HEX1_s1_in_a_read_cycle;
  wire             HEX1_s1_in_a_write_cycle;
  wire             HEX1_s1_master_qreq_vector;
  wire             HEX1_s1_non_bursting_master_requests;
  wire    [ 31: 0] HEX1_s1_readdata_from_sa;
  reg              HEX1_s1_reg_firsttransfer;
  wire             HEX1_s1_reset_n;
  reg              HEX1_s1_slavearbiterlockenable;
  wire             HEX1_s1_slavearbiterlockenable2;
  wire             HEX1_s1_unreg_firsttransfer;
  wire             HEX1_s1_waits_for_read;
  wire             HEX1_s1_waits_for_write;
  wire             HEX1_s1_write_n;
  wire    [ 31: 0] HEX1_s1_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_HEX1_s1;
  wire             cpu_0_data_master_qualified_request_HEX1_s1;
  wire             cpu_0_data_master_read_data_valid_HEX1_s1;
  wire             cpu_0_data_master_requests_HEX1_s1;
  wire             cpu_0_data_master_saved_grant_HEX1_s1;
  reg              d1_HEX1_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_HEX1_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 24: 0] shifted_address_to_HEX1_s1_from_cpu_0_data_master;
  wire             wait_for_HEX1_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~HEX1_s1_end_xfer;
    end


  assign HEX1_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_HEX1_s1));
  //assign HEX1_s1_readdata_from_sa = HEX1_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign HEX1_s1_readdata_from_sa = HEX1_s1_readdata;

  assign cpu_0_data_master_requests_HEX1_s1 = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h10) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //HEX1_s1_arb_share_counter set values, which is an e_mux
  assign HEX1_s1_arb_share_set_values = 1;

  //HEX1_s1_non_bursting_master_requests mux, which is an e_mux
  assign HEX1_s1_non_bursting_master_requests = cpu_0_data_master_requests_HEX1_s1;

  //HEX1_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign HEX1_s1_any_bursting_master_saved_grant = 0;

  //HEX1_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign HEX1_s1_arb_share_counter_next_value = HEX1_s1_firsttransfer ? (HEX1_s1_arb_share_set_values - 1) : |HEX1_s1_arb_share_counter ? (HEX1_s1_arb_share_counter - 1) : 0;

  //HEX1_s1_allgrants all slave grants, which is an e_mux
  assign HEX1_s1_allgrants = |HEX1_s1_grant_vector;

  //HEX1_s1_end_xfer assignment, which is an e_assign
  assign HEX1_s1_end_xfer = ~(HEX1_s1_waits_for_read | HEX1_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_HEX1_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_HEX1_s1 = HEX1_s1_end_xfer & (~HEX1_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //HEX1_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign HEX1_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_HEX1_s1 & HEX1_s1_allgrants) | (end_xfer_arb_share_counter_term_HEX1_s1 & ~HEX1_s1_non_bursting_master_requests);

  //HEX1_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX1_s1_arb_share_counter <= 0;
      else if (HEX1_s1_arb_counter_enable)
          HEX1_s1_arb_share_counter <= HEX1_s1_arb_share_counter_next_value;
    end


  //HEX1_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX1_s1_slavearbiterlockenable <= 0;
      else if ((|HEX1_s1_master_qreq_vector & end_xfer_arb_share_counter_term_HEX1_s1) | (end_xfer_arb_share_counter_term_HEX1_s1 & ~HEX1_s1_non_bursting_master_requests))
          HEX1_s1_slavearbiterlockenable <= |HEX1_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master HEX1/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = HEX1_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //HEX1_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign HEX1_s1_slavearbiterlockenable2 = |HEX1_s1_arb_share_counter_next_value;

  //cpu_0/data_master HEX1/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = HEX1_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //HEX1_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign HEX1_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_HEX1_s1 = cpu_0_data_master_requests_HEX1_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_HEX1_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_HEX1_s1 = cpu_0_data_master_granted_HEX1_s1 & cpu_0_data_master_read & ~HEX1_s1_waits_for_read;

  //HEX1_s1_writedata mux, which is an e_mux
  assign HEX1_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_HEX1_s1 = cpu_0_data_master_qualified_request_HEX1_s1;

  //cpu_0/data_master saved-grant HEX1/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_HEX1_s1 = cpu_0_data_master_requests_HEX1_s1;

  //allow new arb cycle for HEX1/s1, which is an e_assign
  assign HEX1_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign HEX1_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign HEX1_s1_master_qreq_vector = 1;

  //HEX1_s1_reset_n assignment, which is an e_assign
  assign HEX1_s1_reset_n = reset_n;

  assign HEX1_s1_chipselect = cpu_0_data_master_granted_HEX1_s1;
  //HEX1_s1_firsttransfer first transaction, which is an e_assign
  assign HEX1_s1_firsttransfer = HEX1_s1_begins_xfer ? HEX1_s1_unreg_firsttransfer : HEX1_s1_reg_firsttransfer;

  //HEX1_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign HEX1_s1_unreg_firsttransfer = ~(HEX1_s1_slavearbiterlockenable & HEX1_s1_any_continuerequest);

  //HEX1_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX1_s1_reg_firsttransfer <= 1'b1;
      else if (HEX1_s1_begins_xfer)
          HEX1_s1_reg_firsttransfer <= HEX1_s1_unreg_firsttransfer;
    end


  //HEX1_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign HEX1_s1_beginbursttransfer_internal = HEX1_s1_begins_xfer;

  //~HEX1_s1_write_n assignment, which is an e_mux
  assign HEX1_s1_write_n = ~(cpu_0_data_master_granted_HEX1_s1 & cpu_0_data_master_write);

  assign shifted_address_to_HEX1_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //HEX1_s1_address mux, which is an e_mux
  assign HEX1_s1_address = shifted_address_to_HEX1_s1_from_cpu_0_data_master >> 2;

  //d1_HEX1_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_HEX1_s1_end_xfer <= 1;
      else 
        d1_HEX1_s1_end_xfer <= HEX1_s1_end_xfer;
    end


  //HEX1_s1_waits_for_read in a cycle, which is an e_mux
  assign HEX1_s1_waits_for_read = HEX1_s1_in_a_read_cycle & HEX1_s1_begins_xfer;

  //HEX1_s1_in_a_read_cycle assignment, which is an e_assign
  assign HEX1_s1_in_a_read_cycle = cpu_0_data_master_granted_HEX1_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = HEX1_s1_in_a_read_cycle;

  //HEX1_s1_waits_for_write in a cycle, which is an e_mux
  assign HEX1_s1_waits_for_write = HEX1_s1_in_a_write_cycle & 0;

  //HEX1_s1_in_a_write_cycle assignment, which is an e_assign
  assign HEX1_s1_in_a_write_cycle = cpu_0_data_master_granted_HEX1_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = HEX1_s1_in_a_write_cycle;

  assign wait_for_HEX1_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //HEX1/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module HEX2_s1_arbitrator (
                            // inputs:
                             HEX2_s1_readdata,
                             clk,
                             cpu_0_data_master_address_to_slave,
                             cpu_0_data_master_latency_counter,
                             cpu_0_data_master_read,
                             cpu_0_data_master_write,
                             cpu_0_data_master_writedata,
                             reset_n,

                            // outputs:
                             HEX2_s1_address,
                             HEX2_s1_chipselect,
                             HEX2_s1_readdata_from_sa,
                             HEX2_s1_reset_n,
                             HEX2_s1_write_n,
                             HEX2_s1_writedata,
                             cpu_0_data_master_granted_HEX2_s1,
                             cpu_0_data_master_qualified_request_HEX2_s1,
                             cpu_0_data_master_read_data_valid_HEX2_s1,
                             cpu_0_data_master_requests_HEX2_s1,
                             d1_HEX2_s1_end_xfer
                          )
;

  output  [  1: 0] HEX2_s1_address;
  output           HEX2_s1_chipselect;
  output  [ 31: 0] HEX2_s1_readdata_from_sa;
  output           HEX2_s1_reset_n;
  output           HEX2_s1_write_n;
  output  [ 31: 0] HEX2_s1_writedata;
  output           cpu_0_data_master_granted_HEX2_s1;
  output           cpu_0_data_master_qualified_request_HEX2_s1;
  output           cpu_0_data_master_read_data_valid_HEX2_s1;
  output           cpu_0_data_master_requests_HEX2_s1;
  output           d1_HEX2_s1_end_xfer;
  input   [ 31: 0] HEX2_s1_readdata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] HEX2_s1_address;
  wire             HEX2_s1_allgrants;
  wire             HEX2_s1_allow_new_arb_cycle;
  wire             HEX2_s1_any_bursting_master_saved_grant;
  wire             HEX2_s1_any_continuerequest;
  wire             HEX2_s1_arb_counter_enable;
  reg     [  2: 0] HEX2_s1_arb_share_counter;
  wire    [  2: 0] HEX2_s1_arb_share_counter_next_value;
  wire    [  2: 0] HEX2_s1_arb_share_set_values;
  wire             HEX2_s1_beginbursttransfer_internal;
  wire             HEX2_s1_begins_xfer;
  wire             HEX2_s1_chipselect;
  wire             HEX2_s1_end_xfer;
  wire             HEX2_s1_firsttransfer;
  wire             HEX2_s1_grant_vector;
  wire             HEX2_s1_in_a_read_cycle;
  wire             HEX2_s1_in_a_write_cycle;
  wire             HEX2_s1_master_qreq_vector;
  wire             HEX2_s1_non_bursting_master_requests;
  wire    [ 31: 0] HEX2_s1_readdata_from_sa;
  reg              HEX2_s1_reg_firsttransfer;
  wire             HEX2_s1_reset_n;
  reg              HEX2_s1_slavearbiterlockenable;
  wire             HEX2_s1_slavearbiterlockenable2;
  wire             HEX2_s1_unreg_firsttransfer;
  wire             HEX2_s1_waits_for_read;
  wire             HEX2_s1_waits_for_write;
  wire             HEX2_s1_write_n;
  wire    [ 31: 0] HEX2_s1_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_HEX2_s1;
  wire             cpu_0_data_master_qualified_request_HEX2_s1;
  wire             cpu_0_data_master_read_data_valid_HEX2_s1;
  wire             cpu_0_data_master_requests_HEX2_s1;
  wire             cpu_0_data_master_saved_grant_HEX2_s1;
  reg              d1_HEX2_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_HEX2_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 24: 0] shifted_address_to_HEX2_s1_from_cpu_0_data_master;
  wire             wait_for_HEX2_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~HEX2_s1_end_xfer;
    end


  assign HEX2_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_HEX2_s1));
  //assign HEX2_s1_readdata_from_sa = HEX2_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign HEX2_s1_readdata_from_sa = HEX2_s1_readdata;

  assign cpu_0_data_master_requests_HEX2_s1 = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h20) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //HEX2_s1_arb_share_counter set values, which is an e_mux
  assign HEX2_s1_arb_share_set_values = 1;

  //HEX2_s1_non_bursting_master_requests mux, which is an e_mux
  assign HEX2_s1_non_bursting_master_requests = cpu_0_data_master_requests_HEX2_s1;

  //HEX2_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign HEX2_s1_any_bursting_master_saved_grant = 0;

  //HEX2_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign HEX2_s1_arb_share_counter_next_value = HEX2_s1_firsttransfer ? (HEX2_s1_arb_share_set_values - 1) : |HEX2_s1_arb_share_counter ? (HEX2_s1_arb_share_counter - 1) : 0;

  //HEX2_s1_allgrants all slave grants, which is an e_mux
  assign HEX2_s1_allgrants = |HEX2_s1_grant_vector;

  //HEX2_s1_end_xfer assignment, which is an e_assign
  assign HEX2_s1_end_xfer = ~(HEX2_s1_waits_for_read | HEX2_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_HEX2_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_HEX2_s1 = HEX2_s1_end_xfer & (~HEX2_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //HEX2_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign HEX2_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_HEX2_s1 & HEX2_s1_allgrants) | (end_xfer_arb_share_counter_term_HEX2_s1 & ~HEX2_s1_non_bursting_master_requests);

  //HEX2_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX2_s1_arb_share_counter <= 0;
      else if (HEX2_s1_arb_counter_enable)
          HEX2_s1_arb_share_counter <= HEX2_s1_arb_share_counter_next_value;
    end


  //HEX2_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX2_s1_slavearbiterlockenable <= 0;
      else if ((|HEX2_s1_master_qreq_vector & end_xfer_arb_share_counter_term_HEX2_s1) | (end_xfer_arb_share_counter_term_HEX2_s1 & ~HEX2_s1_non_bursting_master_requests))
          HEX2_s1_slavearbiterlockenable <= |HEX2_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master HEX2/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = HEX2_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //HEX2_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign HEX2_s1_slavearbiterlockenable2 = |HEX2_s1_arb_share_counter_next_value;

  //cpu_0/data_master HEX2/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = HEX2_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //HEX2_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign HEX2_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_HEX2_s1 = cpu_0_data_master_requests_HEX2_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_HEX2_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_HEX2_s1 = cpu_0_data_master_granted_HEX2_s1 & cpu_0_data_master_read & ~HEX2_s1_waits_for_read;

  //HEX2_s1_writedata mux, which is an e_mux
  assign HEX2_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_HEX2_s1 = cpu_0_data_master_qualified_request_HEX2_s1;

  //cpu_0/data_master saved-grant HEX2/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_HEX2_s1 = cpu_0_data_master_requests_HEX2_s1;

  //allow new arb cycle for HEX2/s1, which is an e_assign
  assign HEX2_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign HEX2_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign HEX2_s1_master_qreq_vector = 1;

  //HEX2_s1_reset_n assignment, which is an e_assign
  assign HEX2_s1_reset_n = reset_n;

  assign HEX2_s1_chipselect = cpu_0_data_master_granted_HEX2_s1;
  //HEX2_s1_firsttransfer first transaction, which is an e_assign
  assign HEX2_s1_firsttransfer = HEX2_s1_begins_xfer ? HEX2_s1_unreg_firsttransfer : HEX2_s1_reg_firsttransfer;

  //HEX2_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign HEX2_s1_unreg_firsttransfer = ~(HEX2_s1_slavearbiterlockenable & HEX2_s1_any_continuerequest);

  //HEX2_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX2_s1_reg_firsttransfer <= 1'b1;
      else if (HEX2_s1_begins_xfer)
          HEX2_s1_reg_firsttransfer <= HEX2_s1_unreg_firsttransfer;
    end


  //HEX2_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign HEX2_s1_beginbursttransfer_internal = HEX2_s1_begins_xfer;

  //~HEX2_s1_write_n assignment, which is an e_mux
  assign HEX2_s1_write_n = ~(cpu_0_data_master_granted_HEX2_s1 & cpu_0_data_master_write);

  assign shifted_address_to_HEX2_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //HEX2_s1_address mux, which is an e_mux
  assign HEX2_s1_address = shifted_address_to_HEX2_s1_from_cpu_0_data_master >> 2;

  //d1_HEX2_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_HEX2_s1_end_xfer <= 1;
      else 
        d1_HEX2_s1_end_xfer <= HEX2_s1_end_xfer;
    end


  //HEX2_s1_waits_for_read in a cycle, which is an e_mux
  assign HEX2_s1_waits_for_read = HEX2_s1_in_a_read_cycle & HEX2_s1_begins_xfer;

  //HEX2_s1_in_a_read_cycle assignment, which is an e_assign
  assign HEX2_s1_in_a_read_cycle = cpu_0_data_master_granted_HEX2_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = HEX2_s1_in_a_read_cycle;

  //HEX2_s1_waits_for_write in a cycle, which is an e_mux
  assign HEX2_s1_waits_for_write = HEX2_s1_in_a_write_cycle & 0;

  //HEX2_s1_in_a_write_cycle assignment, which is an e_assign
  assign HEX2_s1_in_a_write_cycle = cpu_0_data_master_granted_HEX2_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = HEX2_s1_in_a_write_cycle;

  assign wait_for_HEX2_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //HEX2/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module HEX3_s1_arbitrator (
                            // inputs:
                             HEX3_s1_readdata,
                             clk,
                             cpu_0_data_master_address_to_slave,
                             cpu_0_data_master_latency_counter,
                             cpu_0_data_master_read,
                             cpu_0_data_master_write,
                             cpu_0_data_master_writedata,
                             reset_n,

                            // outputs:
                             HEX3_s1_address,
                             HEX3_s1_chipselect,
                             HEX3_s1_readdata_from_sa,
                             HEX3_s1_reset_n,
                             HEX3_s1_write_n,
                             HEX3_s1_writedata,
                             cpu_0_data_master_granted_HEX3_s1,
                             cpu_0_data_master_qualified_request_HEX3_s1,
                             cpu_0_data_master_read_data_valid_HEX3_s1,
                             cpu_0_data_master_requests_HEX3_s1,
                             d1_HEX3_s1_end_xfer
                          )
;

  output  [  1: 0] HEX3_s1_address;
  output           HEX3_s1_chipselect;
  output  [ 31: 0] HEX3_s1_readdata_from_sa;
  output           HEX3_s1_reset_n;
  output           HEX3_s1_write_n;
  output  [ 31: 0] HEX3_s1_writedata;
  output           cpu_0_data_master_granted_HEX3_s1;
  output           cpu_0_data_master_qualified_request_HEX3_s1;
  output           cpu_0_data_master_read_data_valid_HEX3_s1;
  output           cpu_0_data_master_requests_HEX3_s1;
  output           d1_HEX3_s1_end_xfer;
  input   [ 31: 0] HEX3_s1_readdata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] HEX3_s1_address;
  wire             HEX3_s1_allgrants;
  wire             HEX3_s1_allow_new_arb_cycle;
  wire             HEX3_s1_any_bursting_master_saved_grant;
  wire             HEX3_s1_any_continuerequest;
  wire             HEX3_s1_arb_counter_enable;
  reg     [  2: 0] HEX3_s1_arb_share_counter;
  wire    [  2: 0] HEX3_s1_arb_share_counter_next_value;
  wire    [  2: 0] HEX3_s1_arb_share_set_values;
  wire             HEX3_s1_beginbursttransfer_internal;
  wire             HEX3_s1_begins_xfer;
  wire             HEX3_s1_chipselect;
  wire             HEX3_s1_end_xfer;
  wire             HEX3_s1_firsttransfer;
  wire             HEX3_s1_grant_vector;
  wire             HEX3_s1_in_a_read_cycle;
  wire             HEX3_s1_in_a_write_cycle;
  wire             HEX3_s1_master_qreq_vector;
  wire             HEX3_s1_non_bursting_master_requests;
  wire    [ 31: 0] HEX3_s1_readdata_from_sa;
  reg              HEX3_s1_reg_firsttransfer;
  wire             HEX3_s1_reset_n;
  reg              HEX3_s1_slavearbiterlockenable;
  wire             HEX3_s1_slavearbiterlockenable2;
  wire             HEX3_s1_unreg_firsttransfer;
  wire             HEX3_s1_waits_for_read;
  wire             HEX3_s1_waits_for_write;
  wire             HEX3_s1_write_n;
  wire    [ 31: 0] HEX3_s1_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_HEX3_s1;
  wire             cpu_0_data_master_qualified_request_HEX3_s1;
  wire             cpu_0_data_master_read_data_valid_HEX3_s1;
  wire             cpu_0_data_master_requests_HEX3_s1;
  wire             cpu_0_data_master_saved_grant_HEX3_s1;
  reg              d1_HEX3_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_HEX3_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 24: 0] shifted_address_to_HEX3_s1_from_cpu_0_data_master;
  wire             wait_for_HEX3_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~HEX3_s1_end_xfer;
    end


  assign HEX3_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_HEX3_s1));
  //assign HEX3_s1_readdata_from_sa = HEX3_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign HEX3_s1_readdata_from_sa = HEX3_s1_readdata;

  assign cpu_0_data_master_requests_HEX3_s1 = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h30) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //HEX3_s1_arb_share_counter set values, which is an e_mux
  assign HEX3_s1_arb_share_set_values = 1;

  //HEX3_s1_non_bursting_master_requests mux, which is an e_mux
  assign HEX3_s1_non_bursting_master_requests = cpu_0_data_master_requests_HEX3_s1;

  //HEX3_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign HEX3_s1_any_bursting_master_saved_grant = 0;

  //HEX3_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign HEX3_s1_arb_share_counter_next_value = HEX3_s1_firsttransfer ? (HEX3_s1_arb_share_set_values - 1) : |HEX3_s1_arb_share_counter ? (HEX3_s1_arb_share_counter - 1) : 0;

  //HEX3_s1_allgrants all slave grants, which is an e_mux
  assign HEX3_s1_allgrants = |HEX3_s1_grant_vector;

  //HEX3_s1_end_xfer assignment, which is an e_assign
  assign HEX3_s1_end_xfer = ~(HEX3_s1_waits_for_read | HEX3_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_HEX3_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_HEX3_s1 = HEX3_s1_end_xfer & (~HEX3_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //HEX3_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign HEX3_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_HEX3_s1 & HEX3_s1_allgrants) | (end_xfer_arb_share_counter_term_HEX3_s1 & ~HEX3_s1_non_bursting_master_requests);

  //HEX3_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX3_s1_arb_share_counter <= 0;
      else if (HEX3_s1_arb_counter_enable)
          HEX3_s1_arb_share_counter <= HEX3_s1_arb_share_counter_next_value;
    end


  //HEX3_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX3_s1_slavearbiterlockenable <= 0;
      else if ((|HEX3_s1_master_qreq_vector & end_xfer_arb_share_counter_term_HEX3_s1) | (end_xfer_arb_share_counter_term_HEX3_s1 & ~HEX3_s1_non_bursting_master_requests))
          HEX3_s1_slavearbiterlockenable <= |HEX3_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master HEX3/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = HEX3_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //HEX3_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign HEX3_s1_slavearbiterlockenable2 = |HEX3_s1_arb_share_counter_next_value;

  //cpu_0/data_master HEX3/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = HEX3_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //HEX3_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign HEX3_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_HEX3_s1 = cpu_0_data_master_requests_HEX3_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_HEX3_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_HEX3_s1 = cpu_0_data_master_granted_HEX3_s1 & cpu_0_data_master_read & ~HEX3_s1_waits_for_read;

  //HEX3_s1_writedata mux, which is an e_mux
  assign HEX3_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_HEX3_s1 = cpu_0_data_master_qualified_request_HEX3_s1;

  //cpu_0/data_master saved-grant HEX3/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_HEX3_s1 = cpu_0_data_master_requests_HEX3_s1;

  //allow new arb cycle for HEX3/s1, which is an e_assign
  assign HEX3_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign HEX3_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign HEX3_s1_master_qreq_vector = 1;

  //HEX3_s1_reset_n assignment, which is an e_assign
  assign HEX3_s1_reset_n = reset_n;

  assign HEX3_s1_chipselect = cpu_0_data_master_granted_HEX3_s1;
  //HEX3_s1_firsttransfer first transaction, which is an e_assign
  assign HEX3_s1_firsttransfer = HEX3_s1_begins_xfer ? HEX3_s1_unreg_firsttransfer : HEX3_s1_reg_firsttransfer;

  //HEX3_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign HEX3_s1_unreg_firsttransfer = ~(HEX3_s1_slavearbiterlockenable & HEX3_s1_any_continuerequest);

  //HEX3_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX3_s1_reg_firsttransfer <= 1'b1;
      else if (HEX3_s1_begins_xfer)
          HEX3_s1_reg_firsttransfer <= HEX3_s1_unreg_firsttransfer;
    end


  //HEX3_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign HEX3_s1_beginbursttransfer_internal = HEX3_s1_begins_xfer;

  //~HEX3_s1_write_n assignment, which is an e_mux
  assign HEX3_s1_write_n = ~(cpu_0_data_master_granted_HEX3_s1 & cpu_0_data_master_write);

  assign shifted_address_to_HEX3_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //HEX3_s1_address mux, which is an e_mux
  assign HEX3_s1_address = shifted_address_to_HEX3_s1_from_cpu_0_data_master >> 2;

  //d1_HEX3_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_HEX3_s1_end_xfer <= 1;
      else 
        d1_HEX3_s1_end_xfer <= HEX3_s1_end_xfer;
    end


  //HEX3_s1_waits_for_read in a cycle, which is an e_mux
  assign HEX3_s1_waits_for_read = HEX3_s1_in_a_read_cycle & HEX3_s1_begins_xfer;

  //HEX3_s1_in_a_read_cycle assignment, which is an e_assign
  assign HEX3_s1_in_a_read_cycle = cpu_0_data_master_granted_HEX3_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = HEX3_s1_in_a_read_cycle;

  //HEX3_s1_waits_for_write in a cycle, which is an e_mux
  assign HEX3_s1_waits_for_write = HEX3_s1_in_a_write_cycle & 0;

  //HEX3_s1_in_a_write_cycle assignment, which is an e_assign
  assign HEX3_s1_in_a_write_cycle = cpu_0_data_master_granted_HEX3_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = HEX3_s1_in_a_write_cycle;

  assign wait_for_HEX3_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //HEX3/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module HEX4_s1_arbitrator (
                            // inputs:
                             HEX4_s1_readdata,
                             clk,
                             cpu_0_data_master_address_to_slave,
                             cpu_0_data_master_latency_counter,
                             cpu_0_data_master_read,
                             cpu_0_data_master_write,
                             cpu_0_data_master_writedata,
                             reset_n,

                            // outputs:
                             HEX4_s1_address,
                             HEX4_s1_chipselect,
                             HEX4_s1_readdata_from_sa,
                             HEX4_s1_reset_n,
                             HEX4_s1_write_n,
                             HEX4_s1_writedata,
                             cpu_0_data_master_granted_HEX4_s1,
                             cpu_0_data_master_qualified_request_HEX4_s1,
                             cpu_0_data_master_read_data_valid_HEX4_s1,
                             cpu_0_data_master_requests_HEX4_s1,
                             d1_HEX4_s1_end_xfer
                          )
;

  output  [  1: 0] HEX4_s1_address;
  output           HEX4_s1_chipselect;
  output  [ 31: 0] HEX4_s1_readdata_from_sa;
  output           HEX4_s1_reset_n;
  output           HEX4_s1_write_n;
  output  [ 31: 0] HEX4_s1_writedata;
  output           cpu_0_data_master_granted_HEX4_s1;
  output           cpu_0_data_master_qualified_request_HEX4_s1;
  output           cpu_0_data_master_read_data_valid_HEX4_s1;
  output           cpu_0_data_master_requests_HEX4_s1;
  output           d1_HEX4_s1_end_xfer;
  input   [ 31: 0] HEX4_s1_readdata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] HEX4_s1_address;
  wire             HEX4_s1_allgrants;
  wire             HEX4_s1_allow_new_arb_cycle;
  wire             HEX4_s1_any_bursting_master_saved_grant;
  wire             HEX4_s1_any_continuerequest;
  wire             HEX4_s1_arb_counter_enable;
  reg     [  2: 0] HEX4_s1_arb_share_counter;
  wire    [  2: 0] HEX4_s1_arb_share_counter_next_value;
  wire    [  2: 0] HEX4_s1_arb_share_set_values;
  wire             HEX4_s1_beginbursttransfer_internal;
  wire             HEX4_s1_begins_xfer;
  wire             HEX4_s1_chipselect;
  wire             HEX4_s1_end_xfer;
  wire             HEX4_s1_firsttransfer;
  wire             HEX4_s1_grant_vector;
  wire             HEX4_s1_in_a_read_cycle;
  wire             HEX4_s1_in_a_write_cycle;
  wire             HEX4_s1_master_qreq_vector;
  wire             HEX4_s1_non_bursting_master_requests;
  wire    [ 31: 0] HEX4_s1_readdata_from_sa;
  reg              HEX4_s1_reg_firsttransfer;
  wire             HEX4_s1_reset_n;
  reg              HEX4_s1_slavearbiterlockenable;
  wire             HEX4_s1_slavearbiterlockenable2;
  wire             HEX4_s1_unreg_firsttransfer;
  wire             HEX4_s1_waits_for_read;
  wire             HEX4_s1_waits_for_write;
  wire             HEX4_s1_write_n;
  wire    [ 31: 0] HEX4_s1_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_HEX4_s1;
  wire             cpu_0_data_master_qualified_request_HEX4_s1;
  wire             cpu_0_data_master_read_data_valid_HEX4_s1;
  wire             cpu_0_data_master_requests_HEX4_s1;
  wire             cpu_0_data_master_saved_grant_HEX4_s1;
  reg              d1_HEX4_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_HEX4_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 24: 0] shifted_address_to_HEX4_s1_from_cpu_0_data_master;
  wire             wait_for_HEX4_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~HEX4_s1_end_xfer;
    end


  assign HEX4_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_HEX4_s1));
  //assign HEX4_s1_readdata_from_sa = HEX4_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign HEX4_s1_readdata_from_sa = HEX4_s1_readdata;

  assign cpu_0_data_master_requests_HEX4_s1 = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h40) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //HEX4_s1_arb_share_counter set values, which is an e_mux
  assign HEX4_s1_arb_share_set_values = 1;

  //HEX4_s1_non_bursting_master_requests mux, which is an e_mux
  assign HEX4_s1_non_bursting_master_requests = cpu_0_data_master_requests_HEX4_s1;

  //HEX4_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign HEX4_s1_any_bursting_master_saved_grant = 0;

  //HEX4_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign HEX4_s1_arb_share_counter_next_value = HEX4_s1_firsttransfer ? (HEX4_s1_arb_share_set_values - 1) : |HEX4_s1_arb_share_counter ? (HEX4_s1_arb_share_counter - 1) : 0;

  //HEX4_s1_allgrants all slave grants, which is an e_mux
  assign HEX4_s1_allgrants = |HEX4_s1_grant_vector;

  //HEX4_s1_end_xfer assignment, which is an e_assign
  assign HEX4_s1_end_xfer = ~(HEX4_s1_waits_for_read | HEX4_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_HEX4_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_HEX4_s1 = HEX4_s1_end_xfer & (~HEX4_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //HEX4_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign HEX4_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_HEX4_s1 & HEX4_s1_allgrants) | (end_xfer_arb_share_counter_term_HEX4_s1 & ~HEX4_s1_non_bursting_master_requests);

  //HEX4_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX4_s1_arb_share_counter <= 0;
      else if (HEX4_s1_arb_counter_enable)
          HEX4_s1_arb_share_counter <= HEX4_s1_arb_share_counter_next_value;
    end


  //HEX4_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX4_s1_slavearbiterlockenable <= 0;
      else if ((|HEX4_s1_master_qreq_vector & end_xfer_arb_share_counter_term_HEX4_s1) | (end_xfer_arb_share_counter_term_HEX4_s1 & ~HEX4_s1_non_bursting_master_requests))
          HEX4_s1_slavearbiterlockenable <= |HEX4_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master HEX4/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = HEX4_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //HEX4_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign HEX4_s1_slavearbiterlockenable2 = |HEX4_s1_arb_share_counter_next_value;

  //cpu_0/data_master HEX4/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = HEX4_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //HEX4_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign HEX4_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_HEX4_s1 = cpu_0_data_master_requests_HEX4_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_HEX4_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_HEX4_s1 = cpu_0_data_master_granted_HEX4_s1 & cpu_0_data_master_read & ~HEX4_s1_waits_for_read;

  //HEX4_s1_writedata mux, which is an e_mux
  assign HEX4_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_HEX4_s1 = cpu_0_data_master_qualified_request_HEX4_s1;

  //cpu_0/data_master saved-grant HEX4/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_HEX4_s1 = cpu_0_data_master_requests_HEX4_s1;

  //allow new arb cycle for HEX4/s1, which is an e_assign
  assign HEX4_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign HEX4_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign HEX4_s1_master_qreq_vector = 1;

  //HEX4_s1_reset_n assignment, which is an e_assign
  assign HEX4_s1_reset_n = reset_n;

  assign HEX4_s1_chipselect = cpu_0_data_master_granted_HEX4_s1;
  //HEX4_s1_firsttransfer first transaction, which is an e_assign
  assign HEX4_s1_firsttransfer = HEX4_s1_begins_xfer ? HEX4_s1_unreg_firsttransfer : HEX4_s1_reg_firsttransfer;

  //HEX4_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign HEX4_s1_unreg_firsttransfer = ~(HEX4_s1_slavearbiterlockenable & HEX4_s1_any_continuerequest);

  //HEX4_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX4_s1_reg_firsttransfer <= 1'b1;
      else if (HEX4_s1_begins_xfer)
          HEX4_s1_reg_firsttransfer <= HEX4_s1_unreg_firsttransfer;
    end


  //HEX4_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign HEX4_s1_beginbursttransfer_internal = HEX4_s1_begins_xfer;

  //~HEX4_s1_write_n assignment, which is an e_mux
  assign HEX4_s1_write_n = ~(cpu_0_data_master_granted_HEX4_s1 & cpu_0_data_master_write);

  assign shifted_address_to_HEX4_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //HEX4_s1_address mux, which is an e_mux
  assign HEX4_s1_address = shifted_address_to_HEX4_s1_from_cpu_0_data_master >> 2;

  //d1_HEX4_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_HEX4_s1_end_xfer <= 1;
      else 
        d1_HEX4_s1_end_xfer <= HEX4_s1_end_xfer;
    end


  //HEX4_s1_waits_for_read in a cycle, which is an e_mux
  assign HEX4_s1_waits_for_read = HEX4_s1_in_a_read_cycle & HEX4_s1_begins_xfer;

  //HEX4_s1_in_a_read_cycle assignment, which is an e_assign
  assign HEX4_s1_in_a_read_cycle = cpu_0_data_master_granted_HEX4_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = HEX4_s1_in_a_read_cycle;

  //HEX4_s1_waits_for_write in a cycle, which is an e_mux
  assign HEX4_s1_waits_for_write = HEX4_s1_in_a_write_cycle & 0;

  //HEX4_s1_in_a_write_cycle assignment, which is an e_assign
  assign HEX4_s1_in_a_write_cycle = cpu_0_data_master_granted_HEX4_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = HEX4_s1_in_a_write_cycle;

  assign wait_for_HEX4_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //HEX4/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module HEX5_s1_arbitrator (
                            // inputs:
                             HEX5_s1_readdata,
                             clk,
                             cpu_0_data_master_address_to_slave,
                             cpu_0_data_master_latency_counter,
                             cpu_0_data_master_read,
                             cpu_0_data_master_write,
                             cpu_0_data_master_writedata,
                             reset_n,

                            // outputs:
                             HEX5_s1_address,
                             HEX5_s1_chipselect,
                             HEX5_s1_readdata_from_sa,
                             HEX5_s1_reset_n,
                             HEX5_s1_write_n,
                             HEX5_s1_writedata,
                             cpu_0_data_master_granted_HEX5_s1,
                             cpu_0_data_master_qualified_request_HEX5_s1,
                             cpu_0_data_master_read_data_valid_HEX5_s1,
                             cpu_0_data_master_requests_HEX5_s1,
                             d1_HEX5_s1_end_xfer
                          )
;

  output  [  1: 0] HEX5_s1_address;
  output           HEX5_s1_chipselect;
  output  [ 31: 0] HEX5_s1_readdata_from_sa;
  output           HEX5_s1_reset_n;
  output           HEX5_s1_write_n;
  output  [ 31: 0] HEX5_s1_writedata;
  output           cpu_0_data_master_granted_HEX5_s1;
  output           cpu_0_data_master_qualified_request_HEX5_s1;
  output           cpu_0_data_master_read_data_valid_HEX5_s1;
  output           cpu_0_data_master_requests_HEX5_s1;
  output           d1_HEX5_s1_end_xfer;
  input   [ 31: 0] HEX5_s1_readdata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] HEX5_s1_address;
  wire             HEX5_s1_allgrants;
  wire             HEX5_s1_allow_new_arb_cycle;
  wire             HEX5_s1_any_bursting_master_saved_grant;
  wire             HEX5_s1_any_continuerequest;
  wire             HEX5_s1_arb_counter_enable;
  reg     [  2: 0] HEX5_s1_arb_share_counter;
  wire    [  2: 0] HEX5_s1_arb_share_counter_next_value;
  wire    [  2: 0] HEX5_s1_arb_share_set_values;
  wire             HEX5_s1_beginbursttransfer_internal;
  wire             HEX5_s1_begins_xfer;
  wire             HEX5_s1_chipselect;
  wire             HEX5_s1_end_xfer;
  wire             HEX5_s1_firsttransfer;
  wire             HEX5_s1_grant_vector;
  wire             HEX5_s1_in_a_read_cycle;
  wire             HEX5_s1_in_a_write_cycle;
  wire             HEX5_s1_master_qreq_vector;
  wire             HEX5_s1_non_bursting_master_requests;
  wire    [ 31: 0] HEX5_s1_readdata_from_sa;
  reg              HEX5_s1_reg_firsttransfer;
  wire             HEX5_s1_reset_n;
  reg              HEX5_s1_slavearbiterlockenable;
  wire             HEX5_s1_slavearbiterlockenable2;
  wire             HEX5_s1_unreg_firsttransfer;
  wire             HEX5_s1_waits_for_read;
  wire             HEX5_s1_waits_for_write;
  wire             HEX5_s1_write_n;
  wire    [ 31: 0] HEX5_s1_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_HEX5_s1;
  wire             cpu_0_data_master_qualified_request_HEX5_s1;
  wire             cpu_0_data_master_read_data_valid_HEX5_s1;
  wire             cpu_0_data_master_requests_HEX5_s1;
  wire             cpu_0_data_master_saved_grant_HEX5_s1;
  reg              d1_HEX5_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_HEX5_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 24: 0] shifted_address_to_HEX5_s1_from_cpu_0_data_master;
  wire             wait_for_HEX5_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~HEX5_s1_end_xfer;
    end


  assign HEX5_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_HEX5_s1));
  //assign HEX5_s1_readdata_from_sa = HEX5_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign HEX5_s1_readdata_from_sa = HEX5_s1_readdata;

  assign cpu_0_data_master_requests_HEX5_s1 = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h50) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //HEX5_s1_arb_share_counter set values, which is an e_mux
  assign HEX5_s1_arb_share_set_values = 1;

  //HEX5_s1_non_bursting_master_requests mux, which is an e_mux
  assign HEX5_s1_non_bursting_master_requests = cpu_0_data_master_requests_HEX5_s1;

  //HEX5_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign HEX5_s1_any_bursting_master_saved_grant = 0;

  //HEX5_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign HEX5_s1_arb_share_counter_next_value = HEX5_s1_firsttransfer ? (HEX5_s1_arb_share_set_values - 1) : |HEX5_s1_arb_share_counter ? (HEX5_s1_arb_share_counter - 1) : 0;

  //HEX5_s1_allgrants all slave grants, which is an e_mux
  assign HEX5_s1_allgrants = |HEX5_s1_grant_vector;

  //HEX5_s1_end_xfer assignment, which is an e_assign
  assign HEX5_s1_end_xfer = ~(HEX5_s1_waits_for_read | HEX5_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_HEX5_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_HEX5_s1 = HEX5_s1_end_xfer & (~HEX5_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //HEX5_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign HEX5_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_HEX5_s1 & HEX5_s1_allgrants) | (end_xfer_arb_share_counter_term_HEX5_s1 & ~HEX5_s1_non_bursting_master_requests);

  //HEX5_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX5_s1_arb_share_counter <= 0;
      else if (HEX5_s1_arb_counter_enable)
          HEX5_s1_arb_share_counter <= HEX5_s1_arb_share_counter_next_value;
    end


  //HEX5_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX5_s1_slavearbiterlockenable <= 0;
      else if ((|HEX5_s1_master_qreq_vector & end_xfer_arb_share_counter_term_HEX5_s1) | (end_xfer_arb_share_counter_term_HEX5_s1 & ~HEX5_s1_non_bursting_master_requests))
          HEX5_s1_slavearbiterlockenable <= |HEX5_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master HEX5/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = HEX5_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //HEX5_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign HEX5_s1_slavearbiterlockenable2 = |HEX5_s1_arb_share_counter_next_value;

  //cpu_0/data_master HEX5/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = HEX5_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //HEX5_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign HEX5_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_HEX5_s1 = cpu_0_data_master_requests_HEX5_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_HEX5_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_HEX5_s1 = cpu_0_data_master_granted_HEX5_s1 & cpu_0_data_master_read & ~HEX5_s1_waits_for_read;

  //HEX5_s1_writedata mux, which is an e_mux
  assign HEX5_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_HEX5_s1 = cpu_0_data_master_qualified_request_HEX5_s1;

  //cpu_0/data_master saved-grant HEX5/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_HEX5_s1 = cpu_0_data_master_requests_HEX5_s1;

  //allow new arb cycle for HEX5/s1, which is an e_assign
  assign HEX5_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign HEX5_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign HEX5_s1_master_qreq_vector = 1;

  //HEX5_s1_reset_n assignment, which is an e_assign
  assign HEX5_s1_reset_n = reset_n;

  assign HEX5_s1_chipselect = cpu_0_data_master_granted_HEX5_s1;
  //HEX5_s1_firsttransfer first transaction, which is an e_assign
  assign HEX5_s1_firsttransfer = HEX5_s1_begins_xfer ? HEX5_s1_unreg_firsttransfer : HEX5_s1_reg_firsttransfer;

  //HEX5_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign HEX5_s1_unreg_firsttransfer = ~(HEX5_s1_slavearbiterlockenable & HEX5_s1_any_continuerequest);

  //HEX5_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX5_s1_reg_firsttransfer <= 1'b1;
      else if (HEX5_s1_begins_xfer)
          HEX5_s1_reg_firsttransfer <= HEX5_s1_unreg_firsttransfer;
    end


  //HEX5_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign HEX5_s1_beginbursttransfer_internal = HEX5_s1_begins_xfer;

  //~HEX5_s1_write_n assignment, which is an e_mux
  assign HEX5_s1_write_n = ~(cpu_0_data_master_granted_HEX5_s1 & cpu_0_data_master_write);

  assign shifted_address_to_HEX5_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //HEX5_s1_address mux, which is an e_mux
  assign HEX5_s1_address = shifted_address_to_HEX5_s1_from_cpu_0_data_master >> 2;

  //d1_HEX5_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_HEX5_s1_end_xfer <= 1;
      else 
        d1_HEX5_s1_end_xfer <= HEX5_s1_end_xfer;
    end


  //HEX5_s1_waits_for_read in a cycle, which is an e_mux
  assign HEX5_s1_waits_for_read = HEX5_s1_in_a_read_cycle & HEX5_s1_begins_xfer;

  //HEX5_s1_in_a_read_cycle assignment, which is an e_assign
  assign HEX5_s1_in_a_read_cycle = cpu_0_data_master_granted_HEX5_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = HEX5_s1_in_a_read_cycle;

  //HEX5_s1_waits_for_write in a cycle, which is an e_mux
  assign HEX5_s1_waits_for_write = HEX5_s1_in_a_write_cycle & 0;

  //HEX5_s1_in_a_write_cycle assignment, which is an e_assign
  assign HEX5_s1_in_a_write_cycle = cpu_0_data_master_granted_HEX5_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = HEX5_s1_in_a_write_cycle;

  assign wait_for_HEX5_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //HEX5/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module HEX6_s1_arbitrator (
                            // inputs:
                             HEX6_s1_readdata,
                             clk,
                             cpu_0_data_master_address_to_slave,
                             cpu_0_data_master_latency_counter,
                             cpu_0_data_master_read,
                             cpu_0_data_master_write,
                             cpu_0_data_master_writedata,
                             reset_n,

                            // outputs:
                             HEX6_s1_address,
                             HEX6_s1_chipselect,
                             HEX6_s1_readdata_from_sa,
                             HEX6_s1_reset_n,
                             HEX6_s1_write_n,
                             HEX6_s1_writedata,
                             cpu_0_data_master_granted_HEX6_s1,
                             cpu_0_data_master_qualified_request_HEX6_s1,
                             cpu_0_data_master_read_data_valid_HEX6_s1,
                             cpu_0_data_master_requests_HEX6_s1,
                             d1_HEX6_s1_end_xfer
                          )
;

  output  [  1: 0] HEX6_s1_address;
  output           HEX6_s1_chipselect;
  output  [ 31: 0] HEX6_s1_readdata_from_sa;
  output           HEX6_s1_reset_n;
  output           HEX6_s1_write_n;
  output  [ 31: 0] HEX6_s1_writedata;
  output           cpu_0_data_master_granted_HEX6_s1;
  output           cpu_0_data_master_qualified_request_HEX6_s1;
  output           cpu_0_data_master_read_data_valid_HEX6_s1;
  output           cpu_0_data_master_requests_HEX6_s1;
  output           d1_HEX6_s1_end_xfer;
  input   [ 31: 0] HEX6_s1_readdata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] HEX6_s1_address;
  wire             HEX6_s1_allgrants;
  wire             HEX6_s1_allow_new_arb_cycle;
  wire             HEX6_s1_any_bursting_master_saved_grant;
  wire             HEX6_s1_any_continuerequest;
  wire             HEX6_s1_arb_counter_enable;
  reg     [  2: 0] HEX6_s1_arb_share_counter;
  wire    [  2: 0] HEX6_s1_arb_share_counter_next_value;
  wire    [  2: 0] HEX6_s1_arb_share_set_values;
  wire             HEX6_s1_beginbursttransfer_internal;
  wire             HEX6_s1_begins_xfer;
  wire             HEX6_s1_chipselect;
  wire             HEX6_s1_end_xfer;
  wire             HEX6_s1_firsttransfer;
  wire             HEX6_s1_grant_vector;
  wire             HEX6_s1_in_a_read_cycle;
  wire             HEX6_s1_in_a_write_cycle;
  wire             HEX6_s1_master_qreq_vector;
  wire             HEX6_s1_non_bursting_master_requests;
  wire    [ 31: 0] HEX6_s1_readdata_from_sa;
  reg              HEX6_s1_reg_firsttransfer;
  wire             HEX6_s1_reset_n;
  reg              HEX6_s1_slavearbiterlockenable;
  wire             HEX6_s1_slavearbiterlockenable2;
  wire             HEX6_s1_unreg_firsttransfer;
  wire             HEX6_s1_waits_for_read;
  wire             HEX6_s1_waits_for_write;
  wire             HEX6_s1_write_n;
  wire    [ 31: 0] HEX6_s1_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_HEX6_s1;
  wire             cpu_0_data_master_qualified_request_HEX6_s1;
  wire             cpu_0_data_master_read_data_valid_HEX6_s1;
  wire             cpu_0_data_master_requests_HEX6_s1;
  wire             cpu_0_data_master_saved_grant_HEX6_s1;
  reg              d1_HEX6_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_HEX6_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 24: 0] shifted_address_to_HEX6_s1_from_cpu_0_data_master;
  wire             wait_for_HEX6_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~HEX6_s1_end_xfer;
    end


  assign HEX6_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_HEX6_s1));
  //assign HEX6_s1_readdata_from_sa = HEX6_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign HEX6_s1_readdata_from_sa = HEX6_s1_readdata;

  assign cpu_0_data_master_requests_HEX6_s1 = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h60) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //HEX6_s1_arb_share_counter set values, which is an e_mux
  assign HEX6_s1_arb_share_set_values = 1;

  //HEX6_s1_non_bursting_master_requests mux, which is an e_mux
  assign HEX6_s1_non_bursting_master_requests = cpu_0_data_master_requests_HEX6_s1;

  //HEX6_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign HEX6_s1_any_bursting_master_saved_grant = 0;

  //HEX6_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign HEX6_s1_arb_share_counter_next_value = HEX6_s1_firsttransfer ? (HEX6_s1_arb_share_set_values - 1) : |HEX6_s1_arb_share_counter ? (HEX6_s1_arb_share_counter - 1) : 0;

  //HEX6_s1_allgrants all slave grants, which is an e_mux
  assign HEX6_s1_allgrants = |HEX6_s1_grant_vector;

  //HEX6_s1_end_xfer assignment, which is an e_assign
  assign HEX6_s1_end_xfer = ~(HEX6_s1_waits_for_read | HEX6_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_HEX6_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_HEX6_s1 = HEX6_s1_end_xfer & (~HEX6_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //HEX6_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign HEX6_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_HEX6_s1 & HEX6_s1_allgrants) | (end_xfer_arb_share_counter_term_HEX6_s1 & ~HEX6_s1_non_bursting_master_requests);

  //HEX6_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX6_s1_arb_share_counter <= 0;
      else if (HEX6_s1_arb_counter_enable)
          HEX6_s1_arb_share_counter <= HEX6_s1_arb_share_counter_next_value;
    end


  //HEX6_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX6_s1_slavearbiterlockenable <= 0;
      else if ((|HEX6_s1_master_qreq_vector & end_xfer_arb_share_counter_term_HEX6_s1) | (end_xfer_arb_share_counter_term_HEX6_s1 & ~HEX6_s1_non_bursting_master_requests))
          HEX6_s1_slavearbiterlockenable <= |HEX6_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master HEX6/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = HEX6_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //HEX6_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign HEX6_s1_slavearbiterlockenable2 = |HEX6_s1_arb_share_counter_next_value;

  //cpu_0/data_master HEX6/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = HEX6_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //HEX6_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign HEX6_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_HEX6_s1 = cpu_0_data_master_requests_HEX6_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_HEX6_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_HEX6_s1 = cpu_0_data_master_granted_HEX6_s1 & cpu_0_data_master_read & ~HEX6_s1_waits_for_read;

  //HEX6_s1_writedata mux, which is an e_mux
  assign HEX6_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_HEX6_s1 = cpu_0_data_master_qualified_request_HEX6_s1;

  //cpu_0/data_master saved-grant HEX6/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_HEX6_s1 = cpu_0_data_master_requests_HEX6_s1;

  //allow new arb cycle for HEX6/s1, which is an e_assign
  assign HEX6_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign HEX6_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign HEX6_s1_master_qreq_vector = 1;

  //HEX6_s1_reset_n assignment, which is an e_assign
  assign HEX6_s1_reset_n = reset_n;

  assign HEX6_s1_chipselect = cpu_0_data_master_granted_HEX6_s1;
  //HEX6_s1_firsttransfer first transaction, which is an e_assign
  assign HEX6_s1_firsttransfer = HEX6_s1_begins_xfer ? HEX6_s1_unreg_firsttransfer : HEX6_s1_reg_firsttransfer;

  //HEX6_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign HEX6_s1_unreg_firsttransfer = ~(HEX6_s1_slavearbiterlockenable & HEX6_s1_any_continuerequest);

  //HEX6_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX6_s1_reg_firsttransfer <= 1'b1;
      else if (HEX6_s1_begins_xfer)
          HEX6_s1_reg_firsttransfer <= HEX6_s1_unreg_firsttransfer;
    end


  //HEX6_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign HEX6_s1_beginbursttransfer_internal = HEX6_s1_begins_xfer;

  //~HEX6_s1_write_n assignment, which is an e_mux
  assign HEX6_s1_write_n = ~(cpu_0_data_master_granted_HEX6_s1 & cpu_0_data_master_write);

  assign shifted_address_to_HEX6_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //HEX6_s1_address mux, which is an e_mux
  assign HEX6_s1_address = shifted_address_to_HEX6_s1_from_cpu_0_data_master >> 2;

  //d1_HEX6_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_HEX6_s1_end_xfer <= 1;
      else 
        d1_HEX6_s1_end_xfer <= HEX6_s1_end_xfer;
    end


  //HEX6_s1_waits_for_read in a cycle, which is an e_mux
  assign HEX6_s1_waits_for_read = HEX6_s1_in_a_read_cycle & HEX6_s1_begins_xfer;

  //HEX6_s1_in_a_read_cycle assignment, which is an e_assign
  assign HEX6_s1_in_a_read_cycle = cpu_0_data_master_granted_HEX6_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = HEX6_s1_in_a_read_cycle;

  //HEX6_s1_waits_for_write in a cycle, which is an e_mux
  assign HEX6_s1_waits_for_write = HEX6_s1_in_a_write_cycle & 0;

  //HEX6_s1_in_a_write_cycle assignment, which is an e_assign
  assign HEX6_s1_in_a_write_cycle = cpu_0_data_master_granted_HEX6_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = HEX6_s1_in_a_write_cycle;

  assign wait_for_HEX6_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //HEX6/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module HEX7_s1_arbitrator (
                            // inputs:
                             HEX7_s1_readdata,
                             clk,
                             cpu_0_data_master_address_to_slave,
                             cpu_0_data_master_latency_counter,
                             cpu_0_data_master_read,
                             cpu_0_data_master_write,
                             cpu_0_data_master_writedata,
                             reset_n,

                            // outputs:
                             HEX7_s1_address,
                             HEX7_s1_chipselect,
                             HEX7_s1_readdata_from_sa,
                             HEX7_s1_reset_n,
                             HEX7_s1_write_n,
                             HEX7_s1_writedata,
                             cpu_0_data_master_granted_HEX7_s1,
                             cpu_0_data_master_qualified_request_HEX7_s1,
                             cpu_0_data_master_read_data_valid_HEX7_s1,
                             cpu_0_data_master_requests_HEX7_s1,
                             d1_HEX7_s1_end_xfer
                          )
;

  output  [  1: 0] HEX7_s1_address;
  output           HEX7_s1_chipselect;
  output  [ 31: 0] HEX7_s1_readdata_from_sa;
  output           HEX7_s1_reset_n;
  output           HEX7_s1_write_n;
  output  [ 31: 0] HEX7_s1_writedata;
  output           cpu_0_data_master_granted_HEX7_s1;
  output           cpu_0_data_master_qualified_request_HEX7_s1;
  output           cpu_0_data_master_read_data_valid_HEX7_s1;
  output           cpu_0_data_master_requests_HEX7_s1;
  output           d1_HEX7_s1_end_xfer;
  input   [ 31: 0] HEX7_s1_readdata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] HEX7_s1_address;
  wire             HEX7_s1_allgrants;
  wire             HEX7_s1_allow_new_arb_cycle;
  wire             HEX7_s1_any_bursting_master_saved_grant;
  wire             HEX7_s1_any_continuerequest;
  wire             HEX7_s1_arb_counter_enable;
  reg     [  2: 0] HEX7_s1_arb_share_counter;
  wire    [  2: 0] HEX7_s1_arb_share_counter_next_value;
  wire    [  2: 0] HEX7_s1_arb_share_set_values;
  wire             HEX7_s1_beginbursttransfer_internal;
  wire             HEX7_s1_begins_xfer;
  wire             HEX7_s1_chipselect;
  wire             HEX7_s1_end_xfer;
  wire             HEX7_s1_firsttransfer;
  wire             HEX7_s1_grant_vector;
  wire             HEX7_s1_in_a_read_cycle;
  wire             HEX7_s1_in_a_write_cycle;
  wire             HEX7_s1_master_qreq_vector;
  wire             HEX7_s1_non_bursting_master_requests;
  wire    [ 31: 0] HEX7_s1_readdata_from_sa;
  reg              HEX7_s1_reg_firsttransfer;
  wire             HEX7_s1_reset_n;
  reg              HEX7_s1_slavearbiterlockenable;
  wire             HEX7_s1_slavearbiterlockenable2;
  wire             HEX7_s1_unreg_firsttransfer;
  wire             HEX7_s1_waits_for_read;
  wire             HEX7_s1_waits_for_write;
  wire             HEX7_s1_write_n;
  wire    [ 31: 0] HEX7_s1_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_HEX7_s1;
  wire             cpu_0_data_master_qualified_request_HEX7_s1;
  wire             cpu_0_data_master_read_data_valid_HEX7_s1;
  wire             cpu_0_data_master_requests_HEX7_s1;
  wire             cpu_0_data_master_saved_grant_HEX7_s1;
  reg              d1_HEX7_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_HEX7_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 24: 0] shifted_address_to_HEX7_s1_from_cpu_0_data_master;
  wire             wait_for_HEX7_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~HEX7_s1_end_xfer;
    end


  assign HEX7_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_HEX7_s1));
  //assign HEX7_s1_readdata_from_sa = HEX7_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign HEX7_s1_readdata_from_sa = HEX7_s1_readdata;

  assign cpu_0_data_master_requests_HEX7_s1 = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h70) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //HEX7_s1_arb_share_counter set values, which is an e_mux
  assign HEX7_s1_arb_share_set_values = 1;

  //HEX7_s1_non_bursting_master_requests mux, which is an e_mux
  assign HEX7_s1_non_bursting_master_requests = cpu_0_data_master_requests_HEX7_s1;

  //HEX7_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign HEX7_s1_any_bursting_master_saved_grant = 0;

  //HEX7_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign HEX7_s1_arb_share_counter_next_value = HEX7_s1_firsttransfer ? (HEX7_s1_arb_share_set_values - 1) : |HEX7_s1_arb_share_counter ? (HEX7_s1_arb_share_counter - 1) : 0;

  //HEX7_s1_allgrants all slave grants, which is an e_mux
  assign HEX7_s1_allgrants = |HEX7_s1_grant_vector;

  //HEX7_s1_end_xfer assignment, which is an e_assign
  assign HEX7_s1_end_xfer = ~(HEX7_s1_waits_for_read | HEX7_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_HEX7_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_HEX7_s1 = HEX7_s1_end_xfer & (~HEX7_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //HEX7_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign HEX7_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_HEX7_s1 & HEX7_s1_allgrants) | (end_xfer_arb_share_counter_term_HEX7_s1 & ~HEX7_s1_non_bursting_master_requests);

  //HEX7_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX7_s1_arb_share_counter <= 0;
      else if (HEX7_s1_arb_counter_enable)
          HEX7_s1_arb_share_counter <= HEX7_s1_arb_share_counter_next_value;
    end


  //HEX7_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX7_s1_slavearbiterlockenable <= 0;
      else if ((|HEX7_s1_master_qreq_vector & end_xfer_arb_share_counter_term_HEX7_s1) | (end_xfer_arb_share_counter_term_HEX7_s1 & ~HEX7_s1_non_bursting_master_requests))
          HEX7_s1_slavearbiterlockenable <= |HEX7_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master HEX7/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = HEX7_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //HEX7_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign HEX7_s1_slavearbiterlockenable2 = |HEX7_s1_arb_share_counter_next_value;

  //cpu_0/data_master HEX7/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = HEX7_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //HEX7_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign HEX7_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_HEX7_s1 = cpu_0_data_master_requests_HEX7_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_HEX7_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_HEX7_s1 = cpu_0_data_master_granted_HEX7_s1 & cpu_0_data_master_read & ~HEX7_s1_waits_for_read;

  //HEX7_s1_writedata mux, which is an e_mux
  assign HEX7_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_HEX7_s1 = cpu_0_data_master_qualified_request_HEX7_s1;

  //cpu_0/data_master saved-grant HEX7/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_HEX7_s1 = cpu_0_data_master_requests_HEX7_s1;

  //allow new arb cycle for HEX7/s1, which is an e_assign
  assign HEX7_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign HEX7_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign HEX7_s1_master_qreq_vector = 1;

  //HEX7_s1_reset_n assignment, which is an e_assign
  assign HEX7_s1_reset_n = reset_n;

  assign HEX7_s1_chipselect = cpu_0_data_master_granted_HEX7_s1;
  //HEX7_s1_firsttransfer first transaction, which is an e_assign
  assign HEX7_s1_firsttransfer = HEX7_s1_begins_xfer ? HEX7_s1_unreg_firsttransfer : HEX7_s1_reg_firsttransfer;

  //HEX7_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign HEX7_s1_unreg_firsttransfer = ~(HEX7_s1_slavearbiterlockenable & HEX7_s1_any_continuerequest);

  //HEX7_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          HEX7_s1_reg_firsttransfer <= 1'b1;
      else if (HEX7_s1_begins_xfer)
          HEX7_s1_reg_firsttransfer <= HEX7_s1_unreg_firsttransfer;
    end


  //HEX7_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign HEX7_s1_beginbursttransfer_internal = HEX7_s1_begins_xfer;

  //~HEX7_s1_write_n assignment, which is an e_mux
  assign HEX7_s1_write_n = ~(cpu_0_data_master_granted_HEX7_s1 & cpu_0_data_master_write);

  assign shifted_address_to_HEX7_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //HEX7_s1_address mux, which is an e_mux
  assign HEX7_s1_address = shifted_address_to_HEX7_s1_from_cpu_0_data_master >> 2;

  //d1_HEX7_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_HEX7_s1_end_xfer <= 1;
      else 
        d1_HEX7_s1_end_xfer <= HEX7_s1_end_xfer;
    end


  //HEX7_s1_waits_for_read in a cycle, which is an e_mux
  assign HEX7_s1_waits_for_read = HEX7_s1_in_a_read_cycle & HEX7_s1_begins_xfer;

  //HEX7_s1_in_a_read_cycle assignment, which is an e_assign
  assign HEX7_s1_in_a_read_cycle = cpu_0_data_master_granted_HEX7_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = HEX7_s1_in_a_read_cycle;

  //HEX7_s1_waits_for_write in a cycle, which is an e_mux
  assign HEX7_s1_waits_for_write = HEX7_s1_in_a_write_cycle & 0;

  //HEX7_s1_in_a_write_cycle assignment, which is an e_assign
  assign HEX7_s1_in_a_write_cycle = cpu_0_data_master_granted_HEX7_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = HEX7_s1_in_a_write_cycle;

  assign wait_for_HEX7_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //HEX7/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module clocks_0_avalon_clocks_slave_arbitrator (
                                                 // inputs:
                                                  clk,
                                                  clocks_0_avalon_clocks_slave_readdata,
                                                  nios_system_clock_2_out_address_to_slave,
                                                  nios_system_clock_2_out_read,
                                                  nios_system_clock_2_out_write,
                                                  reset_n,

                                                 // outputs:
                                                  clocks_0_avalon_clocks_slave_address,
                                                  clocks_0_avalon_clocks_slave_readdata_from_sa,
                                                  d1_clocks_0_avalon_clocks_slave_end_xfer,
                                                  nios_system_clock_2_out_granted_clocks_0_avalon_clocks_slave,
                                                  nios_system_clock_2_out_qualified_request_clocks_0_avalon_clocks_slave,
                                                  nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave,
                                                  nios_system_clock_2_out_requests_clocks_0_avalon_clocks_slave
                                               )
;

  output           clocks_0_avalon_clocks_slave_address;
  output  [  7: 0] clocks_0_avalon_clocks_slave_readdata_from_sa;
  output           d1_clocks_0_avalon_clocks_slave_end_xfer;
  output           nios_system_clock_2_out_granted_clocks_0_avalon_clocks_slave;
  output           nios_system_clock_2_out_qualified_request_clocks_0_avalon_clocks_slave;
  output           nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave;
  output           nios_system_clock_2_out_requests_clocks_0_avalon_clocks_slave;
  input            clk;
  input   [  7: 0] clocks_0_avalon_clocks_slave_readdata;
  input            nios_system_clock_2_out_address_to_slave;
  input            nios_system_clock_2_out_read;
  input            nios_system_clock_2_out_write;
  input            reset_n;

  wire             clocks_0_avalon_clocks_slave_address;
  wire             clocks_0_avalon_clocks_slave_allgrants;
  wire             clocks_0_avalon_clocks_slave_allow_new_arb_cycle;
  wire             clocks_0_avalon_clocks_slave_any_bursting_master_saved_grant;
  wire             clocks_0_avalon_clocks_slave_any_continuerequest;
  wire             clocks_0_avalon_clocks_slave_arb_counter_enable;
  reg              clocks_0_avalon_clocks_slave_arb_share_counter;
  wire             clocks_0_avalon_clocks_slave_arb_share_counter_next_value;
  wire             clocks_0_avalon_clocks_slave_arb_share_set_values;
  wire             clocks_0_avalon_clocks_slave_beginbursttransfer_internal;
  wire             clocks_0_avalon_clocks_slave_begins_xfer;
  wire             clocks_0_avalon_clocks_slave_end_xfer;
  wire             clocks_0_avalon_clocks_slave_firsttransfer;
  wire             clocks_0_avalon_clocks_slave_grant_vector;
  wire             clocks_0_avalon_clocks_slave_in_a_read_cycle;
  wire             clocks_0_avalon_clocks_slave_in_a_write_cycle;
  wire             clocks_0_avalon_clocks_slave_master_qreq_vector;
  wire             clocks_0_avalon_clocks_slave_non_bursting_master_requests;
  wire    [  7: 0] clocks_0_avalon_clocks_slave_readdata_from_sa;
  reg              clocks_0_avalon_clocks_slave_reg_firsttransfer;
  reg              clocks_0_avalon_clocks_slave_slavearbiterlockenable;
  wire             clocks_0_avalon_clocks_slave_slavearbiterlockenable2;
  wire             clocks_0_avalon_clocks_slave_unreg_firsttransfer;
  wire             clocks_0_avalon_clocks_slave_waits_for_read;
  wire             clocks_0_avalon_clocks_slave_waits_for_write;
  reg              d1_clocks_0_avalon_clocks_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_clocks_0_avalon_clocks_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             nios_system_clock_2_out_arbiterlock;
  wire             nios_system_clock_2_out_arbiterlock2;
  wire             nios_system_clock_2_out_continuerequest;
  wire             nios_system_clock_2_out_granted_clocks_0_avalon_clocks_slave;
  wire             nios_system_clock_2_out_qualified_request_clocks_0_avalon_clocks_slave;
  wire             nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave;
  reg              nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave_shift_register;
  wire             nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave_shift_register_in;
  wire             nios_system_clock_2_out_requests_clocks_0_avalon_clocks_slave;
  wire             nios_system_clock_2_out_saved_grant_clocks_0_avalon_clocks_slave;
  wire             p1_nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave_shift_register;
  wire             wait_for_clocks_0_avalon_clocks_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~clocks_0_avalon_clocks_slave_end_xfer;
    end


  assign clocks_0_avalon_clocks_slave_begins_xfer = ~d1_reasons_to_wait & ((nios_system_clock_2_out_qualified_request_clocks_0_avalon_clocks_slave));
  //assign clocks_0_avalon_clocks_slave_readdata_from_sa = clocks_0_avalon_clocks_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign clocks_0_avalon_clocks_slave_readdata_from_sa = clocks_0_avalon_clocks_slave_readdata;

  assign nios_system_clock_2_out_requests_clocks_0_avalon_clocks_slave = ((1) & (nios_system_clock_2_out_read | nios_system_clock_2_out_write)) & nios_system_clock_2_out_read;
  //clocks_0_avalon_clocks_slave_arb_share_counter set values, which is an e_mux
  assign clocks_0_avalon_clocks_slave_arb_share_set_values = 1;

  //clocks_0_avalon_clocks_slave_non_bursting_master_requests mux, which is an e_mux
  assign clocks_0_avalon_clocks_slave_non_bursting_master_requests = nios_system_clock_2_out_requests_clocks_0_avalon_clocks_slave;

  //clocks_0_avalon_clocks_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign clocks_0_avalon_clocks_slave_any_bursting_master_saved_grant = 0;

  //clocks_0_avalon_clocks_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign clocks_0_avalon_clocks_slave_arb_share_counter_next_value = clocks_0_avalon_clocks_slave_firsttransfer ? (clocks_0_avalon_clocks_slave_arb_share_set_values - 1) : |clocks_0_avalon_clocks_slave_arb_share_counter ? (clocks_0_avalon_clocks_slave_arb_share_counter - 1) : 0;

  //clocks_0_avalon_clocks_slave_allgrants all slave grants, which is an e_mux
  assign clocks_0_avalon_clocks_slave_allgrants = |clocks_0_avalon_clocks_slave_grant_vector;

  //clocks_0_avalon_clocks_slave_end_xfer assignment, which is an e_assign
  assign clocks_0_avalon_clocks_slave_end_xfer = ~(clocks_0_avalon_clocks_slave_waits_for_read | clocks_0_avalon_clocks_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_clocks_0_avalon_clocks_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_clocks_0_avalon_clocks_slave = clocks_0_avalon_clocks_slave_end_xfer & (~clocks_0_avalon_clocks_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //clocks_0_avalon_clocks_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign clocks_0_avalon_clocks_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_clocks_0_avalon_clocks_slave & clocks_0_avalon_clocks_slave_allgrants) | (end_xfer_arb_share_counter_term_clocks_0_avalon_clocks_slave & ~clocks_0_avalon_clocks_slave_non_bursting_master_requests);

  //clocks_0_avalon_clocks_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clocks_0_avalon_clocks_slave_arb_share_counter <= 0;
      else if (clocks_0_avalon_clocks_slave_arb_counter_enable)
          clocks_0_avalon_clocks_slave_arb_share_counter <= clocks_0_avalon_clocks_slave_arb_share_counter_next_value;
    end


  //clocks_0_avalon_clocks_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clocks_0_avalon_clocks_slave_slavearbiterlockenable <= 0;
      else if ((|clocks_0_avalon_clocks_slave_master_qreq_vector & end_xfer_arb_share_counter_term_clocks_0_avalon_clocks_slave) | (end_xfer_arb_share_counter_term_clocks_0_avalon_clocks_slave & ~clocks_0_avalon_clocks_slave_non_bursting_master_requests))
          clocks_0_avalon_clocks_slave_slavearbiterlockenable <= |clocks_0_avalon_clocks_slave_arb_share_counter_next_value;
    end


  //nios_system_clock_2/out clocks_0/avalon_clocks_slave arbiterlock, which is an e_assign
  assign nios_system_clock_2_out_arbiterlock = clocks_0_avalon_clocks_slave_slavearbiterlockenable & nios_system_clock_2_out_continuerequest;

  //clocks_0_avalon_clocks_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign clocks_0_avalon_clocks_slave_slavearbiterlockenable2 = |clocks_0_avalon_clocks_slave_arb_share_counter_next_value;

  //nios_system_clock_2/out clocks_0/avalon_clocks_slave arbiterlock2, which is an e_assign
  assign nios_system_clock_2_out_arbiterlock2 = clocks_0_avalon_clocks_slave_slavearbiterlockenable2 & nios_system_clock_2_out_continuerequest;

  //clocks_0_avalon_clocks_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign clocks_0_avalon_clocks_slave_any_continuerequest = 1;

  //nios_system_clock_2_out_continuerequest continued request, which is an e_assign
  assign nios_system_clock_2_out_continuerequest = 1;

  assign nios_system_clock_2_out_qualified_request_clocks_0_avalon_clocks_slave = nios_system_clock_2_out_requests_clocks_0_avalon_clocks_slave & ~((nios_system_clock_2_out_read & ((|nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave_shift_register))));
  //nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave_shift_register_in mux for readlatency shift register, which is an e_mux
  assign nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave_shift_register_in = nios_system_clock_2_out_granted_clocks_0_avalon_clocks_slave & nios_system_clock_2_out_read & ~clocks_0_avalon_clocks_slave_waits_for_read & ~(|nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave_shift_register);

  //shift register p1 nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave_shift_register = {nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave_shift_register, nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave_shift_register_in};

  //nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave_shift_register <= 0;
      else 
        nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave_shift_register <= p1_nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave_shift_register;
    end


  //local readdatavalid nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave, which is an e_mux
  assign nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave = nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave_shift_register;

  //master is always granted when requested
  assign nios_system_clock_2_out_granted_clocks_0_avalon_clocks_slave = nios_system_clock_2_out_qualified_request_clocks_0_avalon_clocks_slave;

  //nios_system_clock_2/out saved-grant clocks_0/avalon_clocks_slave, which is an e_assign
  assign nios_system_clock_2_out_saved_grant_clocks_0_avalon_clocks_slave = nios_system_clock_2_out_requests_clocks_0_avalon_clocks_slave;

  //allow new arb cycle for clocks_0/avalon_clocks_slave, which is an e_assign
  assign clocks_0_avalon_clocks_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign clocks_0_avalon_clocks_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign clocks_0_avalon_clocks_slave_master_qreq_vector = 1;

  //clocks_0_avalon_clocks_slave_firsttransfer first transaction, which is an e_assign
  assign clocks_0_avalon_clocks_slave_firsttransfer = clocks_0_avalon_clocks_slave_begins_xfer ? clocks_0_avalon_clocks_slave_unreg_firsttransfer : clocks_0_avalon_clocks_slave_reg_firsttransfer;

  //clocks_0_avalon_clocks_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign clocks_0_avalon_clocks_slave_unreg_firsttransfer = ~(clocks_0_avalon_clocks_slave_slavearbiterlockenable & clocks_0_avalon_clocks_slave_any_continuerequest);

  //clocks_0_avalon_clocks_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          clocks_0_avalon_clocks_slave_reg_firsttransfer <= 1'b1;
      else if (clocks_0_avalon_clocks_slave_begins_xfer)
          clocks_0_avalon_clocks_slave_reg_firsttransfer <= clocks_0_avalon_clocks_slave_unreg_firsttransfer;
    end


  //clocks_0_avalon_clocks_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign clocks_0_avalon_clocks_slave_beginbursttransfer_internal = clocks_0_avalon_clocks_slave_begins_xfer;

  //clocks_0_avalon_clocks_slave_address mux, which is an e_mux
  assign clocks_0_avalon_clocks_slave_address = nios_system_clock_2_out_address_to_slave;

  //d1_clocks_0_avalon_clocks_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_clocks_0_avalon_clocks_slave_end_xfer <= 1;
      else 
        d1_clocks_0_avalon_clocks_slave_end_xfer <= clocks_0_avalon_clocks_slave_end_xfer;
    end


  //clocks_0_avalon_clocks_slave_waits_for_read in a cycle, which is an e_mux
  assign clocks_0_avalon_clocks_slave_waits_for_read = clocks_0_avalon_clocks_slave_in_a_read_cycle & 0;

  //clocks_0_avalon_clocks_slave_in_a_read_cycle assignment, which is an e_assign
  assign clocks_0_avalon_clocks_slave_in_a_read_cycle = nios_system_clock_2_out_granted_clocks_0_avalon_clocks_slave & nios_system_clock_2_out_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = clocks_0_avalon_clocks_slave_in_a_read_cycle;

  //clocks_0_avalon_clocks_slave_waits_for_write in a cycle, which is an e_mux
  assign clocks_0_avalon_clocks_slave_waits_for_write = clocks_0_avalon_clocks_slave_in_a_write_cycle & 0;

  //clocks_0_avalon_clocks_slave_in_a_write_cycle assignment, which is an e_assign
  assign clocks_0_avalon_clocks_slave_in_a_write_cycle = nios_system_clock_2_out_granted_clocks_0_avalon_clocks_slave & nios_system_clock_2_out_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = clocks_0_avalon_clocks_slave_in_a_write_cycle;

  assign wait_for_clocks_0_avalon_clocks_slave_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //clocks_0/avalon_clocks_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_0_jtag_debug_module_arbitrator (
                                            // inputs:
                                             clk,
                                             cpu_0_data_master_address_to_slave,
                                             cpu_0_data_master_byteenable,
                                             cpu_0_data_master_debugaccess,
                                             cpu_0_data_master_latency_counter,
                                             cpu_0_data_master_read,
                                             cpu_0_data_master_write,
                                             cpu_0_data_master_writedata,
                                             cpu_0_instruction_master_address_to_slave,
                                             cpu_0_instruction_master_latency_counter,
                                             cpu_0_instruction_master_read,
                                             cpu_0_jtag_debug_module_readdata,
                                             cpu_0_jtag_debug_module_resetrequest,
                                             reset_n,

                                            // outputs:
                                             cpu_0_data_master_granted_cpu_0_jtag_debug_module,
                                             cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module,
                                             cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module,
                                             cpu_0_data_master_requests_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_granted_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_requests_cpu_0_jtag_debug_module,
                                             cpu_0_jtag_debug_module_address,
                                             cpu_0_jtag_debug_module_begintransfer,
                                             cpu_0_jtag_debug_module_byteenable,
                                             cpu_0_jtag_debug_module_chipselect,
                                             cpu_0_jtag_debug_module_debugaccess,
                                             cpu_0_jtag_debug_module_readdata_from_sa,
                                             cpu_0_jtag_debug_module_reset_n,
                                             cpu_0_jtag_debug_module_resetrequest_from_sa,
                                             cpu_0_jtag_debug_module_write,
                                             cpu_0_jtag_debug_module_writedata,
                                             d1_cpu_0_jtag_debug_module_end_xfer
                                          )
;

  output           cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  output           cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  output           cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  output           cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  output  [  8: 0] cpu_0_jtag_debug_module_address;
  output           cpu_0_jtag_debug_module_begintransfer;
  output  [  3: 0] cpu_0_jtag_debug_module_byteenable;
  output           cpu_0_jtag_debug_module_chipselect;
  output           cpu_0_jtag_debug_module_debugaccess;
  output  [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  output           cpu_0_jtag_debug_module_reset_n;
  output           cpu_0_jtag_debug_module_resetrequest_from_sa;
  output           cpu_0_jtag_debug_module_write;
  output  [ 31: 0] cpu_0_jtag_debug_module_writedata;
  output           d1_cpu_0_jtag_debug_module_end_xfer;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input            cpu_0_data_master_debugaccess;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 24: 0] cpu_0_instruction_master_address_to_slave;
  input            cpu_0_instruction_master_latency_counter;
  input            cpu_0_instruction_master_read;
  input   [ 31: 0] cpu_0_jtag_debug_module_readdata;
  input            cpu_0_jtag_debug_module_resetrequest;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_arbiterlock;
  wire             cpu_0_instruction_master_arbiterlock2;
  wire             cpu_0_instruction_master_continuerequest;
  wire             cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module;
  wire    [  8: 0] cpu_0_jtag_debug_module_address;
  wire             cpu_0_jtag_debug_module_allgrants;
  wire             cpu_0_jtag_debug_module_allow_new_arb_cycle;
  wire             cpu_0_jtag_debug_module_any_bursting_master_saved_grant;
  wire             cpu_0_jtag_debug_module_any_continuerequest;
  reg     [  1: 0] cpu_0_jtag_debug_module_arb_addend;
  wire             cpu_0_jtag_debug_module_arb_counter_enable;
  reg     [  2: 0] cpu_0_jtag_debug_module_arb_share_counter;
  wire    [  2: 0] cpu_0_jtag_debug_module_arb_share_counter_next_value;
  wire    [  2: 0] cpu_0_jtag_debug_module_arb_share_set_values;
  wire    [  1: 0] cpu_0_jtag_debug_module_arb_winner;
  wire             cpu_0_jtag_debug_module_arbitration_holdoff_internal;
  wire             cpu_0_jtag_debug_module_beginbursttransfer_internal;
  wire             cpu_0_jtag_debug_module_begins_xfer;
  wire             cpu_0_jtag_debug_module_begintransfer;
  wire    [  3: 0] cpu_0_jtag_debug_module_byteenable;
  wire             cpu_0_jtag_debug_module_chipselect;
  wire    [  3: 0] cpu_0_jtag_debug_module_chosen_master_double_vector;
  wire    [  1: 0] cpu_0_jtag_debug_module_chosen_master_rot_left;
  wire             cpu_0_jtag_debug_module_debugaccess;
  wire             cpu_0_jtag_debug_module_end_xfer;
  wire             cpu_0_jtag_debug_module_firsttransfer;
  wire    [  1: 0] cpu_0_jtag_debug_module_grant_vector;
  wire             cpu_0_jtag_debug_module_in_a_read_cycle;
  wire             cpu_0_jtag_debug_module_in_a_write_cycle;
  wire    [  1: 0] cpu_0_jtag_debug_module_master_qreq_vector;
  wire             cpu_0_jtag_debug_module_non_bursting_master_requests;
  wire    [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  reg              cpu_0_jtag_debug_module_reg_firsttransfer;
  wire             cpu_0_jtag_debug_module_reset_n;
  wire             cpu_0_jtag_debug_module_resetrequest_from_sa;
  reg     [  1: 0] cpu_0_jtag_debug_module_saved_chosen_master_vector;
  reg              cpu_0_jtag_debug_module_slavearbiterlockenable;
  wire             cpu_0_jtag_debug_module_slavearbiterlockenable2;
  wire             cpu_0_jtag_debug_module_unreg_firsttransfer;
  wire             cpu_0_jtag_debug_module_waits_for_read;
  wire             cpu_0_jtag_debug_module_waits_for_write;
  wire             cpu_0_jtag_debug_module_write;
  wire    [ 31: 0] cpu_0_jtag_debug_module_writedata;
  reg              d1_cpu_0_jtag_debug_module_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module;
  reg              last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module;
  wire    [ 24: 0] shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master;
  wire    [ 24: 0] shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master;
  wire             wait_for_cpu_0_jtag_debug_module_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~cpu_0_jtag_debug_module_end_xfer;
    end


  assign cpu_0_jtag_debug_module_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module));
  //assign cpu_0_jtag_debug_module_readdata_from_sa = cpu_0_jtag_debug_module_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_0_jtag_debug_module_readdata_from_sa = cpu_0_jtag_debug_module_readdata;

  assign cpu_0_data_master_requests_cpu_0_jtag_debug_module = ({cpu_0_data_master_address_to_slave[24 : 11] , 11'b0} == 25'h1000800) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //cpu_0_jtag_debug_module_arb_share_counter set values, which is an e_mux
  assign cpu_0_jtag_debug_module_arb_share_set_values = 1;

  //cpu_0_jtag_debug_module_non_bursting_master_requests mux, which is an e_mux
  assign cpu_0_jtag_debug_module_non_bursting_master_requests = cpu_0_data_master_requests_cpu_0_jtag_debug_module |
    cpu_0_instruction_master_requests_cpu_0_jtag_debug_module |
    cpu_0_data_master_requests_cpu_0_jtag_debug_module |
    cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;

  //cpu_0_jtag_debug_module_any_bursting_master_saved_grant mux, which is an e_mux
  assign cpu_0_jtag_debug_module_any_bursting_master_saved_grant = 0;

  //cpu_0_jtag_debug_module_arb_share_counter_next_value assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_arb_share_counter_next_value = cpu_0_jtag_debug_module_firsttransfer ? (cpu_0_jtag_debug_module_arb_share_set_values - 1) : |cpu_0_jtag_debug_module_arb_share_counter ? (cpu_0_jtag_debug_module_arb_share_counter - 1) : 0;

  //cpu_0_jtag_debug_module_allgrants all slave grants, which is an e_mux
  assign cpu_0_jtag_debug_module_allgrants = (|cpu_0_jtag_debug_module_grant_vector) |
    (|cpu_0_jtag_debug_module_grant_vector) |
    (|cpu_0_jtag_debug_module_grant_vector) |
    (|cpu_0_jtag_debug_module_grant_vector);

  //cpu_0_jtag_debug_module_end_xfer assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_end_xfer = ~(cpu_0_jtag_debug_module_waits_for_read | cpu_0_jtag_debug_module_waits_for_write);

  //end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_end_xfer & (~cpu_0_jtag_debug_module_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //cpu_0_jtag_debug_module_arb_share_counter arbitration counter enable, which is an e_assign
  assign cpu_0_jtag_debug_module_arb_counter_enable = (end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module & cpu_0_jtag_debug_module_allgrants) | (end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module & ~cpu_0_jtag_debug_module_non_bursting_master_requests);

  //cpu_0_jtag_debug_module_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_arb_share_counter <= 0;
      else if (cpu_0_jtag_debug_module_arb_counter_enable)
          cpu_0_jtag_debug_module_arb_share_counter <= cpu_0_jtag_debug_module_arb_share_counter_next_value;
    end


  //cpu_0_jtag_debug_module_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_slavearbiterlockenable <= 0;
      else if ((|cpu_0_jtag_debug_module_master_qreq_vector & end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module) | (end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module & ~cpu_0_jtag_debug_module_non_bursting_master_requests))
          cpu_0_jtag_debug_module_slavearbiterlockenable <= |cpu_0_jtag_debug_module_arb_share_counter_next_value;
    end


  //cpu_0/data_master cpu_0/jtag_debug_module arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = cpu_0_jtag_debug_module_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //cpu_0_jtag_debug_module_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign cpu_0_jtag_debug_module_slavearbiterlockenable2 = |cpu_0_jtag_debug_module_arb_share_counter_next_value;

  //cpu_0/data_master cpu_0/jtag_debug_module arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = cpu_0_jtag_debug_module_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //cpu_0/instruction_master cpu_0/jtag_debug_module arbiterlock, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock = cpu_0_jtag_debug_module_slavearbiterlockenable & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master cpu_0/jtag_debug_module arbiterlock2, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock2 = cpu_0_jtag_debug_module_slavearbiterlockenable2 & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master granted cpu_0/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module <= 0;
      else 
        last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module <= cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module ? 1 : (cpu_0_jtag_debug_module_arbitration_holdoff_internal | ~cpu_0_instruction_master_requests_cpu_0_jtag_debug_module) ? 0 : last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module;
    end


  //cpu_0_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_0_instruction_master_continuerequest = last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module & cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;

  //cpu_0_jtag_debug_module_any_continuerequest at least one master continues requesting, which is an e_mux
  assign cpu_0_jtag_debug_module_any_continuerequest = cpu_0_instruction_master_continuerequest |
    cpu_0_data_master_continuerequest;

  assign cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module = cpu_0_data_master_requests_cpu_0_jtag_debug_module & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))) | cpu_0_instruction_master_arbiterlock);
  //local readdatavalid cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module, which is an e_mux
  assign cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module = cpu_0_data_master_granted_cpu_0_jtag_debug_module & cpu_0_data_master_read & ~cpu_0_jtag_debug_module_waits_for_read;

  //cpu_0_jtag_debug_module_writedata mux, which is an e_mux
  assign cpu_0_jtag_debug_module_writedata = cpu_0_data_master_writedata;

  assign cpu_0_instruction_master_requests_cpu_0_jtag_debug_module = (({cpu_0_instruction_master_address_to_slave[24 : 11] , 11'b0} == 25'h1000800) & (cpu_0_instruction_master_read)) & cpu_0_instruction_master_read;
  //cpu_0/data_master granted cpu_0/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module <= 0;
      else 
        last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module <= cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module ? 1 : (cpu_0_jtag_debug_module_arbitration_holdoff_internal | ~cpu_0_data_master_requests_cpu_0_jtag_debug_module) ? 0 : last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module;
    end


  //cpu_0_data_master_continuerequest continued request, which is an e_mux
  assign cpu_0_data_master_continuerequest = last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module & cpu_0_data_master_requests_cpu_0_jtag_debug_module;

  assign cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module = cpu_0_instruction_master_requests_cpu_0_jtag_debug_module & ~((cpu_0_instruction_master_read & ((cpu_0_instruction_master_latency_counter != 0))) | cpu_0_data_master_arbiterlock);
  //local readdatavalid cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module, which is an e_mux
  assign cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module = cpu_0_instruction_master_granted_cpu_0_jtag_debug_module & cpu_0_instruction_master_read & ~cpu_0_jtag_debug_module_waits_for_read;

  //allow new arb cycle for cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_jtag_debug_module_allow_new_arb_cycle = ~cpu_0_data_master_arbiterlock & ~cpu_0_instruction_master_arbiterlock;

  //cpu_0/instruction_master assignment into master qualified-requests vector for cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_jtag_debug_module_master_qreq_vector[0] = cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;

  //cpu_0/instruction_master grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_instruction_master_granted_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_grant_vector[0];

  //cpu_0/instruction_master saved-grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_arb_winner[0] && cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;

  //cpu_0/data_master assignment into master qualified-requests vector for cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_jtag_debug_module_master_qreq_vector[1] = cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;

  //cpu_0/data_master grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_data_master_granted_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_grant_vector[1];

  //cpu_0/data_master saved-grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_arb_winner[1] && cpu_0_data_master_requests_cpu_0_jtag_debug_module;

  //cpu_0/jtag_debug_module chosen-master double-vector, which is an e_assign
  assign cpu_0_jtag_debug_module_chosen_master_double_vector = {cpu_0_jtag_debug_module_master_qreq_vector, cpu_0_jtag_debug_module_master_qreq_vector} & ({~cpu_0_jtag_debug_module_master_qreq_vector, ~cpu_0_jtag_debug_module_master_qreq_vector} + cpu_0_jtag_debug_module_arb_addend);

  //stable onehot encoding of arb winner
  assign cpu_0_jtag_debug_module_arb_winner = (cpu_0_jtag_debug_module_allow_new_arb_cycle & | cpu_0_jtag_debug_module_grant_vector) ? cpu_0_jtag_debug_module_grant_vector : cpu_0_jtag_debug_module_saved_chosen_master_vector;

  //saved cpu_0_jtag_debug_module_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_saved_chosen_master_vector <= 0;
      else if (cpu_0_jtag_debug_module_allow_new_arb_cycle)
          cpu_0_jtag_debug_module_saved_chosen_master_vector <= |cpu_0_jtag_debug_module_grant_vector ? cpu_0_jtag_debug_module_grant_vector : cpu_0_jtag_debug_module_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign cpu_0_jtag_debug_module_grant_vector = {(cpu_0_jtag_debug_module_chosen_master_double_vector[1] | cpu_0_jtag_debug_module_chosen_master_double_vector[3]),
    (cpu_0_jtag_debug_module_chosen_master_double_vector[0] | cpu_0_jtag_debug_module_chosen_master_double_vector[2])};

  //cpu_0/jtag_debug_module chosen master rotated left, which is an e_assign
  assign cpu_0_jtag_debug_module_chosen_master_rot_left = (cpu_0_jtag_debug_module_arb_winner << 1) ? (cpu_0_jtag_debug_module_arb_winner << 1) : 1;

  //cpu_0/jtag_debug_module's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_arb_addend <= 1;
      else if (|cpu_0_jtag_debug_module_grant_vector)
          cpu_0_jtag_debug_module_arb_addend <= cpu_0_jtag_debug_module_end_xfer? cpu_0_jtag_debug_module_chosen_master_rot_left : cpu_0_jtag_debug_module_grant_vector;
    end


  assign cpu_0_jtag_debug_module_begintransfer = cpu_0_jtag_debug_module_begins_xfer;
  //cpu_0_jtag_debug_module_reset_n assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_reset_n = reset_n;

  //assign cpu_0_jtag_debug_module_resetrequest_from_sa = cpu_0_jtag_debug_module_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_0_jtag_debug_module_resetrequest_from_sa = cpu_0_jtag_debug_module_resetrequest;

  assign cpu_0_jtag_debug_module_chipselect = cpu_0_data_master_granted_cpu_0_jtag_debug_module | cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  //cpu_0_jtag_debug_module_firsttransfer first transaction, which is an e_assign
  assign cpu_0_jtag_debug_module_firsttransfer = cpu_0_jtag_debug_module_begins_xfer ? cpu_0_jtag_debug_module_unreg_firsttransfer : cpu_0_jtag_debug_module_reg_firsttransfer;

  //cpu_0_jtag_debug_module_unreg_firsttransfer first transaction, which is an e_assign
  assign cpu_0_jtag_debug_module_unreg_firsttransfer = ~(cpu_0_jtag_debug_module_slavearbiterlockenable & cpu_0_jtag_debug_module_any_continuerequest);

  //cpu_0_jtag_debug_module_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_reg_firsttransfer <= 1'b1;
      else if (cpu_0_jtag_debug_module_begins_xfer)
          cpu_0_jtag_debug_module_reg_firsttransfer <= cpu_0_jtag_debug_module_unreg_firsttransfer;
    end


  //cpu_0_jtag_debug_module_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign cpu_0_jtag_debug_module_beginbursttransfer_internal = cpu_0_jtag_debug_module_begins_xfer;

  //cpu_0_jtag_debug_module_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign cpu_0_jtag_debug_module_arbitration_holdoff_internal = cpu_0_jtag_debug_module_begins_xfer & cpu_0_jtag_debug_module_firsttransfer;

  //cpu_0_jtag_debug_module_write assignment, which is an e_mux
  assign cpu_0_jtag_debug_module_write = cpu_0_data_master_granted_cpu_0_jtag_debug_module & cpu_0_data_master_write;

  assign shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //cpu_0_jtag_debug_module_address mux, which is an e_mux
  assign cpu_0_jtag_debug_module_address = (cpu_0_data_master_granted_cpu_0_jtag_debug_module)? (shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master >> 2) :
    (shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master >> 2);

  assign shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master = cpu_0_instruction_master_address_to_slave;
  //d1_cpu_0_jtag_debug_module_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_cpu_0_jtag_debug_module_end_xfer <= 1;
      else 
        d1_cpu_0_jtag_debug_module_end_xfer <= cpu_0_jtag_debug_module_end_xfer;
    end


  //cpu_0_jtag_debug_module_waits_for_read in a cycle, which is an e_mux
  assign cpu_0_jtag_debug_module_waits_for_read = cpu_0_jtag_debug_module_in_a_read_cycle & cpu_0_jtag_debug_module_begins_xfer;

  //cpu_0_jtag_debug_module_in_a_read_cycle assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_in_a_read_cycle = (cpu_0_data_master_granted_cpu_0_jtag_debug_module & cpu_0_data_master_read) | (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module & cpu_0_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = cpu_0_jtag_debug_module_in_a_read_cycle;

  //cpu_0_jtag_debug_module_waits_for_write in a cycle, which is an e_mux
  assign cpu_0_jtag_debug_module_waits_for_write = cpu_0_jtag_debug_module_in_a_write_cycle & 0;

  //cpu_0_jtag_debug_module_in_a_write_cycle assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_in_a_write_cycle = cpu_0_data_master_granted_cpu_0_jtag_debug_module & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = cpu_0_jtag_debug_module_in_a_write_cycle;

  assign wait_for_cpu_0_jtag_debug_module_counter = 0;
  //cpu_0_jtag_debug_module_byteenable byte enable port mux, which is an e_mux
  assign cpu_0_jtag_debug_module_byteenable = (cpu_0_data_master_granted_cpu_0_jtag_debug_module)? cpu_0_data_master_byteenable :
    -1;

  //debugaccess mux, which is an e_mux
  assign cpu_0_jtag_debug_module_debugaccess = (cpu_0_data_master_granted_cpu_0_jtag_debug_module)? cpu_0_data_master_debugaccess :
    0;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_0/jtag_debug_module enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_granted_cpu_0_jtag_debug_module + cpu_0_instruction_master_granted_cpu_0_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module + cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_0_data_master_arbitrator (
                                      // inputs:
                                       HEX0_s1_readdata_from_sa,
                                       HEX1_s1_readdata_from_sa,
                                       HEX2_s1_readdata_from_sa,
                                       HEX3_s1_readdata_from_sa,
                                       HEX4_s1_readdata_from_sa,
                                       HEX5_s1_readdata_from_sa,
                                       HEX6_s1_readdata_from_sa,
                                       HEX7_s1_readdata_from_sa,
                                       clk,
                                       cpu_0_data_master_address,
                                       cpu_0_data_master_byteenable,
                                       cpu_0_data_master_byteenable_nios_system_clock_1_in,
                                       cpu_0_data_master_byteenable_nios_system_clock_2_in,
                                       cpu_0_data_master_granted_HEX0_s1,
                                       cpu_0_data_master_granted_HEX1_s1,
                                       cpu_0_data_master_granted_HEX2_s1,
                                       cpu_0_data_master_granted_HEX3_s1,
                                       cpu_0_data_master_granted_HEX4_s1,
                                       cpu_0_data_master_granted_HEX5_s1,
                                       cpu_0_data_master_granted_HEX6_s1,
                                       cpu_0_data_master_granted_HEX7_s1,
                                       cpu_0_data_master_granted_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave,
                                       cpu_0_data_master_granted_keys_s1,
                                       cpu_0_data_master_granted_lcd_0_control_slave,
                                       cpu_0_data_master_granted_leds_s1,
                                       cpu_0_data_master_granted_nios_system_clock_1_in,
                                       cpu_0_data_master_granted_nios_system_clock_2_in,
                                       cpu_0_data_master_granted_sysid_control_slave,
                                       cpu_0_data_master_qualified_request_HEX0_s1,
                                       cpu_0_data_master_qualified_request_HEX1_s1,
                                       cpu_0_data_master_qualified_request_HEX2_s1,
                                       cpu_0_data_master_qualified_request_HEX3_s1,
                                       cpu_0_data_master_qualified_request_HEX4_s1,
                                       cpu_0_data_master_qualified_request_HEX5_s1,
                                       cpu_0_data_master_qualified_request_HEX6_s1,
                                       cpu_0_data_master_qualified_request_HEX7_s1,
                                       cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave,
                                       cpu_0_data_master_qualified_request_keys_s1,
                                       cpu_0_data_master_qualified_request_lcd_0_control_slave,
                                       cpu_0_data_master_qualified_request_leds_s1,
                                       cpu_0_data_master_qualified_request_nios_system_clock_1_in,
                                       cpu_0_data_master_qualified_request_nios_system_clock_2_in,
                                       cpu_0_data_master_qualified_request_sysid_control_slave,
                                       cpu_0_data_master_read,
                                       cpu_0_data_master_read_data_valid_HEX0_s1,
                                       cpu_0_data_master_read_data_valid_HEX1_s1,
                                       cpu_0_data_master_read_data_valid_HEX2_s1,
                                       cpu_0_data_master_read_data_valid_HEX3_s1,
                                       cpu_0_data_master_read_data_valid_HEX4_s1,
                                       cpu_0_data_master_read_data_valid_HEX5_s1,
                                       cpu_0_data_master_read_data_valid_HEX6_s1,
                                       cpu_0_data_master_read_data_valid_HEX7_s1,
                                       cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave,
                                       cpu_0_data_master_read_data_valid_keys_s1,
                                       cpu_0_data_master_read_data_valid_lcd_0_control_slave,
                                       cpu_0_data_master_read_data_valid_leds_s1,
                                       cpu_0_data_master_read_data_valid_nios_system_clock_1_in,
                                       cpu_0_data_master_read_data_valid_nios_system_clock_2_in,
                                       cpu_0_data_master_read_data_valid_sysid_control_slave,
                                       cpu_0_data_master_requests_HEX0_s1,
                                       cpu_0_data_master_requests_HEX1_s1,
                                       cpu_0_data_master_requests_HEX2_s1,
                                       cpu_0_data_master_requests_HEX3_s1,
                                       cpu_0_data_master_requests_HEX4_s1,
                                       cpu_0_data_master_requests_HEX5_s1,
                                       cpu_0_data_master_requests_HEX6_s1,
                                       cpu_0_data_master_requests_HEX7_s1,
                                       cpu_0_data_master_requests_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave,
                                       cpu_0_data_master_requests_keys_s1,
                                       cpu_0_data_master_requests_lcd_0_control_slave,
                                       cpu_0_data_master_requests_leds_s1,
                                       cpu_0_data_master_requests_nios_system_clock_1_in,
                                       cpu_0_data_master_requests_nios_system_clock_2_in,
                                       cpu_0_data_master_requests_sysid_control_slave,
                                       cpu_0_data_master_write,
                                       cpu_0_data_master_writedata,
                                       cpu_0_jtag_debug_module_readdata_from_sa,
                                       d1_HEX0_s1_end_xfer,
                                       d1_HEX1_s1_end_xfer,
                                       d1_HEX2_s1_end_xfer,
                                       d1_HEX3_s1_end_xfer,
                                       d1_HEX4_s1_end_xfer,
                                       d1_HEX5_s1_end_xfer,
                                       d1_HEX6_s1_end_xfer,
                                       d1_HEX7_s1_end_xfer,
                                       d1_cpu_0_jtag_debug_module_end_xfer,
                                       d1_jtag_uart_0_avalon_jtag_slave_end_xfer,
                                       d1_keys_s1_end_xfer,
                                       d1_lcd_0_control_slave_end_xfer,
                                       d1_leds_s1_end_xfer,
                                       d1_nios_system_clock_1_in_end_xfer,
                                       d1_nios_system_clock_2_in_end_xfer,
                                       d1_sysid_control_slave_end_xfer,
                                       jtag_uart_0_avalon_jtag_slave_irq_from_sa,
                                       jtag_uart_0_avalon_jtag_slave_readdata_from_sa,
                                       jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa,
                                       keys_s1_readdata_from_sa,
                                       lcd_0_control_slave_readdata_from_sa,
                                       lcd_0_control_slave_wait_counter_eq_0,
                                       leds_s1_readdata_from_sa,
                                       nios_system_clock_1_in_readdata_from_sa,
                                       nios_system_clock_1_in_waitrequest_from_sa,
                                       nios_system_clock_2_in_readdata_from_sa,
                                       nios_system_clock_2_in_waitrequest_from_sa,
                                       reset_n,
                                       sysid_control_slave_readdata_from_sa,

                                      // outputs:
                                       cpu_0_data_master_address_to_slave,
                                       cpu_0_data_master_dbs_address,
                                       cpu_0_data_master_dbs_write_16,
                                       cpu_0_data_master_dbs_write_8,
                                       cpu_0_data_master_irq,
                                       cpu_0_data_master_latency_counter,
                                       cpu_0_data_master_readdata,
                                       cpu_0_data_master_readdatavalid,
                                       cpu_0_data_master_waitrequest
                                    )
;

  output  [ 24: 0] cpu_0_data_master_address_to_slave;
  output  [  1: 0] cpu_0_data_master_dbs_address;
  output  [ 15: 0] cpu_0_data_master_dbs_write_16;
  output  [  7: 0] cpu_0_data_master_dbs_write_8;
  output  [ 31: 0] cpu_0_data_master_irq;
  output           cpu_0_data_master_latency_counter;
  output  [ 31: 0] cpu_0_data_master_readdata;
  output           cpu_0_data_master_readdatavalid;
  output           cpu_0_data_master_waitrequest;
  input   [ 31: 0] HEX0_s1_readdata_from_sa;
  input   [ 31: 0] HEX1_s1_readdata_from_sa;
  input   [ 31: 0] HEX2_s1_readdata_from_sa;
  input   [ 31: 0] HEX3_s1_readdata_from_sa;
  input   [ 31: 0] HEX4_s1_readdata_from_sa;
  input   [ 31: 0] HEX5_s1_readdata_from_sa;
  input   [ 31: 0] HEX6_s1_readdata_from_sa;
  input   [ 31: 0] HEX7_s1_readdata_from_sa;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input   [  1: 0] cpu_0_data_master_byteenable_nios_system_clock_1_in;
  input            cpu_0_data_master_byteenable_nios_system_clock_2_in;
  input            cpu_0_data_master_granted_HEX0_s1;
  input            cpu_0_data_master_granted_HEX1_s1;
  input            cpu_0_data_master_granted_HEX2_s1;
  input            cpu_0_data_master_granted_HEX3_s1;
  input            cpu_0_data_master_granted_HEX4_s1;
  input            cpu_0_data_master_granted_HEX5_s1;
  input            cpu_0_data_master_granted_HEX6_s1;
  input            cpu_0_data_master_granted_HEX7_s1;
  input            cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  input            cpu_0_data_master_granted_keys_s1;
  input            cpu_0_data_master_granted_lcd_0_control_slave;
  input            cpu_0_data_master_granted_leds_s1;
  input            cpu_0_data_master_granted_nios_system_clock_1_in;
  input            cpu_0_data_master_granted_nios_system_clock_2_in;
  input            cpu_0_data_master_granted_sysid_control_slave;
  input            cpu_0_data_master_qualified_request_HEX0_s1;
  input            cpu_0_data_master_qualified_request_HEX1_s1;
  input            cpu_0_data_master_qualified_request_HEX2_s1;
  input            cpu_0_data_master_qualified_request_HEX3_s1;
  input            cpu_0_data_master_qualified_request_HEX4_s1;
  input            cpu_0_data_master_qualified_request_HEX5_s1;
  input            cpu_0_data_master_qualified_request_HEX6_s1;
  input            cpu_0_data_master_qualified_request_HEX7_s1;
  input            cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  input            cpu_0_data_master_qualified_request_keys_s1;
  input            cpu_0_data_master_qualified_request_lcd_0_control_slave;
  input            cpu_0_data_master_qualified_request_leds_s1;
  input            cpu_0_data_master_qualified_request_nios_system_clock_1_in;
  input            cpu_0_data_master_qualified_request_nios_system_clock_2_in;
  input            cpu_0_data_master_qualified_request_sysid_control_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_read_data_valid_HEX0_s1;
  input            cpu_0_data_master_read_data_valid_HEX1_s1;
  input            cpu_0_data_master_read_data_valid_HEX2_s1;
  input            cpu_0_data_master_read_data_valid_HEX3_s1;
  input            cpu_0_data_master_read_data_valid_HEX4_s1;
  input            cpu_0_data_master_read_data_valid_HEX5_s1;
  input            cpu_0_data_master_read_data_valid_HEX6_s1;
  input            cpu_0_data_master_read_data_valid_HEX7_s1;
  input            cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave;
  input            cpu_0_data_master_read_data_valid_keys_s1;
  input            cpu_0_data_master_read_data_valid_lcd_0_control_slave;
  input            cpu_0_data_master_read_data_valid_leds_s1;
  input            cpu_0_data_master_read_data_valid_nios_system_clock_1_in;
  input            cpu_0_data_master_read_data_valid_nios_system_clock_2_in;
  input            cpu_0_data_master_read_data_valid_sysid_control_slave;
  input            cpu_0_data_master_requests_HEX0_s1;
  input            cpu_0_data_master_requests_HEX1_s1;
  input            cpu_0_data_master_requests_HEX2_s1;
  input            cpu_0_data_master_requests_HEX3_s1;
  input            cpu_0_data_master_requests_HEX4_s1;
  input            cpu_0_data_master_requests_HEX5_s1;
  input            cpu_0_data_master_requests_HEX6_s1;
  input            cpu_0_data_master_requests_HEX7_s1;
  input            cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  input            cpu_0_data_master_requests_keys_s1;
  input            cpu_0_data_master_requests_lcd_0_control_slave;
  input            cpu_0_data_master_requests_leds_s1;
  input            cpu_0_data_master_requests_nios_system_clock_1_in;
  input            cpu_0_data_master_requests_nios_system_clock_2_in;
  input            cpu_0_data_master_requests_sysid_control_slave;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  input            d1_HEX0_s1_end_xfer;
  input            d1_HEX1_s1_end_xfer;
  input            d1_HEX2_s1_end_xfer;
  input            d1_HEX3_s1_end_xfer;
  input            d1_HEX4_s1_end_xfer;
  input            d1_HEX5_s1_end_xfer;
  input            d1_HEX6_s1_end_xfer;
  input            d1_HEX7_s1_end_xfer;
  input            d1_cpu_0_jtag_debug_module_end_xfer;
  input            d1_jtag_uart_0_avalon_jtag_slave_end_xfer;
  input            d1_keys_s1_end_xfer;
  input            d1_lcd_0_control_slave_end_xfer;
  input            d1_leds_s1_end_xfer;
  input            d1_nios_system_clock_1_in_end_xfer;
  input            d1_nios_system_clock_2_in_end_xfer;
  input            d1_sysid_control_slave_end_xfer;
  input            jtag_uart_0_avalon_jtag_slave_irq_from_sa;
  input   [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata_from_sa;
  input            jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  input   [ 31: 0] keys_s1_readdata_from_sa;
  input   [  7: 0] lcd_0_control_slave_readdata_from_sa;
  input            lcd_0_control_slave_wait_counter_eq_0;
  input   [ 31: 0] leds_s1_readdata_from_sa;
  input   [ 15: 0] nios_system_clock_1_in_readdata_from_sa;
  input            nios_system_clock_1_in_waitrequest_from_sa;
  input   [  7: 0] nios_system_clock_2_in_readdata_from_sa;
  input            nios_system_clock_2_in_waitrequest_from_sa;
  input            reset_n;
  input   [ 31: 0] sysid_control_slave_readdata_from_sa;

  reg              active_and_waiting_last_time;
  reg     [ 24: 0] cpu_0_data_master_address_last_time;
  wire    [ 24: 0] cpu_0_data_master_address_to_slave;
  reg     [  3: 0] cpu_0_data_master_byteenable_last_time;
  reg     [  1: 0] cpu_0_data_master_dbs_address;
  wire    [  1: 0] cpu_0_data_master_dbs_increment;
  wire    [ 15: 0] cpu_0_data_master_dbs_write_16;
  wire    [  7: 0] cpu_0_data_master_dbs_write_8;
  wire    [ 31: 0] cpu_0_data_master_irq;
  wire             cpu_0_data_master_is_granted_some_slave;
  reg              cpu_0_data_master_latency_counter;
  reg              cpu_0_data_master_read_but_no_slave_selected;
  reg              cpu_0_data_master_read_last_time;
  wire    [ 31: 0] cpu_0_data_master_readdata;
  wire             cpu_0_data_master_readdatavalid;
  wire             cpu_0_data_master_run;
  wire             cpu_0_data_master_waitrequest;
  reg              cpu_0_data_master_write_last_time;
  reg     [ 31: 0] cpu_0_data_master_writedata_last_time;
  reg     [ 15: 0] dbs_16_reg_segment_0;
  reg     [  7: 0] dbs_8_reg_segment_0;
  reg     [  7: 0] dbs_8_reg_segment_1;
  reg     [  7: 0] dbs_8_reg_segment_2;
  wire             dbs_count_enable;
  wire             dbs_counter_overflow;
  wire             latency_load_value;
  wire    [  1: 0] next_dbs_address;
  wire             p1_cpu_0_data_master_latency_counter;
  wire    [ 15: 0] p1_dbs_16_reg_segment_0;
  wire    [  7: 0] p1_dbs_8_reg_segment_0;
  wire    [  7: 0] p1_dbs_8_reg_segment_1;
  wire    [  7: 0] p1_dbs_8_reg_segment_2;
  wire             pre_dbs_count_enable;
  wire             pre_flush_cpu_0_data_master_readdatavalid;
  wire             r_0;
  wire             r_1;
  wire             r_2;
  wire             r_3;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & (cpu_0_data_master_qualified_request_HEX0_s1 | ~cpu_0_data_master_requests_HEX0_s1) & ((~cpu_0_data_master_qualified_request_HEX0_s1 | ~cpu_0_data_master_read | (1 & ~d1_HEX0_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_HEX0_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_HEX1_s1 | ~cpu_0_data_master_requests_HEX1_s1) & ((~cpu_0_data_master_qualified_request_HEX1_s1 | ~cpu_0_data_master_read | (1 & ~d1_HEX1_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_HEX1_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_HEX2_s1 | ~cpu_0_data_master_requests_HEX2_s1) & ((~cpu_0_data_master_qualified_request_HEX2_s1 | ~cpu_0_data_master_read | (1 & ~d1_HEX2_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_HEX2_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_HEX3_s1 | ~cpu_0_data_master_requests_HEX3_s1) & ((~cpu_0_data_master_qualified_request_HEX3_s1 | ~cpu_0_data_master_read | (1 & ~d1_HEX3_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_HEX3_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_HEX4_s1 | ~cpu_0_data_master_requests_HEX4_s1) & ((~cpu_0_data_master_qualified_request_HEX4_s1 | ~cpu_0_data_master_read | (1 & ~d1_HEX4_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_HEX4_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write)));

  //cascaded wait assignment, which is an e_assign
  assign cpu_0_data_master_run = r_0 & r_1 & r_2 & r_3;

  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = 1 & (cpu_0_data_master_qualified_request_HEX5_s1 | ~cpu_0_data_master_requests_HEX5_s1) & ((~cpu_0_data_master_qualified_request_HEX5_s1 | ~cpu_0_data_master_read | (1 & ~d1_HEX5_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_HEX5_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_HEX6_s1 | ~cpu_0_data_master_requests_HEX6_s1) & ((~cpu_0_data_master_qualified_request_HEX6_s1 | ~cpu_0_data_master_read | (1 & ~d1_HEX6_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_HEX6_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_HEX7_s1 | ~cpu_0_data_master_requests_HEX7_s1) & ((~cpu_0_data_master_qualified_request_HEX7_s1 | ~cpu_0_data_master_read | (1 & ~d1_HEX7_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_HEX7_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_data_master_requests_cpu_0_jtag_debug_module) & (cpu_0_data_master_granted_cpu_0_jtag_debug_module | ~cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module) & ((~cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_data_master_read | (1 & ~d1_cpu_0_jtag_debug_module_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave | ~cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave) & ((~cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & ~jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa & (cpu_0_data_master_read | cpu_0_data_master_write))));

  //r_2 master_run cascaded wait assignment, which is an e_assign
  assign r_2 = ((~cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & ~jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa & (cpu_0_data_master_read | cpu_0_data_master_write)))) & 1 & (cpu_0_data_master_qualified_request_keys_s1 | ~cpu_0_data_master_requests_keys_s1) & ((~cpu_0_data_master_qualified_request_keys_s1 | ~cpu_0_data_master_read | (1 & ~d1_keys_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_keys_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_lcd_0_control_slave | ~cpu_0_data_master_requests_lcd_0_control_slave) & ((~cpu_0_data_master_qualified_request_lcd_0_control_slave | ~cpu_0_data_master_read | (1 & ((lcd_0_control_slave_wait_counter_eq_0 & ~d1_lcd_0_control_slave_end_xfer)) & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_lcd_0_control_slave | ~cpu_0_data_master_write | (1 & ((lcd_0_control_slave_wait_counter_eq_0 & ~d1_lcd_0_control_slave_end_xfer)) & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_leds_s1 | ~cpu_0_data_master_requests_leds_s1) & ((~cpu_0_data_master_qualified_request_leds_s1 | ~cpu_0_data_master_read | (1 & ~d1_leds_s1_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_leds_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_nios_system_clock_1_in | (cpu_0_data_master_write & !cpu_0_data_master_byteenable_nios_system_clock_1_in & cpu_0_data_master_dbs_address[1]) | ~cpu_0_data_master_requests_nios_system_clock_1_in) & ((~cpu_0_data_master_qualified_request_nios_system_clock_1_in | ~cpu_0_data_master_read | (1 & ~nios_system_clock_1_in_waitrequest_from_sa & (cpu_0_data_master_dbs_address[1]) & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_nios_system_clock_1_in | ~cpu_0_data_master_write | (1 & ~nios_system_clock_1_in_waitrequest_from_sa & (cpu_0_data_master_dbs_address[1]) & cpu_0_data_master_write))) & 1 & ((cpu_0_data_master_qualified_request_nios_system_clock_2_in | ((cpu_0_data_master_write & !cpu_0_data_master_byteenable_nios_system_clock_2_in & cpu_0_data_master_dbs_address[1] & cpu_0_data_master_dbs_address[0])) | ~cpu_0_data_master_requests_nios_system_clock_2_in)) & ((~cpu_0_data_master_qualified_request_nios_system_clock_2_in | ~cpu_0_data_master_read | (1 & ~nios_system_clock_2_in_waitrequest_from_sa & (cpu_0_data_master_dbs_address[1] & cpu_0_data_master_dbs_address[0]) & cpu_0_data_master_read)));

  //r_3 master_run cascaded wait assignment, which is an e_assign
  assign r_3 = ((~cpu_0_data_master_qualified_request_nios_system_clock_2_in | ~cpu_0_data_master_write | (1 & ~nios_system_clock_2_in_waitrequest_from_sa & (cpu_0_data_master_dbs_address[1] & cpu_0_data_master_dbs_address[0]) & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_sysid_control_slave | ~cpu_0_data_master_requests_sysid_control_slave) & ((~cpu_0_data_master_qualified_request_sysid_control_slave | ~cpu_0_data_master_read | (1 & ~d1_sysid_control_slave_end_xfer & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_sysid_control_slave | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write)));

  //optimize select-logic by passing only those address bits which matter.
  assign cpu_0_data_master_address_to_slave = cpu_0_data_master_address[24 : 0];

  //cpu_0_data_master_read_but_no_slave_selected assignment, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_read_but_no_slave_selected <= 0;
      else 
        cpu_0_data_master_read_but_no_slave_selected <= cpu_0_data_master_read & cpu_0_data_master_run & ~cpu_0_data_master_is_granted_some_slave;
    end


  //some slave is getting selected, which is an e_mux
  assign cpu_0_data_master_is_granted_some_slave = cpu_0_data_master_granted_HEX0_s1 |
    cpu_0_data_master_granted_HEX1_s1 |
    cpu_0_data_master_granted_HEX2_s1 |
    cpu_0_data_master_granted_HEX3_s1 |
    cpu_0_data_master_granted_HEX4_s1 |
    cpu_0_data_master_granted_HEX5_s1 |
    cpu_0_data_master_granted_HEX6_s1 |
    cpu_0_data_master_granted_HEX7_s1 |
    cpu_0_data_master_granted_cpu_0_jtag_debug_module |
    cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave |
    cpu_0_data_master_granted_keys_s1 |
    cpu_0_data_master_granted_lcd_0_control_slave |
    cpu_0_data_master_granted_leds_s1 |
    cpu_0_data_master_granted_nios_system_clock_1_in |
    cpu_0_data_master_granted_nios_system_clock_2_in |
    cpu_0_data_master_granted_sysid_control_slave;

  //latent slave read data valids which may be flushed, which is an e_mux
  assign pre_flush_cpu_0_data_master_readdatavalid = 0;

  //latent slave read data valid which is not flushed, which is an e_mux
  assign cpu_0_data_master_readdatavalid = cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_HEX0_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_HEX1_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_HEX2_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_HEX3_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_HEX4_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_HEX5_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_HEX6_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_HEX7_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_keys_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_lcd_0_control_slave |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_leds_s1 |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    (cpu_0_data_master_read_data_valid_nios_system_clock_1_in & dbs_counter_overflow) |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    (cpu_0_data_master_read_data_valid_nios_system_clock_2_in & dbs_counter_overflow) |
    cpu_0_data_master_read_but_no_slave_selected |
    pre_flush_cpu_0_data_master_readdatavalid |
    cpu_0_data_master_read_data_valid_sysid_control_slave;

  //cpu_0/data_master readdata mux, which is an e_mux
  assign cpu_0_data_master_readdata = ({32 {~(cpu_0_data_master_qualified_request_HEX0_s1 & cpu_0_data_master_read)}} | HEX0_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_HEX1_s1 & cpu_0_data_master_read)}} | HEX1_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_HEX2_s1 & cpu_0_data_master_read)}} | HEX2_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_HEX3_s1 & cpu_0_data_master_read)}} | HEX3_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_HEX4_s1 & cpu_0_data_master_read)}} | HEX4_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_HEX5_s1 & cpu_0_data_master_read)}} | HEX5_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_HEX6_s1 & cpu_0_data_master_read)}} | HEX6_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_HEX7_s1 & cpu_0_data_master_read)}} | HEX7_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module & cpu_0_data_master_read)}} | cpu_0_jtag_debug_module_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_read)}} | jtag_uart_0_avalon_jtag_slave_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_keys_s1 & cpu_0_data_master_read)}} | keys_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_lcd_0_control_slave & cpu_0_data_master_read)}} | lcd_0_control_slave_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_leds_s1 & cpu_0_data_master_read)}} | leds_s1_readdata_from_sa) &
    ({32 {~(cpu_0_data_master_qualified_request_nios_system_clock_1_in & cpu_0_data_master_read)}} | {nios_system_clock_1_in_readdata_from_sa[15 : 0],
    dbs_16_reg_segment_0}) &
    ({32 {~(cpu_0_data_master_qualified_request_nios_system_clock_2_in & cpu_0_data_master_read)}} | {nios_system_clock_2_in_readdata_from_sa[7 : 0],
    dbs_8_reg_segment_2,
    dbs_8_reg_segment_1,
    dbs_8_reg_segment_0}) &
    ({32 {~(cpu_0_data_master_qualified_request_sysid_control_slave & cpu_0_data_master_read)}} | sysid_control_slave_readdata_from_sa);

  //actual waitrequest port, which is an e_assign
  assign cpu_0_data_master_waitrequest = ~cpu_0_data_master_run;

  //latent max counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_latency_counter <= 0;
      else 
        cpu_0_data_master_latency_counter <= p1_cpu_0_data_master_latency_counter;
    end


  //latency counter load mux, which is an e_mux
  assign p1_cpu_0_data_master_latency_counter = ((cpu_0_data_master_run & cpu_0_data_master_read))? latency_load_value :
    (cpu_0_data_master_latency_counter)? cpu_0_data_master_latency_counter - 1 :
    0;

  //read latency load values, which is an e_mux
  assign latency_load_value = 0;

  //irq assign, which is an e_assign
  assign cpu_0_data_master_irq = {1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    jtag_uart_0_avalon_jtag_slave_irq_from_sa};

  //pre dbs count enable, which is an e_mux
  assign pre_dbs_count_enable = (((~0) & cpu_0_data_master_requests_nios_system_clock_1_in & cpu_0_data_master_write & !cpu_0_data_master_byteenable_nios_system_clock_1_in)) |
    (cpu_0_data_master_granted_nios_system_clock_1_in & cpu_0_data_master_read & 1 & 1 & ~nios_system_clock_1_in_waitrequest_from_sa) |
    (cpu_0_data_master_granted_nios_system_clock_1_in & cpu_0_data_master_write & 1 & 1 & ~nios_system_clock_1_in_waitrequest_from_sa) |
    (((~0) & cpu_0_data_master_requests_nios_system_clock_2_in & cpu_0_data_master_write & !cpu_0_data_master_byteenable_nios_system_clock_2_in)) |
    (cpu_0_data_master_granted_nios_system_clock_2_in & cpu_0_data_master_read & 1 & 1 & ~nios_system_clock_2_in_waitrequest_from_sa) |
    (cpu_0_data_master_granted_nios_system_clock_2_in & cpu_0_data_master_write & 1 & 1 & ~nios_system_clock_2_in_waitrequest_from_sa);

  //input to dbs-16 stored 0, which is an e_mux
  assign p1_dbs_16_reg_segment_0 = nios_system_clock_1_in_readdata_from_sa;

  //dbs register for dbs-16 segment 0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_16_reg_segment_0 <= 0;
      else if (dbs_count_enable & ((cpu_0_data_master_dbs_address[1]) == 0))
          dbs_16_reg_segment_0 <= p1_dbs_16_reg_segment_0;
    end


  //mux write dbs 1, which is an e_mux
  assign cpu_0_data_master_dbs_write_16 = (cpu_0_data_master_dbs_address[1])? cpu_0_data_master_writedata[31 : 16] :
    cpu_0_data_master_writedata[15 : 0];

  //dbs count increment, which is an e_mux
  assign cpu_0_data_master_dbs_increment = (cpu_0_data_master_requests_nios_system_clock_1_in)? 2 :
    (cpu_0_data_master_requests_nios_system_clock_2_in)? 1 :
    0;

  //dbs counter overflow, which is an e_assign
  assign dbs_counter_overflow = cpu_0_data_master_dbs_address[1] & !(next_dbs_address[1]);

  //next master address, which is an e_assign
  assign next_dbs_address = cpu_0_data_master_dbs_address + cpu_0_data_master_dbs_increment;

  //dbs count enable, which is an e_mux
  assign dbs_count_enable = pre_dbs_count_enable;

  //dbs counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_dbs_address <= 0;
      else if (dbs_count_enable)
          cpu_0_data_master_dbs_address <= next_dbs_address;
    end


  //input to dbs-8 stored 0, which is an e_mux
  assign p1_dbs_8_reg_segment_0 = nios_system_clock_2_in_readdata_from_sa;

  //dbs register for dbs-8 segment 0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_8_reg_segment_0 <= 0;
      else if (dbs_count_enable & ((cpu_0_data_master_dbs_address[1 : 0]) == 0))
          dbs_8_reg_segment_0 <= p1_dbs_8_reg_segment_0;
    end


  //input to dbs-8 stored 1, which is an e_mux
  assign p1_dbs_8_reg_segment_1 = nios_system_clock_2_in_readdata_from_sa;

  //dbs register for dbs-8 segment 1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_8_reg_segment_1 <= 0;
      else if (dbs_count_enable & ((cpu_0_data_master_dbs_address[1 : 0]) == 1))
          dbs_8_reg_segment_1 <= p1_dbs_8_reg_segment_1;
    end


  //input to dbs-8 stored 2, which is an e_mux
  assign p1_dbs_8_reg_segment_2 = nios_system_clock_2_in_readdata_from_sa;

  //dbs register for dbs-8 segment 2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_8_reg_segment_2 <= 0;
      else if (dbs_count_enable & ((cpu_0_data_master_dbs_address[1 : 0]) == 2))
          dbs_8_reg_segment_2 <= p1_dbs_8_reg_segment_2;
    end


  //mux write dbs 2, which is an e_mux
  assign cpu_0_data_master_dbs_write_8 = ((cpu_0_data_master_dbs_address[1 : 0] == 0))? cpu_0_data_master_writedata[7 : 0] :
    ((cpu_0_data_master_dbs_address[1 : 0] == 1))? cpu_0_data_master_writedata[15 : 8] :
    ((cpu_0_data_master_dbs_address[1 : 0] == 2))? cpu_0_data_master_writedata[23 : 16] :
    cpu_0_data_master_writedata[31 : 24];


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_0_data_master_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_address_last_time <= 0;
      else 
        cpu_0_data_master_address_last_time <= cpu_0_data_master_address;
    end


  //cpu_0/data_master waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= cpu_0_data_master_waitrequest & (cpu_0_data_master_read | cpu_0_data_master_write);
    end


  //cpu_0_data_master_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_data_master_address != cpu_0_data_master_address_last_time))
        begin
          $write("%0d ns: cpu_0_data_master_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_0_data_master_byteenable check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_byteenable_last_time <= 0;
      else 
        cpu_0_data_master_byteenable_last_time <= cpu_0_data_master_byteenable;
    end


  //cpu_0_data_master_byteenable matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_data_master_byteenable != cpu_0_data_master_byteenable_last_time))
        begin
          $write("%0d ns: cpu_0_data_master_byteenable did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_0_data_master_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_read_last_time <= 0;
      else 
        cpu_0_data_master_read_last_time <= cpu_0_data_master_read;
    end


  //cpu_0_data_master_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_data_master_read != cpu_0_data_master_read_last_time))
        begin
          $write("%0d ns: cpu_0_data_master_read did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_0_data_master_write check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_write_last_time <= 0;
      else 
        cpu_0_data_master_write_last_time <= cpu_0_data_master_write;
    end


  //cpu_0_data_master_write matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_data_master_write != cpu_0_data_master_write_last_time))
        begin
          $write("%0d ns: cpu_0_data_master_write did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_0_data_master_writedata check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_writedata_last_time <= 0;
      else 
        cpu_0_data_master_writedata_last_time <= cpu_0_data_master_writedata;
    end


  //cpu_0_data_master_writedata matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_data_master_writedata != cpu_0_data_master_writedata_last_time) & cpu_0_data_master_write)
        begin
          $write("%0d ns: cpu_0_data_master_writedata did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_0_instruction_master_arbitrator (
                                             // inputs:
                                              clk,
                                              cpu_0_instruction_master_address,
                                              cpu_0_instruction_master_granted_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_granted_nios_system_clock_0_in,
                                              cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_qualified_request_nios_system_clock_0_in,
                                              cpu_0_instruction_master_read,
                                              cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_read_data_valid_nios_system_clock_0_in,
                                              cpu_0_instruction_master_requests_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_requests_nios_system_clock_0_in,
                                              cpu_0_jtag_debug_module_readdata_from_sa,
                                              d1_cpu_0_jtag_debug_module_end_xfer,
                                              d1_nios_system_clock_0_in_end_xfer,
                                              nios_system_clock_0_in_readdata_from_sa,
                                              nios_system_clock_0_in_waitrequest_from_sa,
                                              reset_n,

                                             // outputs:
                                              cpu_0_instruction_master_address_to_slave,
                                              cpu_0_instruction_master_dbs_address,
                                              cpu_0_instruction_master_latency_counter,
                                              cpu_0_instruction_master_readdata,
                                              cpu_0_instruction_master_readdatavalid,
                                              cpu_0_instruction_master_waitrequest
                                           )
;

  output  [ 24: 0] cpu_0_instruction_master_address_to_slave;
  output  [  1: 0] cpu_0_instruction_master_dbs_address;
  output           cpu_0_instruction_master_latency_counter;
  output  [ 31: 0] cpu_0_instruction_master_readdata;
  output           cpu_0_instruction_master_readdatavalid;
  output           cpu_0_instruction_master_waitrequest;
  input            clk;
  input   [ 24: 0] cpu_0_instruction_master_address;
  input            cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_granted_nios_system_clock_0_in;
  input            cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_qualified_request_nios_system_clock_0_in;
  input            cpu_0_instruction_master_read;
  input            cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_read_data_valid_nios_system_clock_0_in;
  input            cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_requests_nios_system_clock_0_in;
  input   [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  input            d1_cpu_0_jtag_debug_module_end_xfer;
  input            d1_nios_system_clock_0_in_end_xfer;
  input   [ 15: 0] nios_system_clock_0_in_readdata_from_sa;
  input            nios_system_clock_0_in_waitrequest_from_sa;
  input            reset_n;

  reg              active_and_waiting_last_time;
  reg     [ 24: 0] cpu_0_instruction_master_address_last_time;
  wire    [ 24: 0] cpu_0_instruction_master_address_to_slave;
  reg     [  1: 0] cpu_0_instruction_master_dbs_address;
  wire    [  1: 0] cpu_0_instruction_master_dbs_increment;
  wire             cpu_0_instruction_master_is_granted_some_slave;
  reg              cpu_0_instruction_master_latency_counter;
  reg              cpu_0_instruction_master_read_but_no_slave_selected;
  reg              cpu_0_instruction_master_read_last_time;
  wire    [ 31: 0] cpu_0_instruction_master_readdata;
  wire             cpu_0_instruction_master_readdatavalid;
  wire             cpu_0_instruction_master_run;
  wire             cpu_0_instruction_master_waitrequest;
  reg     [ 15: 0] dbs_16_reg_segment_0;
  wire             dbs_count_enable;
  wire             dbs_counter_overflow;
  wire             latency_load_value;
  wire    [  1: 0] next_dbs_address;
  wire             p1_cpu_0_instruction_master_latency_counter;
  wire    [ 15: 0] p1_dbs_16_reg_segment_0;
  wire             pre_dbs_count_enable;
  wire             pre_flush_cpu_0_instruction_master_readdatavalid;
  wire             r_1;
  wire             r_2;
  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = 1 & (cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_instruction_master_requests_cpu_0_jtag_debug_module) & (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module | ~cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module) & ((~cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_instruction_master_read | (1 & ~d1_cpu_0_jtag_debug_module_end_xfer & cpu_0_instruction_master_read)));

  //cascaded wait assignment, which is an e_assign
  assign cpu_0_instruction_master_run = r_1 & r_2;

  //r_2 master_run cascaded wait assignment, which is an e_assign
  assign r_2 = 1 & (cpu_0_instruction_master_qualified_request_nios_system_clock_0_in | ~cpu_0_instruction_master_requests_nios_system_clock_0_in) & ((~cpu_0_instruction_master_qualified_request_nios_system_clock_0_in | ~cpu_0_instruction_master_read | (1 & ~nios_system_clock_0_in_waitrequest_from_sa & (cpu_0_instruction_master_dbs_address[1]) & cpu_0_instruction_master_read)));

  //optimize select-logic by passing only those address bits which matter.
  assign cpu_0_instruction_master_address_to_slave = cpu_0_instruction_master_address[24 : 0];

  //cpu_0_instruction_master_read_but_no_slave_selected assignment, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_read_but_no_slave_selected <= 0;
      else 
        cpu_0_instruction_master_read_but_no_slave_selected <= cpu_0_instruction_master_read & cpu_0_instruction_master_run & ~cpu_0_instruction_master_is_granted_some_slave;
    end


  //some slave is getting selected, which is an e_mux
  assign cpu_0_instruction_master_is_granted_some_slave = cpu_0_instruction_master_granted_cpu_0_jtag_debug_module |
    cpu_0_instruction_master_granted_nios_system_clock_0_in;

  //latent slave read data valids which may be flushed, which is an e_mux
  assign pre_flush_cpu_0_instruction_master_readdatavalid = 0;

  //latent slave read data valid which is not flushed, which is an e_mux
  assign cpu_0_instruction_master_readdatavalid = cpu_0_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_0_instruction_master_readdatavalid |
    cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module |
    cpu_0_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_0_instruction_master_readdatavalid |
    (cpu_0_instruction_master_read_data_valid_nios_system_clock_0_in & dbs_counter_overflow);

  //cpu_0/instruction_master readdata mux, which is an e_mux
  assign cpu_0_instruction_master_readdata = ({32 {~(cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module & cpu_0_instruction_master_read)}} | cpu_0_jtag_debug_module_readdata_from_sa) &
    ({32 {~(cpu_0_instruction_master_qualified_request_nios_system_clock_0_in & cpu_0_instruction_master_read)}} | {nios_system_clock_0_in_readdata_from_sa[15 : 0],
    dbs_16_reg_segment_0});

  //actual waitrequest port, which is an e_assign
  assign cpu_0_instruction_master_waitrequest = ~cpu_0_instruction_master_run;

  //latent max counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_latency_counter <= 0;
      else 
        cpu_0_instruction_master_latency_counter <= p1_cpu_0_instruction_master_latency_counter;
    end


  //latency counter load mux, which is an e_mux
  assign p1_cpu_0_instruction_master_latency_counter = ((cpu_0_instruction_master_run & cpu_0_instruction_master_read))? latency_load_value :
    (cpu_0_instruction_master_latency_counter)? cpu_0_instruction_master_latency_counter - 1 :
    0;

  //read latency load values, which is an e_mux
  assign latency_load_value = 0;

  //input to dbs-16 stored 0, which is an e_mux
  assign p1_dbs_16_reg_segment_0 = nios_system_clock_0_in_readdata_from_sa;

  //dbs register for dbs-16 segment 0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_16_reg_segment_0 <= 0;
      else if (dbs_count_enable & ((cpu_0_instruction_master_dbs_address[1]) == 0))
          dbs_16_reg_segment_0 <= p1_dbs_16_reg_segment_0;
    end


  //dbs count increment, which is an e_mux
  assign cpu_0_instruction_master_dbs_increment = (cpu_0_instruction_master_requests_nios_system_clock_0_in)? 2 :
    0;

  //dbs counter overflow, which is an e_assign
  assign dbs_counter_overflow = cpu_0_instruction_master_dbs_address[1] & !(next_dbs_address[1]);

  //next master address, which is an e_assign
  assign next_dbs_address = cpu_0_instruction_master_dbs_address + cpu_0_instruction_master_dbs_increment;

  //dbs count enable, which is an e_mux
  assign dbs_count_enable = pre_dbs_count_enable;

  //dbs counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_dbs_address <= 0;
      else if (dbs_count_enable)
          cpu_0_instruction_master_dbs_address <= next_dbs_address;
    end


  //pre dbs count enable, which is an e_mux
  assign pre_dbs_count_enable = cpu_0_instruction_master_granted_nios_system_clock_0_in & cpu_0_instruction_master_read & 1 & 1 & ~nios_system_clock_0_in_waitrequest_from_sa;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_0_instruction_master_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_address_last_time <= 0;
      else 
        cpu_0_instruction_master_address_last_time <= cpu_0_instruction_master_address;
    end


  //cpu_0/instruction_master waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= cpu_0_instruction_master_waitrequest & (cpu_0_instruction_master_read);
    end


  //cpu_0_instruction_master_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_instruction_master_address != cpu_0_instruction_master_address_last_time))
        begin
          $write("%0d ns: cpu_0_instruction_master_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_0_instruction_master_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_read_last_time <= 0;
      else 
        cpu_0_instruction_master_read_last_time <= cpu_0_instruction_master_read;
    end


  //cpu_0_instruction_master_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_instruction_master_read != cpu_0_instruction_master_read_last_time))
        begin
          $write("%0d ns: cpu_0_instruction_master_read did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module jtag_uart_0_avalon_jtag_slave_arbitrator (
                                                  // inputs:
                                                   clk,
                                                   cpu_0_data_master_address_to_slave,
                                                   cpu_0_data_master_latency_counter,
                                                   cpu_0_data_master_read,
                                                   cpu_0_data_master_write,
                                                   cpu_0_data_master_writedata,
                                                   jtag_uart_0_avalon_jtag_slave_dataavailable,
                                                   jtag_uart_0_avalon_jtag_slave_irq,
                                                   jtag_uart_0_avalon_jtag_slave_readdata,
                                                   jtag_uart_0_avalon_jtag_slave_readyfordata,
                                                   jtag_uart_0_avalon_jtag_slave_waitrequest,
                                                   reset_n,

                                                  // outputs:
                                                   cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave,
                                                   cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave,
                                                   cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave,
                                                   cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave,
                                                   d1_jtag_uart_0_avalon_jtag_slave_end_xfer,
                                                   jtag_uart_0_avalon_jtag_slave_address,
                                                   jtag_uart_0_avalon_jtag_slave_chipselect,
                                                   jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_irq_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_read_n,
                                                   jtag_uart_0_avalon_jtag_slave_readdata_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_reset_n,
                                                   jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_write_n,
                                                   jtag_uart_0_avalon_jtag_slave_writedata
                                                )
;

  output           cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  output           cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  output           cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave;
  output           cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  output           d1_jtag_uart_0_avalon_jtag_slave_end_xfer;
  output           jtag_uart_0_avalon_jtag_slave_address;
  output           jtag_uart_0_avalon_jtag_slave_chipselect;
  output           jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_irq_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_read_n;
  output  [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_reset_n;
  output           jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_write_n;
  output  [ 31: 0] jtag_uart_0_avalon_jtag_slave_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            jtag_uart_0_avalon_jtag_slave_dataavailable;
  input            jtag_uart_0_avalon_jtag_slave_irq;
  input   [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata;
  input            jtag_uart_0_avalon_jtag_slave_readyfordata;
  input            jtag_uart_0_avalon_jtag_slave_waitrequest;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_saved_grant_jtag_uart_0_avalon_jtag_slave;
  reg              d1_jtag_uart_0_avalon_jtag_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             jtag_uart_0_avalon_jtag_slave_address;
  wire             jtag_uart_0_avalon_jtag_slave_allgrants;
  wire             jtag_uart_0_avalon_jtag_slave_allow_new_arb_cycle;
  wire             jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant;
  wire             jtag_uart_0_avalon_jtag_slave_any_continuerequest;
  wire             jtag_uart_0_avalon_jtag_slave_arb_counter_enable;
  reg     [  2: 0] jtag_uart_0_avalon_jtag_slave_arb_share_counter;
  wire    [  2: 0] jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;
  wire    [  2: 0] jtag_uart_0_avalon_jtag_slave_arb_share_set_values;
  wire             jtag_uart_0_avalon_jtag_slave_beginbursttransfer_internal;
  wire             jtag_uart_0_avalon_jtag_slave_begins_xfer;
  wire             jtag_uart_0_avalon_jtag_slave_chipselect;
  wire             jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_end_xfer;
  wire             jtag_uart_0_avalon_jtag_slave_firsttransfer;
  wire             jtag_uart_0_avalon_jtag_slave_grant_vector;
  wire             jtag_uart_0_avalon_jtag_slave_in_a_read_cycle;
  wire             jtag_uart_0_avalon_jtag_slave_in_a_write_cycle;
  wire             jtag_uart_0_avalon_jtag_slave_irq_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_master_qreq_vector;
  wire             jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests;
  wire             jtag_uart_0_avalon_jtag_slave_read_n;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa;
  reg              jtag_uart_0_avalon_jtag_slave_reg_firsttransfer;
  wire             jtag_uart_0_avalon_jtag_slave_reset_n;
  reg              jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable;
  wire             jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2;
  wire             jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer;
  wire             jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_waits_for_read;
  wire             jtag_uart_0_avalon_jtag_slave_waits_for_write;
  wire             jtag_uart_0_avalon_jtag_slave_write_n;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_writedata;
  wire    [ 24: 0] shifted_address_to_jtag_uart_0_avalon_jtag_slave_from_cpu_0_data_master;
  wire             wait_for_jtag_uart_0_avalon_jtag_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~jtag_uart_0_avalon_jtag_slave_end_xfer;
    end


  assign jtag_uart_0_avalon_jtag_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave));
  //assign jtag_uart_0_avalon_jtag_slave_readdata_from_sa = jtag_uart_0_avalon_jtag_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_readdata_from_sa = jtag_uart_0_avalon_jtag_slave_readdata;

  assign cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave = ({cpu_0_data_master_address_to_slave[24 : 3] , 3'b0} == 25'h1001038) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //assign jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_0_avalon_jtag_slave_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_0_avalon_jtag_slave_dataavailable;

  //assign jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_0_avalon_jtag_slave_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_0_avalon_jtag_slave_readyfordata;

  //assign jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_0_avalon_jtag_slave_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_0_avalon_jtag_slave_waitrequest;

  //jtag_uart_0_avalon_jtag_slave_arb_share_counter set values, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_arb_share_set_values = 1;

  //jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests mux, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests = cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;

  //jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant = 0;

  //jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value = jtag_uart_0_avalon_jtag_slave_firsttransfer ? (jtag_uart_0_avalon_jtag_slave_arb_share_set_values - 1) : |jtag_uart_0_avalon_jtag_slave_arb_share_counter ? (jtag_uart_0_avalon_jtag_slave_arb_share_counter - 1) : 0;

  //jtag_uart_0_avalon_jtag_slave_allgrants all slave grants, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_allgrants = |jtag_uart_0_avalon_jtag_slave_grant_vector;

  //jtag_uart_0_avalon_jtag_slave_end_xfer assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_end_xfer = ~(jtag_uart_0_avalon_jtag_slave_waits_for_read | jtag_uart_0_avalon_jtag_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave = jtag_uart_0_avalon_jtag_slave_end_xfer & (~jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //jtag_uart_0_avalon_jtag_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave & jtag_uart_0_avalon_jtag_slave_allgrants) | (end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave & ~jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests);

  //jtag_uart_0_avalon_jtag_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_0_avalon_jtag_slave_arb_share_counter <= 0;
      else if (jtag_uart_0_avalon_jtag_slave_arb_counter_enable)
          jtag_uart_0_avalon_jtag_slave_arb_share_counter <= jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;
    end


  //jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable <= 0;
      else if ((|jtag_uart_0_avalon_jtag_slave_master_qreq_vector & end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave) | (end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave & ~jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests))
          jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable <= |jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;
    end


  //cpu_0/data_master jtag_uart_0/avalon_jtag_slave arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 = |jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;

  //cpu_0/data_master jtag_uart_0/avalon_jtag_slave arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //jtag_uart_0_avalon_jtag_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave = cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave, which is an e_mux
  assign cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave = cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_read & ~jtag_uart_0_avalon_jtag_slave_waits_for_read;

  //jtag_uart_0_avalon_jtag_slave_writedata mux, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave = cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;

  //cpu_0/data_master saved-grant jtag_uart_0/avalon_jtag_slave, which is an e_assign
  assign cpu_0_data_master_saved_grant_jtag_uart_0_avalon_jtag_slave = cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;

  //allow new arb cycle for jtag_uart_0/avalon_jtag_slave, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign jtag_uart_0_avalon_jtag_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign jtag_uart_0_avalon_jtag_slave_master_qreq_vector = 1;

  //jtag_uart_0_avalon_jtag_slave_reset_n assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_reset_n = reset_n;

  assign jtag_uart_0_avalon_jtag_slave_chipselect = cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  //jtag_uart_0_avalon_jtag_slave_firsttransfer first transaction, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_firsttransfer = jtag_uart_0_avalon_jtag_slave_begins_xfer ? jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer : jtag_uart_0_avalon_jtag_slave_reg_firsttransfer;

  //jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer = ~(jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable & jtag_uart_0_avalon_jtag_slave_any_continuerequest);

  //jtag_uart_0_avalon_jtag_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_0_avalon_jtag_slave_reg_firsttransfer <= 1'b1;
      else if (jtag_uart_0_avalon_jtag_slave_begins_xfer)
          jtag_uart_0_avalon_jtag_slave_reg_firsttransfer <= jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer;
    end


  //jtag_uart_0_avalon_jtag_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_beginbursttransfer_internal = jtag_uart_0_avalon_jtag_slave_begins_xfer;

  //~jtag_uart_0_avalon_jtag_slave_read_n assignment, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_read_n = ~(cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_read);

  //~jtag_uart_0_avalon_jtag_slave_write_n assignment, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_write_n = ~(cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_write);

  assign shifted_address_to_jtag_uart_0_avalon_jtag_slave_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //jtag_uart_0_avalon_jtag_slave_address mux, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_address = shifted_address_to_jtag_uart_0_avalon_jtag_slave_from_cpu_0_data_master >> 2;

  //d1_jtag_uart_0_avalon_jtag_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_jtag_uart_0_avalon_jtag_slave_end_xfer <= 1;
      else 
        d1_jtag_uart_0_avalon_jtag_slave_end_xfer <= jtag_uart_0_avalon_jtag_slave_end_xfer;
    end


  //jtag_uart_0_avalon_jtag_slave_waits_for_read in a cycle, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_waits_for_read = jtag_uart_0_avalon_jtag_slave_in_a_read_cycle & jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;

  //jtag_uart_0_avalon_jtag_slave_in_a_read_cycle assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_in_a_read_cycle = cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = jtag_uart_0_avalon_jtag_slave_in_a_read_cycle;

  //jtag_uart_0_avalon_jtag_slave_waits_for_write in a cycle, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_waits_for_write = jtag_uart_0_avalon_jtag_slave_in_a_write_cycle & jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;

  //jtag_uart_0_avalon_jtag_slave_in_a_write_cycle assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_in_a_write_cycle = cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = jtag_uart_0_avalon_jtag_slave_in_a_write_cycle;

  assign wait_for_jtag_uart_0_avalon_jtag_slave_counter = 0;
  //assign jtag_uart_0_avalon_jtag_slave_irq_from_sa = jtag_uart_0_avalon_jtag_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_irq_from_sa = jtag_uart_0_avalon_jtag_slave_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //jtag_uart_0/avalon_jtag_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module keys_s1_arbitrator (
                            // inputs:
                             clk,
                             cpu_0_data_master_address_to_slave,
                             cpu_0_data_master_latency_counter,
                             cpu_0_data_master_read,
                             cpu_0_data_master_write,
                             cpu_0_data_master_writedata,
                             keys_s1_readdata,
                             reset_n,

                            // outputs:
                             cpu_0_data_master_granted_keys_s1,
                             cpu_0_data_master_qualified_request_keys_s1,
                             cpu_0_data_master_read_data_valid_keys_s1,
                             cpu_0_data_master_requests_keys_s1,
                             d1_keys_s1_end_xfer,
                             keys_s1_address,
                             keys_s1_chipselect,
                             keys_s1_readdata_from_sa,
                             keys_s1_reset_n,
                             keys_s1_write_n,
                             keys_s1_writedata
                          )
;

  output           cpu_0_data_master_granted_keys_s1;
  output           cpu_0_data_master_qualified_request_keys_s1;
  output           cpu_0_data_master_read_data_valid_keys_s1;
  output           cpu_0_data_master_requests_keys_s1;
  output           d1_keys_s1_end_xfer;
  output  [  1: 0] keys_s1_address;
  output           keys_s1_chipselect;
  output  [ 31: 0] keys_s1_readdata_from_sa;
  output           keys_s1_reset_n;
  output           keys_s1_write_n;
  output  [ 31: 0] keys_s1_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 31: 0] keys_s1_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_keys_s1;
  wire             cpu_0_data_master_qualified_request_keys_s1;
  wire             cpu_0_data_master_read_data_valid_keys_s1;
  wire             cpu_0_data_master_requests_keys_s1;
  wire             cpu_0_data_master_saved_grant_keys_s1;
  reg              d1_keys_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_keys_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] keys_s1_address;
  wire             keys_s1_allgrants;
  wire             keys_s1_allow_new_arb_cycle;
  wire             keys_s1_any_bursting_master_saved_grant;
  wire             keys_s1_any_continuerequest;
  wire             keys_s1_arb_counter_enable;
  reg     [  2: 0] keys_s1_arb_share_counter;
  wire    [  2: 0] keys_s1_arb_share_counter_next_value;
  wire    [  2: 0] keys_s1_arb_share_set_values;
  wire             keys_s1_beginbursttransfer_internal;
  wire             keys_s1_begins_xfer;
  wire             keys_s1_chipselect;
  wire             keys_s1_end_xfer;
  wire             keys_s1_firsttransfer;
  wire             keys_s1_grant_vector;
  wire             keys_s1_in_a_read_cycle;
  wire             keys_s1_in_a_write_cycle;
  wire             keys_s1_master_qreq_vector;
  wire             keys_s1_non_bursting_master_requests;
  wire    [ 31: 0] keys_s1_readdata_from_sa;
  reg              keys_s1_reg_firsttransfer;
  wire             keys_s1_reset_n;
  reg              keys_s1_slavearbiterlockenable;
  wire             keys_s1_slavearbiterlockenable2;
  wire             keys_s1_unreg_firsttransfer;
  wire             keys_s1_waits_for_read;
  wire             keys_s1_waits_for_write;
  wire             keys_s1_write_n;
  wire    [ 31: 0] keys_s1_writedata;
  wire    [ 24: 0] shifted_address_to_keys_s1_from_cpu_0_data_master;
  wire             wait_for_keys_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~keys_s1_end_xfer;
    end


  assign keys_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_keys_s1));
  //assign keys_s1_readdata_from_sa = keys_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign keys_s1_readdata_from_sa = keys_s1_readdata;

  assign cpu_0_data_master_requests_keys_s1 = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h1001010) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //keys_s1_arb_share_counter set values, which is an e_mux
  assign keys_s1_arb_share_set_values = 1;

  //keys_s1_non_bursting_master_requests mux, which is an e_mux
  assign keys_s1_non_bursting_master_requests = cpu_0_data_master_requests_keys_s1;

  //keys_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign keys_s1_any_bursting_master_saved_grant = 0;

  //keys_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign keys_s1_arb_share_counter_next_value = keys_s1_firsttransfer ? (keys_s1_arb_share_set_values - 1) : |keys_s1_arb_share_counter ? (keys_s1_arb_share_counter - 1) : 0;

  //keys_s1_allgrants all slave grants, which is an e_mux
  assign keys_s1_allgrants = |keys_s1_grant_vector;

  //keys_s1_end_xfer assignment, which is an e_assign
  assign keys_s1_end_xfer = ~(keys_s1_waits_for_read | keys_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_keys_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_keys_s1 = keys_s1_end_xfer & (~keys_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //keys_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign keys_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_keys_s1 & keys_s1_allgrants) | (end_xfer_arb_share_counter_term_keys_s1 & ~keys_s1_non_bursting_master_requests);

  //keys_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          keys_s1_arb_share_counter <= 0;
      else if (keys_s1_arb_counter_enable)
          keys_s1_arb_share_counter <= keys_s1_arb_share_counter_next_value;
    end


  //keys_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          keys_s1_slavearbiterlockenable <= 0;
      else if ((|keys_s1_master_qreq_vector & end_xfer_arb_share_counter_term_keys_s1) | (end_xfer_arb_share_counter_term_keys_s1 & ~keys_s1_non_bursting_master_requests))
          keys_s1_slavearbiterlockenable <= |keys_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master keys/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = keys_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //keys_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign keys_s1_slavearbiterlockenable2 = |keys_s1_arb_share_counter_next_value;

  //cpu_0/data_master keys/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = keys_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //keys_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign keys_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_keys_s1 = cpu_0_data_master_requests_keys_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_keys_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_keys_s1 = cpu_0_data_master_granted_keys_s1 & cpu_0_data_master_read & ~keys_s1_waits_for_read;

  //keys_s1_writedata mux, which is an e_mux
  assign keys_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_keys_s1 = cpu_0_data_master_qualified_request_keys_s1;

  //cpu_0/data_master saved-grant keys/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_keys_s1 = cpu_0_data_master_requests_keys_s1;

  //allow new arb cycle for keys/s1, which is an e_assign
  assign keys_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign keys_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign keys_s1_master_qreq_vector = 1;

  //keys_s1_reset_n assignment, which is an e_assign
  assign keys_s1_reset_n = reset_n;

  assign keys_s1_chipselect = cpu_0_data_master_granted_keys_s1;
  //keys_s1_firsttransfer first transaction, which is an e_assign
  assign keys_s1_firsttransfer = keys_s1_begins_xfer ? keys_s1_unreg_firsttransfer : keys_s1_reg_firsttransfer;

  //keys_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign keys_s1_unreg_firsttransfer = ~(keys_s1_slavearbiterlockenable & keys_s1_any_continuerequest);

  //keys_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          keys_s1_reg_firsttransfer <= 1'b1;
      else if (keys_s1_begins_xfer)
          keys_s1_reg_firsttransfer <= keys_s1_unreg_firsttransfer;
    end


  //keys_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign keys_s1_beginbursttransfer_internal = keys_s1_begins_xfer;

  //~keys_s1_write_n assignment, which is an e_mux
  assign keys_s1_write_n = ~(cpu_0_data_master_granted_keys_s1 & cpu_0_data_master_write);

  assign shifted_address_to_keys_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //keys_s1_address mux, which is an e_mux
  assign keys_s1_address = shifted_address_to_keys_s1_from_cpu_0_data_master >> 2;

  //d1_keys_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_keys_s1_end_xfer <= 1;
      else 
        d1_keys_s1_end_xfer <= keys_s1_end_xfer;
    end


  //keys_s1_waits_for_read in a cycle, which is an e_mux
  assign keys_s1_waits_for_read = keys_s1_in_a_read_cycle & keys_s1_begins_xfer;

  //keys_s1_in_a_read_cycle assignment, which is an e_assign
  assign keys_s1_in_a_read_cycle = cpu_0_data_master_granted_keys_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = keys_s1_in_a_read_cycle;

  //keys_s1_waits_for_write in a cycle, which is an e_mux
  assign keys_s1_waits_for_write = keys_s1_in_a_write_cycle & 0;

  //keys_s1_in_a_write_cycle assignment, which is an e_assign
  assign keys_s1_in_a_write_cycle = cpu_0_data_master_granted_keys_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = keys_s1_in_a_write_cycle;

  assign wait_for_keys_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //keys/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module lcd_0_control_slave_arbitrator (
                                        // inputs:
                                         clk,
                                         cpu_0_data_master_address_to_slave,
                                         cpu_0_data_master_byteenable,
                                         cpu_0_data_master_latency_counter,
                                         cpu_0_data_master_read,
                                         cpu_0_data_master_write,
                                         cpu_0_data_master_writedata,
                                         lcd_0_control_slave_readdata,
                                         reset_n,

                                        // outputs:
                                         cpu_0_data_master_granted_lcd_0_control_slave,
                                         cpu_0_data_master_qualified_request_lcd_0_control_slave,
                                         cpu_0_data_master_read_data_valid_lcd_0_control_slave,
                                         cpu_0_data_master_requests_lcd_0_control_slave,
                                         d1_lcd_0_control_slave_end_xfer,
                                         lcd_0_control_slave_address,
                                         lcd_0_control_slave_begintransfer,
                                         lcd_0_control_slave_read,
                                         lcd_0_control_slave_readdata_from_sa,
                                         lcd_0_control_slave_reset_n,
                                         lcd_0_control_slave_wait_counter_eq_0,
                                         lcd_0_control_slave_write,
                                         lcd_0_control_slave_writedata
                                      )
;

  output           cpu_0_data_master_granted_lcd_0_control_slave;
  output           cpu_0_data_master_qualified_request_lcd_0_control_slave;
  output           cpu_0_data_master_read_data_valid_lcd_0_control_slave;
  output           cpu_0_data_master_requests_lcd_0_control_slave;
  output           d1_lcd_0_control_slave_end_xfer;
  output  [  1: 0] lcd_0_control_slave_address;
  output           lcd_0_control_slave_begintransfer;
  output           lcd_0_control_slave_read;
  output  [  7: 0] lcd_0_control_slave_readdata_from_sa;
  output           lcd_0_control_slave_reset_n;
  output           lcd_0_control_slave_wait_counter_eq_0;
  output           lcd_0_control_slave_write;
  output  [  7: 0] lcd_0_control_slave_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [  7: 0] lcd_0_control_slave_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_lcd_0_control_slave;
  wire             cpu_0_data_master_qualified_request_lcd_0_control_slave;
  wire             cpu_0_data_master_read_data_valid_lcd_0_control_slave;
  wire             cpu_0_data_master_requests_lcd_0_control_slave;
  wire             cpu_0_data_master_saved_grant_lcd_0_control_slave;
  reg              d1_lcd_0_control_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_lcd_0_control_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] lcd_0_control_slave_address;
  wire             lcd_0_control_slave_allgrants;
  wire             lcd_0_control_slave_allow_new_arb_cycle;
  wire             lcd_0_control_slave_any_bursting_master_saved_grant;
  wire             lcd_0_control_slave_any_continuerequest;
  wire             lcd_0_control_slave_arb_counter_enable;
  reg     [  2: 0] lcd_0_control_slave_arb_share_counter;
  wire    [  2: 0] lcd_0_control_slave_arb_share_counter_next_value;
  wire    [  2: 0] lcd_0_control_slave_arb_share_set_values;
  wire             lcd_0_control_slave_beginbursttransfer_internal;
  wire             lcd_0_control_slave_begins_xfer;
  wire             lcd_0_control_slave_begintransfer;
  wire    [  5: 0] lcd_0_control_slave_counter_load_value;
  wire             lcd_0_control_slave_end_xfer;
  wire             lcd_0_control_slave_firsttransfer;
  wire             lcd_0_control_slave_grant_vector;
  wire             lcd_0_control_slave_in_a_read_cycle;
  wire             lcd_0_control_slave_in_a_write_cycle;
  wire             lcd_0_control_slave_master_qreq_vector;
  wire             lcd_0_control_slave_non_bursting_master_requests;
  wire             lcd_0_control_slave_pretend_byte_enable;
  wire             lcd_0_control_slave_read;
  wire    [  7: 0] lcd_0_control_slave_readdata_from_sa;
  reg              lcd_0_control_slave_reg_firsttransfer;
  wire             lcd_0_control_slave_reset_n;
  reg              lcd_0_control_slave_slavearbiterlockenable;
  wire             lcd_0_control_slave_slavearbiterlockenable2;
  wire             lcd_0_control_slave_unreg_firsttransfer;
  reg     [  5: 0] lcd_0_control_slave_wait_counter;
  wire             lcd_0_control_slave_wait_counter_eq_0;
  wire             lcd_0_control_slave_waits_for_read;
  wire             lcd_0_control_slave_waits_for_write;
  wire             lcd_0_control_slave_write;
  wire    [  7: 0] lcd_0_control_slave_writedata;
  wire    [ 24: 0] shifted_address_to_lcd_0_control_slave_from_cpu_0_data_master;
  wire             wait_for_lcd_0_control_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~lcd_0_control_slave_end_xfer;
    end


  assign lcd_0_control_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_lcd_0_control_slave));
  //assign lcd_0_control_slave_readdata_from_sa = lcd_0_control_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign lcd_0_control_slave_readdata_from_sa = lcd_0_control_slave_readdata;

  assign cpu_0_data_master_requests_lcd_0_control_slave = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h1001020) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //lcd_0_control_slave_arb_share_counter set values, which is an e_mux
  assign lcd_0_control_slave_arb_share_set_values = 1;

  //lcd_0_control_slave_non_bursting_master_requests mux, which is an e_mux
  assign lcd_0_control_slave_non_bursting_master_requests = cpu_0_data_master_requests_lcd_0_control_slave;

  //lcd_0_control_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign lcd_0_control_slave_any_bursting_master_saved_grant = 0;

  //lcd_0_control_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign lcd_0_control_slave_arb_share_counter_next_value = lcd_0_control_slave_firsttransfer ? (lcd_0_control_slave_arb_share_set_values - 1) : |lcd_0_control_slave_arb_share_counter ? (lcd_0_control_slave_arb_share_counter - 1) : 0;

  //lcd_0_control_slave_allgrants all slave grants, which is an e_mux
  assign lcd_0_control_slave_allgrants = |lcd_0_control_slave_grant_vector;

  //lcd_0_control_slave_end_xfer assignment, which is an e_assign
  assign lcd_0_control_slave_end_xfer = ~(lcd_0_control_slave_waits_for_read | lcd_0_control_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_lcd_0_control_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_lcd_0_control_slave = lcd_0_control_slave_end_xfer & (~lcd_0_control_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //lcd_0_control_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign lcd_0_control_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_lcd_0_control_slave & lcd_0_control_slave_allgrants) | (end_xfer_arb_share_counter_term_lcd_0_control_slave & ~lcd_0_control_slave_non_bursting_master_requests);

  //lcd_0_control_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          lcd_0_control_slave_arb_share_counter <= 0;
      else if (lcd_0_control_slave_arb_counter_enable)
          lcd_0_control_slave_arb_share_counter <= lcd_0_control_slave_arb_share_counter_next_value;
    end


  //lcd_0_control_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          lcd_0_control_slave_slavearbiterlockenable <= 0;
      else if ((|lcd_0_control_slave_master_qreq_vector & end_xfer_arb_share_counter_term_lcd_0_control_slave) | (end_xfer_arb_share_counter_term_lcd_0_control_slave & ~lcd_0_control_slave_non_bursting_master_requests))
          lcd_0_control_slave_slavearbiterlockenable <= |lcd_0_control_slave_arb_share_counter_next_value;
    end


  //cpu_0/data_master lcd_0/control_slave arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = lcd_0_control_slave_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //lcd_0_control_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign lcd_0_control_slave_slavearbiterlockenable2 = |lcd_0_control_slave_arb_share_counter_next_value;

  //cpu_0/data_master lcd_0/control_slave arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = lcd_0_control_slave_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //lcd_0_control_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign lcd_0_control_slave_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_lcd_0_control_slave = cpu_0_data_master_requests_lcd_0_control_slave & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_lcd_0_control_slave, which is an e_mux
  assign cpu_0_data_master_read_data_valid_lcd_0_control_slave = cpu_0_data_master_granted_lcd_0_control_slave & cpu_0_data_master_read & ~lcd_0_control_slave_waits_for_read;

  //lcd_0_control_slave_writedata mux, which is an e_mux
  assign lcd_0_control_slave_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_lcd_0_control_slave = cpu_0_data_master_qualified_request_lcd_0_control_slave;

  //cpu_0/data_master saved-grant lcd_0/control_slave, which is an e_assign
  assign cpu_0_data_master_saved_grant_lcd_0_control_slave = cpu_0_data_master_requests_lcd_0_control_slave;

  //allow new arb cycle for lcd_0/control_slave, which is an e_assign
  assign lcd_0_control_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign lcd_0_control_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign lcd_0_control_slave_master_qreq_vector = 1;

  assign lcd_0_control_slave_begintransfer = lcd_0_control_slave_begins_xfer;
  //lcd_0_control_slave_reset_n assignment, which is an e_assign
  assign lcd_0_control_slave_reset_n = reset_n;

  //lcd_0_control_slave_firsttransfer first transaction, which is an e_assign
  assign lcd_0_control_slave_firsttransfer = lcd_0_control_slave_begins_xfer ? lcd_0_control_slave_unreg_firsttransfer : lcd_0_control_slave_reg_firsttransfer;

  //lcd_0_control_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign lcd_0_control_slave_unreg_firsttransfer = ~(lcd_0_control_slave_slavearbiterlockenable & lcd_0_control_slave_any_continuerequest);

  //lcd_0_control_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          lcd_0_control_slave_reg_firsttransfer <= 1'b1;
      else if (lcd_0_control_slave_begins_xfer)
          lcd_0_control_slave_reg_firsttransfer <= lcd_0_control_slave_unreg_firsttransfer;
    end


  //lcd_0_control_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign lcd_0_control_slave_beginbursttransfer_internal = lcd_0_control_slave_begins_xfer;

  //lcd_0_control_slave_read assignment, which is an e_mux
  assign lcd_0_control_slave_read = ((cpu_0_data_master_granted_lcd_0_control_slave & cpu_0_data_master_read))& ~lcd_0_control_slave_begins_xfer & (lcd_0_control_slave_wait_counter < 13);

  //lcd_0_control_slave_write assignment, which is an e_mux
  assign lcd_0_control_slave_write = ((cpu_0_data_master_granted_lcd_0_control_slave & cpu_0_data_master_write)) & ~lcd_0_control_slave_begins_xfer & (lcd_0_control_slave_wait_counter >= 13) & (lcd_0_control_slave_wait_counter < 26) & lcd_0_control_slave_pretend_byte_enable;

  assign shifted_address_to_lcd_0_control_slave_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //lcd_0_control_slave_address mux, which is an e_mux
  assign lcd_0_control_slave_address = shifted_address_to_lcd_0_control_slave_from_cpu_0_data_master >> 2;

  //d1_lcd_0_control_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_lcd_0_control_slave_end_xfer <= 1;
      else 
        d1_lcd_0_control_slave_end_xfer <= lcd_0_control_slave_end_xfer;
    end


  //lcd_0_control_slave_waits_for_read in a cycle, which is an e_mux
  assign lcd_0_control_slave_waits_for_read = lcd_0_control_slave_in_a_read_cycle & wait_for_lcd_0_control_slave_counter;

  //lcd_0_control_slave_in_a_read_cycle assignment, which is an e_assign
  assign lcd_0_control_slave_in_a_read_cycle = cpu_0_data_master_granted_lcd_0_control_slave & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = lcd_0_control_slave_in_a_read_cycle;

  //lcd_0_control_slave_waits_for_write in a cycle, which is an e_mux
  assign lcd_0_control_slave_waits_for_write = lcd_0_control_slave_in_a_write_cycle & wait_for_lcd_0_control_slave_counter;

  //lcd_0_control_slave_in_a_write_cycle assignment, which is an e_assign
  assign lcd_0_control_slave_in_a_write_cycle = cpu_0_data_master_granted_lcd_0_control_slave & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = lcd_0_control_slave_in_a_write_cycle;

  assign lcd_0_control_slave_wait_counter_eq_0 = lcd_0_control_slave_wait_counter == 0;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          lcd_0_control_slave_wait_counter <= 0;
      else 
        lcd_0_control_slave_wait_counter <= lcd_0_control_slave_counter_load_value;
    end


  assign lcd_0_control_slave_counter_load_value = ((lcd_0_control_slave_in_a_read_cycle & lcd_0_control_slave_begins_xfer))? 24 :
    ((lcd_0_control_slave_in_a_write_cycle & lcd_0_control_slave_begins_xfer))? 37 :
    (~lcd_0_control_slave_wait_counter_eq_0)? lcd_0_control_slave_wait_counter - 1 :
    0;

  assign wait_for_lcd_0_control_slave_counter = lcd_0_control_slave_begins_xfer | ~lcd_0_control_slave_wait_counter_eq_0;
  //lcd_0_control_slave_pretend_byte_enable byte enable port mux, which is an e_mux
  assign lcd_0_control_slave_pretend_byte_enable = (cpu_0_data_master_granted_lcd_0_control_slave)? cpu_0_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //lcd_0/control_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module leds_s1_arbitrator (
                            // inputs:
                             clk,
                             cpu_0_data_master_address_to_slave,
                             cpu_0_data_master_latency_counter,
                             cpu_0_data_master_read,
                             cpu_0_data_master_write,
                             cpu_0_data_master_writedata,
                             leds_s1_readdata,
                             reset_n,

                            // outputs:
                             cpu_0_data_master_granted_leds_s1,
                             cpu_0_data_master_qualified_request_leds_s1,
                             cpu_0_data_master_read_data_valid_leds_s1,
                             cpu_0_data_master_requests_leds_s1,
                             d1_leds_s1_end_xfer,
                             leds_s1_address,
                             leds_s1_chipselect,
                             leds_s1_readdata_from_sa,
                             leds_s1_reset_n,
                             leds_s1_write_n,
                             leds_s1_writedata
                          )
;

  output           cpu_0_data_master_granted_leds_s1;
  output           cpu_0_data_master_qualified_request_leds_s1;
  output           cpu_0_data_master_read_data_valid_leds_s1;
  output           cpu_0_data_master_requests_leds_s1;
  output           d1_leds_s1_end_xfer;
  output  [  1: 0] leds_s1_address;
  output           leds_s1_chipselect;
  output  [ 31: 0] leds_s1_readdata_from_sa;
  output           leds_s1_reset_n;
  output           leds_s1_write_n;
  output  [ 31: 0] leds_s1_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 31: 0] leds_s1_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_leds_s1;
  wire             cpu_0_data_master_qualified_request_leds_s1;
  wire             cpu_0_data_master_read_data_valid_leds_s1;
  wire             cpu_0_data_master_requests_leds_s1;
  wire             cpu_0_data_master_saved_grant_leds_s1;
  reg              d1_leds_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_leds_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] leds_s1_address;
  wire             leds_s1_allgrants;
  wire             leds_s1_allow_new_arb_cycle;
  wire             leds_s1_any_bursting_master_saved_grant;
  wire             leds_s1_any_continuerequest;
  wire             leds_s1_arb_counter_enable;
  reg     [  2: 0] leds_s1_arb_share_counter;
  wire    [  2: 0] leds_s1_arb_share_counter_next_value;
  wire    [  2: 0] leds_s1_arb_share_set_values;
  wire             leds_s1_beginbursttransfer_internal;
  wire             leds_s1_begins_xfer;
  wire             leds_s1_chipselect;
  wire             leds_s1_end_xfer;
  wire             leds_s1_firsttransfer;
  wire             leds_s1_grant_vector;
  wire             leds_s1_in_a_read_cycle;
  wire             leds_s1_in_a_write_cycle;
  wire             leds_s1_master_qreq_vector;
  wire             leds_s1_non_bursting_master_requests;
  wire    [ 31: 0] leds_s1_readdata_from_sa;
  reg              leds_s1_reg_firsttransfer;
  wire             leds_s1_reset_n;
  reg              leds_s1_slavearbiterlockenable;
  wire             leds_s1_slavearbiterlockenable2;
  wire             leds_s1_unreg_firsttransfer;
  wire             leds_s1_waits_for_read;
  wire             leds_s1_waits_for_write;
  wire             leds_s1_write_n;
  wire    [ 31: 0] leds_s1_writedata;
  wire    [ 24: 0] shifted_address_to_leds_s1_from_cpu_0_data_master;
  wire             wait_for_leds_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~leds_s1_end_xfer;
    end


  assign leds_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_leds_s1));
  //assign leds_s1_readdata_from_sa = leds_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign leds_s1_readdata_from_sa = leds_s1_readdata;

  assign cpu_0_data_master_requests_leds_s1 = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h1001000) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //leds_s1_arb_share_counter set values, which is an e_mux
  assign leds_s1_arb_share_set_values = 1;

  //leds_s1_non_bursting_master_requests mux, which is an e_mux
  assign leds_s1_non_bursting_master_requests = cpu_0_data_master_requests_leds_s1;

  //leds_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign leds_s1_any_bursting_master_saved_grant = 0;

  //leds_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign leds_s1_arb_share_counter_next_value = leds_s1_firsttransfer ? (leds_s1_arb_share_set_values - 1) : |leds_s1_arb_share_counter ? (leds_s1_arb_share_counter - 1) : 0;

  //leds_s1_allgrants all slave grants, which is an e_mux
  assign leds_s1_allgrants = |leds_s1_grant_vector;

  //leds_s1_end_xfer assignment, which is an e_assign
  assign leds_s1_end_xfer = ~(leds_s1_waits_for_read | leds_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_leds_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_leds_s1 = leds_s1_end_xfer & (~leds_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //leds_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign leds_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_leds_s1 & leds_s1_allgrants) | (end_xfer_arb_share_counter_term_leds_s1 & ~leds_s1_non_bursting_master_requests);

  //leds_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          leds_s1_arb_share_counter <= 0;
      else if (leds_s1_arb_counter_enable)
          leds_s1_arb_share_counter <= leds_s1_arb_share_counter_next_value;
    end


  //leds_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          leds_s1_slavearbiterlockenable <= 0;
      else if ((|leds_s1_master_qreq_vector & end_xfer_arb_share_counter_term_leds_s1) | (end_xfer_arb_share_counter_term_leds_s1 & ~leds_s1_non_bursting_master_requests))
          leds_s1_slavearbiterlockenable <= |leds_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master leds/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = leds_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //leds_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign leds_s1_slavearbiterlockenable2 = |leds_s1_arb_share_counter_next_value;

  //cpu_0/data_master leds/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = leds_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //leds_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign leds_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_leds_s1 = cpu_0_data_master_requests_leds_s1 & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_leds_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_leds_s1 = cpu_0_data_master_granted_leds_s1 & cpu_0_data_master_read & ~leds_s1_waits_for_read;

  //leds_s1_writedata mux, which is an e_mux
  assign leds_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_leds_s1 = cpu_0_data_master_qualified_request_leds_s1;

  //cpu_0/data_master saved-grant leds/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_leds_s1 = cpu_0_data_master_requests_leds_s1;

  //allow new arb cycle for leds/s1, which is an e_assign
  assign leds_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign leds_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign leds_s1_master_qreq_vector = 1;

  //leds_s1_reset_n assignment, which is an e_assign
  assign leds_s1_reset_n = reset_n;

  assign leds_s1_chipselect = cpu_0_data_master_granted_leds_s1;
  //leds_s1_firsttransfer first transaction, which is an e_assign
  assign leds_s1_firsttransfer = leds_s1_begins_xfer ? leds_s1_unreg_firsttransfer : leds_s1_reg_firsttransfer;

  //leds_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign leds_s1_unreg_firsttransfer = ~(leds_s1_slavearbiterlockenable & leds_s1_any_continuerequest);

  //leds_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          leds_s1_reg_firsttransfer <= 1'b1;
      else if (leds_s1_begins_xfer)
          leds_s1_reg_firsttransfer <= leds_s1_unreg_firsttransfer;
    end


  //leds_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign leds_s1_beginbursttransfer_internal = leds_s1_begins_xfer;

  //~leds_s1_write_n assignment, which is an e_mux
  assign leds_s1_write_n = ~(cpu_0_data_master_granted_leds_s1 & cpu_0_data_master_write);

  assign shifted_address_to_leds_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //leds_s1_address mux, which is an e_mux
  assign leds_s1_address = shifted_address_to_leds_s1_from_cpu_0_data_master >> 2;

  //d1_leds_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_leds_s1_end_xfer <= 1;
      else 
        d1_leds_s1_end_xfer <= leds_s1_end_xfer;
    end


  //leds_s1_waits_for_read in a cycle, which is an e_mux
  assign leds_s1_waits_for_read = leds_s1_in_a_read_cycle & leds_s1_begins_xfer;

  //leds_s1_in_a_read_cycle assignment, which is an e_assign
  assign leds_s1_in_a_read_cycle = cpu_0_data_master_granted_leds_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = leds_s1_in_a_read_cycle;

  //leds_s1_waits_for_write in a cycle, which is an e_mux
  assign leds_s1_waits_for_write = leds_s1_in_a_write_cycle & 0;

  //leds_s1_in_a_write_cycle assignment, which is an e_assign
  assign leds_s1_in_a_write_cycle = cpu_0_data_master_granted_leds_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = leds_s1_in_a_write_cycle;

  assign wait_for_leds_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //leds/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_system_clock_0_in_arbitrator (
                                           // inputs:
                                            clk,
                                            cpu_0_instruction_master_address_to_slave,
                                            cpu_0_instruction_master_dbs_address,
                                            cpu_0_instruction_master_latency_counter,
                                            cpu_0_instruction_master_read,
                                            nios_system_clock_0_in_endofpacket,
                                            nios_system_clock_0_in_readdata,
                                            nios_system_clock_0_in_waitrequest,
                                            reset_n,

                                           // outputs:
                                            cpu_0_instruction_master_granted_nios_system_clock_0_in,
                                            cpu_0_instruction_master_qualified_request_nios_system_clock_0_in,
                                            cpu_0_instruction_master_read_data_valid_nios_system_clock_0_in,
                                            cpu_0_instruction_master_requests_nios_system_clock_0_in,
                                            d1_nios_system_clock_0_in_end_xfer,
                                            nios_system_clock_0_in_address,
                                            nios_system_clock_0_in_byteenable,
                                            nios_system_clock_0_in_endofpacket_from_sa,
                                            nios_system_clock_0_in_nativeaddress,
                                            nios_system_clock_0_in_read,
                                            nios_system_clock_0_in_readdata_from_sa,
                                            nios_system_clock_0_in_reset_n,
                                            nios_system_clock_0_in_waitrequest_from_sa,
                                            nios_system_clock_0_in_write
                                         )
;

  output           cpu_0_instruction_master_granted_nios_system_clock_0_in;
  output           cpu_0_instruction_master_qualified_request_nios_system_clock_0_in;
  output           cpu_0_instruction_master_read_data_valid_nios_system_clock_0_in;
  output           cpu_0_instruction_master_requests_nios_system_clock_0_in;
  output           d1_nios_system_clock_0_in_end_xfer;
  output  [ 22: 0] nios_system_clock_0_in_address;
  output  [  1: 0] nios_system_clock_0_in_byteenable;
  output           nios_system_clock_0_in_endofpacket_from_sa;
  output  [ 21: 0] nios_system_clock_0_in_nativeaddress;
  output           nios_system_clock_0_in_read;
  output  [ 15: 0] nios_system_clock_0_in_readdata_from_sa;
  output           nios_system_clock_0_in_reset_n;
  output           nios_system_clock_0_in_waitrequest_from_sa;
  output           nios_system_clock_0_in_write;
  input            clk;
  input   [ 24: 0] cpu_0_instruction_master_address_to_slave;
  input   [  1: 0] cpu_0_instruction_master_dbs_address;
  input            cpu_0_instruction_master_latency_counter;
  input            cpu_0_instruction_master_read;
  input            nios_system_clock_0_in_endofpacket;
  input   [ 15: 0] nios_system_clock_0_in_readdata;
  input            nios_system_clock_0_in_waitrequest;
  input            reset_n;

  wire             cpu_0_instruction_master_arbiterlock;
  wire             cpu_0_instruction_master_arbiterlock2;
  wire             cpu_0_instruction_master_continuerequest;
  wire             cpu_0_instruction_master_granted_nios_system_clock_0_in;
  wire             cpu_0_instruction_master_qualified_request_nios_system_clock_0_in;
  wire             cpu_0_instruction_master_read_data_valid_nios_system_clock_0_in;
  wire             cpu_0_instruction_master_requests_nios_system_clock_0_in;
  wire             cpu_0_instruction_master_saved_grant_nios_system_clock_0_in;
  reg              d1_nios_system_clock_0_in_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_nios_system_clock_0_in;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 22: 0] nios_system_clock_0_in_address;
  wire             nios_system_clock_0_in_allgrants;
  wire             nios_system_clock_0_in_allow_new_arb_cycle;
  wire             nios_system_clock_0_in_any_bursting_master_saved_grant;
  wire             nios_system_clock_0_in_any_continuerequest;
  wire             nios_system_clock_0_in_arb_counter_enable;
  reg     [  1: 0] nios_system_clock_0_in_arb_share_counter;
  wire    [  1: 0] nios_system_clock_0_in_arb_share_counter_next_value;
  wire    [  1: 0] nios_system_clock_0_in_arb_share_set_values;
  wire             nios_system_clock_0_in_beginbursttransfer_internal;
  wire             nios_system_clock_0_in_begins_xfer;
  wire    [  1: 0] nios_system_clock_0_in_byteenable;
  wire             nios_system_clock_0_in_end_xfer;
  wire             nios_system_clock_0_in_endofpacket_from_sa;
  wire             nios_system_clock_0_in_firsttransfer;
  wire             nios_system_clock_0_in_grant_vector;
  wire             nios_system_clock_0_in_in_a_read_cycle;
  wire             nios_system_clock_0_in_in_a_write_cycle;
  wire             nios_system_clock_0_in_master_qreq_vector;
  wire    [ 21: 0] nios_system_clock_0_in_nativeaddress;
  wire             nios_system_clock_0_in_non_bursting_master_requests;
  wire             nios_system_clock_0_in_read;
  wire    [ 15: 0] nios_system_clock_0_in_readdata_from_sa;
  reg              nios_system_clock_0_in_reg_firsttransfer;
  wire             nios_system_clock_0_in_reset_n;
  reg              nios_system_clock_0_in_slavearbiterlockenable;
  wire             nios_system_clock_0_in_slavearbiterlockenable2;
  wire             nios_system_clock_0_in_unreg_firsttransfer;
  wire             nios_system_clock_0_in_waitrequest_from_sa;
  wire             nios_system_clock_0_in_waits_for_read;
  wire             nios_system_clock_0_in_waits_for_write;
  wire             nios_system_clock_0_in_write;
  wire             wait_for_nios_system_clock_0_in_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~nios_system_clock_0_in_end_xfer;
    end


  assign nios_system_clock_0_in_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_instruction_master_qualified_request_nios_system_clock_0_in));
  //assign nios_system_clock_0_in_readdata_from_sa = nios_system_clock_0_in_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign nios_system_clock_0_in_readdata_from_sa = nios_system_clock_0_in_readdata;

  assign cpu_0_instruction_master_requests_nios_system_clock_0_in = (({cpu_0_instruction_master_address_to_slave[24 : 23] , 23'b0} == 25'h800000) & (cpu_0_instruction_master_read)) & cpu_0_instruction_master_read;
  //assign nios_system_clock_0_in_waitrequest_from_sa = nios_system_clock_0_in_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign nios_system_clock_0_in_waitrequest_from_sa = nios_system_clock_0_in_waitrequest;

  //nios_system_clock_0_in_arb_share_counter set values, which is an e_mux
  assign nios_system_clock_0_in_arb_share_set_values = (cpu_0_instruction_master_granted_nios_system_clock_0_in)? 2 :
    1;

  //nios_system_clock_0_in_non_bursting_master_requests mux, which is an e_mux
  assign nios_system_clock_0_in_non_bursting_master_requests = cpu_0_instruction_master_requests_nios_system_clock_0_in;

  //nios_system_clock_0_in_any_bursting_master_saved_grant mux, which is an e_mux
  assign nios_system_clock_0_in_any_bursting_master_saved_grant = 0;

  //nios_system_clock_0_in_arb_share_counter_next_value assignment, which is an e_assign
  assign nios_system_clock_0_in_arb_share_counter_next_value = nios_system_clock_0_in_firsttransfer ? (nios_system_clock_0_in_arb_share_set_values - 1) : |nios_system_clock_0_in_arb_share_counter ? (nios_system_clock_0_in_arb_share_counter - 1) : 0;

  //nios_system_clock_0_in_allgrants all slave grants, which is an e_mux
  assign nios_system_clock_0_in_allgrants = |nios_system_clock_0_in_grant_vector;

  //nios_system_clock_0_in_end_xfer assignment, which is an e_assign
  assign nios_system_clock_0_in_end_xfer = ~(nios_system_clock_0_in_waits_for_read | nios_system_clock_0_in_waits_for_write);

  //end_xfer_arb_share_counter_term_nios_system_clock_0_in arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_nios_system_clock_0_in = nios_system_clock_0_in_end_xfer & (~nios_system_clock_0_in_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //nios_system_clock_0_in_arb_share_counter arbitration counter enable, which is an e_assign
  assign nios_system_clock_0_in_arb_counter_enable = (end_xfer_arb_share_counter_term_nios_system_clock_0_in & nios_system_clock_0_in_allgrants) | (end_xfer_arb_share_counter_term_nios_system_clock_0_in & ~nios_system_clock_0_in_non_bursting_master_requests);

  //nios_system_clock_0_in_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_0_in_arb_share_counter <= 0;
      else if (nios_system_clock_0_in_arb_counter_enable)
          nios_system_clock_0_in_arb_share_counter <= nios_system_clock_0_in_arb_share_counter_next_value;
    end


  //nios_system_clock_0_in_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_0_in_slavearbiterlockenable <= 0;
      else if ((|nios_system_clock_0_in_master_qreq_vector & end_xfer_arb_share_counter_term_nios_system_clock_0_in) | (end_xfer_arb_share_counter_term_nios_system_clock_0_in & ~nios_system_clock_0_in_non_bursting_master_requests))
          nios_system_clock_0_in_slavearbiterlockenable <= |nios_system_clock_0_in_arb_share_counter_next_value;
    end


  //cpu_0/instruction_master nios_system_clock_0/in arbiterlock, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock = nios_system_clock_0_in_slavearbiterlockenable & cpu_0_instruction_master_continuerequest;

  //nios_system_clock_0_in_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign nios_system_clock_0_in_slavearbiterlockenable2 = |nios_system_clock_0_in_arb_share_counter_next_value;

  //cpu_0/instruction_master nios_system_clock_0/in arbiterlock2, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock2 = nios_system_clock_0_in_slavearbiterlockenable2 & cpu_0_instruction_master_continuerequest;

  //nios_system_clock_0_in_any_continuerequest at least one master continues requesting, which is an e_assign
  assign nios_system_clock_0_in_any_continuerequest = 1;

  //cpu_0_instruction_master_continuerequest continued request, which is an e_assign
  assign cpu_0_instruction_master_continuerequest = 1;

  assign cpu_0_instruction_master_qualified_request_nios_system_clock_0_in = cpu_0_instruction_master_requests_nios_system_clock_0_in & ~((cpu_0_instruction_master_read & ((cpu_0_instruction_master_latency_counter != 0))));
  //local readdatavalid cpu_0_instruction_master_read_data_valid_nios_system_clock_0_in, which is an e_mux
  assign cpu_0_instruction_master_read_data_valid_nios_system_clock_0_in = cpu_0_instruction_master_granted_nios_system_clock_0_in & cpu_0_instruction_master_read & ~nios_system_clock_0_in_waits_for_read;

  //assign nios_system_clock_0_in_endofpacket_from_sa = nios_system_clock_0_in_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign nios_system_clock_0_in_endofpacket_from_sa = nios_system_clock_0_in_endofpacket;

  //master is always granted when requested
  assign cpu_0_instruction_master_granted_nios_system_clock_0_in = cpu_0_instruction_master_qualified_request_nios_system_clock_0_in;

  //cpu_0/instruction_master saved-grant nios_system_clock_0/in, which is an e_assign
  assign cpu_0_instruction_master_saved_grant_nios_system_clock_0_in = cpu_0_instruction_master_requests_nios_system_clock_0_in;

  //allow new arb cycle for nios_system_clock_0/in, which is an e_assign
  assign nios_system_clock_0_in_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign nios_system_clock_0_in_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign nios_system_clock_0_in_master_qreq_vector = 1;

  //nios_system_clock_0_in_reset_n assignment, which is an e_assign
  assign nios_system_clock_0_in_reset_n = reset_n;

  //nios_system_clock_0_in_firsttransfer first transaction, which is an e_assign
  assign nios_system_clock_0_in_firsttransfer = nios_system_clock_0_in_begins_xfer ? nios_system_clock_0_in_unreg_firsttransfer : nios_system_clock_0_in_reg_firsttransfer;

  //nios_system_clock_0_in_unreg_firsttransfer first transaction, which is an e_assign
  assign nios_system_clock_0_in_unreg_firsttransfer = ~(nios_system_clock_0_in_slavearbiterlockenable & nios_system_clock_0_in_any_continuerequest);

  //nios_system_clock_0_in_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_0_in_reg_firsttransfer <= 1'b1;
      else if (nios_system_clock_0_in_begins_xfer)
          nios_system_clock_0_in_reg_firsttransfer <= nios_system_clock_0_in_unreg_firsttransfer;
    end


  //nios_system_clock_0_in_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign nios_system_clock_0_in_beginbursttransfer_internal = nios_system_clock_0_in_begins_xfer;

  //nios_system_clock_0_in_read assignment, which is an e_mux
  assign nios_system_clock_0_in_read = cpu_0_instruction_master_granted_nios_system_clock_0_in & cpu_0_instruction_master_read;

  //nios_system_clock_0_in_write assignment, which is an e_mux
  assign nios_system_clock_0_in_write = 0;

  //nios_system_clock_0_in_address mux, which is an e_mux
  assign nios_system_clock_0_in_address = {cpu_0_instruction_master_address_to_slave >> 2,
    cpu_0_instruction_master_dbs_address[1],
    {1 {1'b0}}};

  //slaveid nios_system_clock_0_in_nativeaddress nativeaddress mux, which is an e_mux
  assign nios_system_clock_0_in_nativeaddress = cpu_0_instruction_master_address_to_slave >> 2;

  //d1_nios_system_clock_0_in_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_nios_system_clock_0_in_end_xfer <= 1;
      else 
        d1_nios_system_clock_0_in_end_xfer <= nios_system_clock_0_in_end_xfer;
    end


  //nios_system_clock_0_in_waits_for_read in a cycle, which is an e_mux
  assign nios_system_clock_0_in_waits_for_read = nios_system_clock_0_in_in_a_read_cycle & nios_system_clock_0_in_waitrequest_from_sa;

  //nios_system_clock_0_in_in_a_read_cycle assignment, which is an e_assign
  assign nios_system_clock_0_in_in_a_read_cycle = cpu_0_instruction_master_granted_nios_system_clock_0_in & cpu_0_instruction_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = nios_system_clock_0_in_in_a_read_cycle;

  //nios_system_clock_0_in_waits_for_write in a cycle, which is an e_mux
  assign nios_system_clock_0_in_waits_for_write = nios_system_clock_0_in_in_a_write_cycle & nios_system_clock_0_in_waitrequest_from_sa;

  //nios_system_clock_0_in_in_a_write_cycle assignment, which is an e_assign
  assign nios_system_clock_0_in_in_a_write_cycle = 0;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = nios_system_clock_0_in_in_a_write_cycle;

  assign wait_for_nios_system_clock_0_in_counter = 0;
  //nios_system_clock_0_in_byteenable byte enable port mux, which is an e_mux
  assign nios_system_clock_0_in_byteenable = -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //nios_system_clock_0/in enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_system_clock_0_out_arbitrator (
                                            // inputs:
                                             clk,
                                             d1_sdram_0_s1_end_xfer,
                                             nios_system_clock_0_out_address,
                                             nios_system_clock_0_out_byteenable,
                                             nios_system_clock_0_out_granted_sdram_0_s1,
                                             nios_system_clock_0_out_qualified_request_sdram_0_s1,
                                             nios_system_clock_0_out_read,
                                             nios_system_clock_0_out_read_data_valid_sdram_0_s1,
                                             nios_system_clock_0_out_read_data_valid_sdram_0_s1_shift_register,
                                             nios_system_clock_0_out_requests_sdram_0_s1,
                                             nios_system_clock_0_out_write,
                                             nios_system_clock_0_out_writedata,
                                             reset_n,
                                             sdram_0_s1_readdata_from_sa,
                                             sdram_0_s1_waitrequest_from_sa,

                                            // outputs:
                                             nios_system_clock_0_out_address_to_slave,
                                             nios_system_clock_0_out_readdata,
                                             nios_system_clock_0_out_reset_n,
                                             nios_system_clock_0_out_waitrequest
                                          )
;

  output  [ 22: 0] nios_system_clock_0_out_address_to_slave;
  output  [ 15: 0] nios_system_clock_0_out_readdata;
  output           nios_system_clock_0_out_reset_n;
  output           nios_system_clock_0_out_waitrequest;
  input            clk;
  input            d1_sdram_0_s1_end_xfer;
  input   [ 22: 0] nios_system_clock_0_out_address;
  input   [  1: 0] nios_system_clock_0_out_byteenable;
  input            nios_system_clock_0_out_granted_sdram_0_s1;
  input            nios_system_clock_0_out_qualified_request_sdram_0_s1;
  input            nios_system_clock_0_out_read;
  input            nios_system_clock_0_out_read_data_valid_sdram_0_s1;
  input            nios_system_clock_0_out_read_data_valid_sdram_0_s1_shift_register;
  input            nios_system_clock_0_out_requests_sdram_0_s1;
  input            nios_system_clock_0_out_write;
  input   [ 15: 0] nios_system_clock_0_out_writedata;
  input            reset_n;
  input   [ 15: 0] sdram_0_s1_readdata_from_sa;
  input            sdram_0_s1_waitrequest_from_sa;

  reg              active_and_waiting_last_time;
  reg     [ 22: 0] nios_system_clock_0_out_address_last_time;
  wire    [ 22: 0] nios_system_clock_0_out_address_to_slave;
  reg     [  1: 0] nios_system_clock_0_out_byteenable_last_time;
  reg              nios_system_clock_0_out_read_last_time;
  wire    [ 15: 0] nios_system_clock_0_out_readdata;
  wire             nios_system_clock_0_out_reset_n;
  wire             nios_system_clock_0_out_run;
  wire             nios_system_clock_0_out_waitrequest;
  reg              nios_system_clock_0_out_write_last_time;
  reg     [ 15: 0] nios_system_clock_0_out_writedata_last_time;
  wire             r_3;
  //r_3 master_run cascaded wait assignment, which is an e_assign
  assign r_3 = 1 & (nios_system_clock_0_out_qualified_request_sdram_0_s1 | nios_system_clock_0_out_read_data_valid_sdram_0_s1 | ~nios_system_clock_0_out_requests_sdram_0_s1) & (nios_system_clock_0_out_granted_sdram_0_s1 | ~nios_system_clock_0_out_qualified_request_sdram_0_s1) & ((~nios_system_clock_0_out_qualified_request_sdram_0_s1 | ~nios_system_clock_0_out_read | (nios_system_clock_0_out_read_data_valid_sdram_0_s1 & nios_system_clock_0_out_read))) & ((~nios_system_clock_0_out_qualified_request_sdram_0_s1 | ~(nios_system_clock_0_out_read | nios_system_clock_0_out_write) | (1 & ~sdram_0_s1_waitrequest_from_sa & (nios_system_clock_0_out_read | nios_system_clock_0_out_write))));

  //cascaded wait assignment, which is an e_assign
  assign nios_system_clock_0_out_run = r_3;

  //optimize select-logic by passing only those address bits which matter.
  assign nios_system_clock_0_out_address_to_slave = nios_system_clock_0_out_address;

  //nios_system_clock_0/out readdata mux, which is an e_mux
  assign nios_system_clock_0_out_readdata = sdram_0_s1_readdata_from_sa;

  //actual waitrequest port, which is an e_assign
  assign nios_system_clock_0_out_waitrequest = ~nios_system_clock_0_out_run;

  //nios_system_clock_0_out_reset_n assignment, which is an e_assign
  assign nios_system_clock_0_out_reset_n = reset_n;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //nios_system_clock_0_out_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_0_out_address_last_time <= 0;
      else 
        nios_system_clock_0_out_address_last_time <= nios_system_clock_0_out_address;
    end


  //nios_system_clock_0/out waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= nios_system_clock_0_out_waitrequest & (nios_system_clock_0_out_read | nios_system_clock_0_out_write);
    end


  //nios_system_clock_0_out_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_system_clock_0_out_address != nios_system_clock_0_out_address_last_time))
        begin
          $write("%0d ns: nios_system_clock_0_out_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //nios_system_clock_0_out_byteenable check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_0_out_byteenable_last_time <= 0;
      else 
        nios_system_clock_0_out_byteenable_last_time <= nios_system_clock_0_out_byteenable;
    end


  //nios_system_clock_0_out_byteenable matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_system_clock_0_out_byteenable != nios_system_clock_0_out_byteenable_last_time))
        begin
          $write("%0d ns: nios_system_clock_0_out_byteenable did not heed wait!!!", $time);
          $stop;
        end
    end


  //nios_system_clock_0_out_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_0_out_read_last_time <= 0;
      else 
        nios_system_clock_0_out_read_last_time <= nios_system_clock_0_out_read;
    end


  //nios_system_clock_0_out_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_system_clock_0_out_read != nios_system_clock_0_out_read_last_time))
        begin
          $write("%0d ns: nios_system_clock_0_out_read did not heed wait!!!", $time);
          $stop;
        end
    end


  //nios_system_clock_0_out_write check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_0_out_write_last_time <= 0;
      else 
        nios_system_clock_0_out_write_last_time <= nios_system_clock_0_out_write;
    end


  //nios_system_clock_0_out_write matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_system_clock_0_out_write != nios_system_clock_0_out_write_last_time))
        begin
          $write("%0d ns: nios_system_clock_0_out_write did not heed wait!!!", $time);
          $stop;
        end
    end


  //nios_system_clock_0_out_writedata check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_0_out_writedata_last_time <= 0;
      else 
        nios_system_clock_0_out_writedata_last_time <= nios_system_clock_0_out_writedata;
    end


  //nios_system_clock_0_out_writedata matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_system_clock_0_out_writedata != nios_system_clock_0_out_writedata_last_time) & nios_system_clock_0_out_write)
        begin
          $write("%0d ns: nios_system_clock_0_out_writedata did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_system_clock_1_in_arbitrator (
                                           // inputs:
                                            clk,
                                            cpu_0_data_master_address_to_slave,
                                            cpu_0_data_master_byteenable,
                                            cpu_0_data_master_dbs_address,
                                            cpu_0_data_master_dbs_write_16,
                                            cpu_0_data_master_latency_counter,
                                            cpu_0_data_master_read,
                                            cpu_0_data_master_write,
                                            nios_system_clock_1_in_endofpacket,
                                            nios_system_clock_1_in_readdata,
                                            nios_system_clock_1_in_waitrequest,
                                            reset_n,

                                           // outputs:
                                            cpu_0_data_master_byteenable_nios_system_clock_1_in,
                                            cpu_0_data_master_granted_nios_system_clock_1_in,
                                            cpu_0_data_master_qualified_request_nios_system_clock_1_in,
                                            cpu_0_data_master_read_data_valid_nios_system_clock_1_in,
                                            cpu_0_data_master_requests_nios_system_clock_1_in,
                                            d1_nios_system_clock_1_in_end_xfer,
                                            nios_system_clock_1_in_address,
                                            nios_system_clock_1_in_byteenable,
                                            nios_system_clock_1_in_endofpacket_from_sa,
                                            nios_system_clock_1_in_nativeaddress,
                                            nios_system_clock_1_in_read,
                                            nios_system_clock_1_in_readdata_from_sa,
                                            nios_system_clock_1_in_reset_n,
                                            nios_system_clock_1_in_waitrequest_from_sa,
                                            nios_system_clock_1_in_write,
                                            nios_system_clock_1_in_writedata
                                         )
;

  output  [  1: 0] cpu_0_data_master_byteenable_nios_system_clock_1_in;
  output           cpu_0_data_master_granted_nios_system_clock_1_in;
  output           cpu_0_data_master_qualified_request_nios_system_clock_1_in;
  output           cpu_0_data_master_read_data_valid_nios_system_clock_1_in;
  output           cpu_0_data_master_requests_nios_system_clock_1_in;
  output           d1_nios_system_clock_1_in_end_xfer;
  output  [ 22: 0] nios_system_clock_1_in_address;
  output  [  1: 0] nios_system_clock_1_in_byteenable;
  output           nios_system_clock_1_in_endofpacket_from_sa;
  output  [ 21: 0] nios_system_clock_1_in_nativeaddress;
  output           nios_system_clock_1_in_read;
  output  [ 15: 0] nios_system_clock_1_in_readdata_from_sa;
  output           nios_system_clock_1_in_reset_n;
  output           nios_system_clock_1_in_waitrequest_from_sa;
  output           nios_system_clock_1_in_write;
  output  [ 15: 0] nios_system_clock_1_in_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input   [  1: 0] cpu_0_data_master_dbs_address;
  input   [ 15: 0] cpu_0_data_master_dbs_write_16;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input            nios_system_clock_1_in_endofpacket;
  input   [ 15: 0] nios_system_clock_1_in_readdata;
  input            nios_system_clock_1_in_waitrequest;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire    [  1: 0] cpu_0_data_master_byteenable_nios_system_clock_1_in;
  wire    [  1: 0] cpu_0_data_master_byteenable_nios_system_clock_1_in_segment_0;
  wire    [  1: 0] cpu_0_data_master_byteenable_nios_system_clock_1_in_segment_1;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_nios_system_clock_1_in;
  wire             cpu_0_data_master_qualified_request_nios_system_clock_1_in;
  wire             cpu_0_data_master_read_data_valid_nios_system_clock_1_in;
  wire             cpu_0_data_master_requests_nios_system_clock_1_in;
  wire             cpu_0_data_master_saved_grant_nios_system_clock_1_in;
  reg              d1_nios_system_clock_1_in_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_nios_system_clock_1_in;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 22: 0] nios_system_clock_1_in_address;
  wire             nios_system_clock_1_in_allgrants;
  wire             nios_system_clock_1_in_allow_new_arb_cycle;
  wire             nios_system_clock_1_in_any_bursting_master_saved_grant;
  wire             nios_system_clock_1_in_any_continuerequest;
  wire             nios_system_clock_1_in_arb_counter_enable;
  reg     [  2: 0] nios_system_clock_1_in_arb_share_counter;
  wire    [  2: 0] nios_system_clock_1_in_arb_share_counter_next_value;
  wire    [  2: 0] nios_system_clock_1_in_arb_share_set_values;
  wire             nios_system_clock_1_in_beginbursttransfer_internal;
  wire             nios_system_clock_1_in_begins_xfer;
  wire    [  1: 0] nios_system_clock_1_in_byteenable;
  wire             nios_system_clock_1_in_end_xfer;
  wire             nios_system_clock_1_in_endofpacket_from_sa;
  wire             nios_system_clock_1_in_firsttransfer;
  wire             nios_system_clock_1_in_grant_vector;
  wire             nios_system_clock_1_in_in_a_read_cycle;
  wire             nios_system_clock_1_in_in_a_write_cycle;
  wire             nios_system_clock_1_in_master_qreq_vector;
  wire    [ 21: 0] nios_system_clock_1_in_nativeaddress;
  wire             nios_system_clock_1_in_non_bursting_master_requests;
  wire             nios_system_clock_1_in_read;
  wire    [ 15: 0] nios_system_clock_1_in_readdata_from_sa;
  reg              nios_system_clock_1_in_reg_firsttransfer;
  wire             nios_system_clock_1_in_reset_n;
  reg              nios_system_clock_1_in_slavearbiterlockenable;
  wire             nios_system_clock_1_in_slavearbiterlockenable2;
  wire             nios_system_clock_1_in_unreg_firsttransfer;
  wire             nios_system_clock_1_in_waitrequest_from_sa;
  wire             nios_system_clock_1_in_waits_for_read;
  wire             nios_system_clock_1_in_waits_for_write;
  wire             nios_system_clock_1_in_write;
  wire    [ 15: 0] nios_system_clock_1_in_writedata;
  wire             wait_for_nios_system_clock_1_in_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~nios_system_clock_1_in_end_xfer;
    end


  assign nios_system_clock_1_in_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_nios_system_clock_1_in));
  //assign nios_system_clock_1_in_readdata_from_sa = nios_system_clock_1_in_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign nios_system_clock_1_in_readdata_from_sa = nios_system_clock_1_in_readdata;

  assign cpu_0_data_master_requests_nios_system_clock_1_in = ({cpu_0_data_master_address_to_slave[24 : 23] , 23'b0} == 25'h800000) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //assign nios_system_clock_1_in_waitrequest_from_sa = nios_system_clock_1_in_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign nios_system_clock_1_in_waitrequest_from_sa = nios_system_clock_1_in_waitrequest;

  //nios_system_clock_1_in_arb_share_counter set values, which is an e_mux
  assign nios_system_clock_1_in_arb_share_set_values = (cpu_0_data_master_granted_nios_system_clock_1_in)? 2 :
    1;

  //nios_system_clock_1_in_non_bursting_master_requests mux, which is an e_mux
  assign nios_system_clock_1_in_non_bursting_master_requests = cpu_0_data_master_requests_nios_system_clock_1_in;

  //nios_system_clock_1_in_any_bursting_master_saved_grant mux, which is an e_mux
  assign nios_system_clock_1_in_any_bursting_master_saved_grant = 0;

  //nios_system_clock_1_in_arb_share_counter_next_value assignment, which is an e_assign
  assign nios_system_clock_1_in_arb_share_counter_next_value = nios_system_clock_1_in_firsttransfer ? (nios_system_clock_1_in_arb_share_set_values - 1) : |nios_system_clock_1_in_arb_share_counter ? (nios_system_clock_1_in_arb_share_counter - 1) : 0;

  //nios_system_clock_1_in_allgrants all slave grants, which is an e_mux
  assign nios_system_clock_1_in_allgrants = |nios_system_clock_1_in_grant_vector;

  //nios_system_clock_1_in_end_xfer assignment, which is an e_assign
  assign nios_system_clock_1_in_end_xfer = ~(nios_system_clock_1_in_waits_for_read | nios_system_clock_1_in_waits_for_write);

  //end_xfer_arb_share_counter_term_nios_system_clock_1_in arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_nios_system_clock_1_in = nios_system_clock_1_in_end_xfer & (~nios_system_clock_1_in_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //nios_system_clock_1_in_arb_share_counter arbitration counter enable, which is an e_assign
  assign nios_system_clock_1_in_arb_counter_enable = (end_xfer_arb_share_counter_term_nios_system_clock_1_in & nios_system_clock_1_in_allgrants) | (end_xfer_arb_share_counter_term_nios_system_clock_1_in & ~nios_system_clock_1_in_non_bursting_master_requests);

  //nios_system_clock_1_in_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_1_in_arb_share_counter <= 0;
      else if (nios_system_clock_1_in_arb_counter_enable)
          nios_system_clock_1_in_arb_share_counter <= nios_system_clock_1_in_arb_share_counter_next_value;
    end


  //nios_system_clock_1_in_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_1_in_slavearbiterlockenable <= 0;
      else if ((|nios_system_clock_1_in_master_qreq_vector & end_xfer_arb_share_counter_term_nios_system_clock_1_in) | (end_xfer_arb_share_counter_term_nios_system_clock_1_in & ~nios_system_clock_1_in_non_bursting_master_requests))
          nios_system_clock_1_in_slavearbiterlockenable <= |nios_system_clock_1_in_arb_share_counter_next_value;
    end


  //cpu_0/data_master nios_system_clock_1/in arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = nios_system_clock_1_in_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //nios_system_clock_1_in_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign nios_system_clock_1_in_slavearbiterlockenable2 = |nios_system_clock_1_in_arb_share_counter_next_value;

  //cpu_0/data_master nios_system_clock_1/in arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = nios_system_clock_1_in_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //nios_system_clock_1_in_any_continuerequest at least one master continues requesting, which is an e_assign
  assign nios_system_clock_1_in_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_nios_system_clock_1_in = cpu_0_data_master_requests_nios_system_clock_1_in & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))) | ((!cpu_0_data_master_byteenable_nios_system_clock_1_in) & cpu_0_data_master_write));
  //local readdatavalid cpu_0_data_master_read_data_valid_nios_system_clock_1_in, which is an e_mux
  assign cpu_0_data_master_read_data_valid_nios_system_clock_1_in = cpu_0_data_master_granted_nios_system_clock_1_in & cpu_0_data_master_read & ~nios_system_clock_1_in_waits_for_read;

  //nios_system_clock_1_in_writedata mux, which is an e_mux
  assign nios_system_clock_1_in_writedata = cpu_0_data_master_dbs_write_16;

  //assign nios_system_clock_1_in_endofpacket_from_sa = nios_system_clock_1_in_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign nios_system_clock_1_in_endofpacket_from_sa = nios_system_clock_1_in_endofpacket;

  //master is always granted when requested
  assign cpu_0_data_master_granted_nios_system_clock_1_in = cpu_0_data_master_qualified_request_nios_system_clock_1_in;

  //cpu_0/data_master saved-grant nios_system_clock_1/in, which is an e_assign
  assign cpu_0_data_master_saved_grant_nios_system_clock_1_in = cpu_0_data_master_requests_nios_system_clock_1_in;

  //allow new arb cycle for nios_system_clock_1/in, which is an e_assign
  assign nios_system_clock_1_in_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign nios_system_clock_1_in_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign nios_system_clock_1_in_master_qreq_vector = 1;

  //nios_system_clock_1_in_reset_n assignment, which is an e_assign
  assign nios_system_clock_1_in_reset_n = reset_n;

  //nios_system_clock_1_in_firsttransfer first transaction, which is an e_assign
  assign nios_system_clock_1_in_firsttransfer = nios_system_clock_1_in_begins_xfer ? nios_system_clock_1_in_unreg_firsttransfer : nios_system_clock_1_in_reg_firsttransfer;

  //nios_system_clock_1_in_unreg_firsttransfer first transaction, which is an e_assign
  assign nios_system_clock_1_in_unreg_firsttransfer = ~(nios_system_clock_1_in_slavearbiterlockenable & nios_system_clock_1_in_any_continuerequest);

  //nios_system_clock_1_in_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_1_in_reg_firsttransfer <= 1'b1;
      else if (nios_system_clock_1_in_begins_xfer)
          nios_system_clock_1_in_reg_firsttransfer <= nios_system_clock_1_in_unreg_firsttransfer;
    end


  //nios_system_clock_1_in_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign nios_system_clock_1_in_beginbursttransfer_internal = nios_system_clock_1_in_begins_xfer;

  //nios_system_clock_1_in_read assignment, which is an e_mux
  assign nios_system_clock_1_in_read = cpu_0_data_master_granted_nios_system_clock_1_in & cpu_0_data_master_read;

  //nios_system_clock_1_in_write assignment, which is an e_mux
  assign nios_system_clock_1_in_write = cpu_0_data_master_granted_nios_system_clock_1_in & cpu_0_data_master_write;

  //nios_system_clock_1_in_address mux, which is an e_mux
  assign nios_system_clock_1_in_address = {cpu_0_data_master_address_to_slave >> 2,
    cpu_0_data_master_dbs_address[1],
    {1 {1'b0}}};

  //slaveid nios_system_clock_1_in_nativeaddress nativeaddress mux, which is an e_mux
  assign nios_system_clock_1_in_nativeaddress = cpu_0_data_master_address_to_slave >> 2;

  //d1_nios_system_clock_1_in_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_nios_system_clock_1_in_end_xfer <= 1;
      else 
        d1_nios_system_clock_1_in_end_xfer <= nios_system_clock_1_in_end_xfer;
    end


  //nios_system_clock_1_in_waits_for_read in a cycle, which is an e_mux
  assign nios_system_clock_1_in_waits_for_read = nios_system_clock_1_in_in_a_read_cycle & nios_system_clock_1_in_waitrequest_from_sa;

  //nios_system_clock_1_in_in_a_read_cycle assignment, which is an e_assign
  assign nios_system_clock_1_in_in_a_read_cycle = cpu_0_data_master_granted_nios_system_clock_1_in & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = nios_system_clock_1_in_in_a_read_cycle;

  //nios_system_clock_1_in_waits_for_write in a cycle, which is an e_mux
  assign nios_system_clock_1_in_waits_for_write = nios_system_clock_1_in_in_a_write_cycle & nios_system_clock_1_in_waitrequest_from_sa;

  //nios_system_clock_1_in_in_a_write_cycle assignment, which is an e_assign
  assign nios_system_clock_1_in_in_a_write_cycle = cpu_0_data_master_granted_nios_system_clock_1_in & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = nios_system_clock_1_in_in_a_write_cycle;

  assign wait_for_nios_system_clock_1_in_counter = 0;
  //nios_system_clock_1_in_byteenable byte enable port mux, which is an e_mux
  assign nios_system_clock_1_in_byteenable = (cpu_0_data_master_granted_nios_system_clock_1_in)? cpu_0_data_master_byteenable_nios_system_clock_1_in :
    -1;

  assign {cpu_0_data_master_byteenable_nios_system_clock_1_in_segment_1,
cpu_0_data_master_byteenable_nios_system_clock_1_in_segment_0} = cpu_0_data_master_byteenable;
  assign cpu_0_data_master_byteenable_nios_system_clock_1_in = ((cpu_0_data_master_dbs_address[1] == 0))? cpu_0_data_master_byteenable_nios_system_clock_1_in_segment_0 :
    cpu_0_data_master_byteenable_nios_system_clock_1_in_segment_1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //nios_system_clock_1/in enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_system_clock_1_out_arbitrator (
                                            // inputs:
                                             clk,
                                             d1_sdram_0_s1_end_xfer,
                                             nios_system_clock_1_out_address,
                                             nios_system_clock_1_out_byteenable,
                                             nios_system_clock_1_out_granted_sdram_0_s1,
                                             nios_system_clock_1_out_qualified_request_sdram_0_s1,
                                             nios_system_clock_1_out_read,
                                             nios_system_clock_1_out_read_data_valid_sdram_0_s1,
                                             nios_system_clock_1_out_read_data_valid_sdram_0_s1_shift_register,
                                             nios_system_clock_1_out_requests_sdram_0_s1,
                                             nios_system_clock_1_out_write,
                                             nios_system_clock_1_out_writedata,
                                             reset_n,
                                             sdram_0_s1_readdata_from_sa,
                                             sdram_0_s1_waitrequest_from_sa,

                                            // outputs:
                                             nios_system_clock_1_out_address_to_slave,
                                             nios_system_clock_1_out_readdata,
                                             nios_system_clock_1_out_reset_n,
                                             nios_system_clock_1_out_waitrequest
                                          )
;

  output  [ 22: 0] nios_system_clock_1_out_address_to_slave;
  output  [ 15: 0] nios_system_clock_1_out_readdata;
  output           nios_system_clock_1_out_reset_n;
  output           nios_system_clock_1_out_waitrequest;
  input            clk;
  input            d1_sdram_0_s1_end_xfer;
  input   [ 22: 0] nios_system_clock_1_out_address;
  input   [  1: 0] nios_system_clock_1_out_byteenable;
  input            nios_system_clock_1_out_granted_sdram_0_s1;
  input            nios_system_clock_1_out_qualified_request_sdram_0_s1;
  input            nios_system_clock_1_out_read;
  input            nios_system_clock_1_out_read_data_valid_sdram_0_s1;
  input            nios_system_clock_1_out_read_data_valid_sdram_0_s1_shift_register;
  input            nios_system_clock_1_out_requests_sdram_0_s1;
  input            nios_system_clock_1_out_write;
  input   [ 15: 0] nios_system_clock_1_out_writedata;
  input            reset_n;
  input   [ 15: 0] sdram_0_s1_readdata_from_sa;
  input            sdram_0_s1_waitrequest_from_sa;

  reg              active_and_waiting_last_time;
  reg     [ 22: 0] nios_system_clock_1_out_address_last_time;
  wire    [ 22: 0] nios_system_clock_1_out_address_to_slave;
  reg     [  1: 0] nios_system_clock_1_out_byteenable_last_time;
  reg              nios_system_clock_1_out_read_last_time;
  wire    [ 15: 0] nios_system_clock_1_out_readdata;
  wire             nios_system_clock_1_out_reset_n;
  wire             nios_system_clock_1_out_run;
  wire             nios_system_clock_1_out_waitrequest;
  reg              nios_system_clock_1_out_write_last_time;
  reg     [ 15: 0] nios_system_clock_1_out_writedata_last_time;
  wire             r_3;
  //r_3 master_run cascaded wait assignment, which is an e_assign
  assign r_3 = 1 & (nios_system_clock_1_out_qualified_request_sdram_0_s1 | nios_system_clock_1_out_read_data_valid_sdram_0_s1 | ~nios_system_clock_1_out_requests_sdram_0_s1) & (nios_system_clock_1_out_granted_sdram_0_s1 | ~nios_system_clock_1_out_qualified_request_sdram_0_s1) & ((~nios_system_clock_1_out_qualified_request_sdram_0_s1 | ~nios_system_clock_1_out_read | (nios_system_clock_1_out_read_data_valid_sdram_0_s1 & nios_system_clock_1_out_read))) & ((~nios_system_clock_1_out_qualified_request_sdram_0_s1 | ~(nios_system_clock_1_out_read | nios_system_clock_1_out_write) | (1 & ~sdram_0_s1_waitrequest_from_sa & (nios_system_clock_1_out_read | nios_system_clock_1_out_write))));

  //cascaded wait assignment, which is an e_assign
  assign nios_system_clock_1_out_run = r_3;

  //optimize select-logic by passing only those address bits which matter.
  assign nios_system_clock_1_out_address_to_slave = nios_system_clock_1_out_address;

  //nios_system_clock_1/out readdata mux, which is an e_mux
  assign nios_system_clock_1_out_readdata = sdram_0_s1_readdata_from_sa;

  //actual waitrequest port, which is an e_assign
  assign nios_system_clock_1_out_waitrequest = ~nios_system_clock_1_out_run;

  //nios_system_clock_1_out_reset_n assignment, which is an e_assign
  assign nios_system_clock_1_out_reset_n = reset_n;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //nios_system_clock_1_out_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_1_out_address_last_time <= 0;
      else 
        nios_system_clock_1_out_address_last_time <= nios_system_clock_1_out_address;
    end


  //nios_system_clock_1/out waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= nios_system_clock_1_out_waitrequest & (nios_system_clock_1_out_read | nios_system_clock_1_out_write);
    end


  //nios_system_clock_1_out_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_system_clock_1_out_address != nios_system_clock_1_out_address_last_time))
        begin
          $write("%0d ns: nios_system_clock_1_out_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //nios_system_clock_1_out_byteenable check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_1_out_byteenable_last_time <= 0;
      else 
        nios_system_clock_1_out_byteenable_last_time <= nios_system_clock_1_out_byteenable;
    end


  //nios_system_clock_1_out_byteenable matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_system_clock_1_out_byteenable != nios_system_clock_1_out_byteenable_last_time))
        begin
          $write("%0d ns: nios_system_clock_1_out_byteenable did not heed wait!!!", $time);
          $stop;
        end
    end


  //nios_system_clock_1_out_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_1_out_read_last_time <= 0;
      else 
        nios_system_clock_1_out_read_last_time <= nios_system_clock_1_out_read;
    end


  //nios_system_clock_1_out_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_system_clock_1_out_read != nios_system_clock_1_out_read_last_time))
        begin
          $write("%0d ns: nios_system_clock_1_out_read did not heed wait!!!", $time);
          $stop;
        end
    end


  //nios_system_clock_1_out_write check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_1_out_write_last_time <= 0;
      else 
        nios_system_clock_1_out_write_last_time <= nios_system_clock_1_out_write;
    end


  //nios_system_clock_1_out_write matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_system_clock_1_out_write != nios_system_clock_1_out_write_last_time))
        begin
          $write("%0d ns: nios_system_clock_1_out_write did not heed wait!!!", $time);
          $stop;
        end
    end


  //nios_system_clock_1_out_writedata check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_1_out_writedata_last_time <= 0;
      else 
        nios_system_clock_1_out_writedata_last_time <= nios_system_clock_1_out_writedata;
    end


  //nios_system_clock_1_out_writedata matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_system_clock_1_out_writedata != nios_system_clock_1_out_writedata_last_time) & nios_system_clock_1_out_write)
        begin
          $write("%0d ns: nios_system_clock_1_out_writedata did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_system_clock_2_in_arbitrator (
                                           // inputs:
                                            clk,
                                            cpu_0_data_master_address_to_slave,
                                            cpu_0_data_master_byteenable,
                                            cpu_0_data_master_dbs_address,
                                            cpu_0_data_master_dbs_write_8,
                                            cpu_0_data_master_latency_counter,
                                            cpu_0_data_master_read,
                                            cpu_0_data_master_write,
                                            nios_system_clock_2_in_endofpacket,
                                            nios_system_clock_2_in_readdata,
                                            nios_system_clock_2_in_waitrequest,
                                            reset_n,

                                           // outputs:
                                            cpu_0_data_master_byteenable_nios_system_clock_2_in,
                                            cpu_0_data_master_granted_nios_system_clock_2_in,
                                            cpu_0_data_master_qualified_request_nios_system_clock_2_in,
                                            cpu_0_data_master_read_data_valid_nios_system_clock_2_in,
                                            cpu_0_data_master_requests_nios_system_clock_2_in,
                                            d1_nios_system_clock_2_in_end_xfer,
                                            nios_system_clock_2_in_address,
                                            nios_system_clock_2_in_endofpacket_from_sa,
                                            nios_system_clock_2_in_nativeaddress,
                                            nios_system_clock_2_in_read,
                                            nios_system_clock_2_in_readdata_from_sa,
                                            nios_system_clock_2_in_reset_n,
                                            nios_system_clock_2_in_waitrequest_from_sa,
                                            nios_system_clock_2_in_write,
                                            nios_system_clock_2_in_writedata
                                         )
;

  output           cpu_0_data_master_byteenable_nios_system_clock_2_in;
  output           cpu_0_data_master_granted_nios_system_clock_2_in;
  output           cpu_0_data_master_qualified_request_nios_system_clock_2_in;
  output           cpu_0_data_master_read_data_valid_nios_system_clock_2_in;
  output           cpu_0_data_master_requests_nios_system_clock_2_in;
  output           d1_nios_system_clock_2_in_end_xfer;
  output           nios_system_clock_2_in_address;
  output           nios_system_clock_2_in_endofpacket_from_sa;
  output           nios_system_clock_2_in_nativeaddress;
  output           nios_system_clock_2_in_read;
  output  [  7: 0] nios_system_clock_2_in_readdata_from_sa;
  output           nios_system_clock_2_in_reset_n;
  output           nios_system_clock_2_in_waitrequest_from_sa;
  output           nios_system_clock_2_in_write;
  output  [  7: 0] nios_system_clock_2_in_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input   [  1: 0] cpu_0_data_master_dbs_address;
  input   [  7: 0] cpu_0_data_master_dbs_write_8;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input            nios_system_clock_2_in_endofpacket;
  input   [  7: 0] nios_system_clock_2_in_readdata;
  input            nios_system_clock_2_in_waitrequest;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_byteenable_nios_system_clock_2_in;
  wire             cpu_0_data_master_byteenable_nios_system_clock_2_in_segment_0;
  wire             cpu_0_data_master_byteenable_nios_system_clock_2_in_segment_1;
  wire             cpu_0_data_master_byteenable_nios_system_clock_2_in_segment_2;
  wire             cpu_0_data_master_byteenable_nios_system_clock_2_in_segment_3;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_nios_system_clock_2_in;
  wire             cpu_0_data_master_qualified_request_nios_system_clock_2_in;
  wire             cpu_0_data_master_read_data_valid_nios_system_clock_2_in;
  wire             cpu_0_data_master_requests_nios_system_clock_2_in;
  wire             cpu_0_data_master_saved_grant_nios_system_clock_2_in;
  reg              d1_nios_system_clock_2_in_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_nios_system_clock_2_in;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             nios_system_clock_2_in_address;
  wire             nios_system_clock_2_in_allgrants;
  wire             nios_system_clock_2_in_allow_new_arb_cycle;
  wire             nios_system_clock_2_in_any_bursting_master_saved_grant;
  wire             nios_system_clock_2_in_any_continuerequest;
  wire             nios_system_clock_2_in_arb_counter_enable;
  reg     [  2: 0] nios_system_clock_2_in_arb_share_counter;
  wire    [  2: 0] nios_system_clock_2_in_arb_share_counter_next_value;
  wire    [  2: 0] nios_system_clock_2_in_arb_share_set_values;
  wire             nios_system_clock_2_in_beginbursttransfer_internal;
  wire             nios_system_clock_2_in_begins_xfer;
  wire             nios_system_clock_2_in_end_xfer;
  wire             nios_system_clock_2_in_endofpacket_from_sa;
  wire             nios_system_clock_2_in_firsttransfer;
  wire             nios_system_clock_2_in_grant_vector;
  wire             nios_system_clock_2_in_in_a_read_cycle;
  wire             nios_system_clock_2_in_in_a_write_cycle;
  wire             nios_system_clock_2_in_master_qreq_vector;
  wire             nios_system_clock_2_in_nativeaddress;
  wire             nios_system_clock_2_in_non_bursting_master_requests;
  wire             nios_system_clock_2_in_pretend_byte_enable;
  wire             nios_system_clock_2_in_read;
  wire    [  7: 0] nios_system_clock_2_in_readdata_from_sa;
  reg              nios_system_clock_2_in_reg_firsttransfer;
  wire             nios_system_clock_2_in_reset_n;
  reg              nios_system_clock_2_in_slavearbiterlockenable;
  wire             nios_system_clock_2_in_slavearbiterlockenable2;
  wire             nios_system_clock_2_in_unreg_firsttransfer;
  wire             nios_system_clock_2_in_waitrequest_from_sa;
  wire             nios_system_clock_2_in_waits_for_read;
  wire             nios_system_clock_2_in_waits_for_write;
  wire             nios_system_clock_2_in_write;
  wire    [  7: 0] nios_system_clock_2_in_writedata;
  wire             wait_for_nios_system_clock_2_in_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~nios_system_clock_2_in_end_xfer;
    end


  assign nios_system_clock_2_in_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_nios_system_clock_2_in));
  //assign nios_system_clock_2_in_readdata_from_sa = nios_system_clock_2_in_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign nios_system_clock_2_in_readdata_from_sa = nios_system_clock_2_in_readdata;

  assign cpu_0_data_master_requests_nios_system_clock_2_in = ({cpu_0_data_master_address_to_slave[24 : 1] , 1'b0} == 25'h1001040) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //assign nios_system_clock_2_in_waitrequest_from_sa = nios_system_clock_2_in_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign nios_system_clock_2_in_waitrequest_from_sa = nios_system_clock_2_in_waitrequest;

  //nios_system_clock_2_in_arb_share_counter set values, which is an e_mux
  assign nios_system_clock_2_in_arb_share_set_values = (cpu_0_data_master_granted_nios_system_clock_2_in)? 4 :
    1;

  //nios_system_clock_2_in_non_bursting_master_requests mux, which is an e_mux
  assign nios_system_clock_2_in_non_bursting_master_requests = cpu_0_data_master_requests_nios_system_clock_2_in;

  //nios_system_clock_2_in_any_bursting_master_saved_grant mux, which is an e_mux
  assign nios_system_clock_2_in_any_bursting_master_saved_grant = 0;

  //nios_system_clock_2_in_arb_share_counter_next_value assignment, which is an e_assign
  assign nios_system_clock_2_in_arb_share_counter_next_value = nios_system_clock_2_in_firsttransfer ? (nios_system_clock_2_in_arb_share_set_values - 1) : |nios_system_clock_2_in_arb_share_counter ? (nios_system_clock_2_in_arb_share_counter - 1) : 0;

  //nios_system_clock_2_in_allgrants all slave grants, which is an e_mux
  assign nios_system_clock_2_in_allgrants = |nios_system_clock_2_in_grant_vector;

  //nios_system_clock_2_in_end_xfer assignment, which is an e_assign
  assign nios_system_clock_2_in_end_xfer = ~(nios_system_clock_2_in_waits_for_read | nios_system_clock_2_in_waits_for_write);

  //end_xfer_arb_share_counter_term_nios_system_clock_2_in arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_nios_system_clock_2_in = nios_system_clock_2_in_end_xfer & (~nios_system_clock_2_in_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //nios_system_clock_2_in_arb_share_counter arbitration counter enable, which is an e_assign
  assign nios_system_clock_2_in_arb_counter_enable = (end_xfer_arb_share_counter_term_nios_system_clock_2_in & nios_system_clock_2_in_allgrants) | (end_xfer_arb_share_counter_term_nios_system_clock_2_in & ~nios_system_clock_2_in_non_bursting_master_requests);

  //nios_system_clock_2_in_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_2_in_arb_share_counter <= 0;
      else if (nios_system_clock_2_in_arb_counter_enable)
          nios_system_clock_2_in_arb_share_counter <= nios_system_clock_2_in_arb_share_counter_next_value;
    end


  //nios_system_clock_2_in_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_2_in_slavearbiterlockenable <= 0;
      else if ((|nios_system_clock_2_in_master_qreq_vector & end_xfer_arb_share_counter_term_nios_system_clock_2_in) | (end_xfer_arb_share_counter_term_nios_system_clock_2_in & ~nios_system_clock_2_in_non_bursting_master_requests))
          nios_system_clock_2_in_slavearbiterlockenable <= |nios_system_clock_2_in_arb_share_counter_next_value;
    end


  //cpu_0/data_master nios_system_clock_2/in arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = nios_system_clock_2_in_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //nios_system_clock_2_in_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign nios_system_clock_2_in_slavearbiterlockenable2 = |nios_system_clock_2_in_arb_share_counter_next_value;

  //cpu_0/data_master nios_system_clock_2/in arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = nios_system_clock_2_in_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //nios_system_clock_2_in_any_continuerequest at least one master continues requesting, which is an e_assign
  assign nios_system_clock_2_in_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_nios_system_clock_2_in = cpu_0_data_master_requests_nios_system_clock_2_in & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))) | ((!cpu_0_data_master_byteenable_nios_system_clock_2_in) & cpu_0_data_master_write));
  //local readdatavalid cpu_0_data_master_read_data_valid_nios_system_clock_2_in, which is an e_mux
  assign cpu_0_data_master_read_data_valid_nios_system_clock_2_in = cpu_0_data_master_granted_nios_system_clock_2_in & cpu_0_data_master_read & ~nios_system_clock_2_in_waits_for_read;

  //nios_system_clock_2_in_writedata mux, which is an e_mux
  assign nios_system_clock_2_in_writedata = cpu_0_data_master_dbs_write_8;

  //assign nios_system_clock_2_in_endofpacket_from_sa = nios_system_clock_2_in_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign nios_system_clock_2_in_endofpacket_from_sa = nios_system_clock_2_in_endofpacket;

  //master is always granted when requested
  assign cpu_0_data_master_granted_nios_system_clock_2_in = cpu_0_data_master_qualified_request_nios_system_clock_2_in;

  //cpu_0/data_master saved-grant nios_system_clock_2/in, which is an e_assign
  assign cpu_0_data_master_saved_grant_nios_system_clock_2_in = cpu_0_data_master_requests_nios_system_clock_2_in;

  //allow new arb cycle for nios_system_clock_2/in, which is an e_assign
  assign nios_system_clock_2_in_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign nios_system_clock_2_in_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign nios_system_clock_2_in_master_qreq_vector = 1;

  //nios_system_clock_2_in_reset_n assignment, which is an e_assign
  assign nios_system_clock_2_in_reset_n = reset_n;

  //nios_system_clock_2_in_firsttransfer first transaction, which is an e_assign
  assign nios_system_clock_2_in_firsttransfer = nios_system_clock_2_in_begins_xfer ? nios_system_clock_2_in_unreg_firsttransfer : nios_system_clock_2_in_reg_firsttransfer;

  //nios_system_clock_2_in_unreg_firsttransfer first transaction, which is an e_assign
  assign nios_system_clock_2_in_unreg_firsttransfer = ~(nios_system_clock_2_in_slavearbiterlockenable & nios_system_clock_2_in_any_continuerequest);

  //nios_system_clock_2_in_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_2_in_reg_firsttransfer <= 1'b1;
      else if (nios_system_clock_2_in_begins_xfer)
          nios_system_clock_2_in_reg_firsttransfer <= nios_system_clock_2_in_unreg_firsttransfer;
    end


  //nios_system_clock_2_in_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign nios_system_clock_2_in_beginbursttransfer_internal = nios_system_clock_2_in_begins_xfer;

  //nios_system_clock_2_in_read assignment, which is an e_mux
  assign nios_system_clock_2_in_read = cpu_0_data_master_granted_nios_system_clock_2_in & cpu_0_data_master_read;

  //nios_system_clock_2_in_write assignment, which is an e_mux
  assign nios_system_clock_2_in_write = ((cpu_0_data_master_granted_nios_system_clock_2_in & cpu_0_data_master_write)) & nios_system_clock_2_in_pretend_byte_enable;

  //nios_system_clock_2_in_address mux, which is an e_mux
  assign nios_system_clock_2_in_address = {cpu_0_data_master_address_to_slave >> 2,
    cpu_0_data_master_dbs_address[1 : 0]};

  //slaveid nios_system_clock_2_in_nativeaddress nativeaddress mux, which is an e_mux
  assign nios_system_clock_2_in_nativeaddress = cpu_0_data_master_address_to_slave >> 2;

  //d1_nios_system_clock_2_in_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_nios_system_clock_2_in_end_xfer <= 1;
      else 
        d1_nios_system_clock_2_in_end_xfer <= nios_system_clock_2_in_end_xfer;
    end


  //nios_system_clock_2_in_waits_for_read in a cycle, which is an e_mux
  assign nios_system_clock_2_in_waits_for_read = nios_system_clock_2_in_in_a_read_cycle & nios_system_clock_2_in_waitrequest_from_sa;

  //nios_system_clock_2_in_in_a_read_cycle assignment, which is an e_assign
  assign nios_system_clock_2_in_in_a_read_cycle = cpu_0_data_master_granted_nios_system_clock_2_in & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = nios_system_clock_2_in_in_a_read_cycle;

  //nios_system_clock_2_in_waits_for_write in a cycle, which is an e_mux
  assign nios_system_clock_2_in_waits_for_write = nios_system_clock_2_in_in_a_write_cycle & nios_system_clock_2_in_waitrequest_from_sa;

  //nios_system_clock_2_in_in_a_write_cycle assignment, which is an e_assign
  assign nios_system_clock_2_in_in_a_write_cycle = cpu_0_data_master_granted_nios_system_clock_2_in & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = nios_system_clock_2_in_in_a_write_cycle;

  assign wait_for_nios_system_clock_2_in_counter = 0;
  //nios_system_clock_2_in_pretend_byte_enable byte enable port mux, which is an e_mux
  assign nios_system_clock_2_in_pretend_byte_enable = (cpu_0_data_master_granted_nios_system_clock_2_in)? cpu_0_data_master_byteenable_nios_system_clock_2_in :
    -1;

  assign {cpu_0_data_master_byteenable_nios_system_clock_2_in_segment_3,
cpu_0_data_master_byteenable_nios_system_clock_2_in_segment_2,
cpu_0_data_master_byteenable_nios_system_clock_2_in_segment_1,
cpu_0_data_master_byteenable_nios_system_clock_2_in_segment_0} = cpu_0_data_master_byteenable;
  assign cpu_0_data_master_byteenable_nios_system_clock_2_in = ((cpu_0_data_master_dbs_address[1 : 0] == 0))? cpu_0_data_master_byteenable_nios_system_clock_2_in_segment_0 :
    ((cpu_0_data_master_dbs_address[1 : 0] == 1))? cpu_0_data_master_byteenable_nios_system_clock_2_in_segment_1 :
    ((cpu_0_data_master_dbs_address[1 : 0] == 2))? cpu_0_data_master_byteenable_nios_system_clock_2_in_segment_2 :
    cpu_0_data_master_byteenable_nios_system_clock_2_in_segment_3;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //nios_system_clock_2/in enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_system_clock_2_out_arbitrator (
                                            // inputs:
                                             clk,
                                             clocks_0_avalon_clocks_slave_readdata_from_sa,
                                             d1_clocks_0_avalon_clocks_slave_end_xfer,
                                             nios_system_clock_2_out_address,
                                             nios_system_clock_2_out_granted_clocks_0_avalon_clocks_slave,
                                             nios_system_clock_2_out_qualified_request_clocks_0_avalon_clocks_slave,
                                             nios_system_clock_2_out_read,
                                             nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave,
                                             nios_system_clock_2_out_requests_clocks_0_avalon_clocks_slave,
                                             nios_system_clock_2_out_write,
                                             nios_system_clock_2_out_writedata,
                                             reset_n,

                                            // outputs:
                                             nios_system_clock_2_out_address_to_slave,
                                             nios_system_clock_2_out_readdata,
                                             nios_system_clock_2_out_reset_n,
                                             nios_system_clock_2_out_waitrequest
                                          )
;

  output           nios_system_clock_2_out_address_to_slave;
  output  [  7: 0] nios_system_clock_2_out_readdata;
  output           nios_system_clock_2_out_reset_n;
  output           nios_system_clock_2_out_waitrequest;
  input            clk;
  input   [  7: 0] clocks_0_avalon_clocks_slave_readdata_from_sa;
  input            d1_clocks_0_avalon_clocks_slave_end_xfer;
  input            nios_system_clock_2_out_address;
  input            nios_system_clock_2_out_granted_clocks_0_avalon_clocks_slave;
  input            nios_system_clock_2_out_qualified_request_clocks_0_avalon_clocks_slave;
  input            nios_system_clock_2_out_read;
  input            nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave;
  input            nios_system_clock_2_out_requests_clocks_0_avalon_clocks_slave;
  input            nios_system_clock_2_out_write;
  input   [  7: 0] nios_system_clock_2_out_writedata;
  input            reset_n;

  reg              active_and_waiting_last_time;
  reg              nios_system_clock_2_out_address_last_time;
  wire             nios_system_clock_2_out_address_to_slave;
  reg              nios_system_clock_2_out_read_last_time;
  wire    [  7: 0] nios_system_clock_2_out_readdata;
  wire             nios_system_clock_2_out_reset_n;
  wire             nios_system_clock_2_out_run;
  wire             nios_system_clock_2_out_waitrequest;
  reg              nios_system_clock_2_out_write_last_time;
  reg     [  7: 0] nios_system_clock_2_out_writedata_last_time;
  wire             r_1;
  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = 1 & (nios_system_clock_2_out_qualified_request_clocks_0_avalon_clocks_slave | nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave | ~nios_system_clock_2_out_requests_clocks_0_avalon_clocks_slave) & ((~nios_system_clock_2_out_qualified_request_clocks_0_avalon_clocks_slave | ~nios_system_clock_2_out_read | (nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave & nios_system_clock_2_out_read))) & ((~nios_system_clock_2_out_qualified_request_clocks_0_avalon_clocks_slave | ~(nios_system_clock_2_out_read | nios_system_clock_2_out_write) | (1 & (nios_system_clock_2_out_read | nios_system_clock_2_out_write))));

  //cascaded wait assignment, which is an e_assign
  assign nios_system_clock_2_out_run = r_1;

  //optimize select-logic by passing only those address bits which matter.
  assign nios_system_clock_2_out_address_to_slave = nios_system_clock_2_out_address;

  //nios_system_clock_2/out readdata mux, which is an e_mux
  assign nios_system_clock_2_out_readdata = clocks_0_avalon_clocks_slave_readdata_from_sa;

  //actual waitrequest port, which is an e_assign
  assign nios_system_clock_2_out_waitrequest = ~nios_system_clock_2_out_run;

  //nios_system_clock_2_out_reset_n assignment, which is an e_assign
  assign nios_system_clock_2_out_reset_n = reset_n;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //nios_system_clock_2_out_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_2_out_address_last_time <= 0;
      else 
        nios_system_clock_2_out_address_last_time <= nios_system_clock_2_out_address;
    end


  //nios_system_clock_2/out waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= nios_system_clock_2_out_waitrequest & (nios_system_clock_2_out_read | nios_system_clock_2_out_write);
    end


  //nios_system_clock_2_out_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_system_clock_2_out_address != nios_system_clock_2_out_address_last_time))
        begin
          $write("%0d ns: nios_system_clock_2_out_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //nios_system_clock_2_out_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_2_out_read_last_time <= 0;
      else 
        nios_system_clock_2_out_read_last_time <= nios_system_clock_2_out_read;
    end


  //nios_system_clock_2_out_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_system_clock_2_out_read != nios_system_clock_2_out_read_last_time))
        begin
          $write("%0d ns: nios_system_clock_2_out_read did not heed wait!!!", $time);
          $stop;
        end
    end


  //nios_system_clock_2_out_write check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_2_out_write_last_time <= 0;
      else 
        nios_system_clock_2_out_write_last_time <= nios_system_clock_2_out_write;
    end


  //nios_system_clock_2_out_write matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_system_clock_2_out_write != nios_system_clock_2_out_write_last_time))
        begin
          $write("%0d ns: nios_system_clock_2_out_write did not heed wait!!!", $time);
          $stop;
        end
    end


  //nios_system_clock_2_out_writedata check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_system_clock_2_out_writedata_last_time <= 0;
      else 
        nios_system_clock_2_out_writedata_last_time <= nios_system_clock_2_out_writedata;
    end


  //nios_system_clock_2_out_writedata matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_system_clock_2_out_writedata != nios_system_clock_2_out_writedata_last_time) & nios_system_clock_2_out_write)
        begin
          $write("%0d ns: nios_system_clock_2_out_writedata did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_nios_system_clock_0_out_to_sdram_0_s1_module (
                                                                   // inputs:
                                                                    clear_fifo,
                                                                    clk,
                                                                    data_in,
                                                                    read,
                                                                    reset_n,
                                                                    sync_reset,
                                                                    write,

                                                                   // outputs:
                                                                    data_out,
                                                                    empty,
                                                                    fifo_contains_ones_n,
                                                                    full
                                                                 )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_2;
  reg              full_3;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  wire             full_7;
  reg     [  3: 0] how_many_ones;
  wire    [  3: 0] one_count_minus_one;
  wire    [  3: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  reg              stage_0;
  reg              stage_1;
  reg              stage_2;
  reg              stage_3;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  wire    [  3: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_6;
  assign empty = !full_0;
  assign full_7 = 0;
  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    0;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_nios_system_clock_1_out_to_sdram_0_s1_module (
                                                                   // inputs:
                                                                    clear_fifo,
                                                                    clk,
                                                                    data_in,
                                                                    read,
                                                                    reset_n,
                                                                    sync_reset,
                                                                    write,

                                                                   // outputs:
                                                                    data_out,
                                                                    empty,
                                                                    fifo_contains_ones_n,
                                                                    full
                                                                 )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_2;
  reg              full_3;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  wire             full_7;
  reg     [  3: 0] how_many_ones;
  wire    [  3: 0] one_count_minus_one;
  wire    [  3: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  reg              stage_0;
  reg              stage_1;
  reg              stage_2;
  reg              stage_3;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  wire    [  3: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_6;
  assign empty = !full_0;
  assign full_7 = 0;
  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    0;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sdram_0_s1_arbitrator (
                               // inputs:
                                clk,
                                nios_system_clock_0_out_address_to_slave,
                                nios_system_clock_0_out_byteenable,
                                nios_system_clock_0_out_read,
                                nios_system_clock_0_out_write,
                                nios_system_clock_0_out_writedata,
                                nios_system_clock_1_out_address_to_slave,
                                nios_system_clock_1_out_byteenable,
                                nios_system_clock_1_out_read,
                                nios_system_clock_1_out_write,
                                nios_system_clock_1_out_writedata,
                                reset_n,
                                sdram_0_s1_readdata,
                                sdram_0_s1_readdatavalid,
                                sdram_0_s1_waitrequest,

                               // outputs:
                                d1_sdram_0_s1_end_xfer,
                                nios_system_clock_0_out_granted_sdram_0_s1,
                                nios_system_clock_0_out_qualified_request_sdram_0_s1,
                                nios_system_clock_0_out_read_data_valid_sdram_0_s1,
                                nios_system_clock_0_out_read_data_valid_sdram_0_s1_shift_register,
                                nios_system_clock_0_out_requests_sdram_0_s1,
                                nios_system_clock_1_out_granted_sdram_0_s1,
                                nios_system_clock_1_out_qualified_request_sdram_0_s1,
                                nios_system_clock_1_out_read_data_valid_sdram_0_s1,
                                nios_system_clock_1_out_read_data_valid_sdram_0_s1_shift_register,
                                nios_system_clock_1_out_requests_sdram_0_s1,
                                sdram_0_s1_address,
                                sdram_0_s1_byteenable_n,
                                sdram_0_s1_chipselect,
                                sdram_0_s1_read_n,
                                sdram_0_s1_readdata_from_sa,
                                sdram_0_s1_reset_n,
                                sdram_0_s1_waitrequest_from_sa,
                                sdram_0_s1_write_n,
                                sdram_0_s1_writedata
                             )
;

  output           d1_sdram_0_s1_end_xfer;
  output           nios_system_clock_0_out_granted_sdram_0_s1;
  output           nios_system_clock_0_out_qualified_request_sdram_0_s1;
  output           nios_system_clock_0_out_read_data_valid_sdram_0_s1;
  output           nios_system_clock_0_out_read_data_valid_sdram_0_s1_shift_register;
  output           nios_system_clock_0_out_requests_sdram_0_s1;
  output           nios_system_clock_1_out_granted_sdram_0_s1;
  output           nios_system_clock_1_out_qualified_request_sdram_0_s1;
  output           nios_system_clock_1_out_read_data_valid_sdram_0_s1;
  output           nios_system_clock_1_out_read_data_valid_sdram_0_s1_shift_register;
  output           nios_system_clock_1_out_requests_sdram_0_s1;
  output  [ 21: 0] sdram_0_s1_address;
  output  [  1: 0] sdram_0_s1_byteenable_n;
  output           sdram_0_s1_chipselect;
  output           sdram_0_s1_read_n;
  output  [ 15: 0] sdram_0_s1_readdata_from_sa;
  output           sdram_0_s1_reset_n;
  output           sdram_0_s1_waitrequest_from_sa;
  output           sdram_0_s1_write_n;
  output  [ 15: 0] sdram_0_s1_writedata;
  input            clk;
  input   [ 22: 0] nios_system_clock_0_out_address_to_slave;
  input   [  1: 0] nios_system_clock_0_out_byteenable;
  input            nios_system_clock_0_out_read;
  input            nios_system_clock_0_out_write;
  input   [ 15: 0] nios_system_clock_0_out_writedata;
  input   [ 22: 0] nios_system_clock_1_out_address_to_slave;
  input   [  1: 0] nios_system_clock_1_out_byteenable;
  input            nios_system_clock_1_out_read;
  input            nios_system_clock_1_out_write;
  input   [ 15: 0] nios_system_clock_1_out_writedata;
  input            reset_n;
  input   [ 15: 0] sdram_0_s1_readdata;
  input            sdram_0_s1_readdatavalid;
  input            sdram_0_s1_waitrequest;

  reg              d1_reasons_to_wait;
  reg              d1_sdram_0_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sdram_0_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_nios_system_clock_0_out_granted_slave_sdram_0_s1;
  reg              last_cycle_nios_system_clock_1_out_granted_slave_sdram_0_s1;
  wire             nios_system_clock_0_out_arbiterlock;
  wire             nios_system_clock_0_out_arbiterlock2;
  wire             nios_system_clock_0_out_continuerequest;
  wire             nios_system_clock_0_out_granted_sdram_0_s1;
  wire             nios_system_clock_0_out_qualified_request_sdram_0_s1;
  wire             nios_system_clock_0_out_rdv_fifo_empty_sdram_0_s1;
  wire             nios_system_clock_0_out_rdv_fifo_output_from_sdram_0_s1;
  wire             nios_system_clock_0_out_read_data_valid_sdram_0_s1;
  wire             nios_system_clock_0_out_read_data_valid_sdram_0_s1_shift_register;
  wire             nios_system_clock_0_out_requests_sdram_0_s1;
  wire             nios_system_clock_0_out_saved_grant_sdram_0_s1;
  wire             nios_system_clock_1_out_arbiterlock;
  wire             nios_system_clock_1_out_arbiterlock2;
  wire             nios_system_clock_1_out_continuerequest;
  wire             nios_system_clock_1_out_granted_sdram_0_s1;
  wire             nios_system_clock_1_out_qualified_request_sdram_0_s1;
  wire             nios_system_clock_1_out_rdv_fifo_empty_sdram_0_s1;
  wire             nios_system_clock_1_out_rdv_fifo_output_from_sdram_0_s1;
  wire             nios_system_clock_1_out_read_data_valid_sdram_0_s1;
  wire             nios_system_clock_1_out_read_data_valid_sdram_0_s1_shift_register;
  wire             nios_system_clock_1_out_requests_sdram_0_s1;
  wire             nios_system_clock_1_out_saved_grant_sdram_0_s1;
  wire    [ 21: 0] sdram_0_s1_address;
  wire             sdram_0_s1_allgrants;
  wire             sdram_0_s1_allow_new_arb_cycle;
  wire             sdram_0_s1_any_bursting_master_saved_grant;
  wire             sdram_0_s1_any_continuerequest;
  reg     [  1: 0] sdram_0_s1_arb_addend;
  wire             sdram_0_s1_arb_counter_enable;
  reg              sdram_0_s1_arb_share_counter;
  wire             sdram_0_s1_arb_share_counter_next_value;
  wire             sdram_0_s1_arb_share_set_values;
  wire    [  1: 0] sdram_0_s1_arb_winner;
  wire             sdram_0_s1_arbitration_holdoff_internal;
  wire             sdram_0_s1_beginbursttransfer_internal;
  wire             sdram_0_s1_begins_xfer;
  wire    [  1: 0] sdram_0_s1_byteenable_n;
  wire             sdram_0_s1_chipselect;
  wire    [  3: 0] sdram_0_s1_chosen_master_double_vector;
  wire    [  1: 0] sdram_0_s1_chosen_master_rot_left;
  wire             sdram_0_s1_end_xfer;
  wire             sdram_0_s1_firsttransfer;
  wire    [  1: 0] sdram_0_s1_grant_vector;
  wire             sdram_0_s1_in_a_read_cycle;
  wire             sdram_0_s1_in_a_write_cycle;
  wire    [  1: 0] sdram_0_s1_master_qreq_vector;
  wire             sdram_0_s1_move_on_to_next_transaction;
  wire             sdram_0_s1_non_bursting_master_requests;
  wire             sdram_0_s1_read_n;
  wire    [ 15: 0] sdram_0_s1_readdata_from_sa;
  wire             sdram_0_s1_readdatavalid_from_sa;
  reg              sdram_0_s1_reg_firsttransfer;
  wire             sdram_0_s1_reset_n;
  reg     [  1: 0] sdram_0_s1_saved_chosen_master_vector;
  reg              sdram_0_s1_slavearbiterlockenable;
  wire             sdram_0_s1_slavearbiterlockenable2;
  wire             sdram_0_s1_unreg_firsttransfer;
  wire             sdram_0_s1_waitrequest_from_sa;
  wire             sdram_0_s1_waits_for_read;
  wire             sdram_0_s1_waits_for_write;
  wire             sdram_0_s1_write_n;
  wire    [ 15: 0] sdram_0_s1_writedata;
  wire    [ 22: 0] shifted_address_to_sdram_0_s1_from_nios_system_clock_0_out;
  wire    [ 22: 0] shifted_address_to_sdram_0_s1_from_nios_system_clock_1_out;
  wire             wait_for_sdram_0_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~sdram_0_s1_end_xfer;
    end


  assign sdram_0_s1_begins_xfer = ~d1_reasons_to_wait & ((nios_system_clock_0_out_qualified_request_sdram_0_s1 | nios_system_clock_1_out_qualified_request_sdram_0_s1));
  //assign sdram_0_s1_readdata_from_sa = sdram_0_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_0_s1_readdata_from_sa = sdram_0_s1_readdata;

  assign nios_system_clock_0_out_requests_sdram_0_s1 = (1) & (nios_system_clock_0_out_read | nios_system_clock_0_out_write);
  //assign sdram_0_s1_waitrequest_from_sa = sdram_0_s1_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_0_s1_waitrequest_from_sa = sdram_0_s1_waitrequest;

  //assign sdram_0_s1_readdatavalid_from_sa = sdram_0_s1_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_0_s1_readdatavalid_from_sa = sdram_0_s1_readdatavalid;

  //sdram_0_s1_arb_share_counter set values, which is an e_mux
  assign sdram_0_s1_arb_share_set_values = 1;

  //sdram_0_s1_non_bursting_master_requests mux, which is an e_mux
  assign sdram_0_s1_non_bursting_master_requests = nios_system_clock_0_out_requests_sdram_0_s1 |
    nios_system_clock_1_out_requests_sdram_0_s1 |
    nios_system_clock_0_out_requests_sdram_0_s1 |
    nios_system_clock_1_out_requests_sdram_0_s1;

  //sdram_0_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign sdram_0_s1_any_bursting_master_saved_grant = 0;

  //sdram_0_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign sdram_0_s1_arb_share_counter_next_value = sdram_0_s1_firsttransfer ? (sdram_0_s1_arb_share_set_values - 1) : |sdram_0_s1_arb_share_counter ? (sdram_0_s1_arb_share_counter - 1) : 0;

  //sdram_0_s1_allgrants all slave grants, which is an e_mux
  assign sdram_0_s1_allgrants = (|sdram_0_s1_grant_vector) |
    (|sdram_0_s1_grant_vector) |
    (|sdram_0_s1_grant_vector) |
    (|sdram_0_s1_grant_vector);

  //sdram_0_s1_end_xfer assignment, which is an e_assign
  assign sdram_0_s1_end_xfer = ~(sdram_0_s1_waits_for_read | sdram_0_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_sdram_0_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sdram_0_s1 = sdram_0_s1_end_xfer & (~sdram_0_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sdram_0_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign sdram_0_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_sdram_0_s1 & sdram_0_s1_allgrants) | (end_xfer_arb_share_counter_term_sdram_0_s1 & ~sdram_0_s1_non_bursting_master_requests);

  //sdram_0_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_arb_share_counter <= 0;
      else if (sdram_0_s1_arb_counter_enable)
          sdram_0_s1_arb_share_counter <= sdram_0_s1_arb_share_counter_next_value;
    end


  //sdram_0_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_slavearbiterlockenable <= 0;
      else if ((|sdram_0_s1_master_qreq_vector & end_xfer_arb_share_counter_term_sdram_0_s1) | (end_xfer_arb_share_counter_term_sdram_0_s1 & ~sdram_0_s1_non_bursting_master_requests))
          sdram_0_s1_slavearbiterlockenable <= |sdram_0_s1_arb_share_counter_next_value;
    end


  //nios_system_clock_0/out sdram_0/s1 arbiterlock, which is an e_assign
  assign nios_system_clock_0_out_arbiterlock = sdram_0_s1_slavearbiterlockenable & nios_system_clock_0_out_continuerequest;

  //sdram_0_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sdram_0_s1_slavearbiterlockenable2 = |sdram_0_s1_arb_share_counter_next_value;

  //nios_system_clock_0/out sdram_0/s1 arbiterlock2, which is an e_assign
  assign nios_system_clock_0_out_arbiterlock2 = sdram_0_s1_slavearbiterlockenable2 & nios_system_clock_0_out_continuerequest;

  //nios_system_clock_1/out sdram_0/s1 arbiterlock, which is an e_assign
  assign nios_system_clock_1_out_arbiterlock = sdram_0_s1_slavearbiterlockenable & nios_system_clock_1_out_continuerequest;

  //nios_system_clock_1/out sdram_0/s1 arbiterlock2, which is an e_assign
  assign nios_system_clock_1_out_arbiterlock2 = sdram_0_s1_slavearbiterlockenable2 & nios_system_clock_1_out_continuerequest;

  //nios_system_clock_1/out granted sdram_0/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_nios_system_clock_1_out_granted_slave_sdram_0_s1 <= 0;
      else 
        last_cycle_nios_system_clock_1_out_granted_slave_sdram_0_s1 <= nios_system_clock_1_out_saved_grant_sdram_0_s1 ? 1 : (sdram_0_s1_arbitration_holdoff_internal | ~nios_system_clock_1_out_requests_sdram_0_s1) ? 0 : last_cycle_nios_system_clock_1_out_granted_slave_sdram_0_s1;
    end


  //nios_system_clock_1_out_continuerequest continued request, which is an e_mux
  assign nios_system_clock_1_out_continuerequest = last_cycle_nios_system_clock_1_out_granted_slave_sdram_0_s1 & nios_system_clock_1_out_requests_sdram_0_s1;

  //sdram_0_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  assign sdram_0_s1_any_continuerequest = nios_system_clock_1_out_continuerequest |
    nios_system_clock_0_out_continuerequest;

  assign nios_system_clock_0_out_qualified_request_sdram_0_s1 = nios_system_clock_0_out_requests_sdram_0_s1 & ~((nios_system_clock_0_out_read & ((|nios_system_clock_0_out_read_data_valid_sdram_0_s1_shift_register))) | nios_system_clock_1_out_arbiterlock);
  //unique name for sdram_0_s1_move_on_to_next_transaction, which is an e_assign
  assign sdram_0_s1_move_on_to_next_transaction = sdram_0_s1_readdatavalid_from_sa;

  //rdv_fifo_for_nios_system_clock_0_out_to_sdram_0_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_nios_system_clock_0_out_to_sdram_0_s1_module rdv_fifo_for_nios_system_clock_0_out_to_sdram_0_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (nios_system_clock_0_out_granted_sdram_0_s1),
      .data_out             (nios_system_clock_0_out_rdv_fifo_output_from_sdram_0_s1),
      .empty                (),
      .fifo_contains_ones_n (nios_system_clock_0_out_rdv_fifo_empty_sdram_0_s1),
      .full                 (),
      .read                 (sdram_0_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~sdram_0_s1_waits_for_read)
    );

  assign nios_system_clock_0_out_read_data_valid_sdram_0_s1_shift_register = ~nios_system_clock_0_out_rdv_fifo_empty_sdram_0_s1;
  //local readdatavalid nios_system_clock_0_out_read_data_valid_sdram_0_s1, which is an e_mux
  assign nios_system_clock_0_out_read_data_valid_sdram_0_s1 = (sdram_0_s1_readdatavalid_from_sa & nios_system_clock_0_out_rdv_fifo_output_from_sdram_0_s1) & ~ nios_system_clock_0_out_rdv_fifo_empty_sdram_0_s1;

  //sdram_0_s1_writedata mux, which is an e_mux
  assign sdram_0_s1_writedata = (nios_system_clock_0_out_granted_sdram_0_s1)? nios_system_clock_0_out_writedata :
    nios_system_clock_1_out_writedata;

  assign nios_system_clock_1_out_requests_sdram_0_s1 = (1) & (nios_system_clock_1_out_read | nios_system_clock_1_out_write);
  //nios_system_clock_0/out granted sdram_0/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_nios_system_clock_0_out_granted_slave_sdram_0_s1 <= 0;
      else 
        last_cycle_nios_system_clock_0_out_granted_slave_sdram_0_s1 <= nios_system_clock_0_out_saved_grant_sdram_0_s1 ? 1 : (sdram_0_s1_arbitration_holdoff_internal | ~nios_system_clock_0_out_requests_sdram_0_s1) ? 0 : last_cycle_nios_system_clock_0_out_granted_slave_sdram_0_s1;
    end


  //nios_system_clock_0_out_continuerequest continued request, which is an e_mux
  assign nios_system_clock_0_out_continuerequest = last_cycle_nios_system_clock_0_out_granted_slave_sdram_0_s1 & nios_system_clock_0_out_requests_sdram_0_s1;

  assign nios_system_clock_1_out_qualified_request_sdram_0_s1 = nios_system_clock_1_out_requests_sdram_0_s1 & ~((nios_system_clock_1_out_read & ((|nios_system_clock_1_out_read_data_valid_sdram_0_s1_shift_register))) | nios_system_clock_0_out_arbiterlock);
  //rdv_fifo_for_nios_system_clock_1_out_to_sdram_0_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_nios_system_clock_1_out_to_sdram_0_s1_module rdv_fifo_for_nios_system_clock_1_out_to_sdram_0_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (nios_system_clock_1_out_granted_sdram_0_s1),
      .data_out             (nios_system_clock_1_out_rdv_fifo_output_from_sdram_0_s1),
      .empty                (),
      .fifo_contains_ones_n (nios_system_clock_1_out_rdv_fifo_empty_sdram_0_s1),
      .full                 (),
      .read                 (sdram_0_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~sdram_0_s1_waits_for_read)
    );

  assign nios_system_clock_1_out_read_data_valid_sdram_0_s1_shift_register = ~nios_system_clock_1_out_rdv_fifo_empty_sdram_0_s1;
  //local readdatavalid nios_system_clock_1_out_read_data_valid_sdram_0_s1, which is an e_mux
  assign nios_system_clock_1_out_read_data_valid_sdram_0_s1 = (sdram_0_s1_readdatavalid_from_sa & nios_system_clock_1_out_rdv_fifo_output_from_sdram_0_s1) & ~ nios_system_clock_1_out_rdv_fifo_empty_sdram_0_s1;

  //allow new arb cycle for sdram_0/s1, which is an e_assign
  assign sdram_0_s1_allow_new_arb_cycle = ~nios_system_clock_0_out_arbiterlock & ~nios_system_clock_1_out_arbiterlock;

  //nios_system_clock_1/out assignment into master qualified-requests vector for sdram_0/s1, which is an e_assign
  assign sdram_0_s1_master_qreq_vector[0] = nios_system_clock_1_out_qualified_request_sdram_0_s1;

  //nios_system_clock_1/out grant sdram_0/s1, which is an e_assign
  assign nios_system_clock_1_out_granted_sdram_0_s1 = sdram_0_s1_grant_vector[0];

  //nios_system_clock_1/out saved-grant sdram_0/s1, which is an e_assign
  assign nios_system_clock_1_out_saved_grant_sdram_0_s1 = sdram_0_s1_arb_winner[0] && nios_system_clock_1_out_requests_sdram_0_s1;

  //nios_system_clock_0/out assignment into master qualified-requests vector for sdram_0/s1, which is an e_assign
  assign sdram_0_s1_master_qreq_vector[1] = nios_system_clock_0_out_qualified_request_sdram_0_s1;

  //nios_system_clock_0/out grant sdram_0/s1, which is an e_assign
  assign nios_system_clock_0_out_granted_sdram_0_s1 = sdram_0_s1_grant_vector[1];

  //nios_system_clock_0/out saved-grant sdram_0/s1, which is an e_assign
  assign nios_system_clock_0_out_saved_grant_sdram_0_s1 = sdram_0_s1_arb_winner[1] && nios_system_clock_0_out_requests_sdram_0_s1;

  //sdram_0/s1 chosen-master double-vector, which is an e_assign
  assign sdram_0_s1_chosen_master_double_vector = {sdram_0_s1_master_qreq_vector, sdram_0_s1_master_qreq_vector} & ({~sdram_0_s1_master_qreq_vector, ~sdram_0_s1_master_qreq_vector} + sdram_0_s1_arb_addend);

  //stable onehot encoding of arb winner
  assign sdram_0_s1_arb_winner = (sdram_0_s1_allow_new_arb_cycle & | sdram_0_s1_grant_vector) ? sdram_0_s1_grant_vector : sdram_0_s1_saved_chosen_master_vector;

  //saved sdram_0_s1_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_saved_chosen_master_vector <= 0;
      else if (sdram_0_s1_allow_new_arb_cycle)
          sdram_0_s1_saved_chosen_master_vector <= |sdram_0_s1_grant_vector ? sdram_0_s1_grant_vector : sdram_0_s1_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign sdram_0_s1_grant_vector = {(sdram_0_s1_chosen_master_double_vector[1] | sdram_0_s1_chosen_master_double_vector[3]),
    (sdram_0_s1_chosen_master_double_vector[0] | sdram_0_s1_chosen_master_double_vector[2])};

  //sdram_0/s1 chosen master rotated left, which is an e_assign
  assign sdram_0_s1_chosen_master_rot_left = (sdram_0_s1_arb_winner << 1) ? (sdram_0_s1_arb_winner << 1) : 1;

  //sdram_0/s1's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_arb_addend <= 1;
      else if (|sdram_0_s1_grant_vector)
          sdram_0_s1_arb_addend <= sdram_0_s1_end_xfer? sdram_0_s1_chosen_master_rot_left : sdram_0_s1_grant_vector;
    end


  //sdram_0_s1_reset_n assignment, which is an e_assign
  assign sdram_0_s1_reset_n = reset_n;

  assign sdram_0_s1_chipselect = nios_system_clock_0_out_granted_sdram_0_s1 | nios_system_clock_1_out_granted_sdram_0_s1;
  //sdram_0_s1_firsttransfer first transaction, which is an e_assign
  assign sdram_0_s1_firsttransfer = sdram_0_s1_begins_xfer ? sdram_0_s1_unreg_firsttransfer : sdram_0_s1_reg_firsttransfer;

  //sdram_0_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign sdram_0_s1_unreg_firsttransfer = ~(sdram_0_s1_slavearbiterlockenable & sdram_0_s1_any_continuerequest);

  //sdram_0_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_reg_firsttransfer <= 1'b1;
      else if (sdram_0_s1_begins_xfer)
          sdram_0_s1_reg_firsttransfer <= sdram_0_s1_unreg_firsttransfer;
    end


  //sdram_0_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sdram_0_s1_beginbursttransfer_internal = sdram_0_s1_begins_xfer;

  //sdram_0_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign sdram_0_s1_arbitration_holdoff_internal = sdram_0_s1_begins_xfer & sdram_0_s1_firsttransfer;

  //~sdram_0_s1_read_n assignment, which is an e_mux
  assign sdram_0_s1_read_n = ~((nios_system_clock_0_out_granted_sdram_0_s1 & nios_system_clock_0_out_read) | (nios_system_clock_1_out_granted_sdram_0_s1 & nios_system_clock_1_out_read));

  //~sdram_0_s1_write_n assignment, which is an e_mux
  assign sdram_0_s1_write_n = ~((nios_system_clock_0_out_granted_sdram_0_s1 & nios_system_clock_0_out_write) | (nios_system_clock_1_out_granted_sdram_0_s1 & nios_system_clock_1_out_write));

  assign shifted_address_to_sdram_0_s1_from_nios_system_clock_0_out = nios_system_clock_0_out_address_to_slave;
  //sdram_0_s1_address mux, which is an e_mux
  assign sdram_0_s1_address = (nios_system_clock_0_out_granted_sdram_0_s1)? (shifted_address_to_sdram_0_s1_from_nios_system_clock_0_out >> 1) :
    (shifted_address_to_sdram_0_s1_from_nios_system_clock_1_out >> 1);

  assign shifted_address_to_sdram_0_s1_from_nios_system_clock_1_out = nios_system_clock_1_out_address_to_slave;
  //d1_sdram_0_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sdram_0_s1_end_xfer <= 1;
      else 
        d1_sdram_0_s1_end_xfer <= sdram_0_s1_end_xfer;
    end


  //sdram_0_s1_waits_for_read in a cycle, which is an e_mux
  assign sdram_0_s1_waits_for_read = sdram_0_s1_in_a_read_cycle & sdram_0_s1_waitrequest_from_sa;

  //sdram_0_s1_in_a_read_cycle assignment, which is an e_assign
  assign sdram_0_s1_in_a_read_cycle = (nios_system_clock_0_out_granted_sdram_0_s1 & nios_system_clock_0_out_read) | (nios_system_clock_1_out_granted_sdram_0_s1 & nios_system_clock_1_out_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sdram_0_s1_in_a_read_cycle;

  //sdram_0_s1_waits_for_write in a cycle, which is an e_mux
  assign sdram_0_s1_waits_for_write = sdram_0_s1_in_a_write_cycle & sdram_0_s1_waitrequest_from_sa;

  //sdram_0_s1_in_a_write_cycle assignment, which is an e_assign
  assign sdram_0_s1_in_a_write_cycle = (nios_system_clock_0_out_granted_sdram_0_s1 & nios_system_clock_0_out_write) | (nios_system_clock_1_out_granted_sdram_0_s1 & nios_system_clock_1_out_write);

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sdram_0_s1_in_a_write_cycle;

  assign wait_for_sdram_0_s1_counter = 0;
  //~sdram_0_s1_byteenable_n byte enable port mux, which is an e_mux
  assign sdram_0_s1_byteenable_n = ~((nios_system_clock_0_out_granted_sdram_0_s1)? nios_system_clock_0_out_byteenable :
    (nios_system_clock_1_out_granted_sdram_0_s1)? nios_system_clock_1_out_byteenable :
    -1);


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sdram_0/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (nios_system_clock_0_out_granted_sdram_0_s1 + nios_system_clock_1_out_granted_sdram_0_s1 > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (nios_system_clock_0_out_saved_grant_sdram_0_s1 + nios_system_clock_1_out_saved_grant_sdram_0_s1 > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sysid_control_slave_arbitrator (
                                        // inputs:
                                         clk,
                                         cpu_0_data_master_address_to_slave,
                                         cpu_0_data_master_latency_counter,
                                         cpu_0_data_master_read,
                                         cpu_0_data_master_write,
                                         reset_n,
                                         sysid_control_slave_readdata,

                                        // outputs:
                                         cpu_0_data_master_granted_sysid_control_slave,
                                         cpu_0_data_master_qualified_request_sysid_control_slave,
                                         cpu_0_data_master_read_data_valid_sysid_control_slave,
                                         cpu_0_data_master_requests_sysid_control_slave,
                                         d1_sysid_control_slave_end_xfer,
                                         sysid_control_slave_address,
                                         sysid_control_slave_readdata_from_sa,
                                         sysid_control_slave_reset_n
                                      )
;

  output           cpu_0_data_master_granted_sysid_control_slave;
  output           cpu_0_data_master_qualified_request_sysid_control_slave;
  output           cpu_0_data_master_read_data_valid_sysid_control_slave;
  output           cpu_0_data_master_requests_sysid_control_slave;
  output           d1_sysid_control_slave_end_xfer;
  output           sysid_control_slave_address;
  output  [ 31: 0] sysid_control_slave_readdata_from_sa;
  output           sysid_control_slave_reset_n;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_latency_counter;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input            reset_n;
  input   [ 31: 0] sysid_control_slave_readdata;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_sysid_control_slave;
  wire             cpu_0_data_master_qualified_request_sysid_control_slave;
  wire             cpu_0_data_master_read_data_valid_sysid_control_slave;
  wire             cpu_0_data_master_requests_sysid_control_slave;
  wire             cpu_0_data_master_saved_grant_sysid_control_slave;
  reg              d1_reasons_to_wait;
  reg              d1_sysid_control_slave_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sysid_control_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 24: 0] shifted_address_to_sysid_control_slave_from_cpu_0_data_master;
  wire             sysid_control_slave_address;
  wire             sysid_control_slave_allgrants;
  wire             sysid_control_slave_allow_new_arb_cycle;
  wire             sysid_control_slave_any_bursting_master_saved_grant;
  wire             sysid_control_slave_any_continuerequest;
  wire             sysid_control_slave_arb_counter_enable;
  reg     [  2: 0] sysid_control_slave_arb_share_counter;
  wire    [  2: 0] sysid_control_slave_arb_share_counter_next_value;
  wire    [  2: 0] sysid_control_slave_arb_share_set_values;
  wire             sysid_control_slave_beginbursttransfer_internal;
  wire             sysid_control_slave_begins_xfer;
  wire             sysid_control_slave_end_xfer;
  wire             sysid_control_slave_firsttransfer;
  wire             sysid_control_slave_grant_vector;
  wire             sysid_control_slave_in_a_read_cycle;
  wire             sysid_control_slave_in_a_write_cycle;
  wire             sysid_control_slave_master_qreq_vector;
  wire             sysid_control_slave_non_bursting_master_requests;
  wire    [ 31: 0] sysid_control_slave_readdata_from_sa;
  reg              sysid_control_slave_reg_firsttransfer;
  wire             sysid_control_slave_reset_n;
  reg              sysid_control_slave_slavearbiterlockenable;
  wire             sysid_control_slave_slavearbiterlockenable2;
  wire             sysid_control_slave_unreg_firsttransfer;
  wire             sysid_control_slave_waits_for_read;
  wire             sysid_control_slave_waits_for_write;
  wire             wait_for_sysid_control_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~sysid_control_slave_end_xfer;
    end


  assign sysid_control_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_sysid_control_slave));
  //assign sysid_control_slave_readdata_from_sa = sysid_control_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sysid_control_slave_readdata_from_sa = sysid_control_slave_readdata;

  assign cpu_0_data_master_requests_sysid_control_slave = (({cpu_0_data_master_address_to_slave[24 : 3] , 3'b0} == 25'h1001030) & (cpu_0_data_master_read | cpu_0_data_master_write)) & cpu_0_data_master_read;
  //sysid_control_slave_arb_share_counter set values, which is an e_mux
  assign sysid_control_slave_arb_share_set_values = 1;

  //sysid_control_slave_non_bursting_master_requests mux, which is an e_mux
  assign sysid_control_slave_non_bursting_master_requests = cpu_0_data_master_requests_sysid_control_slave;

  //sysid_control_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign sysid_control_slave_any_bursting_master_saved_grant = 0;

  //sysid_control_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign sysid_control_slave_arb_share_counter_next_value = sysid_control_slave_firsttransfer ? (sysid_control_slave_arb_share_set_values - 1) : |sysid_control_slave_arb_share_counter ? (sysid_control_slave_arb_share_counter - 1) : 0;

  //sysid_control_slave_allgrants all slave grants, which is an e_mux
  assign sysid_control_slave_allgrants = |sysid_control_slave_grant_vector;

  //sysid_control_slave_end_xfer assignment, which is an e_assign
  assign sysid_control_slave_end_xfer = ~(sysid_control_slave_waits_for_read | sysid_control_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_sysid_control_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sysid_control_slave = sysid_control_slave_end_xfer & (~sysid_control_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sysid_control_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign sysid_control_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_sysid_control_slave & sysid_control_slave_allgrants) | (end_xfer_arb_share_counter_term_sysid_control_slave & ~sysid_control_slave_non_bursting_master_requests);

  //sysid_control_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_arb_share_counter <= 0;
      else if (sysid_control_slave_arb_counter_enable)
          sysid_control_slave_arb_share_counter <= sysid_control_slave_arb_share_counter_next_value;
    end


  //sysid_control_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_slavearbiterlockenable <= 0;
      else if ((|sysid_control_slave_master_qreq_vector & end_xfer_arb_share_counter_term_sysid_control_slave) | (end_xfer_arb_share_counter_term_sysid_control_slave & ~sysid_control_slave_non_bursting_master_requests))
          sysid_control_slave_slavearbiterlockenable <= |sysid_control_slave_arb_share_counter_next_value;
    end


  //cpu_0/data_master sysid/control_slave arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = sysid_control_slave_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //sysid_control_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sysid_control_slave_slavearbiterlockenable2 = |sysid_control_slave_arb_share_counter_next_value;

  //cpu_0/data_master sysid/control_slave arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = sysid_control_slave_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //sysid_control_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign sysid_control_slave_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_sysid_control_slave = cpu_0_data_master_requests_sysid_control_slave & ~((cpu_0_data_master_read & ((cpu_0_data_master_latency_counter != 0))));
  //local readdatavalid cpu_0_data_master_read_data_valid_sysid_control_slave, which is an e_mux
  assign cpu_0_data_master_read_data_valid_sysid_control_slave = cpu_0_data_master_granted_sysid_control_slave & cpu_0_data_master_read & ~sysid_control_slave_waits_for_read;

  //master is always granted when requested
  assign cpu_0_data_master_granted_sysid_control_slave = cpu_0_data_master_qualified_request_sysid_control_slave;

  //cpu_0/data_master saved-grant sysid/control_slave, which is an e_assign
  assign cpu_0_data_master_saved_grant_sysid_control_slave = cpu_0_data_master_requests_sysid_control_slave;

  //allow new arb cycle for sysid/control_slave, which is an e_assign
  assign sysid_control_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign sysid_control_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign sysid_control_slave_master_qreq_vector = 1;

  //sysid_control_slave_reset_n assignment, which is an e_assign
  assign sysid_control_slave_reset_n = reset_n;

  //sysid_control_slave_firsttransfer first transaction, which is an e_assign
  assign sysid_control_slave_firsttransfer = sysid_control_slave_begins_xfer ? sysid_control_slave_unreg_firsttransfer : sysid_control_slave_reg_firsttransfer;

  //sysid_control_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign sysid_control_slave_unreg_firsttransfer = ~(sysid_control_slave_slavearbiterlockenable & sysid_control_slave_any_continuerequest);

  //sysid_control_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_reg_firsttransfer <= 1'b1;
      else if (sysid_control_slave_begins_xfer)
          sysid_control_slave_reg_firsttransfer <= sysid_control_slave_unreg_firsttransfer;
    end


  //sysid_control_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sysid_control_slave_beginbursttransfer_internal = sysid_control_slave_begins_xfer;

  assign shifted_address_to_sysid_control_slave_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //sysid_control_slave_address mux, which is an e_mux
  assign sysid_control_slave_address = shifted_address_to_sysid_control_slave_from_cpu_0_data_master >> 2;

  //d1_sysid_control_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sysid_control_slave_end_xfer <= 1;
      else 
        d1_sysid_control_slave_end_xfer <= sysid_control_slave_end_xfer;
    end


  //sysid_control_slave_waits_for_read in a cycle, which is an e_mux
  assign sysid_control_slave_waits_for_read = sysid_control_slave_in_a_read_cycle & sysid_control_slave_begins_xfer;

  //sysid_control_slave_in_a_read_cycle assignment, which is an e_assign
  assign sysid_control_slave_in_a_read_cycle = cpu_0_data_master_granted_sysid_control_slave & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sysid_control_slave_in_a_read_cycle;

  //sysid_control_slave_waits_for_write in a cycle, which is an e_mux
  assign sysid_control_slave_waits_for_write = sysid_control_slave_in_a_write_cycle & 0;

  //sysid_control_slave_in_a_write_cycle assignment, which is an e_assign
  assign sysid_control_slave_in_a_write_cycle = cpu_0_data_master_granted_sysid_control_slave & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sysid_control_slave_in_a_write_cycle;

  assign wait_for_sysid_control_slave_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sysid/control_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_system_reset_sys_clk_domain_synch_module (
                                                       // inputs:
                                                        clk,
                                                        data_in,
                                                        reset_n,

                                                       // outputs:
                                                        data_out
                                                     )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else 
        data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else 
        data_out <= data_in_d1;
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_system_reset_clk_0_domain_synch_module (
                                                     // inputs:
                                                      clk,
                                                      data_in,
                                                      reset_n,

                                                     // outputs:
                                                      data_out
                                                   )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else 
        data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else 
        data_out <= data_in_d1;
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_system_reset_sdram_clk_domain_synch_module (
                                                         // inputs:
                                                          clk,
                                                          data_in,
                                                          reset_n,

                                                         // outputs:
                                                          data_out
                                                       )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else 
        data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else 
        data_out <= data_in_d1;
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_system (
                     // 1) global signals:
                      clk_0,
                      reset_n,
                      sdram_clk,
                      sys_clk,

                     // the_HEX0
                      out_port_from_the_HEX0,

                     // the_HEX1
                      out_port_from_the_HEX1,

                     // the_HEX2
                      out_port_from_the_HEX2,

                     // the_HEX3
                      out_port_from_the_HEX3,

                     // the_HEX4
                      out_port_from_the_HEX4,

                     // the_HEX5
                      out_port_from_the_HEX5,

                     // the_HEX6
                      out_port_from_the_HEX6,

                     // the_HEX7
                      out_port_from_the_HEX7,

                     // the_keys
                      in_port_to_the_keys,

                     // the_lcd_0
                      LCD_E_from_the_lcd_0,
                      LCD_RS_from_the_lcd_0,
                      LCD_RW_from_the_lcd_0,
                      LCD_data_to_and_from_the_lcd_0,

                     // the_leds
                      out_port_from_the_leds,

                     // the_sdram_0
                      zs_addr_from_the_sdram_0,
                      zs_ba_from_the_sdram_0,
                      zs_cas_n_from_the_sdram_0,
                      zs_cke_from_the_sdram_0,
                      zs_cs_n_from_the_sdram_0,
                      zs_dq_to_and_from_the_sdram_0,
                      zs_dqm_from_the_sdram_0,
                      zs_ras_n_from_the_sdram_0,
                      zs_we_n_from_the_sdram_0
                   )
;

  output           LCD_E_from_the_lcd_0;
  output           LCD_RS_from_the_lcd_0;
  output           LCD_RW_from_the_lcd_0;
  inout   [  7: 0] LCD_data_to_and_from_the_lcd_0;
  output  [  6: 0] out_port_from_the_HEX0;
  output  [  6: 0] out_port_from_the_HEX1;
  output  [  6: 0] out_port_from_the_HEX2;
  output  [  6: 0] out_port_from_the_HEX3;
  output  [  6: 0] out_port_from_the_HEX4;
  output  [  6: 0] out_port_from_the_HEX5;
  output  [  6: 0] out_port_from_the_HEX6;
  output  [  6: 0] out_port_from_the_HEX7;
  output  [ 25: 0] out_port_from_the_leds;
  output           sdram_clk;
  output           sys_clk;
  output  [ 11: 0] zs_addr_from_the_sdram_0;
  output  [  1: 0] zs_ba_from_the_sdram_0;
  output           zs_cas_n_from_the_sdram_0;
  output           zs_cke_from_the_sdram_0;
  output           zs_cs_n_from_the_sdram_0;
  inout   [ 15: 0] zs_dq_to_and_from_the_sdram_0;
  output  [  1: 0] zs_dqm_from_the_sdram_0;
  output           zs_ras_n_from_the_sdram_0;
  output           zs_we_n_from_the_sdram_0;
  input            clk_0;
  input   [  2: 0] in_port_to_the_keys;
  input            reset_n;

  wire    [  1: 0] HEX0_s1_address;
  wire             HEX0_s1_chipselect;
  wire    [ 31: 0] HEX0_s1_readdata;
  wire    [ 31: 0] HEX0_s1_readdata_from_sa;
  wire             HEX0_s1_reset_n;
  wire             HEX0_s1_write_n;
  wire    [ 31: 0] HEX0_s1_writedata;
  wire    [  1: 0] HEX1_s1_address;
  wire             HEX1_s1_chipselect;
  wire    [ 31: 0] HEX1_s1_readdata;
  wire    [ 31: 0] HEX1_s1_readdata_from_sa;
  wire             HEX1_s1_reset_n;
  wire             HEX1_s1_write_n;
  wire    [ 31: 0] HEX1_s1_writedata;
  wire    [  1: 0] HEX2_s1_address;
  wire             HEX2_s1_chipselect;
  wire    [ 31: 0] HEX2_s1_readdata;
  wire    [ 31: 0] HEX2_s1_readdata_from_sa;
  wire             HEX2_s1_reset_n;
  wire             HEX2_s1_write_n;
  wire    [ 31: 0] HEX2_s1_writedata;
  wire    [  1: 0] HEX3_s1_address;
  wire             HEX3_s1_chipselect;
  wire    [ 31: 0] HEX3_s1_readdata;
  wire    [ 31: 0] HEX3_s1_readdata_from_sa;
  wire             HEX3_s1_reset_n;
  wire             HEX3_s1_write_n;
  wire    [ 31: 0] HEX3_s1_writedata;
  wire    [  1: 0] HEX4_s1_address;
  wire             HEX4_s1_chipselect;
  wire    [ 31: 0] HEX4_s1_readdata;
  wire    [ 31: 0] HEX4_s1_readdata_from_sa;
  wire             HEX4_s1_reset_n;
  wire             HEX4_s1_write_n;
  wire    [ 31: 0] HEX4_s1_writedata;
  wire    [  1: 0] HEX5_s1_address;
  wire             HEX5_s1_chipselect;
  wire    [ 31: 0] HEX5_s1_readdata;
  wire    [ 31: 0] HEX5_s1_readdata_from_sa;
  wire             HEX5_s1_reset_n;
  wire             HEX5_s1_write_n;
  wire    [ 31: 0] HEX5_s1_writedata;
  wire    [  1: 0] HEX6_s1_address;
  wire             HEX6_s1_chipselect;
  wire    [ 31: 0] HEX6_s1_readdata;
  wire    [ 31: 0] HEX6_s1_readdata_from_sa;
  wire             HEX6_s1_reset_n;
  wire             HEX6_s1_write_n;
  wire    [ 31: 0] HEX6_s1_writedata;
  wire    [  1: 0] HEX7_s1_address;
  wire             HEX7_s1_chipselect;
  wire    [ 31: 0] HEX7_s1_readdata;
  wire    [ 31: 0] HEX7_s1_readdata_from_sa;
  wire             HEX7_s1_reset_n;
  wire             HEX7_s1_write_n;
  wire    [ 31: 0] HEX7_s1_writedata;
  wire             LCD_E_from_the_lcd_0;
  wire             LCD_RS_from_the_lcd_0;
  wire             LCD_RW_from_the_lcd_0;
  wire    [  7: 0] LCD_data_to_and_from_the_lcd_0;
  wire             clk_0_reset_n;
  wire             clocks_0_avalon_clocks_slave_address;
  wire    [  7: 0] clocks_0_avalon_clocks_slave_readdata;
  wire    [  7: 0] clocks_0_avalon_clocks_slave_readdata_from_sa;
  wire    [ 24: 0] cpu_0_data_master_address;
  wire    [ 24: 0] cpu_0_data_master_address_to_slave;
  wire    [  3: 0] cpu_0_data_master_byteenable;
  wire    [  1: 0] cpu_0_data_master_byteenable_nios_system_clock_1_in;
  wire             cpu_0_data_master_byteenable_nios_system_clock_2_in;
  wire    [  1: 0] cpu_0_data_master_dbs_address;
  wire    [ 15: 0] cpu_0_data_master_dbs_write_16;
  wire    [  7: 0] cpu_0_data_master_dbs_write_8;
  wire             cpu_0_data_master_debugaccess;
  wire             cpu_0_data_master_granted_HEX0_s1;
  wire             cpu_0_data_master_granted_HEX1_s1;
  wire             cpu_0_data_master_granted_HEX2_s1;
  wire             cpu_0_data_master_granted_HEX3_s1;
  wire             cpu_0_data_master_granted_HEX4_s1;
  wire             cpu_0_data_master_granted_HEX5_s1;
  wire             cpu_0_data_master_granted_HEX6_s1;
  wire             cpu_0_data_master_granted_HEX7_s1;
  wire             cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_granted_keys_s1;
  wire             cpu_0_data_master_granted_lcd_0_control_slave;
  wire             cpu_0_data_master_granted_leds_s1;
  wire             cpu_0_data_master_granted_nios_system_clock_1_in;
  wire             cpu_0_data_master_granted_nios_system_clock_2_in;
  wire             cpu_0_data_master_granted_sysid_control_slave;
  wire    [ 31: 0] cpu_0_data_master_irq;
  wire             cpu_0_data_master_latency_counter;
  wire             cpu_0_data_master_qualified_request_HEX0_s1;
  wire             cpu_0_data_master_qualified_request_HEX1_s1;
  wire             cpu_0_data_master_qualified_request_HEX2_s1;
  wire             cpu_0_data_master_qualified_request_HEX3_s1;
  wire             cpu_0_data_master_qualified_request_HEX4_s1;
  wire             cpu_0_data_master_qualified_request_HEX5_s1;
  wire             cpu_0_data_master_qualified_request_HEX6_s1;
  wire             cpu_0_data_master_qualified_request_HEX7_s1;
  wire             cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_qualified_request_keys_s1;
  wire             cpu_0_data_master_qualified_request_lcd_0_control_slave;
  wire             cpu_0_data_master_qualified_request_leds_s1;
  wire             cpu_0_data_master_qualified_request_nios_system_clock_1_in;
  wire             cpu_0_data_master_qualified_request_nios_system_clock_2_in;
  wire             cpu_0_data_master_qualified_request_sysid_control_slave;
  wire             cpu_0_data_master_read;
  wire             cpu_0_data_master_read_data_valid_HEX0_s1;
  wire             cpu_0_data_master_read_data_valid_HEX1_s1;
  wire             cpu_0_data_master_read_data_valid_HEX2_s1;
  wire             cpu_0_data_master_read_data_valid_HEX3_s1;
  wire             cpu_0_data_master_read_data_valid_HEX4_s1;
  wire             cpu_0_data_master_read_data_valid_HEX5_s1;
  wire             cpu_0_data_master_read_data_valid_HEX6_s1;
  wire             cpu_0_data_master_read_data_valid_HEX7_s1;
  wire             cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_read_data_valid_keys_s1;
  wire             cpu_0_data_master_read_data_valid_lcd_0_control_slave;
  wire             cpu_0_data_master_read_data_valid_leds_s1;
  wire             cpu_0_data_master_read_data_valid_nios_system_clock_1_in;
  wire             cpu_0_data_master_read_data_valid_nios_system_clock_2_in;
  wire             cpu_0_data_master_read_data_valid_sysid_control_slave;
  wire    [ 31: 0] cpu_0_data_master_readdata;
  wire             cpu_0_data_master_readdatavalid;
  wire             cpu_0_data_master_requests_HEX0_s1;
  wire             cpu_0_data_master_requests_HEX1_s1;
  wire             cpu_0_data_master_requests_HEX2_s1;
  wire             cpu_0_data_master_requests_HEX3_s1;
  wire             cpu_0_data_master_requests_HEX4_s1;
  wire             cpu_0_data_master_requests_HEX5_s1;
  wire             cpu_0_data_master_requests_HEX6_s1;
  wire             cpu_0_data_master_requests_HEX7_s1;
  wire             cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_requests_keys_s1;
  wire             cpu_0_data_master_requests_lcd_0_control_slave;
  wire             cpu_0_data_master_requests_leds_s1;
  wire             cpu_0_data_master_requests_nios_system_clock_1_in;
  wire             cpu_0_data_master_requests_nios_system_clock_2_in;
  wire             cpu_0_data_master_requests_sysid_control_slave;
  wire             cpu_0_data_master_waitrequest;
  wire             cpu_0_data_master_write;
  wire    [ 31: 0] cpu_0_data_master_writedata;
  wire    [ 24: 0] cpu_0_instruction_master_address;
  wire    [ 24: 0] cpu_0_instruction_master_address_to_slave;
  wire    [  1: 0] cpu_0_instruction_master_dbs_address;
  wire             cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_granted_nios_system_clock_0_in;
  wire             cpu_0_instruction_master_latency_counter;
  wire             cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_qualified_request_nios_system_clock_0_in;
  wire             cpu_0_instruction_master_read;
  wire             cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_read_data_valid_nios_system_clock_0_in;
  wire    [ 31: 0] cpu_0_instruction_master_readdata;
  wire             cpu_0_instruction_master_readdatavalid;
  wire             cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_requests_nios_system_clock_0_in;
  wire             cpu_0_instruction_master_waitrequest;
  wire    [  8: 0] cpu_0_jtag_debug_module_address;
  wire             cpu_0_jtag_debug_module_begintransfer;
  wire    [  3: 0] cpu_0_jtag_debug_module_byteenable;
  wire             cpu_0_jtag_debug_module_chipselect;
  wire             cpu_0_jtag_debug_module_debugaccess;
  wire    [ 31: 0] cpu_0_jtag_debug_module_readdata;
  wire    [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  wire             cpu_0_jtag_debug_module_reset_n;
  wire             cpu_0_jtag_debug_module_resetrequest;
  wire             cpu_0_jtag_debug_module_resetrequest_from_sa;
  wire             cpu_0_jtag_debug_module_write;
  wire    [ 31: 0] cpu_0_jtag_debug_module_writedata;
  wire             d1_HEX0_s1_end_xfer;
  wire             d1_HEX1_s1_end_xfer;
  wire             d1_HEX2_s1_end_xfer;
  wire             d1_HEX3_s1_end_xfer;
  wire             d1_HEX4_s1_end_xfer;
  wire             d1_HEX5_s1_end_xfer;
  wire             d1_HEX6_s1_end_xfer;
  wire             d1_HEX7_s1_end_xfer;
  wire             d1_clocks_0_avalon_clocks_slave_end_xfer;
  wire             d1_cpu_0_jtag_debug_module_end_xfer;
  wire             d1_jtag_uart_0_avalon_jtag_slave_end_xfer;
  wire             d1_keys_s1_end_xfer;
  wire             d1_lcd_0_control_slave_end_xfer;
  wire             d1_leds_s1_end_xfer;
  wire             d1_nios_system_clock_0_in_end_xfer;
  wire             d1_nios_system_clock_1_in_end_xfer;
  wire             d1_nios_system_clock_2_in_end_xfer;
  wire             d1_sdram_0_s1_end_xfer;
  wire             d1_sysid_control_slave_end_xfer;
  wire             jtag_uart_0_avalon_jtag_slave_address;
  wire             jtag_uart_0_avalon_jtag_slave_chipselect;
  wire             jtag_uart_0_avalon_jtag_slave_dataavailable;
  wire             jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_irq;
  wire             jtag_uart_0_avalon_jtag_slave_irq_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_read_n;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_readyfordata;
  wire             jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_reset_n;
  wire             jtag_uart_0_avalon_jtag_slave_waitrequest;
  wire             jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_write_n;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_writedata;
  wire    [  1: 0] keys_s1_address;
  wire             keys_s1_chipselect;
  wire    [ 31: 0] keys_s1_readdata;
  wire    [ 31: 0] keys_s1_readdata_from_sa;
  wire             keys_s1_reset_n;
  wire             keys_s1_write_n;
  wire    [ 31: 0] keys_s1_writedata;
  wire    [  1: 0] lcd_0_control_slave_address;
  wire             lcd_0_control_slave_begintransfer;
  wire             lcd_0_control_slave_read;
  wire    [  7: 0] lcd_0_control_slave_readdata;
  wire    [  7: 0] lcd_0_control_slave_readdata_from_sa;
  wire             lcd_0_control_slave_reset_n;
  wire             lcd_0_control_slave_wait_counter_eq_0;
  wire             lcd_0_control_slave_write;
  wire    [  7: 0] lcd_0_control_slave_writedata;
  wire    [  1: 0] leds_s1_address;
  wire             leds_s1_chipselect;
  wire    [ 31: 0] leds_s1_readdata;
  wire    [ 31: 0] leds_s1_readdata_from_sa;
  wire             leds_s1_reset_n;
  wire             leds_s1_write_n;
  wire    [ 31: 0] leds_s1_writedata;
  wire    [ 22: 0] nios_system_clock_0_in_address;
  wire    [  1: 0] nios_system_clock_0_in_byteenable;
  wire             nios_system_clock_0_in_endofpacket;
  wire             nios_system_clock_0_in_endofpacket_from_sa;
  wire    [ 21: 0] nios_system_clock_0_in_nativeaddress;
  wire             nios_system_clock_0_in_read;
  wire    [ 15: 0] nios_system_clock_0_in_readdata;
  wire    [ 15: 0] nios_system_clock_0_in_readdata_from_sa;
  wire             nios_system_clock_0_in_reset_n;
  wire             nios_system_clock_0_in_waitrequest;
  wire             nios_system_clock_0_in_waitrequest_from_sa;
  wire             nios_system_clock_0_in_write;
  wire    [ 15: 0] nios_system_clock_0_in_writedata;
  wire    [ 22: 0] nios_system_clock_0_out_address;
  wire    [ 22: 0] nios_system_clock_0_out_address_to_slave;
  wire    [  1: 0] nios_system_clock_0_out_byteenable;
  wire             nios_system_clock_0_out_endofpacket;
  wire             nios_system_clock_0_out_granted_sdram_0_s1;
  wire    [ 21: 0] nios_system_clock_0_out_nativeaddress;
  wire             nios_system_clock_0_out_qualified_request_sdram_0_s1;
  wire             nios_system_clock_0_out_read;
  wire             nios_system_clock_0_out_read_data_valid_sdram_0_s1;
  wire             nios_system_clock_0_out_read_data_valid_sdram_0_s1_shift_register;
  wire    [ 15: 0] nios_system_clock_0_out_readdata;
  wire             nios_system_clock_0_out_requests_sdram_0_s1;
  wire             nios_system_clock_0_out_reset_n;
  wire             nios_system_clock_0_out_waitrequest;
  wire             nios_system_clock_0_out_write;
  wire    [ 15: 0] nios_system_clock_0_out_writedata;
  wire    [ 22: 0] nios_system_clock_1_in_address;
  wire    [  1: 0] nios_system_clock_1_in_byteenable;
  wire             nios_system_clock_1_in_endofpacket;
  wire             nios_system_clock_1_in_endofpacket_from_sa;
  wire    [ 21: 0] nios_system_clock_1_in_nativeaddress;
  wire             nios_system_clock_1_in_read;
  wire    [ 15: 0] nios_system_clock_1_in_readdata;
  wire    [ 15: 0] nios_system_clock_1_in_readdata_from_sa;
  wire             nios_system_clock_1_in_reset_n;
  wire             nios_system_clock_1_in_waitrequest;
  wire             nios_system_clock_1_in_waitrequest_from_sa;
  wire             nios_system_clock_1_in_write;
  wire    [ 15: 0] nios_system_clock_1_in_writedata;
  wire    [ 22: 0] nios_system_clock_1_out_address;
  wire    [ 22: 0] nios_system_clock_1_out_address_to_slave;
  wire    [  1: 0] nios_system_clock_1_out_byteenable;
  wire             nios_system_clock_1_out_endofpacket;
  wire             nios_system_clock_1_out_granted_sdram_0_s1;
  wire    [ 21: 0] nios_system_clock_1_out_nativeaddress;
  wire             nios_system_clock_1_out_qualified_request_sdram_0_s1;
  wire             nios_system_clock_1_out_read;
  wire             nios_system_clock_1_out_read_data_valid_sdram_0_s1;
  wire             nios_system_clock_1_out_read_data_valid_sdram_0_s1_shift_register;
  wire    [ 15: 0] nios_system_clock_1_out_readdata;
  wire             nios_system_clock_1_out_requests_sdram_0_s1;
  wire             nios_system_clock_1_out_reset_n;
  wire             nios_system_clock_1_out_waitrequest;
  wire             nios_system_clock_1_out_write;
  wire    [ 15: 0] nios_system_clock_1_out_writedata;
  wire             nios_system_clock_2_in_address;
  wire             nios_system_clock_2_in_endofpacket;
  wire             nios_system_clock_2_in_endofpacket_from_sa;
  wire             nios_system_clock_2_in_nativeaddress;
  wire             nios_system_clock_2_in_read;
  wire    [  7: 0] nios_system_clock_2_in_readdata;
  wire    [  7: 0] nios_system_clock_2_in_readdata_from_sa;
  wire             nios_system_clock_2_in_reset_n;
  wire             nios_system_clock_2_in_waitrequest;
  wire             nios_system_clock_2_in_waitrequest_from_sa;
  wire             nios_system_clock_2_in_write;
  wire    [  7: 0] nios_system_clock_2_in_writedata;
  wire             nios_system_clock_2_out_address;
  wire             nios_system_clock_2_out_address_to_slave;
  wire             nios_system_clock_2_out_endofpacket;
  wire             nios_system_clock_2_out_granted_clocks_0_avalon_clocks_slave;
  wire             nios_system_clock_2_out_nativeaddress;
  wire             nios_system_clock_2_out_qualified_request_clocks_0_avalon_clocks_slave;
  wire             nios_system_clock_2_out_read;
  wire             nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave;
  wire    [  7: 0] nios_system_clock_2_out_readdata;
  wire             nios_system_clock_2_out_requests_clocks_0_avalon_clocks_slave;
  wire             nios_system_clock_2_out_reset_n;
  wire             nios_system_clock_2_out_waitrequest;
  wire             nios_system_clock_2_out_write;
  wire    [  7: 0] nios_system_clock_2_out_writedata;
  wire             out_clk_clocks_0_SDRAM_CLK;
  wire             out_clk_clocks_0_sys_clk;
  wire    [  6: 0] out_port_from_the_HEX0;
  wire    [  6: 0] out_port_from_the_HEX1;
  wire    [  6: 0] out_port_from_the_HEX2;
  wire    [  6: 0] out_port_from_the_HEX3;
  wire    [  6: 0] out_port_from_the_HEX4;
  wire    [  6: 0] out_port_from_the_HEX5;
  wire    [  6: 0] out_port_from_the_HEX6;
  wire    [  6: 0] out_port_from_the_HEX7;
  wire    [ 25: 0] out_port_from_the_leds;
  wire             reset_n_sources;
  wire    [ 21: 0] sdram_0_s1_address;
  wire    [  1: 0] sdram_0_s1_byteenable_n;
  wire             sdram_0_s1_chipselect;
  wire             sdram_0_s1_read_n;
  wire    [ 15: 0] sdram_0_s1_readdata;
  wire    [ 15: 0] sdram_0_s1_readdata_from_sa;
  wire             sdram_0_s1_readdatavalid;
  wire             sdram_0_s1_reset_n;
  wire             sdram_0_s1_waitrequest;
  wire             sdram_0_s1_waitrequest_from_sa;
  wire             sdram_0_s1_write_n;
  wire    [ 15: 0] sdram_0_s1_writedata;
  wire             sdram_clk;
  wire             sdram_clk_reset_n;
  wire             sys_clk;
  wire             sys_clk_reset_n;
  wire             sysid_control_slave_address;
  wire             sysid_control_slave_clock;
  wire    [ 31: 0] sysid_control_slave_readdata;
  wire    [ 31: 0] sysid_control_slave_readdata_from_sa;
  wire             sysid_control_slave_reset_n;
  wire    [ 11: 0] zs_addr_from_the_sdram_0;
  wire    [  1: 0] zs_ba_from_the_sdram_0;
  wire             zs_cas_n_from_the_sdram_0;
  wire             zs_cke_from_the_sdram_0;
  wire             zs_cs_n_from_the_sdram_0;
  wire    [ 15: 0] zs_dq_to_and_from_the_sdram_0;
  wire    [  1: 0] zs_dqm_from_the_sdram_0;
  wire             zs_ras_n_from_the_sdram_0;
  wire             zs_we_n_from_the_sdram_0;
  HEX0_s1_arbitrator the_HEX0_s1
    (
      .HEX0_s1_address                             (HEX0_s1_address),
      .HEX0_s1_chipselect                          (HEX0_s1_chipselect),
      .HEX0_s1_readdata                            (HEX0_s1_readdata),
      .HEX0_s1_readdata_from_sa                    (HEX0_s1_readdata_from_sa),
      .HEX0_s1_reset_n                             (HEX0_s1_reset_n),
      .HEX0_s1_write_n                             (HEX0_s1_write_n),
      .HEX0_s1_writedata                           (HEX0_s1_writedata),
      .clk                                         (sys_clk),
      .cpu_0_data_master_address_to_slave          (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_HEX0_s1           (cpu_0_data_master_granted_HEX0_s1),
      .cpu_0_data_master_latency_counter           (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_HEX0_s1 (cpu_0_data_master_qualified_request_HEX0_s1),
      .cpu_0_data_master_read                      (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_HEX0_s1   (cpu_0_data_master_read_data_valid_HEX0_s1),
      .cpu_0_data_master_requests_HEX0_s1          (cpu_0_data_master_requests_HEX0_s1),
      .cpu_0_data_master_write                     (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                 (cpu_0_data_master_writedata),
      .d1_HEX0_s1_end_xfer                         (d1_HEX0_s1_end_xfer),
      .reset_n                                     (sys_clk_reset_n)
    );

  HEX0 the_HEX0
    (
      .address    (HEX0_s1_address),
      .chipselect (HEX0_s1_chipselect),
      .clk        (sys_clk),
      .out_port   (out_port_from_the_HEX0),
      .readdata   (HEX0_s1_readdata),
      .reset_n    (HEX0_s1_reset_n),
      .write_n    (HEX0_s1_write_n),
      .writedata  (HEX0_s1_writedata)
    );

  HEX1_s1_arbitrator the_HEX1_s1
    (
      .HEX1_s1_address                             (HEX1_s1_address),
      .HEX1_s1_chipselect                          (HEX1_s1_chipselect),
      .HEX1_s1_readdata                            (HEX1_s1_readdata),
      .HEX1_s1_readdata_from_sa                    (HEX1_s1_readdata_from_sa),
      .HEX1_s1_reset_n                             (HEX1_s1_reset_n),
      .HEX1_s1_write_n                             (HEX1_s1_write_n),
      .HEX1_s1_writedata                           (HEX1_s1_writedata),
      .clk                                         (sys_clk),
      .cpu_0_data_master_address_to_slave          (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_HEX1_s1           (cpu_0_data_master_granted_HEX1_s1),
      .cpu_0_data_master_latency_counter           (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_HEX1_s1 (cpu_0_data_master_qualified_request_HEX1_s1),
      .cpu_0_data_master_read                      (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_HEX1_s1   (cpu_0_data_master_read_data_valid_HEX1_s1),
      .cpu_0_data_master_requests_HEX1_s1          (cpu_0_data_master_requests_HEX1_s1),
      .cpu_0_data_master_write                     (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                 (cpu_0_data_master_writedata),
      .d1_HEX1_s1_end_xfer                         (d1_HEX1_s1_end_xfer),
      .reset_n                                     (sys_clk_reset_n)
    );

  HEX1 the_HEX1
    (
      .address    (HEX1_s1_address),
      .chipselect (HEX1_s1_chipselect),
      .clk        (sys_clk),
      .out_port   (out_port_from_the_HEX1),
      .readdata   (HEX1_s1_readdata),
      .reset_n    (HEX1_s1_reset_n),
      .write_n    (HEX1_s1_write_n),
      .writedata  (HEX1_s1_writedata)
    );

  HEX2_s1_arbitrator the_HEX2_s1
    (
      .HEX2_s1_address                             (HEX2_s1_address),
      .HEX2_s1_chipselect                          (HEX2_s1_chipselect),
      .HEX2_s1_readdata                            (HEX2_s1_readdata),
      .HEX2_s1_readdata_from_sa                    (HEX2_s1_readdata_from_sa),
      .HEX2_s1_reset_n                             (HEX2_s1_reset_n),
      .HEX2_s1_write_n                             (HEX2_s1_write_n),
      .HEX2_s1_writedata                           (HEX2_s1_writedata),
      .clk                                         (sys_clk),
      .cpu_0_data_master_address_to_slave          (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_HEX2_s1           (cpu_0_data_master_granted_HEX2_s1),
      .cpu_0_data_master_latency_counter           (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_HEX2_s1 (cpu_0_data_master_qualified_request_HEX2_s1),
      .cpu_0_data_master_read                      (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_HEX2_s1   (cpu_0_data_master_read_data_valid_HEX2_s1),
      .cpu_0_data_master_requests_HEX2_s1          (cpu_0_data_master_requests_HEX2_s1),
      .cpu_0_data_master_write                     (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                 (cpu_0_data_master_writedata),
      .d1_HEX2_s1_end_xfer                         (d1_HEX2_s1_end_xfer),
      .reset_n                                     (sys_clk_reset_n)
    );

  HEX2 the_HEX2
    (
      .address    (HEX2_s1_address),
      .chipselect (HEX2_s1_chipselect),
      .clk        (sys_clk),
      .out_port   (out_port_from_the_HEX2),
      .readdata   (HEX2_s1_readdata),
      .reset_n    (HEX2_s1_reset_n),
      .write_n    (HEX2_s1_write_n),
      .writedata  (HEX2_s1_writedata)
    );

  HEX3_s1_arbitrator the_HEX3_s1
    (
      .HEX3_s1_address                             (HEX3_s1_address),
      .HEX3_s1_chipselect                          (HEX3_s1_chipselect),
      .HEX3_s1_readdata                            (HEX3_s1_readdata),
      .HEX3_s1_readdata_from_sa                    (HEX3_s1_readdata_from_sa),
      .HEX3_s1_reset_n                             (HEX3_s1_reset_n),
      .HEX3_s1_write_n                             (HEX3_s1_write_n),
      .HEX3_s1_writedata                           (HEX3_s1_writedata),
      .clk                                         (sys_clk),
      .cpu_0_data_master_address_to_slave          (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_HEX3_s1           (cpu_0_data_master_granted_HEX3_s1),
      .cpu_0_data_master_latency_counter           (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_HEX3_s1 (cpu_0_data_master_qualified_request_HEX3_s1),
      .cpu_0_data_master_read                      (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_HEX3_s1   (cpu_0_data_master_read_data_valid_HEX3_s1),
      .cpu_0_data_master_requests_HEX3_s1          (cpu_0_data_master_requests_HEX3_s1),
      .cpu_0_data_master_write                     (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                 (cpu_0_data_master_writedata),
      .d1_HEX3_s1_end_xfer                         (d1_HEX3_s1_end_xfer),
      .reset_n                                     (sys_clk_reset_n)
    );

  HEX3 the_HEX3
    (
      .address    (HEX3_s1_address),
      .chipselect (HEX3_s1_chipselect),
      .clk        (sys_clk),
      .out_port   (out_port_from_the_HEX3),
      .readdata   (HEX3_s1_readdata),
      .reset_n    (HEX3_s1_reset_n),
      .write_n    (HEX3_s1_write_n),
      .writedata  (HEX3_s1_writedata)
    );

  HEX4_s1_arbitrator the_HEX4_s1
    (
      .HEX4_s1_address                             (HEX4_s1_address),
      .HEX4_s1_chipselect                          (HEX4_s1_chipselect),
      .HEX4_s1_readdata                            (HEX4_s1_readdata),
      .HEX4_s1_readdata_from_sa                    (HEX4_s1_readdata_from_sa),
      .HEX4_s1_reset_n                             (HEX4_s1_reset_n),
      .HEX4_s1_write_n                             (HEX4_s1_write_n),
      .HEX4_s1_writedata                           (HEX4_s1_writedata),
      .clk                                         (sys_clk),
      .cpu_0_data_master_address_to_slave          (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_HEX4_s1           (cpu_0_data_master_granted_HEX4_s1),
      .cpu_0_data_master_latency_counter           (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_HEX4_s1 (cpu_0_data_master_qualified_request_HEX4_s1),
      .cpu_0_data_master_read                      (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_HEX4_s1   (cpu_0_data_master_read_data_valid_HEX4_s1),
      .cpu_0_data_master_requests_HEX4_s1          (cpu_0_data_master_requests_HEX4_s1),
      .cpu_0_data_master_write                     (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                 (cpu_0_data_master_writedata),
      .d1_HEX4_s1_end_xfer                         (d1_HEX4_s1_end_xfer),
      .reset_n                                     (sys_clk_reset_n)
    );

  HEX4 the_HEX4
    (
      .address    (HEX4_s1_address),
      .chipselect (HEX4_s1_chipselect),
      .clk        (sys_clk),
      .out_port   (out_port_from_the_HEX4),
      .readdata   (HEX4_s1_readdata),
      .reset_n    (HEX4_s1_reset_n),
      .write_n    (HEX4_s1_write_n),
      .writedata  (HEX4_s1_writedata)
    );

  HEX5_s1_arbitrator the_HEX5_s1
    (
      .HEX5_s1_address                             (HEX5_s1_address),
      .HEX5_s1_chipselect                          (HEX5_s1_chipselect),
      .HEX5_s1_readdata                            (HEX5_s1_readdata),
      .HEX5_s1_readdata_from_sa                    (HEX5_s1_readdata_from_sa),
      .HEX5_s1_reset_n                             (HEX5_s1_reset_n),
      .HEX5_s1_write_n                             (HEX5_s1_write_n),
      .HEX5_s1_writedata                           (HEX5_s1_writedata),
      .clk                                         (sys_clk),
      .cpu_0_data_master_address_to_slave          (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_HEX5_s1           (cpu_0_data_master_granted_HEX5_s1),
      .cpu_0_data_master_latency_counter           (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_HEX5_s1 (cpu_0_data_master_qualified_request_HEX5_s1),
      .cpu_0_data_master_read                      (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_HEX5_s1   (cpu_0_data_master_read_data_valid_HEX5_s1),
      .cpu_0_data_master_requests_HEX5_s1          (cpu_0_data_master_requests_HEX5_s1),
      .cpu_0_data_master_write                     (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                 (cpu_0_data_master_writedata),
      .d1_HEX5_s1_end_xfer                         (d1_HEX5_s1_end_xfer),
      .reset_n                                     (sys_clk_reset_n)
    );

  HEX5 the_HEX5
    (
      .address    (HEX5_s1_address),
      .chipselect (HEX5_s1_chipselect),
      .clk        (sys_clk),
      .out_port   (out_port_from_the_HEX5),
      .readdata   (HEX5_s1_readdata),
      .reset_n    (HEX5_s1_reset_n),
      .write_n    (HEX5_s1_write_n),
      .writedata  (HEX5_s1_writedata)
    );

  HEX6_s1_arbitrator the_HEX6_s1
    (
      .HEX6_s1_address                             (HEX6_s1_address),
      .HEX6_s1_chipselect                          (HEX6_s1_chipselect),
      .HEX6_s1_readdata                            (HEX6_s1_readdata),
      .HEX6_s1_readdata_from_sa                    (HEX6_s1_readdata_from_sa),
      .HEX6_s1_reset_n                             (HEX6_s1_reset_n),
      .HEX6_s1_write_n                             (HEX6_s1_write_n),
      .HEX6_s1_writedata                           (HEX6_s1_writedata),
      .clk                                         (sys_clk),
      .cpu_0_data_master_address_to_slave          (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_HEX6_s1           (cpu_0_data_master_granted_HEX6_s1),
      .cpu_0_data_master_latency_counter           (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_HEX6_s1 (cpu_0_data_master_qualified_request_HEX6_s1),
      .cpu_0_data_master_read                      (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_HEX6_s1   (cpu_0_data_master_read_data_valid_HEX6_s1),
      .cpu_0_data_master_requests_HEX6_s1          (cpu_0_data_master_requests_HEX6_s1),
      .cpu_0_data_master_write                     (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                 (cpu_0_data_master_writedata),
      .d1_HEX6_s1_end_xfer                         (d1_HEX6_s1_end_xfer),
      .reset_n                                     (sys_clk_reset_n)
    );

  HEX6 the_HEX6
    (
      .address    (HEX6_s1_address),
      .chipselect (HEX6_s1_chipselect),
      .clk        (sys_clk),
      .out_port   (out_port_from_the_HEX6),
      .readdata   (HEX6_s1_readdata),
      .reset_n    (HEX6_s1_reset_n),
      .write_n    (HEX6_s1_write_n),
      .writedata  (HEX6_s1_writedata)
    );

  HEX7_s1_arbitrator the_HEX7_s1
    (
      .HEX7_s1_address                             (HEX7_s1_address),
      .HEX7_s1_chipselect                          (HEX7_s1_chipselect),
      .HEX7_s1_readdata                            (HEX7_s1_readdata),
      .HEX7_s1_readdata_from_sa                    (HEX7_s1_readdata_from_sa),
      .HEX7_s1_reset_n                             (HEX7_s1_reset_n),
      .HEX7_s1_write_n                             (HEX7_s1_write_n),
      .HEX7_s1_writedata                           (HEX7_s1_writedata),
      .clk                                         (sys_clk),
      .cpu_0_data_master_address_to_slave          (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_HEX7_s1           (cpu_0_data_master_granted_HEX7_s1),
      .cpu_0_data_master_latency_counter           (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_HEX7_s1 (cpu_0_data_master_qualified_request_HEX7_s1),
      .cpu_0_data_master_read                      (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_HEX7_s1   (cpu_0_data_master_read_data_valid_HEX7_s1),
      .cpu_0_data_master_requests_HEX7_s1          (cpu_0_data_master_requests_HEX7_s1),
      .cpu_0_data_master_write                     (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                 (cpu_0_data_master_writedata),
      .d1_HEX7_s1_end_xfer                         (d1_HEX7_s1_end_xfer),
      .reset_n                                     (sys_clk_reset_n)
    );

  HEX7 the_HEX7
    (
      .address    (HEX7_s1_address),
      .chipselect (HEX7_s1_chipselect),
      .clk        (sys_clk),
      .out_port   (out_port_from_the_HEX7),
      .readdata   (HEX7_s1_readdata),
      .reset_n    (HEX7_s1_reset_n),
      .write_n    (HEX7_s1_write_n),
      .writedata  (HEX7_s1_writedata)
    );

  clocks_0_avalon_clocks_slave_arbitrator the_clocks_0_avalon_clocks_slave
    (
      .clk                                                                    (clk_0),
      .clocks_0_avalon_clocks_slave_address                                   (clocks_0_avalon_clocks_slave_address),
      .clocks_0_avalon_clocks_slave_readdata                                  (clocks_0_avalon_clocks_slave_readdata),
      .clocks_0_avalon_clocks_slave_readdata_from_sa                          (clocks_0_avalon_clocks_slave_readdata_from_sa),
      .d1_clocks_0_avalon_clocks_slave_end_xfer                               (d1_clocks_0_avalon_clocks_slave_end_xfer),
      .nios_system_clock_2_out_address_to_slave                               (nios_system_clock_2_out_address_to_slave),
      .nios_system_clock_2_out_granted_clocks_0_avalon_clocks_slave           (nios_system_clock_2_out_granted_clocks_0_avalon_clocks_slave),
      .nios_system_clock_2_out_qualified_request_clocks_0_avalon_clocks_slave (nios_system_clock_2_out_qualified_request_clocks_0_avalon_clocks_slave),
      .nios_system_clock_2_out_read                                           (nios_system_clock_2_out_read),
      .nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave   (nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave),
      .nios_system_clock_2_out_requests_clocks_0_avalon_clocks_slave          (nios_system_clock_2_out_requests_clocks_0_avalon_clocks_slave),
      .nios_system_clock_2_out_write                                          (nios_system_clock_2_out_write),
      .reset_n                                                                (clk_0_reset_n)
    );

  //sdram_clk out_clk assignment, which is an e_assign
  assign sdram_clk = out_clk_clocks_0_SDRAM_CLK;

  //sys_clk out_clk assignment, which is an e_assign
  assign sys_clk = out_clk_clocks_0_sys_clk;

  clocks_0 the_clocks_0
    (
      .CLOCK_50  (clk_0),
      .SDRAM_CLK (out_clk_clocks_0_SDRAM_CLK),
      .address   (clocks_0_avalon_clocks_slave_address),
      .readdata  (clocks_0_avalon_clocks_slave_readdata),
      .sys_clk   (out_clk_clocks_0_sys_clk)
    );

  cpu_0_jtag_debug_module_arbitrator the_cpu_0_jtag_debug_module
    (
      .clk                                                                (sys_clk),
      .cpu_0_data_master_address_to_slave                                 (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                                       (cpu_0_data_master_byteenable),
      .cpu_0_data_master_debugaccess                                      (cpu_0_data_master_debugaccess),
      .cpu_0_data_master_granted_cpu_0_jtag_debug_module                  (cpu_0_data_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_data_master_latency_counter                                  (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module        (cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_data_master_read                                             (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module          (cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_data_master_requests_cpu_0_jtag_debug_module                 (cpu_0_data_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_data_master_write                                            (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                        (cpu_0_data_master_writedata),
      .cpu_0_instruction_master_address_to_slave                          (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_granted_cpu_0_jtag_debug_module           (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_latency_counter                           (cpu_0_instruction_master_latency_counter),
      .cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module (cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_read                                      (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module   (cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_requests_cpu_0_jtag_debug_module          (cpu_0_instruction_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_jtag_debug_module_address                                    (cpu_0_jtag_debug_module_address),
      .cpu_0_jtag_debug_module_begintransfer                              (cpu_0_jtag_debug_module_begintransfer),
      .cpu_0_jtag_debug_module_byteenable                                 (cpu_0_jtag_debug_module_byteenable),
      .cpu_0_jtag_debug_module_chipselect                                 (cpu_0_jtag_debug_module_chipselect),
      .cpu_0_jtag_debug_module_debugaccess                                (cpu_0_jtag_debug_module_debugaccess),
      .cpu_0_jtag_debug_module_readdata                                   (cpu_0_jtag_debug_module_readdata),
      .cpu_0_jtag_debug_module_readdata_from_sa                           (cpu_0_jtag_debug_module_readdata_from_sa),
      .cpu_0_jtag_debug_module_reset_n                                    (cpu_0_jtag_debug_module_reset_n),
      .cpu_0_jtag_debug_module_resetrequest                               (cpu_0_jtag_debug_module_resetrequest),
      .cpu_0_jtag_debug_module_resetrequest_from_sa                       (cpu_0_jtag_debug_module_resetrequest_from_sa),
      .cpu_0_jtag_debug_module_write                                      (cpu_0_jtag_debug_module_write),
      .cpu_0_jtag_debug_module_writedata                                  (cpu_0_jtag_debug_module_writedata),
      .d1_cpu_0_jtag_debug_module_end_xfer                                (d1_cpu_0_jtag_debug_module_end_xfer),
      .reset_n                                                            (sys_clk_reset_n)
    );

  cpu_0_data_master_arbitrator the_cpu_0_data_master
    (
      .HEX0_s1_readdata_from_sa                                          (HEX0_s1_readdata_from_sa),
      .HEX1_s1_readdata_from_sa                                          (HEX1_s1_readdata_from_sa),
      .HEX2_s1_readdata_from_sa                                          (HEX2_s1_readdata_from_sa),
      .HEX3_s1_readdata_from_sa                                          (HEX3_s1_readdata_from_sa),
      .HEX4_s1_readdata_from_sa                                          (HEX4_s1_readdata_from_sa),
      .HEX5_s1_readdata_from_sa                                          (HEX5_s1_readdata_from_sa),
      .HEX6_s1_readdata_from_sa                                          (HEX6_s1_readdata_from_sa),
      .HEX7_s1_readdata_from_sa                                          (HEX7_s1_readdata_from_sa),
      .clk                                                               (sys_clk),
      .cpu_0_data_master_address                                         (cpu_0_data_master_address),
      .cpu_0_data_master_address_to_slave                                (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                                      (cpu_0_data_master_byteenable),
      .cpu_0_data_master_byteenable_nios_system_clock_1_in               (cpu_0_data_master_byteenable_nios_system_clock_1_in),
      .cpu_0_data_master_byteenable_nios_system_clock_2_in               (cpu_0_data_master_byteenable_nios_system_clock_2_in),
      .cpu_0_data_master_dbs_address                                     (cpu_0_data_master_dbs_address),
      .cpu_0_data_master_dbs_write_16                                    (cpu_0_data_master_dbs_write_16),
      .cpu_0_data_master_dbs_write_8                                     (cpu_0_data_master_dbs_write_8),
      .cpu_0_data_master_granted_HEX0_s1                                 (cpu_0_data_master_granted_HEX0_s1),
      .cpu_0_data_master_granted_HEX1_s1                                 (cpu_0_data_master_granted_HEX1_s1),
      .cpu_0_data_master_granted_HEX2_s1                                 (cpu_0_data_master_granted_HEX2_s1),
      .cpu_0_data_master_granted_HEX3_s1                                 (cpu_0_data_master_granted_HEX3_s1),
      .cpu_0_data_master_granted_HEX4_s1                                 (cpu_0_data_master_granted_HEX4_s1),
      .cpu_0_data_master_granted_HEX5_s1                                 (cpu_0_data_master_granted_HEX5_s1),
      .cpu_0_data_master_granted_HEX6_s1                                 (cpu_0_data_master_granted_HEX6_s1),
      .cpu_0_data_master_granted_HEX7_s1                                 (cpu_0_data_master_granted_HEX7_s1),
      .cpu_0_data_master_granted_cpu_0_jtag_debug_module                 (cpu_0_data_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave           (cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_granted_keys_s1                                 (cpu_0_data_master_granted_keys_s1),
      .cpu_0_data_master_granted_lcd_0_control_slave                     (cpu_0_data_master_granted_lcd_0_control_slave),
      .cpu_0_data_master_granted_leds_s1                                 (cpu_0_data_master_granted_leds_s1),
      .cpu_0_data_master_granted_nios_system_clock_1_in                  (cpu_0_data_master_granted_nios_system_clock_1_in),
      .cpu_0_data_master_granted_nios_system_clock_2_in                  (cpu_0_data_master_granted_nios_system_clock_2_in),
      .cpu_0_data_master_granted_sysid_control_slave                     (cpu_0_data_master_granted_sysid_control_slave),
      .cpu_0_data_master_irq                                             (cpu_0_data_master_irq),
      .cpu_0_data_master_latency_counter                                 (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_HEX0_s1                       (cpu_0_data_master_qualified_request_HEX0_s1),
      .cpu_0_data_master_qualified_request_HEX1_s1                       (cpu_0_data_master_qualified_request_HEX1_s1),
      .cpu_0_data_master_qualified_request_HEX2_s1                       (cpu_0_data_master_qualified_request_HEX2_s1),
      .cpu_0_data_master_qualified_request_HEX3_s1                       (cpu_0_data_master_qualified_request_HEX3_s1),
      .cpu_0_data_master_qualified_request_HEX4_s1                       (cpu_0_data_master_qualified_request_HEX4_s1),
      .cpu_0_data_master_qualified_request_HEX5_s1                       (cpu_0_data_master_qualified_request_HEX5_s1),
      .cpu_0_data_master_qualified_request_HEX6_s1                       (cpu_0_data_master_qualified_request_HEX6_s1),
      .cpu_0_data_master_qualified_request_HEX7_s1                       (cpu_0_data_master_qualified_request_HEX7_s1),
      .cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module       (cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave (cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_qualified_request_keys_s1                       (cpu_0_data_master_qualified_request_keys_s1),
      .cpu_0_data_master_qualified_request_lcd_0_control_slave           (cpu_0_data_master_qualified_request_lcd_0_control_slave),
      .cpu_0_data_master_qualified_request_leds_s1                       (cpu_0_data_master_qualified_request_leds_s1),
      .cpu_0_data_master_qualified_request_nios_system_clock_1_in        (cpu_0_data_master_qualified_request_nios_system_clock_1_in),
      .cpu_0_data_master_qualified_request_nios_system_clock_2_in        (cpu_0_data_master_qualified_request_nios_system_clock_2_in),
      .cpu_0_data_master_qualified_request_sysid_control_slave           (cpu_0_data_master_qualified_request_sysid_control_slave),
      .cpu_0_data_master_read                                            (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_HEX0_s1                         (cpu_0_data_master_read_data_valid_HEX0_s1),
      .cpu_0_data_master_read_data_valid_HEX1_s1                         (cpu_0_data_master_read_data_valid_HEX1_s1),
      .cpu_0_data_master_read_data_valid_HEX2_s1                         (cpu_0_data_master_read_data_valid_HEX2_s1),
      .cpu_0_data_master_read_data_valid_HEX3_s1                         (cpu_0_data_master_read_data_valid_HEX3_s1),
      .cpu_0_data_master_read_data_valid_HEX4_s1                         (cpu_0_data_master_read_data_valid_HEX4_s1),
      .cpu_0_data_master_read_data_valid_HEX5_s1                         (cpu_0_data_master_read_data_valid_HEX5_s1),
      .cpu_0_data_master_read_data_valid_HEX6_s1                         (cpu_0_data_master_read_data_valid_HEX6_s1),
      .cpu_0_data_master_read_data_valid_HEX7_s1                         (cpu_0_data_master_read_data_valid_HEX7_s1),
      .cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module         (cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave   (cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_read_data_valid_keys_s1                         (cpu_0_data_master_read_data_valid_keys_s1),
      .cpu_0_data_master_read_data_valid_lcd_0_control_slave             (cpu_0_data_master_read_data_valid_lcd_0_control_slave),
      .cpu_0_data_master_read_data_valid_leds_s1                         (cpu_0_data_master_read_data_valid_leds_s1),
      .cpu_0_data_master_read_data_valid_nios_system_clock_1_in          (cpu_0_data_master_read_data_valid_nios_system_clock_1_in),
      .cpu_0_data_master_read_data_valid_nios_system_clock_2_in          (cpu_0_data_master_read_data_valid_nios_system_clock_2_in),
      .cpu_0_data_master_read_data_valid_sysid_control_slave             (cpu_0_data_master_read_data_valid_sysid_control_slave),
      .cpu_0_data_master_readdata                                        (cpu_0_data_master_readdata),
      .cpu_0_data_master_readdatavalid                                   (cpu_0_data_master_readdatavalid),
      .cpu_0_data_master_requests_HEX0_s1                                (cpu_0_data_master_requests_HEX0_s1),
      .cpu_0_data_master_requests_HEX1_s1                                (cpu_0_data_master_requests_HEX1_s1),
      .cpu_0_data_master_requests_HEX2_s1                                (cpu_0_data_master_requests_HEX2_s1),
      .cpu_0_data_master_requests_HEX3_s1                                (cpu_0_data_master_requests_HEX3_s1),
      .cpu_0_data_master_requests_HEX4_s1                                (cpu_0_data_master_requests_HEX4_s1),
      .cpu_0_data_master_requests_HEX5_s1                                (cpu_0_data_master_requests_HEX5_s1),
      .cpu_0_data_master_requests_HEX6_s1                                (cpu_0_data_master_requests_HEX6_s1),
      .cpu_0_data_master_requests_HEX7_s1                                (cpu_0_data_master_requests_HEX7_s1),
      .cpu_0_data_master_requests_cpu_0_jtag_debug_module                (cpu_0_data_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave          (cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_requests_keys_s1                                (cpu_0_data_master_requests_keys_s1),
      .cpu_0_data_master_requests_lcd_0_control_slave                    (cpu_0_data_master_requests_lcd_0_control_slave),
      .cpu_0_data_master_requests_leds_s1                                (cpu_0_data_master_requests_leds_s1),
      .cpu_0_data_master_requests_nios_system_clock_1_in                 (cpu_0_data_master_requests_nios_system_clock_1_in),
      .cpu_0_data_master_requests_nios_system_clock_2_in                 (cpu_0_data_master_requests_nios_system_clock_2_in),
      .cpu_0_data_master_requests_sysid_control_slave                    (cpu_0_data_master_requests_sysid_control_slave),
      .cpu_0_data_master_waitrequest                                     (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                           (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                       (cpu_0_data_master_writedata),
      .cpu_0_jtag_debug_module_readdata_from_sa                          (cpu_0_jtag_debug_module_readdata_from_sa),
      .d1_HEX0_s1_end_xfer                                               (d1_HEX0_s1_end_xfer),
      .d1_HEX1_s1_end_xfer                                               (d1_HEX1_s1_end_xfer),
      .d1_HEX2_s1_end_xfer                                               (d1_HEX2_s1_end_xfer),
      .d1_HEX3_s1_end_xfer                                               (d1_HEX3_s1_end_xfer),
      .d1_HEX4_s1_end_xfer                                               (d1_HEX4_s1_end_xfer),
      .d1_HEX5_s1_end_xfer                                               (d1_HEX5_s1_end_xfer),
      .d1_HEX6_s1_end_xfer                                               (d1_HEX6_s1_end_xfer),
      .d1_HEX7_s1_end_xfer                                               (d1_HEX7_s1_end_xfer),
      .d1_cpu_0_jtag_debug_module_end_xfer                               (d1_cpu_0_jtag_debug_module_end_xfer),
      .d1_jtag_uart_0_avalon_jtag_slave_end_xfer                         (d1_jtag_uart_0_avalon_jtag_slave_end_xfer),
      .d1_keys_s1_end_xfer                                               (d1_keys_s1_end_xfer),
      .d1_lcd_0_control_slave_end_xfer                                   (d1_lcd_0_control_slave_end_xfer),
      .d1_leds_s1_end_xfer                                               (d1_leds_s1_end_xfer),
      .d1_nios_system_clock_1_in_end_xfer                                (d1_nios_system_clock_1_in_end_xfer),
      .d1_nios_system_clock_2_in_end_xfer                                (d1_nios_system_clock_2_in_end_xfer),
      .d1_sysid_control_slave_end_xfer                                   (d1_sysid_control_slave_end_xfer),
      .jtag_uart_0_avalon_jtag_slave_irq_from_sa                         (jtag_uart_0_avalon_jtag_slave_irq_from_sa),
      .jtag_uart_0_avalon_jtag_slave_readdata_from_sa                    (jtag_uart_0_avalon_jtag_slave_readdata_from_sa),
      .jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa                 (jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa),
      .keys_s1_readdata_from_sa                                          (keys_s1_readdata_from_sa),
      .lcd_0_control_slave_readdata_from_sa                              (lcd_0_control_slave_readdata_from_sa),
      .lcd_0_control_slave_wait_counter_eq_0                             (lcd_0_control_slave_wait_counter_eq_0),
      .leds_s1_readdata_from_sa                                          (leds_s1_readdata_from_sa),
      .nios_system_clock_1_in_readdata_from_sa                           (nios_system_clock_1_in_readdata_from_sa),
      .nios_system_clock_1_in_waitrequest_from_sa                        (nios_system_clock_1_in_waitrequest_from_sa),
      .nios_system_clock_2_in_readdata_from_sa                           (nios_system_clock_2_in_readdata_from_sa),
      .nios_system_clock_2_in_waitrequest_from_sa                        (nios_system_clock_2_in_waitrequest_from_sa),
      .reset_n                                                           (sys_clk_reset_n),
      .sysid_control_slave_readdata_from_sa                              (sysid_control_slave_readdata_from_sa)
    );

  cpu_0_instruction_master_arbitrator the_cpu_0_instruction_master
    (
      .clk                                                                (sys_clk),
      .cpu_0_instruction_master_address                                   (cpu_0_instruction_master_address),
      .cpu_0_instruction_master_address_to_slave                          (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_dbs_address                               (cpu_0_instruction_master_dbs_address),
      .cpu_0_instruction_master_granted_cpu_0_jtag_debug_module           (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_granted_nios_system_clock_0_in            (cpu_0_instruction_master_granted_nios_system_clock_0_in),
      .cpu_0_instruction_master_latency_counter                           (cpu_0_instruction_master_latency_counter),
      .cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module (cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_qualified_request_nios_system_clock_0_in  (cpu_0_instruction_master_qualified_request_nios_system_clock_0_in),
      .cpu_0_instruction_master_read                                      (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module   (cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_read_data_valid_nios_system_clock_0_in    (cpu_0_instruction_master_read_data_valid_nios_system_clock_0_in),
      .cpu_0_instruction_master_readdata                                  (cpu_0_instruction_master_readdata),
      .cpu_0_instruction_master_readdatavalid                             (cpu_0_instruction_master_readdatavalid),
      .cpu_0_instruction_master_requests_cpu_0_jtag_debug_module          (cpu_0_instruction_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_requests_nios_system_clock_0_in           (cpu_0_instruction_master_requests_nios_system_clock_0_in),
      .cpu_0_instruction_master_waitrequest                               (cpu_0_instruction_master_waitrequest),
      .cpu_0_jtag_debug_module_readdata_from_sa                           (cpu_0_jtag_debug_module_readdata_from_sa),
      .d1_cpu_0_jtag_debug_module_end_xfer                                (d1_cpu_0_jtag_debug_module_end_xfer),
      .d1_nios_system_clock_0_in_end_xfer                                 (d1_nios_system_clock_0_in_end_xfer),
      .nios_system_clock_0_in_readdata_from_sa                            (nios_system_clock_0_in_readdata_from_sa),
      .nios_system_clock_0_in_waitrequest_from_sa                         (nios_system_clock_0_in_waitrequest_from_sa),
      .reset_n                                                            (sys_clk_reset_n)
    );

  cpu_0 the_cpu_0
    (
      .clk                                   (sys_clk),
      .d_address                             (cpu_0_data_master_address),
      .d_byteenable                          (cpu_0_data_master_byteenable),
      .d_irq                                 (cpu_0_data_master_irq),
      .d_read                                (cpu_0_data_master_read),
      .d_readdata                            (cpu_0_data_master_readdata),
      .d_readdatavalid                       (cpu_0_data_master_readdatavalid),
      .d_waitrequest                         (cpu_0_data_master_waitrequest),
      .d_write                               (cpu_0_data_master_write),
      .d_writedata                           (cpu_0_data_master_writedata),
      .i_address                             (cpu_0_instruction_master_address),
      .i_read                                (cpu_0_instruction_master_read),
      .i_readdata                            (cpu_0_instruction_master_readdata),
      .i_readdatavalid                       (cpu_0_instruction_master_readdatavalid),
      .i_waitrequest                         (cpu_0_instruction_master_waitrequest),
      .jtag_debug_module_address             (cpu_0_jtag_debug_module_address),
      .jtag_debug_module_begintransfer       (cpu_0_jtag_debug_module_begintransfer),
      .jtag_debug_module_byteenable          (cpu_0_jtag_debug_module_byteenable),
      .jtag_debug_module_debugaccess         (cpu_0_jtag_debug_module_debugaccess),
      .jtag_debug_module_debugaccess_to_roms (cpu_0_data_master_debugaccess),
      .jtag_debug_module_readdata            (cpu_0_jtag_debug_module_readdata),
      .jtag_debug_module_resetrequest        (cpu_0_jtag_debug_module_resetrequest),
      .jtag_debug_module_select              (cpu_0_jtag_debug_module_chipselect),
      .jtag_debug_module_write               (cpu_0_jtag_debug_module_write),
      .jtag_debug_module_writedata           (cpu_0_jtag_debug_module_writedata),
      .reset_n                               (cpu_0_jtag_debug_module_reset_n)
    );

  jtag_uart_0_avalon_jtag_slave_arbitrator the_jtag_uart_0_avalon_jtag_slave
    (
      .clk                                                               (sys_clk),
      .cpu_0_data_master_address_to_slave                                (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave           (cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_latency_counter                                 (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave (cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_read                                            (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave   (cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave          (cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_write                                           (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                       (cpu_0_data_master_writedata),
      .d1_jtag_uart_0_avalon_jtag_slave_end_xfer                         (d1_jtag_uart_0_avalon_jtag_slave_end_xfer),
      .jtag_uart_0_avalon_jtag_slave_address                             (jtag_uart_0_avalon_jtag_slave_address),
      .jtag_uart_0_avalon_jtag_slave_chipselect                          (jtag_uart_0_avalon_jtag_slave_chipselect),
      .jtag_uart_0_avalon_jtag_slave_dataavailable                       (jtag_uart_0_avalon_jtag_slave_dataavailable),
      .jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa               (jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa),
      .jtag_uart_0_avalon_jtag_slave_irq                                 (jtag_uart_0_avalon_jtag_slave_irq),
      .jtag_uart_0_avalon_jtag_slave_irq_from_sa                         (jtag_uart_0_avalon_jtag_slave_irq_from_sa),
      .jtag_uart_0_avalon_jtag_slave_read_n                              (jtag_uart_0_avalon_jtag_slave_read_n),
      .jtag_uart_0_avalon_jtag_slave_readdata                            (jtag_uart_0_avalon_jtag_slave_readdata),
      .jtag_uart_0_avalon_jtag_slave_readdata_from_sa                    (jtag_uart_0_avalon_jtag_slave_readdata_from_sa),
      .jtag_uart_0_avalon_jtag_slave_readyfordata                        (jtag_uart_0_avalon_jtag_slave_readyfordata),
      .jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa                (jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa),
      .jtag_uart_0_avalon_jtag_slave_reset_n                             (jtag_uart_0_avalon_jtag_slave_reset_n),
      .jtag_uart_0_avalon_jtag_slave_waitrequest                         (jtag_uart_0_avalon_jtag_slave_waitrequest),
      .jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa                 (jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa),
      .jtag_uart_0_avalon_jtag_slave_write_n                             (jtag_uart_0_avalon_jtag_slave_write_n),
      .jtag_uart_0_avalon_jtag_slave_writedata                           (jtag_uart_0_avalon_jtag_slave_writedata),
      .reset_n                                                           (sys_clk_reset_n)
    );

  jtag_uart_0 the_jtag_uart_0
    (
      .av_address     (jtag_uart_0_avalon_jtag_slave_address),
      .av_chipselect  (jtag_uart_0_avalon_jtag_slave_chipselect),
      .av_irq         (jtag_uart_0_avalon_jtag_slave_irq),
      .av_read_n      (jtag_uart_0_avalon_jtag_slave_read_n),
      .av_readdata    (jtag_uart_0_avalon_jtag_slave_readdata),
      .av_waitrequest (jtag_uart_0_avalon_jtag_slave_waitrequest),
      .av_write_n     (jtag_uart_0_avalon_jtag_slave_write_n),
      .av_writedata   (jtag_uart_0_avalon_jtag_slave_writedata),
      .clk            (sys_clk),
      .dataavailable  (jtag_uart_0_avalon_jtag_slave_dataavailable),
      .readyfordata   (jtag_uart_0_avalon_jtag_slave_readyfordata),
      .rst_n          (jtag_uart_0_avalon_jtag_slave_reset_n)
    );

  keys_s1_arbitrator the_keys_s1
    (
      .clk                                         (sys_clk),
      .cpu_0_data_master_address_to_slave          (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_keys_s1           (cpu_0_data_master_granted_keys_s1),
      .cpu_0_data_master_latency_counter           (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_keys_s1 (cpu_0_data_master_qualified_request_keys_s1),
      .cpu_0_data_master_read                      (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_keys_s1   (cpu_0_data_master_read_data_valid_keys_s1),
      .cpu_0_data_master_requests_keys_s1          (cpu_0_data_master_requests_keys_s1),
      .cpu_0_data_master_write                     (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                 (cpu_0_data_master_writedata),
      .d1_keys_s1_end_xfer                         (d1_keys_s1_end_xfer),
      .keys_s1_address                             (keys_s1_address),
      .keys_s1_chipselect                          (keys_s1_chipselect),
      .keys_s1_readdata                            (keys_s1_readdata),
      .keys_s1_readdata_from_sa                    (keys_s1_readdata_from_sa),
      .keys_s1_reset_n                             (keys_s1_reset_n),
      .keys_s1_write_n                             (keys_s1_write_n),
      .keys_s1_writedata                           (keys_s1_writedata),
      .reset_n                                     (sys_clk_reset_n)
    );

  keys the_keys
    (
      .address    (keys_s1_address),
      .chipselect (keys_s1_chipselect),
      .clk        (sys_clk),
      .in_port    (in_port_to_the_keys),
      .readdata   (keys_s1_readdata),
      .reset_n    (keys_s1_reset_n),
      .write_n    (keys_s1_write_n),
      .writedata  (keys_s1_writedata)
    );

  lcd_0_control_slave_arbitrator the_lcd_0_control_slave
    (
      .clk                                                     (sys_clk),
      .cpu_0_data_master_address_to_slave                      (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                            (cpu_0_data_master_byteenable),
      .cpu_0_data_master_granted_lcd_0_control_slave           (cpu_0_data_master_granted_lcd_0_control_slave),
      .cpu_0_data_master_latency_counter                       (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_lcd_0_control_slave (cpu_0_data_master_qualified_request_lcd_0_control_slave),
      .cpu_0_data_master_read                                  (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_lcd_0_control_slave   (cpu_0_data_master_read_data_valid_lcd_0_control_slave),
      .cpu_0_data_master_requests_lcd_0_control_slave          (cpu_0_data_master_requests_lcd_0_control_slave),
      .cpu_0_data_master_write                                 (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                             (cpu_0_data_master_writedata),
      .d1_lcd_0_control_slave_end_xfer                         (d1_lcd_0_control_slave_end_xfer),
      .lcd_0_control_slave_address                             (lcd_0_control_slave_address),
      .lcd_0_control_slave_begintransfer                       (lcd_0_control_slave_begintransfer),
      .lcd_0_control_slave_read                                (lcd_0_control_slave_read),
      .lcd_0_control_slave_readdata                            (lcd_0_control_slave_readdata),
      .lcd_0_control_slave_readdata_from_sa                    (lcd_0_control_slave_readdata_from_sa),
      .lcd_0_control_slave_reset_n                             (lcd_0_control_slave_reset_n),
      .lcd_0_control_slave_wait_counter_eq_0                   (lcd_0_control_slave_wait_counter_eq_0),
      .lcd_0_control_slave_write                               (lcd_0_control_slave_write),
      .lcd_0_control_slave_writedata                           (lcd_0_control_slave_writedata),
      .reset_n                                                 (sys_clk_reset_n)
    );

  lcd_0 the_lcd_0
    (
      .LCD_E         (LCD_E_from_the_lcd_0),
      .LCD_RS        (LCD_RS_from_the_lcd_0),
      .LCD_RW        (LCD_RW_from_the_lcd_0),
      .LCD_data      (LCD_data_to_and_from_the_lcd_0),
      .address       (lcd_0_control_slave_address),
      .begintransfer (lcd_0_control_slave_begintransfer),
      .clk           (sys_clk),
      .read          (lcd_0_control_slave_read),
      .readdata      (lcd_0_control_slave_readdata),
      .reset_n       (lcd_0_control_slave_reset_n),
      .write         (lcd_0_control_slave_write),
      .writedata     (lcd_0_control_slave_writedata)
    );

  leds_s1_arbitrator the_leds_s1
    (
      .clk                                         (sys_clk),
      .cpu_0_data_master_address_to_slave          (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_leds_s1           (cpu_0_data_master_granted_leds_s1),
      .cpu_0_data_master_latency_counter           (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_leds_s1 (cpu_0_data_master_qualified_request_leds_s1),
      .cpu_0_data_master_read                      (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_leds_s1   (cpu_0_data_master_read_data_valid_leds_s1),
      .cpu_0_data_master_requests_leds_s1          (cpu_0_data_master_requests_leds_s1),
      .cpu_0_data_master_write                     (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                 (cpu_0_data_master_writedata),
      .d1_leds_s1_end_xfer                         (d1_leds_s1_end_xfer),
      .leds_s1_address                             (leds_s1_address),
      .leds_s1_chipselect                          (leds_s1_chipselect),
      .leds_s1_readdata                            (leds_s1_readdata),
      .leds_s1_readdata_from_sa                    (leds_s1_readdata_from_sa),
      .leds_s1_reset_n                             (leds_s1_reset_n),
      .leds_s1_write_n                             (leds_s1_write_n),
      .leds_s1_writedata                           (leds_s1_writedata),
      .reset_n                                     (sys_clk_reset_n)
    );

  leds the_leds
    (
      .address    (leds_s1_address),
      .chipselect (leds_s1_chipselect),
      .clk        (sys_clk),
      .out_port   (out_port_from_the_leds),
      .readdata   (leds_s1_readdata),
      .reset_n    (leds_s1_reset_n),
      .write_n    (leds_s1_write_n),
      .writedata  (leds_s1_writedata)
    );

  nios_system_clock_0_in_arbitrator the_nios_system_clock_0_in
    (
      .clk                                                               (sys_clk),
      .cpu_0_instruction_master_address_to_slave                         (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_dbs_address                              (cpu_0_instruction_master_dbs_address),
      .cpu_0_instruction_master_granted_nios_system_clock_0_in           (cpu_0_instruction_master_granted_nios_system_clock_0_in),
      .cpu_0_instruction_master_latency_counter                          (cpu_0_instruction_master_latency_counter),
      .cpu_0_instruction_master_qualified_request_nios_system_clock_0_in (cpu_0_instruction_master_qualified_request_nios_system_clock_0_in),
      .cpu_0_instruction_master_read                                     (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_nios_system_clock_0_in   (cpu_0_instruction_master_read_data_valid_nios_system_clock_0_in),
      .cpu_0_instruction_master_requests_nios_system_clock_0_in          (cpu_0_instruction_master_requests_nios_system_clock_0_in),
      .d1_nios_system_clock_0_in_end_xfer                                (d1_nios_system_clock_0_in_end_xfer),
      .nios_system_clock_0_in_address                                    (nios_system_clock_0_in_address),
      .nios_system_clock_0_in_byteenable                                 (nios_system_clock_0_in_byteenable),
      .nios_system_clock_0_in_endofpacket                                (nios_system_clock_0_in_endofpacket),
      .nios_system_clock_0_in_endofpacket_from_sa                        (nios_system_clock_0_in_endofpacket_from_sa),
      .nios_system_clock_0_in_nativeaddress                              (nios_system_clock_0_in_nativeaddress),
      .nios_system_clock_0_in_read                                       (nios_system_clock_0_in_read),
      .nios_system_clock_0_in_readdata                                   (nios_system_clock_0_in_readdata),
      .nios_system_clock_0_in_readdata_from_sa                           (nios_system_clock_0_in_readdata_from_sa),
      .nios_system_clock_0_in_reset_n                                    (nios_system_clock_0_in_reset_n),
      .nios_system_clock_0_in_waitrequest                                (nios_system_clock_0_in_waitrequest),
      .nios_system_clock_0_in_waitrequest_from_sa                        (nios_system_clock_0_in_waitrequest_from_sa),
      .nios_system_clock_0_in_write                                      (nios_system_clock_0_in_write),
      .reset_n                                                           (sys_clk_reset_n)
    );

  nios_system_clock_0_out_arbitrator the_nios_system_clock_0_out
    (
      .clk                                                               (sdram_clk),
      .d1_sdram_0_s1_end_xfer                                            (d1_sdram_0_s1_end_xfer),
      .nios_system_clock_0_out_address                                   (nios_system_clock_0_out_address),
      .nios_system_clock_0_out_address_to_slave                          (nios_system_clock_0_out_address_to_slave),
      .nios_system_clock_0_out_byteenable                                (nios_system_clock_0_out_byteenable),
      .nios_system_clock_0_out_granted_sdram_0_s1                        (nios_system_clock_0_out_granted_sdram_0_s1),
      .nios_system_clock_0_out_qualified_request_sdram_0_s1              (nios_system_clock_0_out_qualified_request_sdram_0_s1),
      .nios_system_clock_0_out_read                                      (nios_system_clock_0_out_read),
      .nios_system_clock_0_out_read_data_valid_sdram_0_s1                (nios_system_clock_0_out_read_data_valid_sdram_0_s1),
      .nios_system_clock_0_out_read_data_valid_sdram_0_s1_shift_register (nios_system_clock_0_out_read_data_valid_sdram_0_s1_shift_register),
      .nios_system_clock_0_out_readdata                                  (nios_system_clock_0_out_readdata),
      .nios_system_clock_0_out_requests_sdram_0_s1                       (nios_system_clock_0_out_requests_sdram_0_s1),
      .nios_system_clock_0_out_reset_n                                   (nios_system_clock_0_out_reset_n),
      .nios_system_clock_0_out_waitrequest                               (nios_system_clock_0_out_waitrequest),
      .nios_system_clock_0_out_write                                     (nios_system_clock_0_out_write),
      .nios_system_clock_0_out_writedata                                 (nios_system_clock_0_out_writedata),
      .reset_n                                                           (sdram_clk_reset_n),
      .sdram_0_s1_readdata_from_sa                                       (sdram_0_s1_readdata_from_sa),
      .sdram_0_s1_waitrequest_from_sa                                    (sdram_0_s1_waitrequest_from_sa)
    );

  nios_system_clock_0 the_nios_system_clock_0
    (
      .master_address       (nios_system_clock_0_out_address),
      .master_byteenable    (nios_system_clock_0_out_byteenable),
      .master_clk           (sdram_clk),
      .master_endofpacket   (nios_system_clock_0_out_endofpacket),
      .master_nativeaddress (nios_system_clock_0_out_nativeaddress),
      .master_read          (nios_system_clock_0_out_read),
      .master_readdata      (nios_system_clock_0_out_readdata),
      .master_reset_n       (nios_system_clock_0_out_reset_n),
      .master_waitrequest   (nios_system_clock_0_out_waitrequest),
      .master_write         (nios_system_clock_0_out_write),
      .master_writedata     (nios_system_clock_0_out_writedata),
      .slave_address        (nios_system_clock_0_in_address),
      .slave_byteenable     (nios_system_clock_0_in_byteenable),
      .slave_clk            (sys_clk),
      .slave_endofpacket    (nios_system_clock_0_in_endofpacket),
      .slave_nativeaddress  (nios_system_clock_0_in_nativeaddress),
      .slave_read           (nios_system_clock_0_in_read),
      .slave_readdata       (nios_system_clock_0_in_readdata),
      .slave_reset_n        (nios_system_clock_0_in_reset_n),
      .slave_waitrequest    (nios_system_clock_0_in_waitrequest),
      .slave_write          (nios_system_clock_0_in_write),
      .slave_writedata      (nios_system_clock_0_in_writedata)
    );

  nios_system_clock_1_in_arbitrator the_nios_system_clock_1_in
    (
      .clk                                                        (sys_clk),
      .cpu_0_data_master_address_to_slave                         (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                               (cpu_0_data_master_byteenable),
      .cpu_0_data_master_byteenable_nios_system_clock_1_in        (cpu_0_data_master_byteenable_nios_system_clock_1_in),
      .cpu_0_data_master_dbs_address                              (cpu_0_data_master_dbs_address),
      .cpu_0_data_master_dbs_write_16                             (cpu_0_data_master_dbs_write_16),
      .cpu_0_data_master_granted_nios_system_clock_1_in           (cpu_0_data_master_granted_nios_system_clock_1_in),
      .cpu_0_data_master_latency_counter                          (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_nios_system_clock_1_in (cpu_0_data_master_qualified_request_nios_system_clock_1_in),
      .cpu_0_data_master_read                                     (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_nios_system_clock_1_in   (cpu_0_data_master_read_data_valid_nios_system_clock_1_in),
      .cpu_0_data_master_requests_nios_system_clock_1_in          (cpu_0_data_master_requests_nios_system_clock_1_in),
      .cpu_0_data_master_write                                    (cpu_0_data_master_write),
      .d1_nios_system_clock_1_in_end_xfer                         (d1_nios_system_clock_1_in_end_xfer),
      .nios_system_clock_1_in_address                             (nios_system_clock_1_in_address),
      .nios_system_clock_1_in_byteenable                          (nios_system_clock_1_in_byteenable),
      .nios_system_clock_1_in_endofpacket                         (nios_system_clock_1_in_endofpacket),
      .nios_system_clock_1_in_endofpacket_from_sa                 (nios_system_clock_1_in_endofpacket_from_sa),
      .nios_system_clock_1_in_nativeaddress                       (nios_system_clock_1_in_nativeaddress),
      .nios_system_clock_1_in_read                                (nios_system_clock_1_in_read),
      .nios_system_clock_1_in_readdata                            (nios_system_clock_1_in_readdata),
      .nios_system_clock_1_in_readdata_from_sa                    (nios_system_clock_1_in_readdata_from_sa),
      .nios_system_clock_1_in_reset_n                             (nios_system_clock_1_in_reset_n),
      .nios_system_clock_1_in_waitrequest                         (nios_system_clock_1_in_waitrequest),
      .nios_system_clock_1_in_waitrequest_from_sa                 (nios_system_clock_1_in_waitrequest_from_sa),
      .nios_system_clock_1_in_write                               (nios_system_clock_1_in_write),
      .nios_system_clock_1_in_writedata                           (nios_system_clock_1_in_writedata),
      .reset_n                                                    (sys_clk_reset_n)
    );

  nios_system_clock_1_out_arbitrator the_nios_system_clock_1_out
    (
      .clk                                                               (sdram_clk),
      .d1_sdram_0_s1_end_xfer                                            (d1_sdram_0_s1_end_xfer),
      .nios_system_clock_1_out_address                                   (nios_system_clock_1_out_address),
      .nios_system_clock_1_out_address_to_slave                          (nios_system_clock_1_out_address_to_slave),
      .nios_system_clock_1_out_byteenable                                (nios_system_clock_1_out_byteenable),
      .nios_system_clock_1_out_granted_sdram_0_s1                        (nios_system_clock_1_out_granted_sdram_0_s1),
      .nios_system_clock_1_out_qualified_request_sdram_0_s1              (nios_system_clock_1_out_qualified_request_sdram_0_s1),
      .nios_system_clock_1_out_read                                      (nios_system_clock_1_out_read),
      .nios_system_clock_1_out_read_data_valid_sdram_0_s1                (nios_system_clock_1_out_read_data_valid_sdram_0_s1),
      .nios_system_clock_1_out_read_data_valid_sdram_0_s1_shift_register (nios_system_clock_1_out_read_data_valid_sdram_0_s1_shift_register),
      .nios_system_clock_1_out_readdata                                  (nios_system_clock_1_out_readdata),
      .nios_system_clock_1_out_requests_sdram_0_s1                       (nios_system_clock_1_out_requests_sdram_0_s1),
      .nios_system_clock_1_out_reset_n                                   (nios_system_clock_1_out_reset_n),
      .nios_system_clock_1_out_waitrequest                               (nios_system_clock_1_out_waitrequest),
      .nios_system_clock_1_out_write                                     (nios_system_clock_1_out_write),
      .nios_system_clock_1_out_writedata                                 (nios_system_clock_1_out_writedata),
      .reset_n                                                           (sdram_clk_reset_n),
      .sdram_0_s1_readdata_from_sa                                       (sdram_0_s1_readdata_from_sa),
      .sdram_0_s1_waitrequest_from_sa                                    (sdram_0_s1_waitrequest_from_sa)
    );

  nios_system_clock_1 the_nios_system_clock_1
    (
      .master_address       (nios_system_clock_1_out_address),
      .master_byteenable    (nios_system_clock_1_out_byteenable),
      .master_clk           (sdram_clk),
      .master_endofpacket   (nios_system_clock_1_out_endofpacket),
      .master_nativeaddress (nios_system_clock_1_out_nativeaddress),
      .master_read          (nios_system_clock_1_out_read),
      .master_readdata      (nios_system_clock_1_out_readdata),
      .master_reset_n       (nios_system_clock_1_out_reset_n),
      .master_waitrequest   (nios_system_clock_1_out_waitrequest),
      .master_write         (nios_system_clock_1_out_write),
      .master_writedata     (nios_system_clock_1_out_writedata),
      .slave_address        (nios_system_clock_1_in_address),
      .slave_byteenable     (nios_system_clock_1_in_byteenable),
      .slave_clk            (sys_clk),
      .slave_endofpacket    (nios_system_clock_1_in_endofpacket),
      .slave_nativeaddress  (nios_system_clock_1_in_nativeaddress),
      .slave_read           (nios_system_clock_1_in_read),
      .slave_readdata       (nios_system_clock_1_in_readdata),
      .slave_reset_n        (nios_system_clock_1_in_reset_n),
      .slave_waitrequest    (nios_system_clock_1_in_waitrequest),
      .slave_write          (nios_system_clock_1_in_write),
      .slave_writedata      (nios_system_clock_1_in_writedata)
    );

  nios_system_clock_2_in_arbitrator the_nios_system_clock_2_in
    (
      .clk                                                        (sys_clk),
      .cpu_0_data_master_address_to_slave                         (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                               (cpu_0_data_master_byteenable),
      .cpu_0_data_master_byteenable_nios_system_clock_2_in        (cpu_0_data_master_byteenable_nios_system_clock_2_in),
      .cpu_0_data_master_dbs_address                              (cpu_0_data_master_dbs_address),
      .cpu_0_data_master_dbs_write_8                              (cpu_0_data_master_dbs_write_8),
      .cpu_0_data_master_granted_nios_system_clock_2_in           (cpu_0_data_master_granted_nios_system_clock_2_in),
      .cpu_0_data_master_latency_counter                          (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_nios_system_clock_2_in (cpu_0_data_master_qualified_request_nios_system_clock_2_in),
      .cpu_0_data_master_read                                     (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_nios_system_clock_2_in   (cpu_0_data_master_read_data_valid_nios_system_clock_2_in),
      .cpu_0_data_master_requests_nios_system_clock_2_in          (cpu_0_data_master_requests_nios_system_clock_2_in),
      .cpu_0_data_master_write                                    (cpu_0_data_master_write),
      .d1_nios_system_clock_2_in_end_xfer                         (d1_nios_system_clock_2_in_end_xfer),
      .nios_system_clock_2_in_address                             (nios_system_clock_2_in_address),
      .nios_system_clock_2_in_endofpacket                         (nios_system_clock_2_in_endofpacket),
      .nios_system_clock_2_in_endofpacket_from_sa                 (nios_system_clock_2_in_endofpacket_from_sa),
      .nios_system_clock_2_in_nativeaddress                       (nios_system_clock_2_in_nativeaddress),
      .nios_system_clock_2_in_read                                (nios_system_clock_2_in_read),
      .nios_system_clock_2_in_readdata                            (nios_system_clock_2_in_readdata),
      .nios_system_clock_2_in_readdata_from_sa                    (nios_system_clock_2_in_readdata_from_sa),
      .nios_system_clock_2_in_reset_n                             (nios_system_clock_2_in_reset_n),
      .nios_system_clock_2_in_waitrequest                         (nios_system_clock_2_in_waitrequest),
      .nios_system_clock_2_in_waitrequest_from_sa                 (nios_system_clock_2_in_waitrequest_from_sa),
      .nios_system_clock_2_in_write                               (nios_system_clock_2_in_write),
      .nios_system_clock_2_in_writedata                           (nios_system_clock_2_in_writedata),
      .reset_n                                                    (sys_clk_reset_n)
    );

  nios_system_clock_2_out_arbitrator the_nios_system_clock_2_out
    (
      .clk                                                                    (clk_0),
      .clocks_0_avalon_clocks_slave_readdata_from_sa                          (clocks_0_avalon_clocks_slave_readdata_from_sa),
      .d1_clocks_0_avalon_clocks_slave_end_xfer                               (d1_clocks_0_avalon_clocks_slave_end_xfer),
      .nios_system_clock_2_out_address                                        (nios_system_clock_2_out_address),
      .nios_system_clock_2_out_address_to_slave                               (nios_system_clock_2_out_address_to_slave),
      .nios_system_clock_2_out_granted_clocks_0_avalon_clocks_slave           (nios_system_clock_2_out_granted_clocks_0_avalon_clocks_slave),
      .nios_system_clock_2_out_qualified_request_clocks_0_avalon_clocks_slave (nios_system_clock_2_out_qualified_request_clocks_0_avalon_clocks_slave),
      .nios_system_clock_2_out_read                                           (nios_system_clock_2_out_read),
      .nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave   (nios_system_clock_2_out_read_data_valid_clocks_0_avalon_clocks_slave),
      .nios_system_clock_2_out_readdata                                       (nios_system_clock_2_out_readdata),
      .nios_system_clock_2_out_requests_clocks_0_avalon_clocks_slave          (nios_system_clock_2_out_requests_clocks_0_avalon_clocks_slave),
      .nios_system_clock_2_out_reset_n                                        (nios_system_clock_2_out_reset_n),
      .nios_system_clock_2_out_waitrequest                                    (nios_system_clock_2_out_waitrequest),
      .nios_system_clock_2_out_write                                          (nios_system_clock_2_out_write),
      .nios_system_clock_2_out_writedata                                      (nios_system_clock_2_out_writedata),
      .reset_n                                                                (clk_0_reset_n)
    );

  nios_system_clock_2 the_nios_system_clock_2
    (
      .master_address       (nios_system_clock_2_out_address),
      .master_clk           (clk_0),
      .master_endofpacket   (nios_system_clock_2_out_endofpacket),
      .master_nativeaddress (nios_system_clock_2_out_nativeaddress),
      .master_read          (nios_system_clock_2_out_read),
      .master_readdata      (nios_system_clock_2_out_readdata),
      .master_reset_n       (nios_system_clock_2_out_reset_n),
      .master_waitrequest   (nios_system_clock_2_out_waitrequest),
      .master_write         (nios_system_clock_2_out_write),
      .master_writedata     (nios_system_clock_2_out_writedata),
      .slave_address        (nios_system_clock_2_in_address),
      .slave_clk            (sys_clk),
      .slave_endofpacket    (nios_system_clock_2_in_endofpacket),
      .slave_nativeaddress  (nios_system_clock_2_in_nativeaddress),
      .slave_read           (nios_system_clock_2_in_read),
      .slave_readdata       (nios_system_clock_2_in_readdata),
      .slave_reset_n        (nios_system_clock_2_in_reset_n),
      .slave_waitrequest    (nios_system_clock_2_in_waitrequest),
      .slave_write          (nios_system_clock_2_in_write),
      .slave_writedata      (nios_system_clock_2_in_writedata)
    );

  sdram_0_s1_arbitrator the_sdram_0_s1
    (
      .clk                                                               (sdram_clk),
      .d1_sdram_0_s1_end_xfer                                            (d1_sdram_0_s1_end_xfer),
      .nios_system_clock_0_out_address_to_slave                          (nios_system_clock_0_out_address_to_slave),
      .nios_system_clock_0_out_byteenable                                (nios_system_clock_0_out_byteenable),
      .nios_system_clock_0_out_granted_sdram_0_s1                        (nios_system_clock_0_out_granted_sdram_0_s1),
      .nios_system_clock_0_out_qualified_request_sdram_0_s1              (nios_system_clock_0_out_qualified_request_sdram_0_s1),
      .nios_system_clock_0_out_read                                      (nios_system_clock_0_out_read),
      .nios_system_clock_0_out_read_data_valid_sdram_0_s1                (nios_system_clock_0_out_read_data_valid_sdram_0_s1),
      .nios_system_clock_0_out_read_data_valid_sdram_0_s1_shift_register (nios_system_clock_0_out_read_data_valid_sdram_0_s1_shift_register),
      .nios_system_clock_0_out_requests_sdram_0_s1                       (nios_system_clock_0_out_requests_sdram_0_s1),
      .nios_system_clock_0_out_write                                     (nios_system_clock_0_out_write),
      .nios_system_clock_0_out_writedata                                 (nios_system_clock_0_out_writedata),
      .nios_system_clock_1_out_address_to_slave                          (nios_system_clock_1_out_address_to_slave),
      .nios_system_clock_1_out_byteenable                                (nios_system_clock_1_out_byteenable),
      .nios_system_clock_1_out_granted_sdram_0_s1                        (nios_system_clock_1_out_granted_sdram_0_s1),
      .nios_system_clock_1_out_qualified_request_sdram_0_s1              (nios_system_clock_1_out_qualified_request_sdram_0_s1),
      .nios_system_clock_1_out_read                                      (nios_system_clock_1_out_read),
      .nios_system_clock_1_out_read_data_valid_sdram_0_s1                (nios_system_clock_1_out_read_data_valid_sdram_0_s1),
      .nios_system_clock_1_out_read_data_valid_sdram_0_s1_shift_register (nios_system_clock_1_out_read_data_valid_sdram_0_s1_shift_register),
      .nios_system_clock_1_out_requests_sdram_0_s1                       (nios_system_clock_1_out_requests_sdram_0_s1),
      .nios_system_clock_1_out_write                                     (nios_system_clock_1_out_write),
      .nios_system_clock_1_out_writedata                                 (nios_system_clock_1_out_writedata),
      .reset_n                                                           (sdram_clk_reset_n),
      .sdram_0_s1_address                                                (sdram_0_s1_address),
      .sdram_0_s1_byteenable_n                                           (sdram_0_s1_byteenable_n),
      .sdram_0_s1_chipselect                                             (sdram_0_s1_chipselect),
      .sdram_0_s1_read_n                                                 (sdram_0_s1_read_n),
      .sdram_0_s1_readdata                                               (sdram_0_s1_readdata),
      .sdram_0_s1_readdata_from_sa                                       (sdram_0_s1_readdata_from_sa),
      .sdram_0_s1_readdatavalid                                          (sdram_0_s1_readdatavalid),
      .sdram_0_s1_reset_n                                                (sdram_0_s1_reset_n),
      .sdram_0_s1_waitrequest                                            (sdram_0_s1_waitrequest),
      .sdram_0_s1_waitrequest_from_sa                                    (sdram_0_s1_waitrequest_from_sa),
      .sdram_0_s1_write_n                                                (sdram_0_s1_write_n),
      .sdram_0_s1_writedata                                              (sdram_0_s1_writedata)
    );

  sdram_0 the_sdram_0
    (
      .az_addr        (sdram_0_s1_address),
      .az_be_n        (sdram_0_s1_byteenable_n),
      .az_cs          (sdram_0_s1_chipselect),
      .az_data        (sdram_0_s1_writedata),
      .az_rd_n        (sdram_0_s1_read_n),
      .az_wr_n        (sdram_0_s1_write_n),
      .clk            (sdram_clk),
      .reset_n        (sdram_0_s1_reset_n),
      .za_data        (sdram_0_s1_readdata),
      .za_valid       (sdram_0_s1_readdatavalid),
      .za_waitrequest (sdram_0_s1_waitrequest),
      .zs_addr        (zs_addr_from_the_sdram_0),
      .zs_ba          (zs_ba_from_the_sdram_0),
      .zs_cas_n       (zs_cas_n_from_the_sdram_0),
      .zs_cke         (zs_cke_from_the_sdram_0),
      .zs_cs_n        (zs_cs_n_from_the_sdram_0),
      .zs_dq          (zs_dq_to_and_from_the_sdram_0),
      .zs_dqm         (zs_dqm_from_the_sdram_0),
      .zs_ras_n       (zs_ras_n_from_the_sdram_0),
      .zs_we_n        (zs_we_n_from_the_sdram_0)
    );

  sysid_control_slave_arbitrator the_sysid_control_slave
    (
      .clk                                                     (sys_clk),
      .cpu_0_data_master_address_to_slave                      (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_sysid_control_slave           (cpu_0_data_master_granted_sysid_control_slave),
      .cpu_0_data_master_latency_counter                       (cpu_0_data_master_latency_counter),
      .cpu_0_data_master_qualified_request_sysid_control_slave (cpu_0_data_master_qualified_request_sysid_control_slave),
      .cpu_0_data_master_read                                  (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_sysid_control_slave   (cpu_0_data_master_read_data_valid_sysid_control_slave),
      .cpu_0_data_master_requests_sysid_control_slave          (cpu_0_data_master_requests_sysid_control_slave),
      .cpu_0_data_master_write                                 (cpu_0_data_master_write),
      .d1_sysid_control_slave_end_xfer                         (d1_sysid_control_slave_end_xfer),
      .reset_n                                                 (sys_clk_reset_n),
      .sysid_control_slave_address                             (sysid_control_slave_address),
      .sysid_control_slave_readdata                            (sysid_control_slave_readdata),
      .sysid_control_slave_readdata_from_sa                    (sysid_control_slave_readdata_from_sa),
      .sysid_control_slave_reset_n                             (sysid_control_slave_reset_n)
    );

  sysid the_sysid
    (
      .address  (sysid_control_slave_address),
      .clock    (sysid_control_slave_clock),
      .readdata (sysid_control_slave_readdata),
      .reset_n  (sysid_control_slave_reset_n)
    );

  //reset is asserted asynchronously and deasserted synchronously
  nios_system_reset_sys_clk_domain_synch_module nios_system_reset_sys_clk_domain_synch
    (
      .clk      (sys_clk),
      .data_in  (1'b1),
      .data_out (sys_clk_reset_n),
      .reset_n  (reset_n_sources)
    );

  //reset sources mux, which is an e_mux
  assign reset_n_sources = ~(~reset_n |
    0 |
    0 |
    cpu_0_jtag_debug_module_resetrequest_from_sa |
    cpu_0_jtag_debug_module_resetrequest_from_sa |
    0);

  //reset is asserted asynchronously and deasserted synchronously
  nios_system_reset_clk_0_domain_synch_module nios_system_reset_clk_0_domain_synch
    (
      .clk      (clk_0),
      .data_in  (1'b1),
      .data_out (clk_0_reset_n),
      .reset_n  (reset_n_sources)
    );

  //reset is asserted asynchronously and deasserted synchronously
  nios_system_reset_sdram_clk_domain_synch_module nios_system_reset_sdram_clk_domain_synch
    (
      .clk      (sdram_clk),
      .data_in  (1'b1),
      .data_out (sdram_clk_reset_n),
      .reset_n  (reset_n_sources)
    );

  //nios_system_clock_0_in_writedata of type writedata does not connect to anything so wire it to default (0)
  assign nios_system_clock_0_in_writedata = 0;

  //nios_system_clock_0_out_endofpacket of type endofpacket does not connect to anything so wire it to default (0)
  assign nios_system_clock_0_out_endofpacket = 0;

  //nios_system_clock_1_out_endofpacket of type endofpacket does not connect to anything so wire it to default (0)
  assign nios_system_clock_1_out_endofpacket = 0;

  //nios_system_clock_2_out_endofpacket of type endofpacket does not connect to anything so wire it to default (0)
  assign nios_system_clock_2_out_endofpacket = 0;

  //sysid_control_slave_clock of type clock does not connect to anything so wire it to default (0)
  assign sysid_control_slave_clock = 0;


endmodule


//synthesis translate_off



// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE

// AND HERE WILL BE PRESERVED </ALTERA_NOTE>


// If user logic components use Altsync_Ram with convert_hex2ver.dll,
// set USE_convert_hex2ver in the user comments section above

// `ifdef USE_convert_hex2ver
// `else
// `define NO_PLI 1
// `endif

`include "/usr/local/3rdparty/altera/quartus12/quartus/eda/sim_lib/altera_mf.v"
`include "/usr/local/3rdparty/altera/quartus12/quartus/eda/sim_lib/220model.v"
`include "/usr/local/3rdparty/altera/quartus12/quartus/eda/sim_lib/sgate.v"
`include "clocks_0.v"
`include "leds.v"
`include "nios_system_clock_1.v"
`include "HEX7.v"
`include "sysid.v"
`include "HEX1.v"
`include "cpu_0_test_bench.v"
`include "cpu_0_mult_cell.v"
`include "cpu_0_oci_test_bench.v"
`include "cpu_0_jtag_debug_module_tck.v"
`include "cpu_0_jtag_debug_module_sysclk.v"
`include "cpu_0_jtag_debug_module_wrapper.v"
`include "cpu_0.v"
`include "HEX3.v"
`include "keys.v"
`include "jtag_uart_0.v"
`include "lcd_0.v"
`include "HEX6.v"
`include "sdram_0.v"
`include "HEX5.v"
`include "nios_system_clock_2.v"
`include "HEX4.v"
`include "HEX2.v"
`include "HEX0.v"
`include "nios_system_clock_0.v"

`timescale 1ns / 1ps

module test_bench 
;


  wire             LCD_E_from_the_lcd_0;
  wire             LCD_RS_from_the_lcd_0;
  wire             LCD_RW_from_the_lcd_0;
  wire    [  7: 0] LCD_data_to_and_from_the_lcd_0;
  wire             clk;
  reg              clk_0;
  wire    [  2: 0] in_port_to_the_keys;
  wire             jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa;
  wire             nios_system_clock_0_in_endofpacket_from_sa;
  wire    [ 15: 0] nios_system_clock_0_in_writedata;
  wire             nios_system_clock_0_out_endofpacket;
  wire    [ 21: 0] nios_system_clock_0_out_nativeaddress;
  wire             nios_system_clock_1_in_endofpacket_from_sa;
  wire             nios_system_clock_1_out_endofpacket;
  wire    [ 21: 0] nios_system_clock_1_out_nativeaddress;
  wire             nios_system_clock_2_in_endofpacket_from_sa;
  wire             nios_system_clock_2_out_endofpacket;
  wire             nios_system_clock_2_out_nativeaddress;
  wire    [  6: 0] out_port_from_the_HEX0;
  wire    [  6: 0] out_port_from_the_HEX1;
  wire    [  6: 0] out_port_from_the_HEX2;
  wire    [  6: 0] out_port_from_the_HEX3;
  wire    [  6: 0] out_port_from_the_HEX4;
  wire    [  6: 0] out_port_from_the_HEX5;
  wire    [  6: 0] out_port_from_the_HEX6;
  wire    [  6: 0] out_port_from_the_HEX7;
  wire    [ 25: 0] out_port_from_the_leds;
  reg              reset_n;
  wire             sdram_clk;
  wire             sys_clk;
  wire             sysid_control_slave_clock;
  wire    [ 11: 0] zs_addr_from_the_sdram_0;
  wire    [  1: 0] zs_ba_from_the_sdram_0;
  wire             zs_cas_n_from_the_sdram_0;
  wire             zs_cke_from_the_sdram_0;
  wire             zs_cs_n_from_the_sdram_0;
  wire    [ 15: 0] zs_dq_to_and_from_the_sdram_0;
  wire    [  1: 0] zs_dqm_from_the_sdram_0;
  wire             zs_ras_n_from_the_sdram_0;
  wire             zs_we_n_from_the_sdram_0;


// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
//  add your signals and additional architecture here
// AND HERE WILL BE PRESERVED </ALTERA_NOTE>

  //Set us up the Dut
  nios_system DUT
    (
      .LCD_E_from_the_lcd_0           (LCD_E_from_the_lcd_0),
      .LCD_RS_from_the_lcd_0          (LCD_RS_from_the_lcd_0),
      .LCD_RW_from_the_lcd_0          (LCD_RW_from_the_lcd_0),
      .LCD_data_to_and_from_the_lcd_0 (LCD_data_to_and_from_the_lcd_0),
      .clk_0                          (clk_0),
      .in_port_to_the_keys            (in_port_to_the_keys),
      .out_port_from_the_HEX0         (out_port_from_the_HEX0),
      .out_port_from_the_HEX1         (out_port_from_the_HEX1),
      .out_port_from_the_HEX2         (out_port_from_the_HEX2),
      .out_port_from_the_HEX3         (out_port_from_the_HEX3),
      .out_port_from_the_HEX4         (out_port_from_the_HEX4),
      .out_port_from_the_HEX5         (out_port_from_the_HEX5),
      .out_port_from_the_HEX6         (out_port_from_the_HEX6),
      .out_port_from_the_HEX7         (out_port_from_the_HEX7),
      .out_port_from_the_leds         (out_port_from_the_leds),
      .reset_n                        (reset_n),
      .sdram_clk                      (sdram_clk),
      .sys_clk                        (sys_clk),
      .zs_addr_from_the_sdram_0       (zs_addr_from_the_sdram_0),
      .zs_ba_from_the_sdram_0         (zs_ba_from_the_sdram_0),
      .zs_cas_n_from_the_sdram_0      (zs_cas_n_from_the_sdram_0),
      .zs_cke_from_the_sdram_0        (zs_cke_from_the_sdram_0),
      .zs_cs_n_from_the_sdram_0       (zs_cs_n_from_the_sdram_0),
      .zs_dq_to_and_from_the_sdram_0  (zs_dq_to_and_from_the_sdram_0),
      .zs_dqm_from_the_sdram_0        (zs_dqm_from_the_sdram_0),
      .zs_ras_n_from_the_sdram_0      (zs_ras_n_from_the_sdram_0),
      .zs_we_n_from_the_sdram_0       (zs_we_n_from_the_sdram_0)
    );

  initial
    clk_0 = 1'b0;
  always
    #10 clk_0 <= ~clk_0;
  
  initial 
    begin
      reset_n <= 0;
      #200 reset_n <= 1;
    end

endmodule


//synthesis translate_on