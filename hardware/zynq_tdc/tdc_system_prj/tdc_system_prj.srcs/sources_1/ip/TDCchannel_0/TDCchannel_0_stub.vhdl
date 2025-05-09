-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Thu May 23 19:40:59 2024
-- Host        : DESKTOP-QJLKIHB running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/zynq_tdc/tdc_system_prj/tdc_system_prj.srcs/sources_1/ip/TDCchannel_0/TDCchannel_0_stub.vhdl
-- Design      : TDCchannel_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TDCchannel_0 is
  Port ( 
    clk : in STD_LOGIC;
    hit : in STD_LOGIC;
    DLenable : in STD_LOGIC;
    ValidOut : out STD_LOGIC;
    timestamp : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end TDCchannel_0;

architecture stub of TDCchannel_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,hit,DLenable,ValidOut,timestamp[31:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "TDCchannel,Vivado 2018.3";
begin
end;
