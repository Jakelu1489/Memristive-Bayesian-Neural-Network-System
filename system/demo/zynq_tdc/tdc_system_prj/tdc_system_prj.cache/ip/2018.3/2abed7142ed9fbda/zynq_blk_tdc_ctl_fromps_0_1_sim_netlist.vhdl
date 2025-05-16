-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sat Jun  1 23:15:21 2024
-- Host        : DESKTOP-QJLKIHB running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ zynq_blk_tdc_ctl_fromps_0_1_sim_netlist.vhdl
-- Design      : zynq_blk_tdc_ctl_fromps_0_1
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tdc_ctl_fromps_v1_0_S00_AXI is
  port (
    \out\ : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_wready : out STD_LOGIC;
    s00_axi_awready : out STD_LOGIC;
    s00_axi_arready : out STD_LOGIC;
    s00_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_bvalid : out STD_LOGIC;
    s00_axi_rvalid : out STD_LOGIC;
    tdc_calib_finish : in STD_LOGIC;
    tdc_calibing : in STD_LOGIC;
    s00_axi_aclk : in STD_LOGIC;
    s00_axi_awaddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_wvalid : in STD_LOGIC;
    s00_axi_awvalid : in STD_LOGIC;
    s00_axi_araddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_arvalid : in STD_LOGIC;
    clk_sys : in STD_LOGIC;
    s00_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s00_axi_aresetn : in STD_LOGIC;
    s00_axi_bready : in STD_LOGIC;
    s00_axi_rready : in STD_LOGIC
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tdc_ctl_fromps_v1_0_S00_AXI;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tdc_ctl_fromps_v1_0_S00_AXI is
  signal aw_en_i_1_n_0 : STD_LOGIC;
  signal aw_en_reg_n_0 : STD_LOGIC;
  signal axi_araddr : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \axi_araddr[2]_i_1_n_0\ : STD_LOGIC;
  signal \axi_araddr[3]_i_1_n_0\ : STD_LOGIC;
  signal axi_arready0 : STD_LOGIC;
  signal axi_awaddr : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \axi_awaddr[2]_i_1_n_0\ : STD_LOGIC;
  signal \axi_awaddr[3]_i_1_n_0\ : STD_LOGIC;
  signal \axi_awready0__0\ : STD_LOGIC;
  signal axi_bvalid_i_1_n_0 : STD_LOGIC;
  signal \axi_rdata[0]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[10]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[11]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[12]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[13]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[14]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[15]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[16]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[17]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[18]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[19]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[1]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[20]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[21]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[22]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[23]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[24]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[25]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[26]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[27]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[28]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[29]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[2]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[30]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[31]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[3]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[4]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[5]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[6]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[7]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[8]_i_1_n_0\ : STD_LOGIC;
  signal \axi_rdata[9]_i_1_n_0\ : STD_LOGIC;
  signal axi_rvalid_i_1_n_0 : STD_LOGIC;
  signal \axi_wready0__0\ : STD_LOGIC;
  signal out_sync_reg0 : STD_LOGIC_VECTOR ( 31 downto 0 );
  attribute async_reg : string;
  attribute async_reg of out_sync_reg0 : signal is "true";
  signal out_sync_reg01 : STD_LOGIC_VECTOR ( 31 downto 0 );
  attribute async_reg of out_sync_reg01 : signal is "true";
  signal p_0_in : STD_LOGIC;
  signal p_1_in : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \^s00_axi_arready\ : STD_LOGIC;
  signal \^s00_axi_awready\ : STD_LOGIC;
  signal \^s00_axi_bvalid\ : STD_LOGIC;
  signal \^s00_axi_rvalid\ : STD_LOGIC;
  signal \^s00_axi_wready\ : STD_LOGIC;
  signal slv_reg0 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \slv_reg_rden__0\ : STD_LOGIC;
  signal slv_reg_wren : STD_LOGIC;
  signal tdc_calib_finish_r : STD_LOGIC;
  attribute async_reg of tdc_calib_finish_r : signal is "true";
  signal tdc_calib_finish_r1 : STD_LOGIC;
  attribute async_reg of tdc_calib_finish_r1 : signal is "true";
  signal tdc_calibing_r : STD_LOGIC;
  attribute async_reg of tdc_calibing_r : signal is "true";
  signal tdc_calibing_r1 : STD_LOGIC;
  attribute async_reg of tdc_calibing_r1 : signal is "true";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \axi_araddr[2]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of axi_arready_i_1 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of axi_awready0 : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of axi_wready0 : label is "soft_lutpair1";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[0]\ : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of \out_sync_reg01_reg[0]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[10]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[10]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[11]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[11]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[12]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[12]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[13]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[13]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[14]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[14]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[15]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[15]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[16]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[16]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[17]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[17]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[18]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[18]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[19]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[19]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[1]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[1]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[20]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[20]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[21]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[21]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[22]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[22]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[23]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[23]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[24]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[24]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[25]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[25]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[26]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[26]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[27]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[27]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[28]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[28]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[29]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[29]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[2]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[2]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[30]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[30]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[31]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[31]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[3]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[3]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[4]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[4]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[5]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[5]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[6]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[6]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[7]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[7]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[8]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[8]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg01_reg[9]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg01_reg[9]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[0]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[0]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[10]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[10]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[11]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[11]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[12]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[12]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[13]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[13]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[14]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[14]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[15]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[15]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[16]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[16]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[17]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[17]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[18]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[18]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[19]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[19]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[1]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[1]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[20]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[20]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[21]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[21]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[22]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[22]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[23]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[23]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[24]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[24]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[25]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[25]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[26]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[26]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[27]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[27]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[28]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[28]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[29]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[29]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[2]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[2]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[30]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[30]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[31]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[31]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[3]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[3]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[4]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[4]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[5]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[5]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[6]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[6]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[7]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[7]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[8]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[8]\ : label is "yes";
  attribute ASYNC_REG_boolean of \out_sync_reg0_reg[9]\ : label is std.standard.true;
  attribute KEEP of \out_sync_reg0_reg[9]\ : label is "yes";
  attribute ASYNC_REG_boolean of tdc_calib_finish_r1_reg : label is std.standard.true;
  attribute KEEP of tdc_calib_finish_r1_reg : label is "yes";
  attribute ASYNC_REG_boolean of tdc_calib_finish_r_reg : label is std.standard.true;
  attribute KEEP of tdc_calib_finish_r_reg : label is "yes";
  attribute ASYNC_REG_boolean of tdc_calibing_r1_reg : label is std.standard.true;
  attribute KEEP of tdc_calibing_r1_reg : label is "yes";
  attribute ASYNC_REG_boolean of tdc_calibing_r_reg : label is std.standard.true;
  attribute KEEP of tdc_calibing_r_reg : label is "yes";
begin
  \out\(1 downto 0) <= out_sync_reg01(1 downto 0);
  s00_axi_arready <= \^s00_axi_arready\;
  s00_axi_awready <= \^s00_axi_awready\;
  s00_axi_bvalid <= \^s00_axi_bvalid\;
  s00_axi_rvalid <= \^s00_axi_rvalid\;
  s00_axi_wready <= \^s00_axi_wready\;
aw_en_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F7FFC4CCC4CCC4CC"
    )
        port map (
      I0 => s00_axi_awvalid,
      I1 => aw_en_reg_n_0,
      I2 => \^s00_axi_awready\,
      I3 => s00_axi_wvalid,
      I4 => s00_axi_bready,
      I5 => \^s00_axi_bvalid\,
      O => aw_en_i_1_n_0
    );
