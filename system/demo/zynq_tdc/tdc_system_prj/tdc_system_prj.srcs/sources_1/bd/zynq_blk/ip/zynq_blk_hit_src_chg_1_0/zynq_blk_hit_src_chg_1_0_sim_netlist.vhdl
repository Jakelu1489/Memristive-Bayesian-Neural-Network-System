-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Thu Jul 11 20:13:50 2024
-- Host        : DESKTOP-L5QOME4 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               D:/zynq_tdc/tdc_system_prj/tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_hit_src_chg_1_0/zynq_blk_hit_src_chg_1_0_sim_netlist.vhdl
-- Design      : zynq_blk_hit_src_chg_1_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity zynq_blk_hit_src_chg_1_0_hit_src_chg is
  port (
    hitO : out STD_LOGIC;
    clk_i_p : in STD_LOGIC;
    clk_i_n : in STD_LOGIC;
    clk_calib : in STD_LOGIC;
    channel : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of zynq_blk_hit_src_chg_1_0_hit_src_chg : entity is "hit_src_chg";
end zynq_blk_hit_src_chg_1_0_hit_src_chg;

architecture STRUCTURE of zynq_blk_hit_src_chg_1_0_hit_src_chg is
  signal clk_i : STD_LOGIC;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of HIT_CLK_U : label is "PRIMITIVE";
  attribute CAPACITANCE : string;
  attribute CAPACITANCE of HIT_CLK_U : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE : string;
  attribute IBUF_DELAY_VALUE of HIT_CLK_U : label is "0";
  attribute IFD_DELAY_VALUE : string;
  attribute IFD_DELAY_VALUE of HIT_CLK_U : label is "AUTO";
begin
HIT_CLK_U: unisim.vcomponents.IBUFDS
    generic map(
      IOSTANDARD => "DEFAULT"
    )
        port map (
      I => clk_i_p,
      IB => clk_i_n,
      O => clk_i
    );
hitO_INST_0: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => clk_calib,
      I1 => channel,
      I2 => clk_i,
      O => hitO
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity zynq_blk_hit_src_chg_1_0 is
  port (
    hit : in STD_LOGIC;
    clk_i_p : in STD_LOGIC;
    clk_i_n : in STD_LOGIC;
    clk_calib : in STD_LOGIC;
    channel : in STD_LOGIC;
    hitO : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of zynq_blk_hit_src_chg_1_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of zynq_blk_hit_src_chg_1_0 : entity is "zynq_blk_hit_src_chg_1_0,hit_src_chg,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of zynq_blk_hit_src_chg_1_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of zynq_blk_hit_src_chg_1_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of zynq_blk_hit_src_chg_1_0 : entity is "hit_src_chg,Vivado 2018.3";
end zynq_blk_hit_src_chg_1_0;

architecture STRUCTURE of zynq_blk_hit_src_chg_1_0 is
begin
inst: entity work.zynq_blk_hit_src_chg_1_0_hit_src_chg
     port map (
      channel => channel,
      clk_calib => clk_calib,
      clk_i_n => clk_i_n,
      clk_i_p => clk_i_p,
      hitO => hitO
    );
end STRUCTURE;
