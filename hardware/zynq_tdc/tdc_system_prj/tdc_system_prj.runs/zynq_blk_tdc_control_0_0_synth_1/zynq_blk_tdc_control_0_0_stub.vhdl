-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Mon Jun 10 15:19:55 2024
-- Host        : DESKTOP-QJLKIHB running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ zynq_blk_tdc_control_0_0_stub.vhdl
-- Design      : zynq_blk_tdc_control_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  Port ( 
    clk : in STD_LOGIC;
    rst_n : in STD_LOGIC;
    ValidOutStart : in STD_LOGIC;
    ValidOutStop : in STD_LOGIC;
    timestampStart : in STD_LOGIC_VECTOR ( 31 downto 0 );
    timestampStop : in STD_LOGIC_VECTOR ( 31 downto 0 );
    DLenable : out STD_LOGIC;
    run : in STD_LOGIC;
    calib_en : in STD_LOGIC;
    calibing_flag : out STD_LOGIC;
    calib_finished : out STD_LOGIC;
    hit_source : out STD_LOGIC;
    axis_tready : in STD_LOGIC;
    axis_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    axis_tkeep : out STD_LOGIC_VECTOR ( 7 downto 0 );
    axis_tlast : out STD_LOGIC;
    axis_tvalid : out STD_LOGIC
  );

end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture stub of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,rst_n,ValidOutStart,ValidOutStop,timestampStart[31:0],timestampStop[31:0],DLenable,run,calib_en,calibing_flag,calib_finished,hit_source,axis_tready,axis_tdata[63:0],axis_tkeep[7:0],axis_tlast,axis_tvalid";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "tdc_control,Vivado 2018.3";
begin
end;