aw_en_reg: unisim.vcomponents.FDSE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => aw_en_i_1_n_0,
      Q => aw_en_reg_n_0,
      S => p_0_in
    );
\axi_araddr[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s00_axi_araddr(0),
      I1 => s00_axi_arvalid,
      I2 => \^s00_axi_arready\,
      I3 => axi_araddr(2),
      O => \axi_araddr[2]_i_1_n_0\
    );
\axi_araddr[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s00_axi_araddr(1),
      I1 => s00_axi_arvalid,
      I2 => \^s00_axi_arready\,
      I3 => axi_araddr(3),
      O => \axi_araddr[3]_i_1_n_0\
    );
\axi_araddr_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \axi_araddr[2]_i_1_n_0\,
      Q => axi_araddr(2),
      R => p_0_in
    );
\axi_araddr_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \axi_araddr[3]_i_1_n_0\,
      Q => axi_araddr(3),
      R => p_0_in
    );
axi_arready_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => s00_axi_arvalid,
      I1 => \^s00_axi_arready\,
      O => axi_arready0
    );
axi_arready_reg: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => axi_arready0,
      Q => \^s00_axi_arready\,
      R => p_0_in
    );
\axi_awaddr[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FBFFFFFF08000000"
    )
        port map (
      I0 => s00_axi_awaddr(0),
      I1 => s00_axi_wvalid,
      I2 => \^s00_axi_awready\,
      I3 => aw_en_reg_n_0,
      I4 => s00_axi_awvalid,
      I5 => axi_awaddr(2),
      O => \axi_awaddr[2]_i_1_n_0\
    );
\axi_awaddr[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FBFFFFFF08000000"
    )
        port map (
      I0 => s00_axi_awaddr(1),
      I1 => s00_axi_wvalid,
      I2 => \^s00_axi_awready\,
      I3 => aw_en_reg_n_0,
      I4 => s00_axi_awvalid,
      I5 => axi_awaddr(3),
      O => \axi_awaddr[3]_i_1_n_0\
    );
\axi_awaddr_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \axi_awaddr[2]_i_1_n_0\,
      Q => axi_awaddr(2),
      R => p_0_in
    );
\axi_awaddr_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \axi_awaddr[3]_i_1_n_0\,
      Q => axi_awaddr(3),
      R => p_0_in
    );
axi_awready0: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2000"
    )
        port map (
      I0 => s00_axi_wvalid,
      I1 => \^s00_axi_awready\,
      I2 => aw_en_reg_n_0,
      I3 => s00_axi_awvalid,
      O => \axi_awready0__0\
    );
axi_awready_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => s00_axi_aresetn,
      O => p_0_in
    );
axi_awready_reg: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \axi_awready0__0\,
      Q => \^s00_axi_awready\,
      R => p_0_in
    );
axi_bvalid_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FFFF80008000"
    )
        port map (
      I0 => s00_axi_awvalid,
      I1 => s00_axi_wvalid,
      I2 => \^s00_axi_awready\,
      I3 => \^s00_axi_wready\,
      I4 => s00_axi_bready,
      I5 => \^s00_axi_bvalid\,
      O => axi_bvalid_i_1_n_0
    );
axi_bvalid_reg: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => axi_bvalid_i_1_n_0,
      Q => \^s00_axi_bvalid\,
      R => p_0_in
    );
