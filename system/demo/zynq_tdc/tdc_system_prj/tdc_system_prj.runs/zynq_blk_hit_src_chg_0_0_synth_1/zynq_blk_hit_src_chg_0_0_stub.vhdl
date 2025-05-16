-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Thu Jul 11 20:13:50 2024
-- Host        : DESKTOP-L5QOME4 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ zynq_blk_hit_src_chg_0_0_stub.vhdl
-- Design      : zynq_blk_hit_src_chg_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  Port ( 
    hit : in STD_LOGIC;
    clk_i_p : in STD_LOGIC;
    clk_i_n : in STD_LOGIC;
    clk_calib : in STD_LOGIC;
    channel : in STD_LOGIC;
    hitO : out STD_LOGIC
  );

end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture stub of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "hit,clk_i_p,clk_i_n,clk_calib,channel,hitO";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "hit_src_chg,Vivado 2018.3";
begin
end;