\axi_rdata[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
        port map (
      I0 => slv_reg0(0),
      I1 => axi_araddr(2),
      I2 => tdc_calib_finish_r1,
      I3 => axi_araddr(3),
      O => \axi_rdata[0]_i_1_n_0\
    );
\axi_rdata[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(10),
      I2 => axi_araddr(3),
      O => \axi_rdata[10]_i_1_n_0\
    );
\axi_rdata[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(11),
      I2 => axi_araddr(3),
      O => \axi_rdata[11]_i_1_n_0\
    );
\axi_rdata[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(12),
      I2 => axi_araddr(3),
      O => \axi_rdata[12]_i_1_n_0\
    );
\axi_rdata[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(13),
      I2 => axi_araddr(3),
      O => \axi_rdata[13]_i_1_n_0\
    );
\axi_rdata[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(14),
      I2 => axi_araddr(3),
      O => \axi_rdata[14]_i_1_n_0\
    );
\axi_rdata[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(15),
      I2 => axi_araddr(3),
      O => \axi_rdata[15]_i_1_n_0\
    );
\axi_rdata[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(16),
      I2 => axi_araddr(3),
      O => \axi_rdata[16]_i_1_n_0\
    );
\axi_rdata[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(17),
      I2 => axi_araddr(3),
      O => \axi_rdata[17]_i_1_n_0\
    );
\axi_rdata[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(18),
      I2 => axi_araddr(3),
      O => \axi_rdata[18]_i_1_n_0\
    );
\axi_rdata[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(19),
      I2 => axi_araddr(3),
      O => \axi_rdata[19]_i_1_n_0\
    );
\axi_rdata[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
        port map (
      I0 => slv_reg0(1),
      I1 => axi_araddr(2),
      I2 => tdc_calibing_r1,
      I3 => axi_araddr(3),
      O => \axi_rdata[1]_i_1_n_0\
    );
\axi_rdata[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(20),
      I2 => axi_araddr(3),
      O => \axi_rdata[20]_i_1_n_0\
    );
\axi_rdata[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(21),
      I2 => axi_araddr(3),
      O => \axi_rdata[21]_i_1_n_0\
    );
\axi_rdata[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(22),
      I2 => axi_araddr(3),
      O => \axi_rdata[22]_i_1_n_0\
    );
\axi_rdata[23]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(23),
      I2 => axi_araddr(3),
      O => \axi_rdata[23]_i_1_n_0\
    );
\axi_rdata[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(24),
      I2 => axi_araddr(3),
      O => \axi_rdata[24]_i_1_n_0\
    );
\axi_rdata[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(25),
      I2 => axi_araddr(3),
      O => \axi_rdata[25]_i_1_n_0\
    );
\axi_rdata[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(26),
      I2 => axi_araddr(3),
      O => \axi_rdata[26]_i_1_n_0\
    );
\axi_rdata[27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(27),
      I2 => axi_araddr(3),
      O => \axi_rdata[27]_i_1_n_0\
    );
\axi_rdata[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(28),
      I2 => axi_araddr(3),
      O => \axi_rdata[28]_i_1_n_0\
    );
\axi_rdata[29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(29),
      I2 => axi_araddr(3),
      O => \axi_rdata[29]_i_1_n_0\
    );
\axi_rdata[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(2),
      I2 => axi_araddr(3),
      O => \axi_rdata[2]_i_1_n_0\
    );
\axi_rdata[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(30),
      I2 => axi_araddr(3),
      O => \axi_rdata[30]_i_1_n_0\
    );
\axi_rdata[31]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(31),
      I2 => axi_araddr(3),
      O => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(3),
      I2 => axi_araddr(3),
      O => \axi_rdata[3]_i_1_n_0\
    );
\axi_rdata[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(4),
      I2 => axi_araddr(3),
      O => \axi_rdata[4]_i_1_n_0\
    );
\axi_rdata[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(5),
      I2 => axi_araddr(3),
      O => \axi_rdata[5]_i_1_n_0\
    );
\axi_rdata[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(6),
      I2 => axi_araddr(3),
      O => \axi_rdata[6]_i_1_n_0\
    );
\axi_rdata[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(7),
      I2 => axi_araddr(3),
      O => \axi_rdata[7]_i_1_n_0\
    );
\axi_rdata[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(8),
      I2 => axi_araddr(3),
      O => \axi_rdata[8]_i_1_n_0\
    );
\axi_rdata[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => axi_araddr(2),
      I1 => slv_reg0(9),
      I2 => axi_araddr(3),
      O => \axi_rdata[9]_i_1_n_0\
    );
\axi_rdata_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[0]_i_1_n_0\,
      Q => s00_axi_rdata(0),
      R => p_0_in
    );
\axi_rdata_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[10]_i_1_n_0\,
      Q => s00_axi_rdata(10),
      R => p_0_in
    );
\axi_rdata_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[11]_i_1_n_0\,
      Q => s00_axi_rdata(11),
      R => p_0_in
    );
\axi_rdata_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[12]_i_1_n_0\,
      Q => s00_axi_rdata(12),
      R => p_0_in
    );
\axi_rdata_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[13]_i_1_n_0\,
      Q => s00_axi_rdata(13),
      R => p_0_in
    );
\axi_rdata_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[14]_i_1_n_0\,
      Q => s00_axi_rdata(14),
      R => p_0_in
    );
\axi_rdata_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[15]_i_1_n_0\,
      Q => s00_axi_rdata(15),
      R => p_0_in
    );
\axi_rdata_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[16]_i_1_n_0\,
      Q => s00_axi_rdata(16),
      R => p_0_in
    );
\axi_rdata_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[17]_i_1_n_0\,
      Q => s00_axi_rdata(17),
      R => p_0_in
    );
\axi_rdata_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[18]_i_1_n_0\,
      Q => s00_axi_rdata(18),
      R => p_0_in
    );
\axi_rdata_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[19]_i_1_n_0\,
      Q => s00_axi_rdata(19),
      R => p_0_in
    );
\axi_rdata_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[1]_i_1_n_0\,
      Q => s00_axi_rdata(1),
      R => p_0_in
    );
\axi_rdata_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[20]_i_1_n_0\,
      Q => s00_axi_rdata(20),
      R => p_0_in
    );
\axi_rdata_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[21]_i_1_n_0\,
      Q => s00_axi_rdata(21),
      R => p_0_in
    );
\axi_rdata_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[22]_i_1_n_0\,
      Q => s00_axi_rdata(22),
      R => p_0_in
    );
\axi_rdata_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[23]_i_1_n_0\,
      Q => s00_axi_rdata(23),
      R => p_0_in
    );
\axi_rdata_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[24]_i_1_n_0\,
      Q => s00_axi_rdata(24),
      R => p_0_in
    );
\axi_rdata_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[25]_i_1_n_0\,
      Q => s00_axi_rdata(25),
      R => p_0_in
    );
\axi_rdata_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[26]_i_1_n_0\,
      Q => s00_axi_rdata(26),
      R => p_0_in
    );
\axi_rdata_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[27]_i_1_n_0\,
      Q => s00_axi_rdata(27),
      R => p_0_in
    );
\axi_rdata_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[28]_i_1_n_0\,
      Q => s00_axi_rdata(28),
      R => p_0_in
    );
\axi_rdata_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[29]_i_1_n_0\,
      Q => s00_axi_rdata(29),
      R => p_0_in
    );
\axi_rdata_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[2]_i_1_n_0\,
      Q => s00_axi_rdata(2),
      R => p_0_in
    );
\axi_rdata_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[30]_i_1_n_0\,
      Q => s00_axi_rdata(30),
      R => p_0_in
    );
\axi_rdata_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[31]_i_1_n_0\,
      Q => s00_axi_rdata(31),
      R => p_0_in
    );
\axi_rdata_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[3]_i_1_n_0\,
      Q => s00_axi_rdata(3),
      R => p_0_in
    );
\axi_rdata_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[4]_i_1_n_0\,
      Q => s00_axi_rdata(4),
      R => p_0_in
    );
\axi_rdata_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[5]_i_1_n_0\,
      Q => s00_axi_rdata(5),
      R => p_0_in
    );
\axi_rdata_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[6]_i_1_n_0\,
      Q => s00_axi_rdata(6),
      R => p_0_in
    );
\axi_rdata_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[7]_i_1_n_0\,
      Q => s00_axi_rdata(7),
      R => p_0_in
    );
\axi_rdata_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[8]_i_1_n_0\,
      Q => s00_axi_rdata(8),
      R => p_0_in
    );
\axi_rdata_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg_rden__0\,
      D => \axi_rdata[9]_i_1_n_0\,
      Q => s00_axi_rdata(9),
      R => p_0_in
    );
axi_rvalid_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"08F8"
    )
        port map (
      I0 => \^s00_axi_arready\,
      I1 => s00_axi_arvalid,
      I2 => \^s00_axi_rvalid\,
      I3 => s00_axi_rready,
      O => axi_rvalid_i_1_n_0
    );
axi_rvalid_reg: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => axi_rvalid_i_1_n_0,
      Q => \^s00_axi_rvalid\,
      R => p_0_in
    );
axi_wready0: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => s00_axi_awvalid,
      I1 => s00_axi_wvalid,
      I2 => \^s00_axi_wready\,
      I3 => aw_en_reg_n_0,
      O => \axi_wready0__0\
    );
axi_wready_reg: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \axi_wready0__0\,
      Q => \^s00_axi_wready\,
      R => p_0_in
    );
\out_sync_reg01_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(0),
      Q => out_sync_reg01(0),
      R => '0'
    );
\out_sync_reg01_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(10),
      Q => out_sync_reg01(10),
      R => '0'
    );
\out_sync_reg01_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(11),
      Q => out_sync_reg01(11),
      R => '0'
    );
\out_sync_reg01_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(12),
      Q => out_sync_reg01(12),
      R => '0'
    );
\out_sync_reg01_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(13),
      Q => out_sync_reg01(13),
      R => '0'
    );
\out_sync_reg01_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(14),
      Q => out_sync_reg01(14),
      R => '0'
    );
\out_sync_reg01_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(15),
      Q => out_sync_reg01(15),
      R => '0'
    );
\out_sync_reg01_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(16),
      Q => out_sync_reg01(16),
      R => '0'
    );
\out_sync_reg01_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(17),
      Q => out_sync_reg01(17),
      R => '0'
    );
\out_sync_reg01_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(18),
      Q => out_sync_reg01(18),
      R => '0'
    );
\out_sync_reg01_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(19),
      Q => out_sync_reg01(19),
      R => '0'
    );
\out_sync_reg01_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(1),
      Q => out_sync_reg01(1),
      R => '0'
    );
\out_sync_reg01_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(20),
      Q => out_sync_reg01(20),
      R => '0'
    );
\out_sync_reg01_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(21),
      Q => out_sync_reg01(21),
      R => '0'
    );
\out_sync_reg01_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(22),
      Q => out_sync_reg01(22),
      R => '0'
    );
\out_sync_reg01_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(23),
      Q => out_sync_reg01(23),
      R => '0'
    );
\out_sync_reg01_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(24),
      Q => out_sync_reg01(24),
      R => '0'
    );
\out_sync_reg01_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(25),
      Q => out_sync_reg01(25),
      R => '0'
    );
\out_sync_reg01_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(26),
      Q => out_sync_reg01(26),
      R => '0'
    );
\out_sync_reg01_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(27),
      Q => out_sync_reg01(27),
      R => '0'
    );
\out_sync_reg01_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(28),
      Q => out_sync_reg01(28),
      R => '0'
    );
\out_sync_reg01_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(29),
      Q => out_sync_reg01(29),
      R => '0'
    );
\out_sync_reg01_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(2),
      Q => out_sync_reg01(2),
      R => '0'
    );
\out_sync_reg01_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(30),
      Q => out_sync_reg01(30),
      R => '0'
    );
\out_sync_reg01_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(31),
      Q => out_sync_reg01(31),
      R => '0'
    );
\out_sync_reg01_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(3),
      Q => out_sync_reg01(3),
      R => '0'
    );
\out_sync_reg01_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(4),
      Q => out_sync_reg01(4),
      R => '0'
    );
\out_sync_reg01_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(5),
      Q => out_sync_reg01(5),
      R => '0'
    );
\out_sync_reg01_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(6),
      Q => out_sync_reg01(6),
      R => '0'
    );
\out_sync_reg01_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(7),
      Q => out_sync_reg01(7),
      R => '0'
    );
\out_sync_reg01_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(8),
      Q => out_sync_reg01(8),
      R => '0'
    );
\out_sync_reg01_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => out_sync_reg0(9),
      Q => out_sync_reg01(9),
      R => '0'
    );
\out_sync_reg0_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(0),
      Q => out_sync_reg0(0),
      R => '0'
    );
\out_sync_reg0_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(10),
      Q => out_sync_reg0(10),
      R => '0'
    );
\out_sync_reg0_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(11),
      Q => out_sync_reg0(11),
      R => '0'
    );
\out_sync_reg0_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(12),
      Q => out_sync_reg0(12),
      R => '0'
    );
\out_sync_reg0_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(13),
      Q => out_sync_reg0(13),
      R => '0'
    );
\out_sync_reg0_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(14),
      Q => out_sync_reg0(14),
      R => '0'
    );
\out_sync_reg0_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(15),
      Q => out_sync_reg0(15),
      R => '0'
    );
\out_sync_reg0_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(16),
      Q => out_sync_reg0(16),
      R => '0'
    );
\out_sync_reg0_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(17),
      Q => out_sync_reg0(17),
      R => '0'
    );
\out_sync_reg0_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(18),
      Q => out_sync_reg0(18),
      R => '0'
    );
\out_sync_reg0_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(19),
      Q => out_sync_reg0(19),
      R => '0'
    );
\out_sync_reg0_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(1),
      Q => out_sync_reg0(1),
      R => '0'
    );
\out_sync_reg0_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(20),
      Q => out_sync_reg0(20),
      R => '0'
    );
\out_sync_reg0_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(21),
      Q => out_sync_reg0(21),
      R => '0'
    );
\out_sync_reg0_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(22),
      Q => out_sync_reg0(22),
      R => '0'
    );
\out_sync_reg0_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(23),
      Q => out_sync_reg0(23),
      R => '0'
    );
\out_sync_reg0_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(24),
      Q => out_sync_reg0(24),
      R => '0'
    );
\out_sync_reg0_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(25),
      Q => out_sync_reg0(25),
      R => '0'
    );
\out_sync_reg0_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(26),
      Q => out_sync_reg0(26),
      R => '0'
    );
\out_sync_reg0_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(27),
      Q => out_sync_reg0(27),
      R => '0'
    );
\out_sync_reg0_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(28),
      Q => out_sync_reg0(28),
      R => '0'
    );
\out_sync_reg0_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(29),
      Q => out_sync_reg0(29),
      R => '0'
    );
\out_sync_reg0_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(2),
      Q => out_sync_reg0(2),
      R => '0'
    );
\out_sync_reg0_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(30),
      Q => out_sync_reg0(30),
      R => '0'
    );
\out_sync_reg0_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(31),
      Q => out_sync_reg0(31),
      R => '0'
    );
\out_sync_reg0_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(3),
      Q => out_sync_reg0(3),
      R => '0'
    );
\out_sync_reg0_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(4),
      Q => out_sync_reg0(4),
      R => '0'
    );
\out_sync_reg0_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(5),
      Q => out_sync_reg0(5),
      R => '0'
    );
\out_sync_reg0_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(6),
      Q => out_sync_reg0(6),
      R => '0'
    );
\out_sync_reg0_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(7),
      Q => out_sync_reg0(7),
      R => '0'
    );
\out_sync_reg0_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(8),
      Q => out_sync_reg0(8),
      R => '0'
    );
\out_sync_reg0_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk_sys,
      CE => '1',
      D => slv_reg0(9),
      Q => out_sync_reg0(9),
      R => '0'
    );
\slv_reg0[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(0),
      I1 => s00_axi_wstrb(0),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(0),
      O => p_1_in(0)
    );
\slv_reg0[10]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(10),
      I1 => s00_axi_wstrb(1),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(10),
      O => p_1_in(10)
    );
\slv_reg0[11]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(11),
      I1 => s00_axi_wstrb(1),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(11),
      O => p_1_in(11)
    );
\slv_reg0[12]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(12),
      I1 => s00_axi_wstrb(1),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(12),
      O => p_1_in(12)
    );
\slv_reg0[13]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(13),
      I1 => s00_axi_wstrb(1),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(13),
      O => p_1_in(13)
    );
\slv_reg0[14]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(14),
      I1 => s00_axi_wstrb(1),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(14),
      O => p_1_in(14)
    );
\slv_reg0[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(15),
      I1 => s00_axi_wstrb(1),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(15),
      O => p_1_in(15)
    );
\slv_reg0[16]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(16),
      I1 => s00_axi_wstrb(2),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(16),
      O => p_1_in(16)
    );
\slv_reg0[17]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(17),
      I1 => s00_axi_wstrb(2),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(17),
      O => p_1_in(17)
    );
\slv_reg0[18]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(18),
      I1 => s00_axi_wstrb(2),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(18),
      O => p_1_in(18)
    );
\slv_reg0[19]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(19),
      I1 => s00_axi_wstrb(2),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(19),
      O => p_1_in(19)
    );
\slv_reg0[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(1),
      I1 => s00_axi_wstrb(0),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(1),
      O => p_1_in(1)
    );
\slv_reg0[20]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(20),
      I1 => s00_axi_wstrb(2),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(20),
      O => p_1_in(20)
    );
\slv_reg0[21]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(21),
      I1 => s00_axi_wstrb(2),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(21),
      O => p_1_in(21)
    );
\slv_reg0[22]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(22),
      I1 => s00_axi_wstrb(2),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(22),
      O => p_1_in(22)
    );
\slv_reg0[23]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(23),
      I1 => s00_axi_wstrb(2),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(23),
      O => p_1_in(23)
    );
\slv_reg0[24]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(24),
      I1 => s00_axi_wstrb(3),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(24),
      O => p_1_in(24)
    );
\slv_reg0[25]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(25),
      I1 => s00_axi_wstrb(3),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(25),
      O => p_1_in(25)
    );
\slv_reg0[26]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(26),
      I1 => s00_axi_wstrb(3),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(26),
      O => p_1_in(26)
    );
\slv_reg0[27]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(27),
      I1 => s00_axi_wstrb(3),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(27),
      O => p_1_in(27)
    );
\slv_reg0[28]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(28),
      I1 => s00_axi_wstrb(3),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(28),
      O => p_1_in(28)
    );
\slv_reg0[29]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(29),
      I1 => s00_axi_wstrb(3),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(29),
      O => p_1_in(29)
    );
\slv_reg0[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(2),
      I1 => s00_axi_wstrb(0),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(2),
      O => p_1_in(2)
    );
\slv_reg0[30]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(30),
      I1 => s00_axi_wstrb(3),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(30),
      O => p_1_in(30)
    );
\slv_reg0[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => \^s00_axi_wready\,
      I1 => \^s00_axi_awready\,
      I2 => s00_axi_awvalid,
      I3 => s00_axi_wvalid,
      O => slv_reg_wren
    );
\slv_reg0[31]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(31),
      I1 => s00_axi_wstrb(3),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(31),
      O => p_1_in(31)
    );
\slv_reg0[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(3),
      I1 => s00_axi_wstrb(0),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(3),
      O => p_1_in(3)
    );
\slv_reg0[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(4),
      I1 => s00_axi_wstrb(0),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(4),
      O => p_1_in(4)
    );
\slv_reg0[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(5),
      I1 => s00_axi_wstrb(0),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(5),
      O => p_1_in(5)
    );
\slv_reg0[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(6),
      I1 => s00_axi_wstrb(0),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(6),
      O => p_1_in(6)
    );
\slv_reg0[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(7),
      I1 => s00_axi_wstrb(0),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(7),
      O => p_1_in(7)
    );
\slv_reg0[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(8),
      I1 => s00_axi_wstrb(1),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(8),
      O => p_1_in(8)
    );
\slv_reg0[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s00_axi_wdata(9),
      I1 => s00_axi_wstrb(1),
      I2 => axi_awaddr(2),
      I3 => axi_awaddr(3),
      I4 => slv_reg0(9),
      O => p_1_in(9)
    );
\slv_reg0_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(0),
      Q => slv_reg0(0),
      R => p_0_in
    );
\slv_reg0_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(10),
      Q => slv_reg0(10),
      R => p_0_in
    );
\slv_reg0_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(11),
      Q => slv_reg0(11),
      R => p_0_in
    );
\slv_reg0_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(12),
      Q => slv_reg0(12),
      R => p_0_in
    );
\slv_reg0_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(13),
      Q => slv_reg0(13),
      R => p_0_in
    );
\slv_reg0_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(14),
      Q => slv_reg0(14),
      R => p_0_in
    );
\slv_reg0_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(15),
      Q => slv_reg0(15),
      R => p_0_in
    );
\slv_reg0_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(16),
      Q => slv_reg0(16),
      R => p_0_in
    );
\slv_reg0_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(17),
      Q => slv_reg0(17),
      R => p_0_in
    );
\slv_reg0_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(18),
      Q => slv_reg0(18),
      R => p_0_in
    );
\slv_reg0_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(19),
      Q => slv_reg0(19),
      R => p_0_in
    );
\slv_reg0_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(1),
      Q => slv_reg0(1),
      R => p_0_in
    );
\slv_reg0_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(20),
      Q => slv_reg0(20),
      R => p_0_in
    );
\slv_reg0_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(21),
      Q => slv_reg0(21),
      R => p_0_in
    );
\slv_reg0_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(22),
      Q => slv_reg0(22),
      R => p_0_in
    );
\slv_reg0_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(23),
      Q => slv_reg0(23),
      R => p_0_in
    );
\slv_reg0_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(24),
      Q => slv_reg0(24),
      R => p_0_in
    );
\slv_reg0_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(25),
      Q => slv_reg0(25),
      R => p_0_in
    );
\slv_reg0_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(26),
      Q => slv_reg0(26),
      R => p_0_in
    );
\slv_reg0_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(27),
      Q => slv_reg0(27),
      R => p_0_in
    );
\slv_reg0_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(28),
      Q => slv_reg0(28),
      R => p_0_in
    );
\slv_reg0_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(29),
      Q => slv_reg0(29),
      R => p_0_in
    );
\slv_reg0_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(2),
      Q => slv_reg0(2),
      R => p_0_in
    );
\slv_reg0_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(30),
      Q => slv_reg0(30),
      R => p_0_in
    );
\slv_reg0_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(31),
      Q => slv_reg0(31),
      R => p_0_in
    );
\slv_reg0_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(3),
      Q => slv_reg0(3),
      R => p_0_in
    );
\slv_reg0_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(4),
      Q => slv_reg0(4),
      R => p_0_in
    );
\slv_reg0_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(5),
      Q => slv_reg0(5),
      R => p_0_in
    );
\slv_reg0_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(6),
      Q => slv_reg0(6),
      R => p_0_in
    );
\slv_reg0_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(7),
      Q => slv_reg0(7),
      R => p_0_in
    );
\slv_reg0_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(8),
      Q => slv_reg0(8),
      R => p_0_in
    );
\slv_reg0_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => slv_reg_wren,
      D => p_1_in(9),
      Q => slv_reg0(9),
      R => p_0_in
    );
slv_reg_rden: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => s00_axi_arvalid,
      I1 => \^s00_axi_rvalid\,
      I2 => \^s00_axi_arready\,
      O => \slv_reg_rden__0\
    );
tdc_calib_finish_r1_reg: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => tdc_calib_finish_r,
      Q => tdc_calib_finish_r1,
      R => '0'
    );
tdc_calib_finish_r_reg: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => tdc_calib_finish,
      Q => tdc_calib_finish_r,
      R => '0'
    );
tdc_calibing_r1_reg: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => tdc_calibing_r,
      Q => tdc_calibing_r1,
      R => '0'
    );
tdc_calibing_r_reg: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => tdc_calibing,
      Q => tdc_calibing_r,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tdc_ctl_fromps_v1_0 is
  port (
    \out\ : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_WREADY : out STD_LOGIC;
    S_AXI_AWREADY : out STD_LOGIC;
    S_AXI_ARREADY : out STD_LOGIC;
    s00_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_bvalid : out STD_LOGIC;
    s00_axi_rvalid : out STD_LOGIC;
    tdc_calib_finish : in STD_LOGIC;
    tdc_calibing : in STD_LOGIC;
    s00_axi_aclk : in STD_LOGIC;
    s00_axi_awaddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_wvalid : in STD_LOGIC;
    s00_axi_awvalid : in STD_LOGIC;
    s00_axi_araddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_arvalid : in STD_LOGIC;
    clk_sys : in STD_LOGIC;
    s00_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s00_axi_aresetn : in STD_LOGIC;
    s00_axi_bready : in STD_LOGIC;
    s00_axi_rready : in STD_LOGIC
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tdc_ctl_fromps_v1_0;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tdc_ctl_fromps_v1_0 is
begin
tdc_ctl_fromps_v1_0_S00_AXI_inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tdc_ctl_fromps_v1_0_S00_AXI
     port map (
      clk_sys => clk_sys,
      \out\(1 downto 0) => \out\(1 downto 0),
      s00_axi_aclk => s00_axi_aclk,
      s00_axi_araddr(1 downto 0) => s00_axi_araddr(1 downto 0),
      s00_axi_aresetn => s00_axi_aresetn,
      s00_axi_arready => S_AXI_ARREADY,
      s00_axi_arvalid => s00_axi_arvalid,
      s00_axi_awaddr(1 downto 0) => s00_axi_awaddr(1 downto 0),
      s00_axi_awready => S_AXI_AWREADY,
      s00_axi_awvalid => s00_axi_awvalid,
      s00_axi_bready => s00_axi_bready,
      s00_axi_bvalid => s00_axi_bvalid,
      s00_axi_rdata(31 downto 0) => s00_axi_rdata(31 downto 0),
      s00_axi_rready => s00_axi_rready,
      s00_axi_rvalid => s00_axi_rvalid,
      s00_axi_wdata(31 downto 0) => s00_axi_wdata(31 downto 0),
      s00_axi_wready => S_AXI_WREADY,
      s00_axi_wstrb(3 downto 0) => s00_axi_wstrb(3 downto 0),
      s00_axi_wvalid => s00_axi_wvalid,
      tdc_calib_finish => tdc_calib_finish,
      tdc_calibing => tdc_calibing
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  port (
    clk_sys : in STD_LOGIC;
    s00_axi_awaddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s00_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s00_axi_awvalid : in STD_LOGIC;
    s00_axi_awready : out STD_LOGIC;
    s00_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s00_axi_wvalid : in STD_LOGIC;
    s00_axi_wready : out STD_LOGIC;
    s00_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_bvalid : out STD_LOGIC;
    s00_axi_bready : in STD_LOGIC;
    s00_axi_araddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s00_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s00_axi_arvalid : in STD_LOGIC;
    s00_axi_arready : out STD_LOGIC;
    s00_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_rvalid : out STD_LOGIC;
    s00_axi_rready : in STD_LOGIC;
    tdc_run : out STD_LOGIC;
    tdc_calib_en : out STD_LOGIC;
    tdc_calibing : in STD_LOGIC;
    tdc_calib_finish : in STD_LOGIC;
    s00_axi_aclk : in STD_LOGIC;
    s00_axi_aresetn : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "zynq_blk_tdc_ctl_fromps_0_1,tdc_ctl_fromps_v1_0,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "tdc_ctl_fromps_v1_0,Vivado 2018.3";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  signal \<const0>\ : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of s00_axi_aclk : signal is "xilinx.com:signal:clock:1.0 S00_AXI_CLK CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of s00_axi_aclk : signal is "XIL_INTERFACENAME S00_AXI_CLK, ASSOCIATED_BUSIF S00_AXI, ASSOCIATED_RESET s00_axi_aresetn, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN zynq_blk_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s00_axi_aresetn : signal is "xilinx.com:signal:reset:1.0 S00_AXI_RST RST";
  attribute X_INTERFACE_PARAMETER of s00_axi_aresetn : signal is "XIL_INTERFACENAME S00_AXI_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s00_axi_arready : signal is "xilinx.com:interface:aximm:1.0 S00_AXI ARREADY";
  attribute X_INTERFACE_INFO of s00_axi_arvalid : signal is "xilinx.com:interface:aximm:1.0 S00_AXI ARVALID";
  attribute X_INTERFACE_INFO of s00_axi_awready : signal is "xilinx.com:interface:aximm:1.0 S00_AXI AWREADY";
  attribute X_INTERFACE_INFO of s00_axi_awvalid : signal is "xilinx.com:interface:aximm:1.0 S00_AXI AWVALID";
  attribute X_INTERFACE_INFO of s00_axi_bready : signal is "xilinx.com:interface:aximm:1.0 S00_AXI BREADY";
  attribute X_INTERFACE_INFO of s00_axi_bvalid : signal is "xilinx.com:interface:aximm:1.0 S00_AXI BVALID";
  attribute X_INTERFACE_INFO of s00_axi_rready : signal is "xilinx.com:interface:aximm:1.0 S00_AXI RREADY";
  attribute X_INTERFACE_PARAMETER of s00_axi_rready : signal is "XIL_INTERFACENAME S00_AXI, WIZ_DATA_WIDTH 32, WIZ_NUM_REG 4, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 4, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN zynq_blk_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s00_axi_rvalid : signal is "xilinx.com:interface:aximm:1.0 S00_AXI RVALID";
  attribute X_INTERFACE_INFO of s00_axi_wready : signal is "xilinx.com:interface:aximm:1.0 S00_AXI WREADY";
  attribute X_INTERFACE_INFO of s00_axi_wvalid : signal is "xilinx.com:interface:aximm:1.0 S00_AXI WVALID";
  attribute X_INTERFACE_INFO of s00_axi_araddr : signal is "xilinx.com:interface:aximm:1.0 S00_AXI ARADDR";
  attribute X_INTERFACE_INFO of s00_axi_arprot : signal is "xilinx.com:interface:aximm:1.0 S00_AXI ARPROT";
  attribute X_INTERFACE_INFO of s00_axi_awaddr : signal is "xilinx.com:interface:aximm:1.0 S00_AXI AWADDR";
  attribute X_INTERFACE_INFO of s00_axi_awprot : signal is "xilinx.com:interface:aximm:1.0 S00_AXI AWPROT";
  attribute X_INTERFACE_INFO of s00_axi_bresp : signal is "xilinx.com:interface:aximm:1.0 S00_AXI BRESP";
  attribute X_INTERFACE_INFO of s00_axi_rdata : signal is "xilinx.com:interface:aximm:1.0 S00_AXI RDATA";
  attribute X_INTERFACE_INFO of s00_axi_rresp : signal is "xilinx.com:interface:aximm:1.0 S00_AXI RRESP";
  attribute X_INTERFACE_INFO of s00_axi_wdata : signal is "xilinx.com:interface:aximm:1.0 S00_AXI WDATA";
  attribute X_INTERFACE_INFO of s00_axi_wstrb : signal is "xilinx.com:interface:aximm:1.0 S00_AXI WSTRB";
begin
  s00_axi_bresp(1) <= \<const0>\;
  s00_axi_bresp(0) <= \<const0>\;
  s00_axi_rresp(1) <= \<const0>\;
  s00_axi_rresp(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tdc_ctl_fromps_v1_0
     port map (
      S_AXI_ARREADY => s00_axi_arready,
      S_AXI_AWREADY => s00_axi_awready,
      S_AXI_WREADY => s00_axi_wready,
      clk_sys => clk_sys,
      \out\(1) => tdc_calib_en,
      \out\(0) => tdc_run,
      s00_axi_aclk => s00_axi_aclk,
      s00_axi_araddr(1 downto 0) => s00_axi_araddr(3 downto 2),
      s00_axi_aresetn => s00_axi_aresetn,
      s00_axi_arvalid => s00_axi_arvalid,
      s00_axi_awaddr(1 downto 0) => s00_axi_awaddr(3 downto 2),
      s00_axi_awvalid => s00_axi_awvalid,
      s00_axi_bready => s00_axi_bready,
      s00_axi_bvalid => s00_axi_bvalid,
      s00_axi_rdata(31 downto 0) => s00_axi_rdata(31 downto 0),
      s00_axi_rready => s00_axi_rready,
      s00_axi_rvalid => s00_axi_rvalid,
      s00_axi_wdata(31 downto 0) => s00_axi_wdata(31 downto 0),
      s00_axi_wstrb(3 downto 0) => s00_axi_wstrb(3 downto 0),
      s00_axi_wvalid => s00_axi_wvalid,
      tdc_calib_finish => tdc_calib_finish,
      tdc_calibing => tdc_calibing
    );
end STRUCTURE;
