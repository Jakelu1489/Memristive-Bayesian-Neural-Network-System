-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Wed Jun  5 09:48:02 2024
-- Host        : DESKTOP-QJLKIHB running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ zynq_blk_xbar_0_sim_netlist.vhdl
-- Design      : zynq_blk_xbar_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_addr_arbiter_sasd is
  port (
    m_valid_i : out STD_LOGIC;
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    aa_grant_rnw : out STD_LOGIC;
    \gen_no_arbiter.m_amesg_i_reg[20]_0\ : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \gen_no_arbiter.m_amesg_i_reg[20]_1\ : out STD_LOGIC;
    m_ready_d0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    Q : out STD_LOGIC_VECTOR ( 34 downto 0 );
    \m_ready_d_reg[2]\ : out STD_LOGIC;
    s_axi_bvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_bready : out STD_LOGIC_VECTOR ( 2 downto 0 );
    \gen_no_arbiter.grant_rnw_reg_0\ : out STD_LOGIC;
    s_axi_wready : out STD_LOGIC_VECTOR ( 0 to 0 );
    \gen_no_arbiter.grant_rnw_reg_1\ : out STD_LOGIC;
    m_axi_wvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    \gen_no_arbiter.grant_rnw_reg_2\ : out STD_LOGIC;
    \aresetn_d_reg[0]\ : out STD_LOGIC;
    \aresetn_d_reg[1]\ : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_arvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    \m_ready_d_reg[1]\ : out STD_LOGIC;
    s_axi_awready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    \m_atarget_hot_reg[3]\ : out STD_LOGIC;
    aclk : in STD_LOGIC;
    aresetn_d : in STD_LOGIC;
    \gen_no_arbiter.m_grant_hot_i_reg[0]_0\ : in STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_ready_d : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \m_ready_d_reg[2]_0\ : in STD_LOGIC;
    s_axi_bvalid_0_sp_1 : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    \gen_axilite.s_axi_awready_i_reg\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wready_0_sp_1 : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_valid_i_reg : in STD_LOGIC_VECTOR ( 1 downto 0 );
    aa_rready : in STD_LOGIC;
    m_valid_i_reg_0 : in STD_LOGIC;
    m_ready_d_0 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    sr_rvalid : in STD_LOGIC;
    \gen_no_arbiter.m_valid_i_reg_0\ : in STD_LOGIC;
    \gen_no_arbiter.m_valid_i_reg_1\ : in STD_LOGIC;
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    mi_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    mi_wready : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_addr_arbiter_sasd;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_addr_arbiter_sasd is
  signal \^q\ : STD_LOGIC_VECTOR ( 34 downto 0 );
  signal \^sr\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal aa_grant_any : STD_LOGIC;
  signal \^aa_grant_rnw\ : STD_LOGIC;
  signal \gen_axilite.s_axi_awready_i_i_2_n_0\ : STD_LOGIC;
  signal \gen_no_arbiter.grant_rnw_i_1_n_0\ : STD_LOGIC;
  signal \^gen_no_arbiter.grant_rnw_reg_2\ : STD_LOGIC;
  signal \gen_no_arbiter.m_grant_hot_i[0]_i_1_n_0\ : STD_LOGIC;
  signal \gen_no_arbiter.m_grant_hot_i[0]_i_2_n_0\ : STD_LOGIC;
  signal \gen_no_arbiter.m_grant_hot_i[0]_i_4_n_0\ : STD_LOGIC;
  signal \gen_no_arbiter.m_valid_i_i_1_n_0\ : STD_LOGIC;
  signal \gen_no_arbiter.s_ready_i[0]_i_1_n_0\ : STD_LOGIC;
  signal \m_atarget_hot[3]_i_2_n_0\ : STD_LOGIC;
  signal \m_atarget_hot[3]_i_5_n_0\ : STD_LOGIC;
  signal \m_atarget_hot[3]_i_6_n_0\ : STD_LOGIC;
  signal \m_atarget_hot[3]_i_7_n_0\ : STD_LOGIC;
  signal \m_atarget_hot[3]_i_8_n_0\ : STD_LOGIC;
  signal \^m_ready_d0\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^m_valid_i\ : STD_LOGIC;
  signal m_valid_i_i_2_n_0 : STD_LOGIC;
  signal m_valid_i_i_3_n_0 : STD_LOGIC;
  signal p_0_in1_in : STD_LOGIC;
  signal s_amesg : STD_LOGIC_VECTOR ( 48 downto 1 );
  signal \s_arvalid_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \s_arvalid_reg_reg_n_0_[0]\ : STD_LOGIC;
  signal s_awvalid_reg : STD_LOGIC;
  signal \s_awvalid_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal s_axi_bvalid_0_sn_1 : STD_LOGIC;
  signal s_axi_wready_0_sn_1 : STD_LOGIC;
  signal s_ready_i : STD_LOGIC;
  signal target_mi_enc : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \gen_axilite.s_axi_awready_i_i_2\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \gen_axilite.s_axi_awready_i_i_3\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \gen_axilite.s_axi_bvalid_i_i_2\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \gen_axilite.s_axi_rvalid_i_i_2\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \gen_no_arbiter.m_grant_hot_i[0]_i_2\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \gen_no_arbiter.m_grant_hot_i[0]_i_4\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \gen_no_arbiter.s_ready_i[0]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \m_atarget_enc[0]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \m_atarget_enc[1]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \m_atarget_hot[0]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \m_atarget_hot[2]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \m_atarget_hot[3]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \m_axi_arvalid[0]_INST_0\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \m_axi_arvalid[1]_INST_0\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \m_axi_arvalid[2]_INST_0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \m_axi_awvalid[0]_INST_0\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \m_axi_awvalid[1]_INST_0\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \m_axi_awvalid[2]_INST_0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \m_axi_wvalid[0]_INST_0\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \m_payload_i[34]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \m_ready_d[2]_i_2\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \m_ready_d[2]_i_4\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of m_valid_i_i_1 : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of m_valid_i_i_2 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \s_arvalid_reg[0]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \s_axi_arready[0]_INST_0\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \s_axi_awready[0]_INST_0\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \s_axi_bvalid[0]_INST_0\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \s_axi_rvalid[0]_INST_0\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of s_ready_i_i_1 : label is "soft_lutpair12";
begin
  Q(34 downto 0) <= \^q\(34 downto 0);
  SR(0) <= \^sr\(0);
  aa_grant_rnw <= \^aa_grant_rnw\;
  \gen_no_arbiter.grant_rnw_reg_2\ <= \^gen_no_arbiter.grant_rnw_reg_2\;
  m_ready_d0(0) <= \^m_ready_d0\(0);
  m_valid_i <= \^m_valid_i\;
  s_axi_bvalid_0_sn_1 <= s_axi_bvalid_0_sp_1;
  s_axi_wready_0_sn_1 <= s_axi_wready_0_sp_1;
\gen_axilite.s_axi_awready_i_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFB00000004"
    )
        port map (
      I0 => \gen_axilite.s_axi_awready_i_i_2_n_0\,
      I1 => \gen_axilite.s_axi_awready_i_reg\(3),
      I2 => m_ready_d(2),
      I3 => \^gen_no_arbiter.grant_rnw_reg_2\,
      I4 => mi_bvalid(0),
      I5 => mi_wready(0),
      O => \m_atarget_hot_reg[3]\
    );
\gen_axilite.s_axi_awready_i_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FBFF"
    )
        port map (
      I0 => \^aa_grant_rnw\,
      I1 => \^m_valid_i\,
      I2 => m_ready_d(1),
      I3 => s_axi_wvalid(0),
      O => \gen_axilite.s_axi_awready_i_i_2_n_0\
    );
\gen_axilite.s_axi_awready_i_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => \^aa_grant_rnw\,
      I1 => \^m_valid_i\,
      O => \^gen_no_arbiter.grant_rnw_reg_2\
    );
\gen_axilite.s_axi_bvalid_i_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FBFF"
    )
        port map (
      I0 => \^aa_grant_rnw\,
      I1 => \^m_valid_i\,
      I2 => m_ready_d(0),
      I3 => s_axi_bready(0),
      O => \gen_no_arbiter.grant_rnw_reg_0\
    );
\gen_axilite.s_axi_rvalid_i_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => m_ready_d_0(1),
      I1 => \^m_valid_i\,
      I2 => \^aa_grant_rnw\,
      O => \m_ready_d_reg[1]\
    );
\gen_no_arbiter.grant_rnw_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFF5300000050"
    )
        port map (
      I0 => s_awvalid_reg,
      I1 => s_axi_awvalid(0),
      I2 => s_axi_arvalid(0),
      I3 => aa_grant_any,
      I4 => \^m_valid_i\,
      I5 => \^aa_grant_rnw\,
      O => \gen_no_arbiter.grant_rnw_i_1_n_0\
    );
\gen_no_arbiter.grant_rnw_reg\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \gen_no_arbiter.grant_rnw_i_1_n_0\,
      Q => \^aa_grant_rnw\,
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i[10]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(9),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(9),
      O => s_amesg(10)
    );
\gen_no_arbiter.m_amesg_i[11]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(10),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(10),
      O => s_amesg(11)
    );
\gen_no_arbiter.m_amesg_i[12]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(11),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(11),
      O => s_amesg(12)
    );
\gen_no_arbiter.m_amesg_i[13]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(12),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(12),
      O => s_amesg(13)
    );
\gen_no_arbiter.m_amesg_i[14]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(13),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(13),
      O => s_amesg(14)
    );
\gen_no_arbiter.m_amesg_i[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(14),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(14),
      O => s_amesg(15)
    );
\gen_no_arbiter.m_amesg_i[16]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(15),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(15),
      O => s_amesg(16)
    );
\gen_no_arbiter.m_amesg_i[17]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(16),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(16),
      O => s_amesg(17)
    );
\gen_no_arbiter.m_amesg_i[18]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(17),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(17),
      O => s_amesg(18)
    );
\gen_no_arbiter.m_amesg_i[19]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(18),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(18),
      O => s_amesg(19)
    );
\gen_no_arbiter.m_amesg_i[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(0),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(0),
      O => s_amesg(1)
    );
\gen_no_arbiter.m_amesg_i[20]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(19),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(19),
      O => s_amesg(20)
    );
\gen_no_arbiter.m_amesg_i[21]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(20),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(20),
      O => s_amesg(21)
    );
\gen_no_arbiter.m_amesg_i[22]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(21),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(21),
      O => s_amesg(22)
    );
\gen_no_arbiter.m_amesg_i[23]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(22),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(22),
      O => s_amesg(23)
    );
\gen_no_arbiter.m_amesg_i[24]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(23),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(23),
      O => s_amesg(24)
    );
\gen_no_arbiter.m_amesg_i[25]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(24),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(24),
      O => s_amesg(25)
    );
\gen_no_arbiter.m_amesg_i[26]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(25),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(25),
      O => s_amesg(26)
    );
\gen_no_arbiter.m_amesg_i[27]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(26),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(26),
      O => s_amesg(27)
    );
\gen_no_arbiter.m_amesg_i[28]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(27),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(27),
      O => s_amesg(28)
    );
\gen_no_arbiter.m_amesg_i[29]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(28),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(28),
      O => s_amesg(29)
    );
\gen_no_arbiter.m_amesg_i[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(1),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(1),
      O => s_amesg(2)
    );
\gen_no_arbiter.m_amesg_i[30]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(29),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(29),
      O => s_amesg(30)
    );
\gen_no_arbiter.m_amesg_i[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(30),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(30),
      O => s_amesg(31)
    );
\gen_no_arbiter.m_amesg_i[32]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => aresetn_d,
      O => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i[32]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => aa_grant_any,
      O => p_0_in1_in
    );
\gen_no_arbiter.m_amesg_i[32]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(31),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(31),
      O => s_amesg(32)
    );
\gen_no_arbiter.m_amesg_i[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(2),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(2),
      O => s_amesg(3)
    );
\gen_no_arbiter.m_amesg_i[46]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_arprot(0),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awprot(0),
      O => s_amesg(46)
    );
\gen_no_arbiter.m_amesg_i[47]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_arprot(1),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awprot(1),
      O => s_amesg(47)
    );
\gen_no_arbiter.m_amesg_i[48]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_arprot(2),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awprot(2),
      O => s_amesg(48)
    );
\gen_no_arbiter.m_amesg_i[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(3),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(3),
      O => s_amesg(4)
    );
\gen_no_arbiter.m_amesg_i[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(4),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(4),
      O => s_amesg(5)
    );
\gen_no_arbiter.m_amesg_i[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(5),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(5),
      O => s_amesg(6)
    );
\gen_no_arbiter.m_amesg_i[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(6),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(6),
      O => s_amesg(7)
    );
\gen_no_arbiter.m_amesg_i[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(7),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(7),
      O => s_amesg(8)
    );
\gen_no_arbiter.m_amesg_i[9]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => s_axi_araddr(8),
      I1 => s_axi_arvalid(0),
      I2 => s_awvalid_reg,
      I3 => s_axi_awaddr(8),
      O => s_amesg(9)
    );
\gen_no_arbiter.m_amesg_i_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(10),
      Q => \^q\(9),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(11),
      Q => \^q\(10),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(12),
      Q => \^q\(11),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(13),
      Q => \^q\(12),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(14),
      Q => \^q\(13),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(15),
      Q => \^q\(14),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(16),
      Q => \^q\(15),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(17),
      Q => \^q\(16),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(18),
      Q => \^q\(17),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(19),
      Q => \^q\(18),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(1),
      Q => \^q\(0),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(20),
      Q => \^q\(19),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(21),
      Q => \^q\(20),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(22),
      Q => \^q\(21),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(23),
      Q => \^q\(22),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(24),
      Q => \^q\(23),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(25),
      Q => \^q\(24),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(26),
      Q => \^q\(25),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(27),
      Q => \^q\(26),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(28),
      Q => \^q\(27),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(29),
      Q => \^q\(28),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(2),
      Q => \^q\(1),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(30),
      Q => \^q\(29),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(31),
      Q => \^q\(30),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(32),
      Q => \^q\(31),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(3),
      Q => \^q\(2),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(46),
      Q => \^q\(32),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(47),
      Q => \^q\(33),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(48),
      Q => \^q\(34),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(4),
      Q => \^q\(3),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(5),
      Q => \^q\(4),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(6),
      Q => \^q\(5),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(7),
      Q => \^q\(6),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(8),
      Q => \^q\(7),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_amesg_i_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => p_0_in1_in,
      D => s_amesg(9),
      Q => \^q\(8),
      R => \^sr\(0)
    );
\gen_no_arbiter.m_grant_hot_i[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000007F7F737F"
    )
        port map (
      I0 => \gen_no_arbiter.m_grant_hot_i[0]_i_2_n_0\,
      I1 => \^m_valid_i\,
      I2 => \^aa_grant_rnw\,
      I3 => \^m_ready_d0\(0),
      I4 => \gen_no_arbiter.m_grant_hot_i_reg[0]_0\,
      I5 => \gen_no_arbiter.m_grant_hot_i[0]_i_4_n_0\,
      O => \gen_no_arbiter.m_grant_hot_i[0]_i_1_n_0\
    );
\gen_no_arbiter.m_grant_hot_i[0]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000F0F8"
    )
        port map (
      I0 => \^aa_grant_rnw\,
      I1 => \^m_valid_i\,
      I2 => m_ready_d_0(1),
      I3 => \gen_no_arbiter.m_valid_i_reg_0\,
      I4 => \gen_no_arbiter.m_valid_i_reg_1\,
      O => \gen_no_arbiter.m_grant_hot_i[0]_i_2_n_0\
    );
\gen_no_arbiter.m_grant_hot_i[0]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"5D5D5D5F"
    )
        port map (
      I0 => aresetn_d,
      I1 => \^m_valid_i\,
      I2 => aa_grant_any,
      I3 => s_axi_arvalid(0),
      I4 => s_axi_awvalid(0),
      O => \gen_no_arbiter.m_grant_hot_i[0]_i_4_n_0\
    );
\gen_no_arbiter.m_grant_hot_i_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => \gen_no_arbiter.m_grant_hot_i[0]_i_1_n_0\,
      Q => aa_grant_any,
      R => '0'
    );
\gen_no_arbiter.m_valid_i_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3AFA3AFA3A0A3AFA"
    )
        port map (
      I0 => aa_grant_any,
      I1 => \gen_no_arbiter.m_grant_hot_i[0]_i_2_n_0\,
      I2 => \^m_valid_i\,
      I3 => \^aa_grant_rnw\,
      I4 => \^m_ready_d0\(0),
      I5 => \gen_no_arbiter.m_grant_hot_i_reg[0]_0\,
      O => \gen_no_arbiter.m_valid_i_i_1_n_0\
    );
\gen_no_arbiter.m_valid_i_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => \gen_no_arbiter.m_valid_i_i_1_n_0\,
      Q => \^m_valid_i\,
      R => \^sr\(0)
    );
\gen_no_arbiter.s_ready_i[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => \^m_valid_i\,
      I1 => aa_grant_any,
      I2 => aresetn_d,
      O => \gen_no_arbiter.s_ready_i[0]_i_1_n_0\
    );
\gen_no_arbiter.s_ready_i_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => \gen_no_arbiter.s_ready_i[0]_i_1_n_0\,
      Q => s_ready_i,
      R => '0'
    );
\m_atarget_enc[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F2"
    )
        port map (
      I0 => \m_atarget_hot[3]_i_2_n_0\,
      I1 => target_mi_enc(1),
      I2 => target_mi_enc(0),
      O => \gen_no_arbiter.m_amesg_i_reg[20]_1\
    );
\m_atarget_enc[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CE"
    )
        port map (
      I0 => \m_atarget_hot[3]_i_2_n_0\,
      I1 => target_mi_enc(1),
      I2 => target_mi_enc(0),
      O => \gen_no_arbiter.m_amesg_i_reg[20]_0\
    );
\m_atarget_hot[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => aa_grant_any,
      I1 => \m_atarget_hot[3]_i_2_n_0\,
      O => D(0)
    );
\m_atarget_hot[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => target_mi_enc(0),
      I1 => aa_grant_any,
      O => D(1)
    );
\m_atarget_hot[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => target_mi_enc(1),
      I1 => aa_grant_any,
      O => D(2)
    );
\m_atarget_hot[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0008"
    )
        port map (
      I0 => aa_grant_any,
      I1 => \m_atarget_hot[3]_i_2_n_0\,
      I2 => target_mi_enc(1),
      I3 => target_mi_enc(0),
      O => D(3)
    );
\m_atarget_hot[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFD"
    )
        port map (
      I0 => \m_atarget_hot[3]_i_5_n_0\,
      I1 => \m_atarget_hot[3]_i_6_n_0\,
      I2 => \^q\(19),
      I3 => \^q\(17),
      I4 => \^q\(18),
      I5 => \^q\(16),
      O => \m_atarget_hot[3]_i_2_n_0\
    );
\m_atarget_hot[3]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000002"
    )
        port map (
      I0 => \m_atarget_hot[3]_i_5_n_0\,
      I1 => \m_atarget_hot[3]_i_7_n_0\,
      I2 => \^q\(19),
      I3 => \^q\(17),
      I4 => \^q\(18),
      I5 => \^q\(16),
      O => target_mi_enc(1)
    );
\m_atarget_hot[3]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000002"
    )
        port map (
      I0 => \m_atarget_hot[3]_i_5_n_0\,
      I1 => \m_atarget_hot[3]_i_8_n_0\,
      I2 => \^q\(19),
      I3 => \^q\(17),
      I4 => \^q\(18),
      I5 => \^q\(16),
      O => target_mi_enc(0)
    );
\m_atarget_hot[3]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000100"
    )
        port map (
      I0 => \^q\(26),
      I1 => \^q\(29),
      I2 => \^q\(28),
      I3 => \^q\(30),
      I4 => \^q\(31),
      I5 => \^q\(27),
      O => \m_atarget_hot[3]_i_5_n_0\
    );
\m_atarget_hot[3]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFEFFFFFFFF"
    )
        port map (
      I0 => \^q\(23),
      I1 => \^q\(25),
      I2 => \^q\(20),
      I3 => \^q\(24),
      I4 => \^q\(21),
      I5 => \^q\(22),
      O => \m_atarget_hot[3]_i_6_n_0\
    );
\m_atarget_hot[3]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFDFFFFFFFFFFF"
    )
        port map (
      I0 => \^q\(24),
      I1 => \^q\(20),
      I2 => \^q\(25),
      I3 => \^q\(23),
      I4 => \^q\(21),
      I5 => \^q\(22),
      O => \m_atarget_hot[3]_i_7_n_0\
    );
\m_atarget_hot[3]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFDFF"
    )
        port map (
      I0 => \^q\(24),
      I1 => \^q\(20),
      I2 => \^q\(22),
      I3 => \^q\(21),
      I4 => \^q\(25),
      I5 => \^q\(23),
      O => \m_atarget_hot[3]_i_8_n_0\
    );
\m_axi_arvalid[0]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
        port map (
      I0 => \gen_axilite.s_axi_awready_i_reg\(0),
      I1 => \^aa_grant_rnw\,
      I2 => \^m_valid_i\,
      I3 => m_ready_d_0(1),
      O => m_axi_arvalid(0)
    );
\m_axi_arvalid[1]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
        port map (
      I0 => \gen_axilite.s_axi_awready_i_reg\(1),
      I1 => \^aa_grant_rnw\,
      I2 => \^m_valid_i\,
      I3 => m_ready_d_0(1),
      O => m_axi_arvalid(1)
    );
\m_axi_arvalid[2]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
        port map (
      I0 => \gen_axilite.s_axi_awready_i_reg\(2),
      I1 => \^aa_grant_rnw\,
      I2 => \^m_valid_i\,
      I3 => m_ready_d_0(1),
      O => m_axi_arvalid(2)
    );
\m_axi_awvalid[0]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0020"
    )
        port map (
      I0 => \gen_axilite.s_axi_awready_i_reg\(0),
      I1 => \^aa_grant_rnw\,
      I2 => \^m_valid_i\,
      I3 => m_ready_d(2),
      O => m_axi_awvalid(0)
    );
\m_axi_awvalid[1]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0020"
    )
        port map (
      I0 => \gen_axilite.s_axi_awready_i_reg\(1),
      I1 => \^aa_grant_rnw\,
      I2 => \^m_valid_i\,
      I3 => m_ready_d(2),
      O => m_axi_awvalid(1)
    );
\m_axi_awvalid[2]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0020"
    )
        port map (
      I0 => \gen_axilite.s_axi_awready_i_reg\(2),
      I1 => \^aa_grant_rnw\,
      I2 => \^m_valid_i\,
      I3 => m_ready_d(2),
      O => m_axi_awvalid(2)
    );
\m_axi_bready[0]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000800"
    )
        port map (
      I0 => \gen_axilite.s_axi_awready_i_reg\(0),
      I1 => s_axi_bready(0),
      I2 => m_ready_d(0),
      I3 => \^m_valid_i\,
      I4 => \^aa_grant_rnw\,
      O => m_axi_bready(0)
    );
\m_axi_bready[1]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000800"
    )
        port map (
      I0 => \gen_axilite.s_axi_awready_i_reg\(1),
      I1 => s_axi_bready(0),
      I2 => m_ready_d(0),
      I3 => \^m_valid_i\,
      I4 => \^aa_grant_rnw\,
      O => m_axi_bready(1)
    );
\m_axi_bready[2]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000800"
    )
        port map (
      I0 => \gen_axilite.s_axi_awready_i_reg\(2),
      I1 => s_axi_bready(0),
      I2 => m_ready_d(0),
      I3 => \^m_valid_i\,
      I4 => \^aa_grant_rnw\,
      O => m_axi_bready(2)
    );
\m_axi_wvalid[0]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000800"
    )
        port map (
      I0 => \gen_axilite.s_axi_awready_i_reg\(0),
      I1 => s_axi_wvalid(0),
      I2 => m_ready_d(1),
      I3 => \^m_valid_i\,
      I4 => \^aa_grant_rnw\,
      O => m_axi_wvalid(0)
    );
\m_axi_wvalid[1]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000800"
    )
        port map (
      I0 => \gen_axilite.s_axi_awready_i_reg\(1),
      I1 => s_axi_wvalid(0),
      I2 => m_ready_d(1),
      I3 => \^m_valid_i\,
      I4 => \^aa_grant_rnw\,
      O => m_axi_wvalid(1)
    );
\m_axi_wvalid[2]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000800"
    )
        port map (
      I0 => \gen_axilite.s_axi_awready_i_reg\(2),
      I1 => s_axi_wvalid(0),
      I2 => m_ready_d(1),
      I3 => \^m_valid_i\,
      I4 => \^aa_grant_rnw\,
      O => m_axi_wvalid(2)
    );
\m_payload_i[34]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0080FFFF"
    )
        port map (
      I0 => s_axi_rready(0),
      I1 => \^aa_grant_rnw\,
      I2 => \^m_valid_i\,
      I3 => m_ready_d_0(0),
      I4 => sr_rvalid,
      O => E(0)
    );
\m_ready_d[2]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4555"
    )
        port map (
      I0 => m_ready_d(2),
      I1 => \^aa_grant_rnw\,
      I2 => \^m_valid_i\,
      I3 => \m_ready_d_reg[2]_0\,
      O => \m_ready_d_reg[2]\
    );
\m_ready_d[2]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0F0B0F0F"
    )
        port map (
      I0 => \^aa_grant_rnw\,
      I1 => \^m_valid_i\,
      I2 => m_ready_d(1),
      I3 => s_axi_wready_0_sn_1,
      I4 => s_axi_wvalid(0),
      O => \gen_no_arbiter.grant_rnw_reg_1\
    );
\m_ready_d[2]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0F4F0F0"
    )
        port map (
      I0 => \^aa_grant_rnw\,
      I1 => \^m_valid_i\,
      I2 => m_ready_d(0),
      I3 => s_axi_bvalid_0_sn_1,
      I4 => s_axi_bready(0),
      O => \^m_ready_d0\(0)
    );
m_valid_i_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_valid_i_reg(1),
      I1 => m_valid_i_i_2_n_0,
      I2 => m_valid_i_i_3_n_0,
      O => \aresetn_d_reg[1]\
    );
m_valid_i_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8AAAAAAA"
    )
        port map (
      I0 => sr_rvalid,
      I1 => m_ready_d_0(0),
      I2 => \^m_valid_i\,
      I3 => \^aa_grant_rnw\,
      I4 => s_axi_rready(0),
      O => m_valid_i_i_2_n_0
    );
m_valid_i_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A8AAAAAA"
    )
        port map (
      I0 => aa_rready,
      I1 => m_valid_i_reg_0,
      I2 => m_ready_d_0(0),
      I3 => \^m_valid_i\,
      I4 => \^aa_grant_rnw\,
      O => m_valid_i_i_3_n_0
    );
\s_arvalid_reg[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0040"
    )
        port map (
      I0 => s_awvalid_reg,
      I1 => s_axi_arvalid(0),
      I2 => aresetn_d,
      I3 => s_ready_i,
      O => \s_arvalid_reg[0]_i_1_n_0\
    );
\s_arvalid_reg_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => \s_arvalid_reg[0]_i_1_n_0\,
      Q => \s_arvalid_reg_reg_n_0_[0]\,
      R => '0'
    );
\s_awvalid_reg[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000D00000"
    )
        port map (
      I0 => s_axi_arvalid(0),
      I1 => s_awvalid_reg,
      I2 => s_axi_awvalid(0),
      I3 => \s_arvalid_reg_reg_n_0_[0]\,
      I4 => aresetn_d,
      I5 => s_ready_i,
      O => \s_awvalid_reg[0]_i_1_n_0\
    );
\s_awvalid_reg_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => \s_awvalid_reg[0]_i_1_n_0\,
      Q => s_awvalid_reg,
      R => '0'
    );
\s_axi_arready[0]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^aa_grant_rnw\,
      I1 => s_ready_i,
      O => s_axi_arready(0)
    );
\s_axi_awready[0]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => s_ready_i,
      I1 => \^aa_grant_rnw\,
      O => s_axi_awready(0)
    );
\s_axi_bvalid[0]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000200"
    )
        port map (
      I0 => aa_grant_any,
      I1 => s_axi_bvalid_0_sn_1,
      I2 => m_ready_d(0),
      I3 => \^m_valid_i\,
      I4 => \^aa_grant_rnw\,
      O => s_axi_bvalid(0)
    );
\s_axi_rvalid[0]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => aa_grant_any,
      I1 => sr_rvalid,
      O => s_axi_rvalid(0)
    );
\s_axi_wready[0]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000200"
    )
        port map (
      I0 => aa_grant_any,
      I1 => s_axi_wready_0_sn_1,
      I2 => m_ready_d(1),
      I3 => \^m_valid_i\,
      I4 => \^aa_grant_rnw\,
      O => s_axi_wready(0)
    );
s_ready_i_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8A"
    )
        port map (
      I0 => m_valid_i_reg(0),
      I1 => m_valid_i_i_3_n_0,
      I2 => m_valid_i_i_2_n_0,
      O => \aresetn_d_reg[0]\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_decerr_slave is
  port (
    mi_bvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    mi_wready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wvalid_0_sp_1 : out STD_LOGIC;
    m_axi_wready_0_sp_1 : out STD_LOGIC;
    m_axi_awready_0_sp_1 : out STD_LOGIC;
    m_axi_rvalid_1_sp_1 : out STD_LOGIC;
    m_axi_bvalid_2_sp_1 : out STD_LOGIC;
    m_axi_arready_2_sp_1 : out STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    aclk : in STD_LOGIC;
    \gen_axilite.s_axi_awready_i_reg_0\ : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_ready_d : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \gen_no_arbiter.m_grant_hot_i_reg[0]\ : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    \gen_axilite.s_axi_rvalid_i_reg_0\ : in STD_LOGIC;
    aresetn_d : in STD_LOGIC;
    m_axi_rvalid : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \s_axi_wready[0]\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_wready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_bvalid : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \gen_axilite.s_axi_bvalid_i_reg_0\ : in STD_LOGIC;
    \gen_axilite.s_axi_bvalid_i_reg_1\ : in STD_LOGIC;
    aa_rready : in STD_LOGIC
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_decerr_slave;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_decerr_slave is
  signal \gen_axilite.s_axi_arready_i_i_1_n_0\ : STD_LOGIC;
  signal \gen_axilite.s_axi_bvalid_i_i_1_n_0\ : STD_LOGIC;
  signal \gen_axilite.s_axi_rvalid_i_i_1_n_0\ : STD_LOGIC;
  signal m_axi_arready_2_sn_1 : STD_LOGIC;
  signal m_axi_awready_0_sn_1 : STD_LOGIC;
  signal m_axi_bvalid_2_sn_1 : STD_LOGIC;
  signal m_axi_rvalid_1_sn_1 : STD_LOGIC;
  signal m_axi_wready_0_sn_1 : STD_LOGIC;
  signal mi_arready : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \^mi_bvalid\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal mi_rvalid : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \^mi_wready\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s_axi_wvalid_0_sn_1 : STD_LOGIC;
begin
  m_axi_arready_2_sp_1 <= m_axi_arready_2_sn_1;
  m_axi_awready_0_sp_1 <= m_axi_awready_0_sn_1;
  m_axi_bvalid_2_sp_1 <= m_axi_bvalid_2_sn_1;
  m_axi_rvalid_1_sp_1 <= m_axi_rvalid_1_sn_1;
  m_axi_wready_0_sp_1 <= m_axi_wready_0_sn_1;
  mi_bvalid(0) <= \^mi_bvalid\(0);
  mi_wready(0) <= \^mi_wready\(0);
  s_axi_wvalid_0_sp_1 <= s_axi_wvalid_0_sn_1;
\gen_axilite.s_axi_arready_i_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F07F0000"
    )
        port map (
      I0 => Q(0),
      I1 => \gen_axilite.s_axi_rvalid_i_reg_0\,
      I2 => mi_arready(3),
      I3 => mi_rvalid(3),
      I4 => aresetn_d,
      O => \gen_axilite.s_axi_arready_i_i_1_n_0\
    );
\gen_axilite.s_axi_arready_i_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => \gen_axilite.s_axi_arready_i_i_1_n_0\,
      Q => mi_arready(3),
      R => '0'
    );
\gen_axilite.s_axi_awready_i_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => \gen_axilite.s_axi_awready_i_reg_0\,
      Q => \^mi_wready\(0),
      R => SR(0)
    );
\gen_axilite.s_axi_bvalid_i_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBBB0F00"
    )
        port map (
      I0 => \gen_axilite.s_axi_bvalid_i_reg_0\,
      I1 => Q(0),
      I2 => \gen_axilite.s_axi_bvalid_i_reg_1\,
      I3 => \^mi_wready\(0),
      I4 => \^mi_bvalid\(0),
      O => \gen_axilite.s_axi_bvalid_i_i_1_n_0\
    );
\gen_axilite.s_axi_bvalid_i_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => \gen_axilite.s_axi_bvalid_i_i_1_n_0\,
      Q => \^mi_bvalid\(0),
      R => SR(0)
    );
\gen_axilite.s_axi_rvalid_i_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0FFF8800"
    )
        port map (
      I0 => mi_arready(3),
      I1 => \gen_axilite.s_axi_rvalid_i_reg_0\,
      I2 => aa_rready,
      I3 => Q(0),
      I4 => mi_rvalid(3),
      O => \gen_axilite.s_axi_rvalid_i_i_1_n_0\
    );
\gen_axilite.s_axi_rvalid_i_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => \gen_axilite.s_axi_rvalid_i_i_1_n_0\,
      Q => mi_rvalid(3),
      R => SR(0)
    );
\gen_no_arbiter.m_grant_hot_i[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F0F0D0DFFFF0DFF"
    )
        port map (
      I0 => s_axi_wvalid(0),
      I1 => m_axi_wready_0_sn_1,
      I2 => m_ready_d(0),
      I3 => m_axi_awready_0_sn_1,
      I4 => \gen_no_arbiter.m_grant_hot_i_reg[0]\,
      I5 => m_ready_d(1),
      O => s_axi_wvalid_0_sn_1
    );
\m_ready_d[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"33550F0033550FFF"
    )
        port map (
      I0 => m_axi_arready(2),
      I1 => mi_arready(3),
      I2 => m_axi_arready(1),
      I3 => \s_axi_wready[0]\(0),
      I4 => \s_axi_wready[0]\(1),
      I5 => m_axi_arready(0),
      O => m_axi_arready_2_sn_1
    );
\m_ready_d[2]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFCCF0AA00CCF0AA"
    )
        port map (
      I0 => m_axi_awready(0),
      I1 => m_axi_awready(2),
      I2 => m_axi_awready(1),
      I3 => \s_axi_wready[0]\(0),
      I4 => \s_axi_wready[0]\(1),
      I5 => \^mi_wready\(0),
      O => m_axi_awready_0_sn_1
    );
m_valid_i_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00550F33FF550F33"
    )
        port map (
      I0 => m_axi_rvalid(1),
      I1 => m_axi_rvalid(0),
      I2 => m_axi_rvalid(2),
      I3 => \s_axi_wready[0]\(1),
      I4 => \s_axi_wready[0]\(0),
      I5 => mi_rvalid(3),
      O => m_axi_rvalid_1_sn_1
    );
\s_axi_bvalid[0]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0055330FFF55330F"
    )
        port map (
      I0 => m_axi_bvalid(2),
      I1 => m_axi_bvalid(1),
      I2 => m_axi_bvalid(0),
      I3 => \s_axi_wready[0]\(0),
      I4 => \s_axi_wready[0]\(1),
      I5 => \^mi_bvalid\(0),
      O => m_axi_bvalid_2_sn_1
    );
\s_axi_wready[0]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"33000F5533FF0F55"
    )
        port map (
      I0 => m_axi_wready(0),
      I1 => \^mi_wready\(0),
      I2 => m_axi_wready(2),
      I3 => \s_axi_wready[0]\(1),
      I4 => \s_axi_wready[0]\(0),
      I5 => m_axi_wready(1),
      O => m_axi_wready_0_sn_1
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_splitter is
  port (
    s_axi_wvalid_0_sp_1 : out STD_LOGIC;
    m_ready_d : out STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_wvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_valid_i : in STD_LOGIC;
    aa_grant_rnw : in STD_LOGIC;
    \m_ready_d_reg[2]_0\ : in STD_LOGIC;
    \m_ready_d_reg[2]_1\ : in STD_LOGIC;
    m_ready_d0 : in STD_LOGIC_VECTOR ( 0 to 0 );
    aresetn_d : in STD_LOGIC;
    aclk : in STD_LOGIC
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_splitter;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_splitter is
  signal \^m_ready_d\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \m_ready_d[0]_i_1_n_0\ : STD_LOGIC;
  signal \m_ready_d[1]_i_1_n_0\ : STD_LOGIC;
  signal \m_ready_d[2]_i_1_n_0\ : STD_LOGIC;
  signal s_axi_wvalid_0_sn_1 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \m_ready_d[1]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \m_ready_d[2]_i_1\ : label is "soft_lutpair34";
begin
  m_ready_d(2 downto 0) <= \^m_ready_d\(2 downto 0);
  s_axi_wvalid_0_sp_1 <= s_axi_wvalid_0_sn_1;
\gen_axilite.s_axi_bvalid_i_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFDFFFFF"
    )
        port map (
      I0 => s_axi_wvalid(0),
      I1 => \^m_ready_d\(1),
      I2 => Q(0),
      I3 => \^m_ready_d\(2),
      I4 => m_valid_i,
      I5 => aa_grant_rnw,
      O => s_axi_wvalid_0_sn_1
    );
\m_ready_d[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"E000"
    )
        port map (
      I0 => \m_ready_d_reg[2]_0\,
      I1 => \m_ready_d_reg[2]_1\,
      I2 => m_ready_d0(0),
      I3 => aresetn_d,
      O => \m_ready_d[0]_i_1_n_0\
    );
\m_ready_d[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2300"
    )
        port map (
      I0 => \m_ready_d_reg[2]_0\,
      I1 => \m_ready_d_reg[2]_1\,
      I2 => m_ready_d0(0),
      I3 => aresetn_d,
      O => \m_ready_d[1]_i_1_n_0\
    );
\m_ready_d[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4500"
    )
        port map (
      I0 => \m_ready_d_reg[2]_0\,
      I1 => \m_ready_d_reg[2]_1\,
      I2 => m_ready_d0(0),
      I3 => aresetn_d,
      O => \m_ready_d[2]_i_1_n_0\
    );
\m_ready_d_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => \m_ready_d[0]_i_1_n_0\,
      Q => \^m_ready_d\(0),
      R => '0'
    );
\m_ready_d_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => \m_ready_d[1]_i_1_n_0\,
      Q => \^m_ready_d\(1),
      R => '0'
    );
\m_ready_d_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => \m_ready_d[2]_i_1_n_0\,
      Q => \^m_ready_d\(2),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_splitter__parameterized0\ is
  port (
    m_ready_d : out STD_LOGIC_VECTOR ( 1 downto 0 );
    aresetn_d : in STD_LOGIC;
    aa_grant_rnw : in STD_LOGIC;
    m_valid_i : in STD_LOGIC;
    \m_ready_d_reg[1]_0\ : in STD_LOGIC;
    \m_ready_d_reg[1]_1\ : in STD_LOGIC;
    aclk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_splitter__parameterized0\ : entity is "axi_crossbar_v2_1_19_splitter";
end \decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_splitter__parameterized0\;

architecture STRUCTURE of \decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_splitter__parameterized0\ is
  signal \^m_ready_d\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \m_ready_d[0]_i_1_n_0\ : STD_LOGIC;
  signal \m_ready_d[1]_i_1_n_0\ : STD_LOGIC;
begin
  m_ready_d(1 downto 0) <= \^m_ready_d\(1 downto 0);
\m_ready_d[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000AA002A"
    )
        port map (
      I0 => aresetn_d,
      I1 => aa_grant_rnw,
      I2 => m_valid_i,
      I3 => \^m_ready_d\(1),
      I4 => \m_ready_d_reg[1]_0\,
      I5 => \m_ready_d_reg[1]_1\,
      O => \m_ready_d[0]_i_1_n_0\
    );
\m_ready_d[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AA00AA8000000000"
    )
        port map (
      I0 => aresetn_d,
      I1 => aa_grant_rnw,
      I2 => m_valid_i,
      I3 => \^m_ready_d\(1),
      I4 => \m_ready_d_reg[1]_0\,
      I5 => \m_ready_d_reg[1]_1\,
      O => \m_ready_d[1]_i_1_n_0\
    );
\m_ready_d_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => \m_ready_d[0]_i_1_n_0\,
      Q => \^m_ready_d\(0),
      R => '0'
    );
\m_ready_d_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => \m_ready_d[1]_i_1_n_0\,
      Q => \^m_ready_d\(1),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_register_slice_v2_1_18_axic_register_slice is
  port (
    sr_rvalid : out STD_LOGIC;
    aa_rready : out STD_LOGIC;
    m_valid_i_reg_0 : out STD_LOGIC;
    m_axi_rready : out STD_LOGIC_VECTOR ( 2 downto 0 );
    \aresetn_d_reg[1]_0\ : out STD_LOGIC_VECTOR ( 1 downto 0 );
    \m_payload_i_reg[34]_0\ : out STD_LOGIC_VECTOR ( 33 downto 0 );
    m_valid_i_reg_1 : in STD_LOGIC;
    aclk : in STD_LOGIC;
    s_ready_i_reg_0 : in STD_LOGIC;
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    aa_grant_rnw : in STD_LOGIC;
    m_valid_i : in STD_LOGIC;
    m_ready_d : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 5 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 95 downto 0 );
    \m_axi_rready[2]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    E : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_register_slice_v2_1_18_axic_register_slice;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_register_slice_v2_1_18_axic_register_slice is
  signal \^aa_rready\ : STD_LOGIC;
  signal \^aresetn_d_reg[1]_0\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \m_payload_i[12]_i_2_n_0\ : STD_LOGIC;
  signal \m_payload_i[13]_i_2_n_0\ : STD_LOGIC;
  signal \m_payload_i[14]_i_2_n_0\ : STD_LOGIC;
  signal \m_payload_i[15]_i_2_n_0\ : STD_LOGIC;
  signal \m_payload_i[17]_i_2_n_0\ : STD_LOGIC;
  signal \m_payload_i[18]_i_2_n_0\ : STD_LOGIC;
  signal \m_payload_i[1]_i_2_n_0\ : STD_LOGIC;
  signal \m_payload_i[25]_i_2_n_0\ : STD_LOGIC;
  signal \m_payload_i[26]_i_2_n_0\ : STD_LOGIC;
  signal \m_payload_i[28]_i_2_n_0\ : STD_LOGIC;
  signal \m_payload_i[29]_i_2_n_0\ : STD_LOGIC;
  signal \m_payload_i[2]_i_2_n_0\ : STD_LOGIC;
  signal \m_payload_i[30]_i_2_n_0\ : STD_LOGIC;
  signal \m_payload_i[31]_i_2_n_0\ : STD_LOGIC;
  signal \m_payload_i[33]_i_2_n_0\ : STD_LOGIC;
  signal \m_payload_i[34]_i_3_n_0\ : STD_LOGIC;
  signal \m_payload_i[5]_i_2_n_0\ : STD_LOGIC;
  signal \m_payload_i[6]_i_2_n_0\ : STD_LOGIC;
  signal \m_payload_i[7]_i_2_n_0\ : STD_LOGIC;
  signal \m_payload_i_reg_n_0_[0]\ : STD_LOGIC;
  signal skid_buffer : STD_LOGIC_VECTOR ( 34 downto 0 );
  signal \skid_buffer[10]_i_1_n_0\ : STD_LOGIC;
  signal \skid_buffer[11]_i_1_n_0\ : STD_LOGIC;
  signal \skid_buffer[16]_i_1_n_0\ : STD_LOGIC;
  signal \skid_buffer[19]_i_1_n_0\ : STD_LOGIC;
  signal \skid_buffer[20]_i_1_n_0\ : STD_LOGIC;
  signal \skid_buffer[21]_i_1_n_0\ : STD_LOGIC;
  signal \skid_buffer[22]_i_1_n_0\ : STD_LOGIC;
  signal \skid_buffer[23]_i_1_n_0\ : STD_LOGIC;
  signal \skid_buffer[24]_i_1_n_0\ : STD_LOGIC;
  signal \skid_buffer[27]_i_1_n_0\ : STD_LOGIC;
  signal \skid_buffer[32]_i_1_n_0\ : STD_LOGIC;
  signal \skid_buffer[3]_i_1_n_0\ : STD_LOGIC;
  signal \skid_buffer[4]_i_1_n_0\ : STD_LOGIC;
  signal \skid_buffer[8]_i_1_n_0\ : STD_LOGIC;
  signal \skid_buffer[9]_i_1_n_0\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[0]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[10]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[11]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[12]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[13]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[14]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[15]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[16]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[17]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[18]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[19]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[1]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[20]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[21]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[22]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[23]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[24]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[25]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[26]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[27]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[28]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[29]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[2]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[30]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[31]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[32]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[33]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[34]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[3]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[4]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[5]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[6]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[7]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[8]\ : STD_LOGIC;
  signal \skid_buffer_reg_n_0_[9]\ : STD_LOGIC;
  signal \^sr_rvalid\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \m_axi_rready[0]_INST_0\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \m_axi_rready[1]_INST_0\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \m_axi_rready[2]_INST_0\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \m_payload_i[10]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \m_payload_i[11]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \m_payload_i[12]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \m_payload_i[13]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \m_payload_i[14]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \m_payload_i[15]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \m_payload_i[16]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \m_payload_i[17]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \m_payload_i[18]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \m_payload_i[19]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \m_payload_i[1]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \m_payload_i[20]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \m_payload_i[21]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \m_payload_i[22]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \m_payload_i[23]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \m_payload_i[24]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \m_payload_i[25]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \m_payload_i[26]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \m_payload_i[27]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \m_payload_i[28]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \m_payload_i[29]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \m_payload_i[2]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \m_payload_i[30]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \m_payload_i[31]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \m_payload_i[32]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \m_payload_i[33]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \m_payload_i[34]_i_2\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \m_payload_i[3]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \m_payload_i[4]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \m_payload_i[5]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \m_payload_i[6]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \m_payload_i[7]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \m_payload_i[8]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \m_payload_i[9]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \skid_buffer[0]_i_1\ : label is "soft_lutpair33";
begin
  aa_rready <= \^aa_rready\;
  \aresetn_d_reg[1]_0\(1 downto 0) <= \^aresetn_d_reg[1]_0\(1 downto 0);
  sr_rvalid <= \^sr_rvalid\;
\aresetn_d_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => '1',
      Q => \^aresetn_d_reg[1]_0\(0),
      R => SR(0)
    );
\aresetn_d_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => \^aresetn_d_reg[1]_0\(0),
      Q => \^aresetn_d_reg[1]_0\(1),
      R => SR(0)
    );
\m_axi_rready[0]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^aa_rready\,
      I1 => \m_axi_rready[2]\(0),
      O => m_axi_rready(0)
    );
\m_axi_rready[1]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^aa_rready\,
      I1 => \m_axi_rready[2]\(1),
      O => m_axi_rready(1)
    );
\m_axi_rready[2]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^aa_rready\,
      I1 => \m_axi_rready[2]\(2),
      O => m_axi_rready(2)
    );
\m_payload_i[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \skid_buffer[10]_i_1_n_0\,
      I1 => \^aa_rready\,
      I2 => \skid_buffer_reg_n_0_[10]\,
      O => skid_buffer(10)
    );
\m_payload_i[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \skid_buffer[11]_i_1_n_0\,
      I1 => \^aa_rready\,
      I2 => \skid_buffer_reg_n_0_[11]\,
      O => skid_buffer(11)
    );
\m_payload_i[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => \skid_buffer_reg_n_0_[12]\,
      I1 => \^aa_rready\,
      I2 => \m_payload_i[12]_i_2_n_0\,
      O => skid_buffer(12)
    );
\m_payload_i[12]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330F5500000000"
    )
        port map (
      I0 => m_axi_rdata(9),
      I1 => m_axi_rdata(73),
      I2 => m_axi_rdata(41),
      I3 => Q(0),
      I4 => Q(1),
      I5 => \^aa_rready\,
      O => \m_payload_i[12]_i_2_n_0\
    );
\m_payload_i[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => \skid_buffer_reg_n_0_[13]\,
      I1 => \^aa_rready\,
      I2 => \m_payload_i[13]_i_2_n_0\,
      O => skid_buffer(13)
    );
\m_payload_i[13]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330F5500000000"
    )
        port map (
      I0 => m_axi_rdata(10),
      I1 => m_axi_rdata(74),
      I2 => m_axi_rdata(42),
      I3 => Q(0),
      I4 => Q(1),
      I5 => \^aa_rready\,
      O => \m_payload_i[13]_i_2_n_0\
    );
\m_payload_i[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => \skid_buffer_reg_n_0_[14]\,
      I1 => \^aa_rready\,
      I2 => \m_payload_i[14]_i_2_n_0\,
      O => skid_buffer(14)
    );
\m_payload_i[14]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330F5500000000"
    )
        port map (
      I0 => m_axi_rdata(11),
      I1 => m_axi_rdata(75),
      I2 => m_axi_rdata(43),
      I3 => Q(0),
      I4 => Q(1),
      I5 => \^aa_rready\,
      O => \m_payload_i[14]_i_2_n_0\
    );
\m_payload_i[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => \skid_buffer_reg_n_0_[15]\,
      I1 => \^aa_rready\,
      I2 => \m_payload_i[15]_i_2_n_0\,
      O => skid_buffer(15)
    );
\m_payload_i[15]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330F5500000000"
    )
        port map (
      I0 => m_axi_rdata(12),
      I1 => m_axi_rdata(76),
      I2 => m_axi_rdata(44),
      I3 => Q(0),
      I4 => Q(1),
      I5 => \^aa_rready\,
      O => \m_payload_i[15]_i_2_n_0\
    );
\m_payload_i[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \skid_buffer[16]_i_1_n_0\,
      I1 => \^aa_rready\,
      I2 => \skid_buffer_reg_n_0_[16]\,
      O => skid_buffer(16)
    );
\m_payload_i[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => \skid_buffer_reg_n_0_[17]\,
      I1 => \^aa_rready\,
      I2 => \m_payload_i[17]_i_2_n_0\,
      O => skid_buffer(17)
    );
\m_payload_i[17]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330F5500000000"
    )
        port map (
      I0 => m_axi_rdata(14),
      I1 => m_axi_rdata(78),
      I2 => m_axi_rdata(46),
      I3 => Q(0),
      I4 => Q(1),
      I5 => \^aa_rready\,
      O => \m_payload_i[17]_i_2_n_0\
    );
\m_payload_i[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => \skid_buffer_reg_n_0_[18]\,
      I1 => \^aa_rready\,
      I2 => \m_payload_i[18]_i_2_n_0\,
      O => skid_buffer(18)
    );
\m_payload_i[18]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330F5500000000"
    )
        port map (
      I0 => m_axi_rdata(15),
      I1 => m_axi_rdata(79),
      I2 => m_axi_rdata(47),
      I3 => Q(0),
      I4 => Q(1),
      I5 => \^aa_rready\,
      O => \m_payload_i[18]_i_2_n_0\
    );
\m_payload_i[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \skid_buffer[19]_i_1_n_0\,
      I1 => \^aa_rready\,
      I2 => \skid_buffer_reg_n_0_[19]\,
      O => skid_buffer(19)
    );
\m_payload_i[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => \skid_buffer_reg_n_0_[1]\,
      I1 => \^aa_rready\,
      I2 => \m_payload_i[1]_i_2_n_0\,
      O => skid_buffer(1)
    );
\m_payload_i[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330F5500000000"
    )
        port map (
      I0 => m_axi_rresp(0),
      I1 => m_axi_rresp(4),
      I2 => m_axi_rresp(2),
      I3 => Q(0),
      I4 => Q(1),
      I5 => \^aa_rready\,
      O => \m_payload_i[1]_i_2_n_0\
    );
\m_payload_i[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \skid_buffer[20]_i_1_n_0\,
      I1 => \^aa_rready\,
      I2 => \skid_buffer_reg_n_0_[20]\,
      O => skid_buffer(20)
    );
\m_payload_i[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \skid_buffer[21]_i_1_n_0\,
      I1 => \^aa_rready\,
      I2 => \skid_buffer_reg_n_0_[21]\,
      O => skid_buffer(21)
    );
\m_payload_i[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \skid_buffer[22]_i_1_n_0\,
      I1 => \^aa_rready\,
      I2 => \skid_buffer_reg_n_0_[22]\,
      O => skid_buffer(22)
    );
\m_payload_i[23]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \skid_buffer[23]_i_1_n_0\,
      I1 => \^aa_rready\,
      I2 => \skid_buffer_reg_n_0_[23]\,
      O => skid_buffer(23)
    );
\m_payload_i[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \skid_buffer[24]_i_1_n_0\,
      I1 => \^aa_rready\,
      I2 => \skid_buffer_reg_n_0_[24]\,
      O => skid_buffer(24)
    );
\m_payload_i[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => \skid_buffer_reg_n_0_[25]\,
      I1 => \^aa_rready\,
      I2 => \m_payload_i[25]_i_2_n_0\,
      O => skid_buffer(25)
    );
\m_payload_i[25]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330F5500000000"
    )
        port map (
      I0 => m_axi_rdata(22),
      I1 => m_axi_rdata(86),
      I2 => m_axi_rdata(54),
      I3 => Q(0),
      I4 => Q(1),
      I5 => \^aa_rready\,
      O => \m_payload_i[25]_i_2_n_0\
    );
\m_payload_i[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => \skid_buffer_reg_n_0_[26]\,
      I1 => \^aa_rready\,
      I2 => \m_payload_i[26]_i_2_n_0\,
      O => skid_buffer(26)
    );
\m_payload_i[26]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330F5500000000"
    )
        port map (
      I0 => m_axi_rdata(23),
      I1 => m_axi_rdata(87),
      I2 => m_axi_rdata(55),
      I3 => Q(0),
      I4 => Q(1),
      I5 => \^aa_rready\,
      O => \m_payload_i[26]_i_2_n_0\
    );
\m_payload_i[27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \skid_buffer[27]_i_1_n_0\,
      I1 => \^aa_rready\,
      I2 => \skid_buffer_reg_n_0_[27]\,
      O => skid_buffer(27)
    );
\m_payload_i[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => \skid_buffer_reg_n_0_[28]\,
      I1 => \^aa_rready\,
      I2 => \m_payload_i[28]_i_2_n_0\,
      O => skid_buffer(28)
    );
\m_payload_i[28]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330F5500000000"
    )
        port map (
      I0 => m_axi_rdata(25),
      I1 => m_axi_rdata(89),
      I2 => m_axi_rdata(57),
      I3 => Q(0),
      I4 => Q(1),
      I5 => \^aa_rready\,
      O => \m_payload_i[28]_i_2_n_0\
    );
\m_payload_i[29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => \skid_buffer_reg_n_0_[29]\,
      I1 => \^aa_rready\,
      I2 => \m_payload_i[29]_i_2_n_0\,
      O => skid_buffer(29)
    );
\m_payload_i[29]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330F5500000000"
    )
        port map (
      I0 => m_axi_rdata(26),
      I1 => m_axi_rdata(90),
      I2 => m_axi_rdata(58),
      I3 => Q(0),
      I4 => Q(1),
      I5 => \^aa_rready\,
      O => \m_payload_i[29]_i_2_n_0\
    );
\m_payload_i[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => \skid_buffer_reg_n_0_[2]\,
      I1 => \^aa_rready\,
      I2 => \m_payload_i[2]_i_2_n_0\,
      O => skid_buffer(2)
    );
\m_payload_i[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330F5500000000"
    )
        port map (
      I0 => m_axi_rresp(1),
      I1 => m_axi_rresp(5),
      I2 => m_axi_rresp(3),
      I3 => Q(0),
      I4 => Q(1),
      I5 => \^aa_rready\,
      O => \m_payload_i[2]_i_2_n_0\
    );
\m_payload_i[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => \skid_buffer_reg_n_0_[30]\,
      I1 => \^aa_rready\,
      I2 => \m_payload_i[30]_i_2_n_0\,
      O => skid_buffer(30)
    );
\m_payload_i[30]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330F5500000000"
    )
        port map (
      I0 => m_axi_rdata(27),
      I1 => m_axi_rdata(91),
      I2 => m_axi_rdata(59),
      I3 => Q(0),
      I4 => Q(1),
      I5 => \^aa_rready\,
      O => \m_payload_i[30]_i_2_n_0\
    );
\m_payload_i[31]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => \skid_buffer_reg_n_0_[31]\,
      I1 => \^aa_rready\,
      I2 => \m_payload_i[31]_i_2_n_0\,
      O => skid_buffer(31)
    );
\m_payload_i[31]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330F5500000000"
    )
        port map (
      I0 => m_axi_rdata(28),
      I1 => m_axi_rdata(92),
      I2 => m_axi_rdata(60),
      I3 => Q(0),
      I4 => Q(1),
      I5 => \^aa_rready\,
      O => \m_payload_i[31]_i_2_n_0\
    );
\m_payload_i[32]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \skid_buffer[32]_i_1_n_0\,
      I1 => \^aa_rready\,
      I2 => \skid_buffer_reg_n_0_[32]\,
      O => skid_buffer(32)
    );
\m_payload_i[33]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => \skid_buffer_reg_n_0_[33]\,
      I1 => \^aa_rready\,
      I2 => \m_payload_i[33]_i_2_n_0\,
      O => skid_buffer(33)
    );
\m_payload_i[33]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330F5500000000"
    )
        port map (
      I0 => m_axi_rdata(30),
      I1 => m_axi_rdata(94),
      I2 => m_axi_rdata(62),
      I3 => Q(0),
      I4 => Q(1),
      I5 => \^aa_rready\,
      O => \m_payload_i[33]_i_2_n_0\
    );
\m_payload_i[34]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => \skid_buffer_reg_n_0_[34]\,
      I1 => \^aa_rready\,
      I2 => \m_payload_i[34]_i_3_n_0\,
      O => skid_buffer(34)
    );
\m_payload_i[34]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"003000500030F050"
    )
        port map (
      I0 => m_axi_rdata(31),
      I1 => m_axi_rdata(95),
      I2 => \^aa_rready\,
      I3 => Q(0),
      I4 => Q(1),
      I5 => m_axi_rdata(63),
      O => \m_payload_i[34]_i_3_n_0\
    );
\m_payload_i[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \skid_buffer[3]_i_1_n_0\,
      I1 => \^aa_rready\,
      I2 => \skid_buffer_reg_n_0_[3]\,
      O => skid_buffer(3)
    );
\m_payload_i[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \skid_buffer[4]_i_1_n_0\,
      I1 => \^aa_rready\,
      I2 => \skid_buffer_reg_n_0_[4]\,
      O => skid_buffer(4)
    );
\m_payload_i[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => \skid_buffer_reg_n_0_[5]\,
      I1 => \^aa_rready\,
      I2 => \m_payload_i[5]_i_2_n_0\,
      O => skid_buffer(5)
    );
\m_payload_i[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330F5500000000"
    )
        port map (
      I0 => m_axi_rdata(2),
      I1 => m_axi_rdata(66),
      I2 => m_axi_rdata(34),
      I3 => Q(0),
      I4 => Q(1),
      I5 => \^aa_rready\,
      O => \m_payload_i[5]_i_2_n_0\
    );
\m_payload_i[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => \skid_buffer_reg_n_0_[6]\,
      I1 => \^aa_rready\,
      I2 => \m_payload_i[6]_i_2_n_0\,
      O => skid_buffer(6)
    );
\m_payload_i[6]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330F5500000000"
    )
        port map (
      I0 => m_axi_rdata(3),
      I1 => m_axi_rdata(67),
      I2 => m_axi_rdata(35),
      I3 => Q(0),
      I4 => Q(1),
      I5 => \^aa_rready\,
      O => \m_payload_i[6]_i_2_n_0\
    );
\m_payload_i[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => \skid_buffer_reg_n_0_[7]\,
      I1 => \^aa_rready\,
      I2 => \m_payload_i[7]_i_2_n_0\,
      O => skid_buffer(7)
    );
\m_payload_i[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330F5500000000"
    )
        port map (
      I0 => m_axi_rdata(4),
      I1 => m_axi_rdata(68),
      I2 => m_axi_rdata(36),
      I3 => Q(0),
      I4 => Q(1),
      I5 => \^aa_rready\,
      O => \m_payload_i[7]_i_2_n_0\
    );
\m_payload_i[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \skid_buffer[8]_i_1_n_0\,
      I1 => \^aa_rready\,
      I2 => \skid_buffer_reg_n_0_[8]\,
      O => skid_buffer(8)
    );
\m_payload_i[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \skid_buffer[9]_i_1_n_0\,
      I1 => \^aa_rready\,
      I2 => \skid_buffer_reg_n_0_[9]\,
      O => skid_buffer(9)
    );
\m_payload_i_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(0),
      Q => \m_payload_i_reg_n_0_[0]\,
      R => '0'
    );
\m_payload_i_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(10),
      Q => \m_payload_i_reg[34]_0\(9),
      R => '0'
    );
\m_payload_i_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(11),
      Q => \m_payload_i_reg[34]_0\(10),
      R => '0'
    );
\m_payload_i_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(12),
      Q => \m_payload_i_reg[34]_0\(11),
      R => '0'
    );
\m_payload_i_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(13),
      Q => \m_payload_i_reg[34]_0\(12),
      R => '0'
    );
\m_payload_i_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(14),
      Q => \m_payload_i_reg[34]_0\(13),
      R => '0'
    );
\m_payload_i_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(15),
      Q => \m_payload_i_reg[34]_0\(14),
      R => '0'
    );
\m_payload_i_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(16),
      Q => \m_payload_i_reg[34]_0\(15),
      R => '0'
    );
\m_payload_i_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(17),
      Q => \m_payload_i_reg[34]_0\(16),
      R => '0'
    );
\m_payload_i_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(18),
      Q => \m_payload_i_reg[34]_0\(17),
      R => '0'
    );
\m_payload_i_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(19),
      Q => \m_payload_i_reg[34]_0\(18),
      R => '0'
    );
\m_payload_i_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(1),
      Q => \m_payload_i_reg[34]_0\(0),
      R => '0'
    );
\m_payload_i_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(20),
      Q => \m_payload_i_reg[34]_0\(19),
      R => '0'
    );
\m_payload_i_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(21),
      Q => \m_payload_i_reg[34]_0\(20),
      R => '0'
    );
\m_payload_i_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(22),
      Q => \m_payload_i_reg[34]_0\(21),
      R => '0'
    );
\m_payload_i_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(23),
      Q => \m_payload_i_reg[34]_0\(22),
      R => '0'
    );
\m_payload_i_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(24),
      Q => \m_payload_i_reg[34]_0\(23),
      R => '0'
    );
\m_payload_i_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(25),
      Q => \m_payload_i_reg[34]_0\(24),
      R => '0'
    );
\m_payload_i_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(26),
      Q => \m_payload_i_reg[34]_0\(25),
      R => '0'
    );
\m_payload_i_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(27),
      Q => \m_payload_i_reg[34]_0\(26),
      R => '0'
    );
\m_payload_i_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(28),
      Q => \m_payload_i_reg[34]_0\(27),
      R => '0'
    );
\m_payload_i_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(29),
      Q => \m_payload_i_reg[34]_0\(28),
      R => '0'
    );
\m_payload_i_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(2),
      Q => \m_payload_i_reg[34]_0\(1),
      R => '0'
    );
\m_payload_i_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(30),
      Q => \m_payload_i_reg[34]_0\(29),
      R => '0'
    );
\m_payload_i_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(31),
      Q => \m_payload_i_reg[34]_0\(30),
      R => '0'
    );
\m_payload_i_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(32),
      Q => \m_payload_i_reg[34]_0\(31),
      R => '0'
    );
\m_payload_i_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(33),
      Q => \m_payload_i_reg[34]_0\(32),
      R => '0'
    );
\m_payload_i_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(34),
      Q => \m_payload_i_reg[34]_0\(33),
      R => '0'
    );
\m_payload_i_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(3),
      Q => \m_payload_i_reg[34]_0\(2),
      R => '0'
    );
\m_payload_i_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(4),
      Q => \m_payload_i_reg[34]_0\(3),
      R => '0'
    );
\m_payload_i_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(5),
      Q => \m_payload_i_reg[34]_0\(4),
      R => '0'
    );
\m_payload_i_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(6),
      Q => \m_payload_i_reg[34]_0\(5),
      R => '0'
    );
\m_payload_i_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(7),
      Q => \m_payload_i_reg[34]_0\(6),
      R => '0'
    );
\m_payload_i_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(8),
      Q => \m_payload_i_reg[34]_0\(7),
      R => '0'
    );
\m_payload_i_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => E(0),
      D => skid_buffer(9),
      Q => \m_payload_i_reg[34]_0\(8),
      R => '0'
    );
\m_ready_d[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000007FFFFFFF"
    )
        port map (
      I0 => \^sr_rvalid\,
      I1 => \m_payload_i_reg_n_0_[0]\,
      I2 => s_axi_rready(0),
      I3 => aa_grant_rnw,
      I4 => m_valid_i,
      I5 => m_ready_d(0),
      O => m_valid_i_reg_0
    );
m_valid_i_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => m_valid_i_reg_1,
      Q => \^sr_rvalid\,
      R => '0'
    );
s_ready_i_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => s_ready_i_reg_0,
      Q => \^aa_rready\,
      R => '0'
    );
\skid_buffer[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \^aa_rready\,
      I1 => \skid_buffer_reg_n_0_[0]\,
      O => skid_buffer(0)
    );
\skid_buffer[10]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0CAF0CA0"
    )
        port map (
      I0 => m_axi_rdata(71),
      I1 => m_axi_rdata(39),
      I2 => Q(1),
      I3 => Q(0),
      I4 => m_axi_rdata(7),
      O => \skid_buffer[10]_i_1_n_0\
    );
\skid_buffer[11]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0CAF0CA0"
    )
        port map (
      I0 => m_axi_rdata(72),
      I1 => m_axi_rdata(40),
      I2 => Q(1),
      I3 => Q(0),
      I4 => m_axi_rdata(8),
      O => \skid_buffer[11]_i_1_n_0\
    );
\skid_buffer[16]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0CAF0CA0"
    )
        port map (
      I0 => m_axi_rdata(77),
      I1 => m_axi_rdata(45),
      I2 => Q(1),
      I3 => Q(0),
      I4 => m_axi_rdata(13),
      O => \skid_buffer[16]_i_1_n_0\
    );
\skid_buffer[19]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0CAF0CA0"
    )
        port map (
      I0 => m_axi_rdata(80),
      I1 => m_axi_rdata(48),
      I2 => Q(1),
      I3 => Q(0),
      I4 => m_axi_rdata(16),
      O => \skid_buffer[19]_i_1_n_0\
    );
\skid_buffer[20]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0FCA00CA"
    )
        port map (
      I0 => m_axi_rdata(17),
      I1 => m_axi_rdata(81),
      I2 => Q(1),
      I3 => Q(0),
      I4 => m_axi_rdata(49),
      O => \skid_buffer[20]_i_1_n_0\
    );
\skid_buffer[21]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0CAF0CA0"
    )
        port map (
      I0 => m_axi_rdata(82),
      I1 => m_axi_rdata(50),
      I2 => Q(1),
      I3 => Q(0),
      I4 => m_axi_rdata(18),
      O => \skid_buffer[21]_i_1_n_0\
    );
\skid_buffer[22]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0CAF0CA0"
    )
        port map (
      I0 => m_axi_rdata(83),
      I1 => m_axi_rdata(51),
      I2 => Q(1),
      I3 => Q(0),
      I4 => m_axi_rdata(19),
      O => \skid_buffer[22]_i_1_n_0\
    );
\skid_buffer[23]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0FCA00CA"
    )
        port map (
      I0 => m_axi_rdata(20),
      I1 => m_axi_rdata(52),
      I2 => Q(0),
      I3 => Q(1),
      I4 => m_axi_rdata(84),
      O => \skid_buffer[23]_i_1_n_0\
    );
\skid_buffer[24]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0CAF0CA0"
    )
        port map (
      I0 => m_axi_rdata(85),
      I1 => m_axi_rdata(53),
      I2 => Q(1),
      I3 => Q(0),
      I4 => m_axi_rdata(21),
      O => \skid_buffer[24]_i_1_n_0\
    );
\skid_buffer[27]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0FCA00CA"
    )
        port map (
      I0 => m_axi_rdata(24),
      I1 => m_axi_rdata(56),
      I2 => Q(0),
      I3 => Q(1),
      I4 => m_axi_rdata(88),
      O => \skid_buffer[27]_i_1_n_0\
    );
\skid_buffer[32]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0FCA00CA"
    )
        port map (
      I0 => m_axi_rdata(29),
      I1 => m_axi_rdata(61),
      I2 => Q(0),
      I3 => Q(1),
      I4 => m_axi_rdata(93),
      O => \skid_buffer[32]_i_1_n_0\
    );
\skid_buffer[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0CAF0CA0"
    )
        port map (
      I0 => m_axi_rdata(64),
      I1 => m_axi_rdata(32),
      I2 => Q(1),
      I3 => Q(0),
      I4 => m_axi_rdata(0),
      O => \skid_buffer[3]_i_1_n_0\
    );
\skid_buffer[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0CAF0CA0"
    )
        port map (
      I0 => m_axi_rdata(65),
      I1 => m_axi_rdata(33),
      I2 => Q(1),
      I3 => Q(0),
      I4 => m_axi_rdata(1),
      O => \skid_buffer[4]_i_1_n_0\
    );
\skid_buffer[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0CAF0CA0"
    )
        port map (
      I0 => m_axi_rdata(69),
      I1 => m_axi_rdata(37),
      I2 => Q(1),
      I3 => Q(0),
      I4 => m_axi_rdata(5),
      O => \skid_buffer[8]_i_1_n_0\
    );
\skid_buffer[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0CAF0CA0"
    )
        port map (
      I0 => m_axi_rdata(70),
      I1 => m_axi_rdata(38),
      I2 => Q(1),
      I3 => Q(0),
      I4 => m_axi_rdata(6),
      O => \skid_buffer[9]_i_1_n_0\
    );
\skid_buffer_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => skid_buffer(0),
      Q => \skid_buffer_reg_n_0_[0]\,
      R => '0'
    );
\skid_buffer_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^aa_rready\,
      D => \skid_buffer[10]_i_1_n_0\,
      Q => \skid_buffer_reg_n_0_[10]\,
      R => '0'
    );
\skid_buffer_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^aa_rready\,
      D => \skid_buffer[11]_i_1_n_0\,
      Q => \skid_buffer_reg_n_0_[11]\,
      R => '0'
    );
\skid_buffer_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => skid_buffer(12),
      Q => \skid_buffer_reg_n_0_[12]\,
      R => '0'
    );
\skid_buffer_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => skid_buffer(13),
      Q => \skid_buffer_reg_n_0_[13]\,
      R => '0'
    );
\skid_buffer_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => skid_buffer(14),
      Q => \skid_buffer_reg_n_0_[14]\,
      R => '0'
    );
\skid_buffer_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => skid_buffer(15),
      Q => \skid_buffer_reg_n_0_[15]\,
      R => '0'
    );
\skid_buffer_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^aa_rready\,
      D => \skid_buffer[16]_i_1_n_0\,
      Q => \skid_buffer_reg_n_0_[16]\,
      R => '0'
    );
\skid_buffer_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => skid_buffer(17),
      Q => \skid_buffer_reg_n_0_[17]\,
      R => '0'
    );
\skid_buffer_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => skid_buffer(18),
      Q => \skid_buffer_reg_n_0_[18]\,
      R => '0'
    );
\skid_buffer_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^aa_rready\,
      D => \skid_buffer[19]_i_1_n_0\,
      Q => \skid_buffer_reg_n_0_[19]\,
      R => '0'
    );
\skid_buffer_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => skid_buffer(1),
      Q => \skid_buffer_reg_n_0_[1]\,
      R => '0'
    );
\skid_buffer_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^aa_rready\,
      D => \skid_buffer[20]_i_1_n_0\,
      Q => \skid_buffer_reg_n_0_[20]\,
      R => '0'
    );
\skid_buffer_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^aa_rready\,
      D => \skid_buffer[21]_i_1_n_0\,
      Q => \skid_buffer_reg_n_0_[21]\,
      R => '0'
    );
\skid_buffer_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^aa_rready\,
      D => \skid_buffer[22]_i_1_n_0\,
      Q => \skid_buffer_reg_n_0_[22]\,
      R => '0'
    );
\skid_buffer_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^aa_rready\,
      D => \skid_buffer[23]_i_1_n_0\,
      Q => \skid_buffer_reg_n_0_[23]\,
      R => '0'
    );
\skid_buffer_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^aa_rready\,
      D => \skid_buffer[24]_i_1_n_0\,
      Q => \skid_buffer_reg_n_0_[24]\,
      R => '0'
    );
\skid_buffer_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => skid_buffer(25),
      Q => \skid_buffer_reg_n_0_[25]\,
      R => '0'
    );
\skid_buffer_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => skid_buffer(26),
      Q => \skid_buffer_reg_n_0_[26]\,
      R => '0'
    );
\skid_buffer_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^aa_rready\,
      D => \skid_buffer[27]_i_1_n_0\,
      Q => \skid_buffer_reg_n_0_[27]\,
      R => '0'
    );
\skid_buffer_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => skid_buffer(28),
      Q => \skid_buffer_reg_n_0_[28]\,
      R => '0'
    );
\skid_buffer_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => skid_buffer(29),
      Q => \skid_buffer_reg_n_0_[29]\,
      R => '0'
    );
\skid_buffer_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => skid_buffer(2),
      Q => \skid_buffer_reg_n_0_[2]\,
      R => '0'
    );
\skid_buffer_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => skid_buffer(30),
      Q => \skid_buffer_reg_n_0_[30]\,
      R => '0'
    );
\skid_buffer_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => skid_buffer(31),
      Q => \skid_buffer_reg_n_0_[31]\,
      R => '0'
    );
\skid_buffer_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^aa_rready\,
      D => \skid_buffer[32]_i_1_n_0\,
      Q => \skid_buffer_reg_n_0_[32]\,
      R => '0'
    );
\skid_buffer_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => skid_buffer(33),
      Q => \skid_buffer_reg_n_0_[33]\,
      R => '0'
    );
\skid_buffer_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => skid_buffer(34),
      Q => \skid_buffer_reg_n_0_[34]\,
      R => '0'
    );
\skid_buffer_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^aa_rready\,
      D => \skid_buffer[3]_i_1_n_0\,
      Q => \skid_buffer_reg_n_0_[3]\,
      R => '0'
    );
\skid_buffer_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^aa_rready\,
      D => \skid_buffer[4]_i_1_n_0\,
      Q => \skid_buffer_reg_n_0_[4]\,
      R => '0'
    );
\skid_buffer_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => skid_buffer(5),
      Q => \skid_buffer_reg_n_0_[5]\,
      R => '0'
    );
\skid_buffer_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => skid_buffer(6),
      Q => \skid_buffer_reg_n_0_[6]\,
      R => '0'
    );
\skid_buffer_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => skid_buffer(7),
      Q => \skid_buffer_reg_n_0_[7]\,
      R => '0'
    );
\skid_buffer_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^aa_rready\,
      D => \skid_buffer[8]_i_1_n_0\,
      Q => \skid_buffer_reg_n_0_[8]\,
      R => '0'
    );
\skid_buffer_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => \^aa_rready\,
      D => \skid_buffer[9]_i_1_n_0\,
      Q => \skid_buffer_reg_n_0_[9]\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_crossbar_sasd is
  port (
    Q : out STD_LOGIC_VECTOR ( 34 downto 0 );
    \m_payload_i_reg[34]\ : out STD_LOGIC_VECTOR ( 33 downto 0 );
    s_axi_bvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_bready : out STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_wready : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rready : out STD_LOGIC_VECTOR ( 2 downto 0 );
    aresetn : in STD_LOGIC;
    aclk : in STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 95 downto 0 );
    m_axi_rvalid : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_wready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_bvalid : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_crossbar_sasd;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_crossbar_sasd is
  signal aa_grant_rnw : STD_LOGIC;
  signal aa_rready : STD_LOGIC;
  signal addr_arbiter_inst_n_3 : STD_LOGIC;
  signal addr_arbiter_inst_n_45 : STD_LOGIC;
  signal addr_arbiter_inst_n_5 : STD_LOGIC;
  signal addr_arbiter_inst_n_50 : STD_LOGIC;
  signal addr_arbiter_inst_n_52 : STD_LOGIC;
  signal addr_arbiter_inst_n_59 : STD_LOGIC;
  signal addr_arbiter_inst_n_6 : STD_LOGIC;
  signal addr_arbiter_inst_n_60 : STD_LOGIC;
  signal addr_arbiter_inst_n_61 : STD_LOGIC;
  signal addr_arbiter_inst_n_66 : STD_LOGIC;
  signal addr_arbiter_inst_n_70 : STD_LOGIC;
  signal addr_arbiter_inst_n_8 : STD_LOGIC;
  signal aresetn_d : STD_LOGIC;
  signal \gen_decerr.decerr_slave_inst_n_2\ : STD_LOGIC;
  signal \gen_decerr.decerr_slave_inst_n_3\ : STD_LOGIC;
  signal \gen_decerr.decerr_slave_inst_n_4\ : STD_LOGIC;
  signal \gen_decerr.decerr_slave_inst_n_5\ : STD_LOGIC;
  signal \gen_decerr.decerr_slave_inst_n_6\ : STD_LOGIC;
  signal \gen_decerr.decerr_slave_inst_n_7\ : STD_LOGIC;
  signal m_atarget_enc : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m_atarget_hot : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m_atarget_hot0 : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m_ready_d : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m_ready_d0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m_ready_d_0 : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m_valid_i : STD_LOGIC;
  signal mi_bvalid : STD_LOGIC_VECTOR ( 3 to 3 );
  signal mi_wready : STD_LOGIC_VECTOR ( 3 to 3 );
  signal p_1_in : STD_LOGIC;
  signal reg_slice_r_n_2 : STD_LOGIC;
  signal reg_slice_r_n_6 : STD_LOGIC;
  signal reg_slice_r_n_7 : STD_LOGIC;
  signal reset : STD_LOGIC;
  signal splitter_aw_n_0 : STD_LOGIC;
  signal sr_rvalid : STD_LOGIC;
begin
addr_arbiter_inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_addr_arbiter_sasd
     port map (
      D(3) => m_atarget_hot0(3),
      D(2) => addr_arbiter_inst_n_5,
      D(1) => addr_arbiter_inst_n_6,
      D(0) => m_atarget_hot0(0),
      E(0) => p_1_in,
      Q(34 downto 0) => Q(34 downto 0),
      SR(0) => reset,
      aa_grant_rnw => aa_grant_rnw,
      aa_rready => aa_rready,
      aclk => aclk,
      aresetn_d => aresetn_d,
      \aresetn_d_reg[0]\ => addr_arbiter_inst_n_60,
      \aresetn_d_reg[1]\ => addr_arbiter_inst_n_61,
      \gen_axilite.s_axi_awready_i_reg\(3 downto 0) => m_atarget_hot(3 downto 0),
      \gen_no_arbiter.grant_rnw_reg_0\ => addr_arbiter_inst_n_50,
      \gen_no_arbiter.grant_rnw_reg_1\ => addr_arbiter_inst_n_52,
      \gen_no_arbiter.grant_rnw_reg_2\ => addr_arbiter_inst_n_59,
      \gen_no_arbiter.m_amesg_i_reg[20]_0\ => addr_arbiter_inst_n_3,
      \gen_no_arbiter.m_amesg_i_reg[20]_1\ => addr_arbiter_inst_n_8,
      \gen_no_arbiter.m_grant_hot_i_reg[0]_0\ => \gen_decerr.decerr_slave_inst_n_2\,
      \gen_no_arbiter.m_valid_i_reg_0\ => \gen_decerr.decerr_slave_inst_n_7\,
      \gen_no_arbiter.m_valid_i_reg_1\ => reg_slice_r_n_2,
      \m_atarget_hot_reg[3]\ => addr_arbiter_inst_n_70,
      m_axi_arvalid(2 downto 0) => m_axi_arvalid(2 downto 0),
      m_axi_awvalid(2 downto 0) => m_axi_awvalid(2 downto 0),
      m_axi_bready(2 downto 0) => m_axi_bready(2 downto 0),
      m_axi_wvalid(2 downto 0) => m_axi_wvalid(2 downto 0),
      m_ready_d(2 downto 0) => m_ready_d_0(2 downto 0),
      m_ready_d0(0) => m_ready_d0(0),
      m_ready_d_0(1 downto 0) => m_ready_d(1 downto 0),
      \m_ready_d_reg[1]\ => addr_arbiter_inst_n_66,
      \m_ready_d_reg[2]\ => addr_arbiter_inst_n_45,
      \m_ready_d_reg[2]_0\ => \gen_decerr.decerr_slave_inst_n_4\,
      m_valid_i => m_valid_i,
      m_valid_i_reg(1) => reg_slice_r_n_6,
      m_valid_i_reg(0) => reg_slice_r_n_7,
      m_valid_i_reg_0 => \gen_decerr.decerr_slave_inst_n_5\,
      mi_bvalid(0) => mi_bvalid(3),
      mi_wready(0) => mi_wready(3),
      s_axi_araddr(31 downto 0) => s_axi_araddr(31 downto 0),
      s_axi_arprot(2 downto 0) => s_axi_arprot(2 downto 0),
      s_axi_arready(0) => s_axi_arready(0),
      s_axi_arvalid(0) => s_axi_arvalid(0),
      s_axi_awaddr(31 downto 0) => s_axi_awaddr(31 downto 0),
      s_axi_awprot(2 downto 0) => s_axi_awprot(2 downto 0),
      s_axi_awready(0) => s_axi_awready(0),
      s_axi_awvalid(0) => s_axi_awvalid(0),
      s_axi_bready(0) => s_axi_bready(0),
      s_axi_bvalid(0) => s_axi_bvalid(0),
      s_axi_bvalid_0_sp_1 => \gen_decerr.decerr_slave_inst_n_6\,
      s_axi_rready(0) => s_axi_rready(0),
      s_axi_rvalid(0) => s_axi_rvalid(0),
      s_axi_wready(0) => s_axi_wready(0),
      s_axi_wready_0_sp_1 => \gen_decerr.decerr_slave_inst_n_3\,
      s_axi_wvalid(0) => s_axi_wvalid(0),
      sr_rvalid => sr_rvalid
    );
aresetn_d_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => aresetn,
      Q => aresetn_d,
      R => '0'
    );
\gen_decerr.decerr_slave_inst\: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_decerr_slave
     port map (
      Q(0) => m_atarget_hot(3),
      SR(0) => reset,
      aa_rready => aa_rready,
      aclk => aclk,
      aresetn_d => aresetn_d,
      \gen_axilite.s_axi_awready_i_reg_0\ => addr_arbiter_inst_n_70,
      \gen_axilite.s_axi_bvalid_i_reg_0\ => addr_arbiter_inst_n_50,
      \gen_axilite.s_axi_bvalid_i_reg_1\ => splitter_aw_n_0,
      \gen_axilite.s_axi_rvalid_i_reg_0\ => addr_arbiter_inst_n_66,
      \gen_no_arbiter.m_grant_hot_i_reg[0]\ => addr_arbiter_inst_n_59,
      m_axi_arready(2 downto 0) => m_axi_arready(2 downto 0),
      m_axi_arready_2_sp_1 => \gen_decerr.decerr_slave_inst_n_7\,
      m_axi_awready(2 downto 0) => m_axi_awready(2 downto 0),
      m_axi_awready_0_sp_1 => \gen_decerr.decerr_slave_inst_n_4\,
      m_axi_bvalid(2 downto 0) => m_axi_bvalid(2 downto 0),
      m_axi_bvalid_2_sp_1 => \gen_decerr.decerr_slave_inst_n_6\,
      m_axi_rvalid(2 downto 0) => m_axi_rvalid(2 downto 0),
      m_axi_rvalid_1_sp_1 => \gen_decerr.decerr_slave_inst_n_5\,
      m_axi_wready(2 downto 0) => m_axi_wready(2 downto 0),
      m_axi_wready_0_sp_1 => \gen_decerr.decerr_slave_inst_n_3\,
      m_ready_d(1 downto 0) => m_ready_d_0(2 downto 1),
      mi_bvalid(0) => mi_bvalid(3),
      mi_wready(0) => mi_wready(3),
      \s_axi_wready[0]\(1 downto 0) => m_atarget_enc(1 downto 0),
      s_axi_wvalid(0) => s_axi_wvalid(0),
      s_axi_wvalid_0_sp_1 => \gen_decerr.decerr_slave_inst_n_2\
    );
\m_atarget_enc_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => addr_arbiter_inst_n_8,
      Q => m_atarget_enc(0),
      R => reset
    );
\m_atarget_enc_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => addr_arbiter_inst_n_3,
      Q => m_atarget_enc(1),
      R => reset
    );
\m_atarget_hot_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => m_atarget_hot0(0),
      Q => m_atarget_hot(0),
      R => reset
    );
\m_atarget_hot_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => addr_arbiter_inst_n_6,
      Q => m_atarget_hot(1),
      R => reset
    );
\m_atarget_hot_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => addr_arbiter_inst_n_5,
      Q => m_atarget_hot(2),
      R => reset
    );
\m_atarget_hot_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => m_atarget_hot0(3),
      Q => m_atarget_hot(3),
      R => reset
    );
reg_slice_r: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_register_slice_v2_1_18_axic_register_slice
     port map (
      E(0) => p_1_in,
      Q(1 downto 0) => m_atarget_enc(1 downto 0),
      SR(0) => reset,
      aa_grant_rnw => aa_grant_rnw,
      aa_rready => aa_rready,
      aclk => aclk,
      \aresetn_d_reg[1]_0\(1) => reg_slice_r_n_6,
      \aresetn_d_reg[1]_0\(0) => reg_slice_r_n_7,
      m_axi_rdata(95 downto 0) => m_axi_rdata(95 downto 0),
      m_axi_rready(2 downto 0) => m_axi_rready(2 downto 0),
      \m_axi_rready[2]\(2 downto 0) => m_atarget_hot(2 downto 0),
      m_axi_rresp(5 downto 0) => m_axi_rresp(5 downto 0),
      \m_payload_i_reg[34]_0\(33 downto 0) => \m_payload_i_reg[34]\(33 downto 0),
      m_ready_d(0) => m_ready_d(0),
      m_valid_i => m_valid_i,
      m_valid_i_reg_0 => reg_slice_r_n_2,
      m_valid_i_reg_1 => addr_arbiter_inst_n_61,
      s_axi_rready(0) => s_axi_rready(0),
      s_ready_i_reg_0 => addr_arbiter_inst_n_60,
      sr_rvalid => sr_rvalid
    );
\s_axi_bresp[0]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FCEEFC22"
    )
        port map (
      I0 => m_axi_bresp(0),
      I1 => m_atarget_enc(0),
      I2 => m_axi_bresp(4),
      I3 => m_atarget_enc(1),
      I4 => m_axi_bresp(2),
      O => s_axi_bresp(0)
    );
\s_axi_bresp[1]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FCEEFC22"
    )
        port map (
      I0 => m_axi_bresp(1),
      I1 => m_atarget_enc(0),
      I2 => m_axi_bresp(5),
      I3 => m_atarget_enc(1),
      I4 => m_axi_bresp(3),
      O => s_axi_bresp(1)
    );
splitter_ar: entity work.\decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_splitter__parameterized0\
     port map (
      aa_grant_rnw => aa_grant_rnw,
      aclk => aclk,
      aresetn_d => aresetn_d,
      m_ready_d(1 downto 0) => m_ready_d(1 downto 0),
      \m_ready_d_reg[1]_0\ => \gen_decerr.decerr_slave_inst_n_7\,
      \m_ready_d_reg[1]_1\ => reg_slice_r_n_2,
      m_valid_i => m_valid_i
    );
splitter_aw: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_splitter
     port map (
      Q(0) => m_atarget_hot(3),
      aa_grant_rnw => aa_grant_rnw,
      aclk => aclk,
      aresetn_d => aresetn_d,
      m_ready_d(2 downto 0) => m_ready_d_0(2 downto 0),
      m_ready_d0(0) => m_ready_d0(0),
      \m_ready_d_reg[2]_0\ => addr_arbiter_inst_n_45,
      \m_ready_d_reg[2]_1\ => addr_arbiter_inst_n_52,
      m_valid_i => m_valid_i,
      s_axi_wvalid(0) => s_axi_wvalid(0),
      s_axi_wvalid_0_sp_1 => splitter_aw_n_0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_axi_crossbar is
  port (
    Q : out STD_LOGIC_VECTOR ( 34 downto 0 );
    \m_payload_i_reg[34]\ : out STD_LOGIC_VECTOR ( 33 downto 0 );
    s_axi_bvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_bready : out STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_wready : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rready : out STD_LOGIC_VECTOR ( 2 downto 0 );
    aresetn : in STD_LOGIC;
    aclk : in STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 95 downto 0 );
    m_axi_rvalid : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_wready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_bvalid : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_axi_crossbar;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_axi_crossbar is
begin
\gen_sasd.crossbar_sasd_0\: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_crossbar_sasd
     port map (
      Q(34 downto 0) => Q(34 downto 0),
      aclk => aclk,
      aresetn => aresetn,
      m_axi_arready(2 downto 0) => m_axi_arready(2 downto 0),
      m_axi_arvalid(2 downto 0) => m_axi_arvalid(2 downto 0),
      m_axi_awready(2 downto 0) => m_axi_awready(2 downto 0),
      m_axi_awvalid(2 downto 0) => m_axi_awvalid(2 downto 0),
      m_axi_bready(2 downto 0) => m_axi_bready(2 downto 0),
      m_axi_bresp(5 downto 0) => m_axi_bresp(5 downto 0),
      m_axi_bvalid(2 downto 0) => m_axi_bvalid(2 downto 0),
      m_axi_rdata(95 downto 0) => m_axi_rdata(95 downto 0),
      m_axi_rready(2 downto 0) => m_axi_rready(2 downto 0),
      m_axi_rresp(5 downto 0) => m_axi_rresp(5 downto 0),
      m_axi_rvalid(2 downto 0) => m_axi_rvalid(2 downto 0),
      m_axi_wready(2 downto 0) => m_axi_wready(2 downto 0),
      m_axi_wvalid(2 downto 0) => m_axi_wvalid(2 downto 0),
      \m_payload_i_reg[34]\(33 downto 0) => \m_payload_i_reg[34]\(33 downto 0),
      s_axi_araddr(31 downto 0) => s_axi_araddr(31 downto 0),
      s_axi_arprot(2 downto 0) => s_axi_arprot(2 downto 0),
      s_axi_arready(0) => s_axi_arready(0),
      s_axi_arvalid(0) => s_axi_arvalid(0),
      s_axi_awaddr(31 downto 0) => s_axi_awaddr(31 downto 0),
      s_axi_awprot(2 downto 0) => s_axi_awprot(2 downto 0),
      s_axi_awready(0) => s_axi_awready(0),
      s_axi_awvalid(0) => s_axi_awvalid(0),
      s_axi_bready(0) => s_axi_bready(0),
      s_axi_bresp(1 downto 0) => s_axi_bresp(1 downto 0),
      s_axi_bvalid(0) => s_axi_bvalid(0),
      s_axi_rready(0) => s_axi_rready(0),
      s_axi_rvalid(0) => s_axi_rvalid(0),
      s_axi_wready(0) => s_axi_wready(0),
      s_axi_wvalid(0) => s_axi_wvalid(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 95 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 8 downto 0 );
    m_axi_awvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_wdata : out STD_LOGIC_VECTOR ( 95 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 11 downto 0 );
    m_axi_wvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_wready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_bvalid : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_bready : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_araddr : out STD_LOGIC_VECTOR ( 95 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 8 downto 0 );
    m_axi_arvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 95 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 5 downto 0 );
    m_axi_rvalid : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_rready : out STD_LOGIC_VECTOR ( 2 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "zynq_blk_xbar_0,axi_crossbar_v2_1_19_axi_crossbar,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "axi_crossbar_v2_1_19_axi_crossbar,Vivado 2018.3";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  signal \^m_axi_araddr\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \^m_axi_arprot\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \^m_axi_awaddr\ : STD_LOGIC_VECTOR ( 95 downto 80 );
  signal \^s_axi_wdata\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \^s_axi_wstrb\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of aclk : signal is "xilinx.com:signal:clock:1.0 CLKIF CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of aclk : signal is "XIL_INTERFACENAME CLKIF, FREQ_HZ 1e+08, PHASE 0.000, CLK_DOMAIN zynq_blk_processing_system7_0_0_FCLK_CLK0, ASSOCIATED_BUSIF M00_AXI:M01_AXI:M02_AXI:M03_AXI:M04_AXI:M05_AXI:M06_AXI:M07_AXI:M08_AXI:M09_AXI:M10_AXI:M11_AXI:M12_AXI:M13_AXI:M14_AXI:M15_AXI:S00_AXI:S01_AXI:S02_AXI:S03_AXI:S04_AXI:S05_AXI:S06_AXI:S07_AXI:S08_AXI:S09_AXI:S10_AXI:S11_AXI:S12_AXI:S13_AXI:S14_AXI:S15_AXI, ASSOCIATED_RESET ARESETN, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of aresetn : signal is "xilinx.com:signal:reset:1.0 RSTIF RST";
  attribute X_INTERFACE_PARAMETER of aresetn : signal is "XIL_INTERFACENAME RSTIF, POLARITY ACTIVE_LOW, INSERT_VIP 0, TYPE INTERCONNECT";
  attribute X_INTERFACE_INFO of m_axi_araddr : signal is "xilinx.com:interface:aximm:1.0 M00_AXI ARADDR [31:0] [31:0], xilinx.com:interface:aximm:1.0 M01_AXI ARADDR [31:0] [63:32], xilinx.com:interface:aximm:1.0 M02_AXI ARADDR [31:0] [95:64]";
  attribute X_INTERFACE_INFO of m_axi_arprot : signal is "xilinx.com:interface:aximm:1.0 M00_AXI ARPROT [2:0] [2:0], xilinx.com:interface:aximm:1.0 M01_AXI ARPROT [2:0] [5:3], xilinx.com:interface:aximm:1.0 M02_AXI ARPROT [2:0] [8:6]";
  attribute X_INTERFACE_INFO of m_axi_arready : signal is "xilinx.com:interface:aximm:1.0 M00_AXI ARREADY [0:0] [0:0], xilinx.com:interface:aximm:1.0 M01_AXI ARREADY [0:0] [1:1], xilinx.com:interface:aximm:1.0 M02_AXI ARREADY [0:0] [2:2]";
  attribute X_INTERFACE_INFO of m_axi_arvalid : signal is "xilinx.com:interface:aximm:1.0 M00_AXI ARVALID [0:0] [0:0], xilinx.com:interface:aximm:1.0 M01_AXI ARVALID [0:0] [1:1], xilinx.com:interface:aximm:1.0 M02_AXI ARVALID [0:0] [2:2]";
  attribute X_INTERFACE_INFO of m_axi_awaddr : signal is "xilinx.com:interface:aximm:1.0 M00_AXI AWADDR [31:0] [31:0], xilinx.com:interface:aximm:1.0 M01_AXI AWADDR [31:0] [63:32], xilinx.com:interface:aximm:1.0 M02_AXI AWADDR [31:0] [95:64]";
  attribute X_INTERFACE_INFO of m_axi_awprot : signal is "xilinx.com:interface:aximm:1.0 M00_AXI AWPROT [2:0] [2:0], xilinx.com:interface:aximm:1.0 M01_AXI AWPROT [2:0] [5:3], xilinx.com:interface:aximm:1.0 M02_AXI AWPROT [2:0] [8:6]";
  attribute X_INTERFACE_INFO of m_axi_awready : signal is "xilinx.com:interface:aximm:1.0 M00_AXI AWREADY [0:0] [0:0], xilinx.com:interface:aximm:1.0 M01_AXI AWREADY [0:0] [1:1], xilinx.com:interface:aximm:1.0 M02_AXI AWREADY [0:0] [2:2]";
  attribute X_INTERFACE_INFO of m_axi_awvalid : signal is "xilinx.com:interface:aximm:1.0 M00_AXI AWVALID [0:0] [0:0], xilinx.com:interface:aximm:1.0 M01_AXI AWVALID [0:0] [1:1], xilinx.com:interface:aximm:1.0 M02_AXI AWVALID [0:0] [2:2]";
  attribute X_INTERFACE_INFO of m_axi_bready : signal is "xilinx.com:interface:aximm:1.0 M00_AXI BREADY [0:0] [0:0], xilinx.com:interface:aximm:1.0 M01_AXI BREADY [0:0] [1:1], xilinx.com:interface:aximm:1.0 M02_AXI BREADY [0:0] [2:2]";
  attribute X_INTERFACE_INFO of m_axi_bresp : signal is "xilinx.com:interface:aximm:1.0 M00_AXI BRESP [1:0] [1:0], xilinx.com:interface:aximm:1.0 M01_AXI BRESP [1:0] [3:2], xilinx.com:interface:aximm:1.0 M02_AXI BRESP [1:0] [5:4]";
  attribute X_INTERFACE_INFO of m_axi_bvalid : signal is "xilinx.com:interface:aximm:1.0 M00_AXI BVALID [0:0] [0:0], xilinx.com:interface:aximm:1.0 M01_AXI BVALID [0:0] [1:1], xilinx.com:interface:aximm:1.0 M02_AXI BVALID [0:0] [2:2]";
  attribute X_INTERFACE_INFO of m_axi_rdata : signal is "xilinx.com:interface:aximm:1.0 M00_AXI RDATA [31:0] [31:0], xilinx.com:interface:aximm:1.0 M01_AXI RDATA [31:0] [63:32], xilinx.com:interface:aximm:1.0 M02_AXI RDATA [31:0] [95:64]";
  attribute X_INTERFACE_INFO of m_axi_rready : signal is "xilinx.com:interface:aximm:1.0 M00_AXI RREADY [0:0] [0:0], xilinx.com:interface:aximm:1.0 M01_AXI RREADY [0:0] [1:1], xilinx.com:interface:aximm:1.0 M02_AXI RREADY [0:0] [2:2]";
  attribute X_INTERFACE_PARAMETER of m_axi_rready : signal is "XIL_INTERFACENAME M00_AXI, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 1e+08, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN zynq_blk_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0, XIL_INTERFACENAME M01_AXI, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 1e+08, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN zynq_blk_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0, XIL_INTERFACENAME M02_AXI, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 1e+08, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN zynq_blk_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_axi_rresp : signal is "xilinx.com:interface:aximm:1.0 M00_AXI RRESP [1:0] [1:0], xilinx.com:interface:aximm:1.0 M01_AXI RRESP [1:0] [3:2], xilinx.com:interface:aximm:1.0 M02_AXI RRESP [1:0] [5:4]";
  attribute X_INTERFACE_INFO of m_axi_rvalid : signal is "xilinx.com:interface:aximm:1.0 M00_AXI RVALID [0:0] [0:0], xilinx.com:interface:aximm:1.0 M01_AXI RVALID [0:0] [1:1], xilinx.com:interface:aximm:1.0 M02_AXI RVALID [0:0] [2:2]";
  attribute X_INTERFACE_INFO of m_axi_wdata : signal is "xilinx.com:interface:aximm:1.0 M00_AXI WDATA [31:0] [31:0], xilinx.com:interface:aximm:1.0 M01_AXI WDATA [31:0] [63:32], xilinx.com:interface:aximm:1.0 M02_AXI WDATA [31:0] [95:64]";
  attribute X_INTERFACE_INFO of m_axi_wready : signal is "xilinx.com:interface:aximm:1.0 M00_AXI WREADY [0:0] [0:0], xilinx.com:interface:aximm:1.0 M01_AXI WREADY [0:0] [1:1], xilinx.com:interface:aximm:1.0 M02_AXI WREADY [0:0] [2:2]";
  attribute X_INTERFACE_INFO of m_axi_wstrb : signal is "xilinx.com:interface:aximm:1.0 M00_AXI WSTRB [3:0] [3:0], xilinx.com:interface:aximm:1.0 M01_AXI WSTRB [3:0] [7:4], xilinx.com:interface:aximm:1.0 M02_AXI WSTRB [3:0] [11:8]";
  attribute X_INTERFACE_INFO of m_axi_wvalid : signal is "xilinx.com:interface:aximm:1.0 M00_AXI WVALID [0:0] [0:0], xilinx.com:interface:aximm:1.0 M01_AXI WVALID [0:0] [1:1], xilinx.com:interface:aximm:1.0 M02_AXI WVALID [0:0] [2:2]";
  attribute X_INTERFACE_INFO of s_axi_araddr : signal is "xilinx.com:interface:aximm:1.0 S00_AXI ARADDR";
  attribute X_INTERFACE_INFO of s_axi_arprot : signal is "xilinx.com:interface:aximm:1.0 S00_AXI ARPROT";
  attribute X_INTERFACE_INFO of s_axi_arready : signal is "xilinx.com:interface:aximm:1.0 S00_AXI ARREADY";
  attribute X_INTERFACE_INFO of s_axi_arvalid : signal is "xilinx.com:interface:aximm:1.0 S00_AXI ARVALID";
  attribute X_INTERFACE_INFO of s_axi_awaddr : signal is "xilinx.com:interface:aximm:1.0 S00_AXI AWADDR";
  attribute X_INTERFACE_INFO of s_axi_awprot : signal is "xilinx.com:interface:aximm:1.0 S00_AXI AWPROT";
  attribute X_INTERFACE_INFO of s_axi_awready : signal is "xilinx.com:interface:aximm:1.0 S00_AXI AWREADY";
  attribute X_INTERFACE_INFO of s_axi_awvalid : signal is "xilinx.com:interface:aximm:1.0 S00_AXI AWVALID";
  attribute X_INTERFACE_INFO of s_axi_bready : signal is "xilinx.com:interface:aximm:1.0 S00_AXI BREADY";
  attribute X_INTERFACE_INFO of s_axi_bresp : signal is "xilinx.com:interface:aximm:1.0 S00_AXI BRESP";
  attribute X_INTERFACE_INFO of s_axi_bvalid : signal is "xilinx.com:interface:aximm:1.0 S00_AXI BVALID";
  attribute X_INTERFACE_INFO of s_axi_rdata : signal is "xilinx.com:interface:aximm:1.0 S00_AXI RDATA";
  attribute X_INTERFACE_INFO of s_axi_rready : signal is "xilinx.com:interface:aximm:1.0 S00_AXI RREADY";
  attribute X_INTERFACE_PARAMETER of s_axi_rready : signal is "XIL_INTERFACENAME S00_AXI, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 1e+08, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 8, NUM_WRITE_OUTSTANDING 8, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN zynq_blk_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 4, NUM_WRITE_THREADS 4, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axi_rresp : signal is "xilinx.com:interface:aximm:1.0 S00_AXI RRESP";
  attribute X_INTERFACE_INFO of s_axi_rvalid : signal is "xilinx.com:interface:aximm:1.0 S00_AXI RVALID";
  attribute X_INTERFACE_INFO of s_axi_wdata : signal is "xilinx.com:interface:aximm:1.0 S00_AXI WDATA";
  attribute X_INTERFACE_INFO of s_axi_wready : signal is "xilinx.com:interface:aximm:1.0 S00_AXI WREADY";
  attribute X_INTERFACE_INFO of s_axi_wstrb : signal is "xilinx.com:interface:aximm:1.0 S00_AXI WSTRB";
  attribute X_INTERFACE_INFO of s_axi_wvalid : signal is "xilinx.com:interface:aximm:1.0 S00_AXI WVALID";
begin
  \^s_axi_wdata\(31 downto 0) <= s_axi_wdata(31 downto 0);
  \^s_axi_wstrb\(3 downto 0) <= s_axi_wstrb(3 downto 0);
  m_axi_araddr(95 downto 80) <= \^m_axi_awaddr\(95 downto 80);
  m_axi_araddr(79 downto 64) <= \^m_axi_araddr\(15 downto 0);
  m_axi_araddr(63 downto 48) <= \^m_axi_awaddr\(95 downto 80);
  m_axi_araddr(47 downto 32) <= \^m_axi_araddr\(15 downto 0);
  m_axi_araddr(31 downto 16) <= \^m_axi_awaddr\(95 downto 80);
  m_axi_araddr(15 downto 0) <= \^m_axi_araddr\(15 downto 0);
  m_axi_arprot(8 downto 6) <= \^m_axi_arprot\(2 downto 0);
  m_axi_arprot(5 downto 3) <= \^m_axi_arprot\(2 downto 0);
  m_axi_arprot(2 downto 0) <= \^m_axi_arprot\(2 downto 0);
  m_axi_awaddr(95 downto 80) <= \^m_axi_awaddr\(95 downto 80);
  m_axi_awaddr(79 downto 64) <= \^m_axi_araddr\(15 downto 0);
  m_axi_awaddr(63 downto 48) <= \^m_axi_awaddr\(95 downto 80);
  m_axi_awaddr(47 downto 32) <= \^m_axi_araddr\(15 downto 0);
  m_axi_awaddr(31 downto 16) <= \^m_axi_awaddr\(95 downto 80);
  m_axi_awaddr(15 downto 0) <= \^m_axi_araddr\(15 downto 0);
  m_axi_awprot(8 downto 6) <= \^m_axi_arprot\(2 downto 0);
  m_axi_awprot(5 downto 3) <= \^m_axi_arprot\(2 downto 0);
  m_axi_awprot(2 downto 0) <= \^m_axi_arprot\(2 downto 0);
  m_axi_wdata(95 downto 64) <= \^s_axi_wdata\(31 downto 0);
  m_axi_wdata(63 downto 32) <= \^s_axi_wdata\(31 downto 0);
  m_axi_wdata(31 downto 0) <= \^s_axi_wdata\(31 downto 0);
  m_axi_wstrb(11 downto 8) <= \^s_axi_wstrb\(3 downto 0);
  m_axi_wstrb(7 downto 4) <= \^s_axi_wstrb\(3 downto 0);
  m_axi_wstrb(3 downto 0) <= \^s_axi_wstrb\(3 downto 0);
inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_crossbar_v2_1_19_axi_crossbar
     port map (
      Q(34 downto 32) => \^m_axi_arprot\(2 downto 0),
      Q(31 downto 16) => \^m_axi_awaddr\(95 downto 80),
      Q(15 downto 0) => \^m_axi_araddr\(15 downto 0),
      aclk => aclk,
      aresetn => aresetn,
      m_axi_arready(2 downto 0) => m_axi_arready(2 downto 0),
      m_axi_arvalid(2 downto 0) => m_axi_arvalid(2 downto 0),
      m_axi_awready(2 downto 0) => m_axi_awready(2 downto 0),
      m_axi_awvalid(2 downto 0) => m_axi_awvalid(2 downto 0),
      m_axi_bready(2 downto 0) => m_axi_bready(2 downto 0),
      m_axi_bresp(5 downto 0) => m_axi_bresp(5 downto 0),
      m_axi_bvalid(2 downto 0) => m_axi_bvalid(2 downto 0),
      m_axi_rdata(95 downto 0) => m_axi_rdata(95 downto 0),
      m_axi_rready(2 downto 0) => m_axi_rready(2 downto 0),
      m_axi_rresp(5 downto 0) => m_axi_rresp(5 downto 0),
      m_axi_rvalid(2 downto 0) => m_axi_rvalid(2 downto 0),
      m_axi_wready(2 downto 0) => m_axi_wready(2 downto 0),
      m_axi_wvalid(2 downto 0) => m_axi_wvalid(2 downto 0),
      \m_payload_i_reg[34]\(33 downto 2) => s_axi_rdata(31 downto 0),
      \m_payload_i_reg[34]\(1 downto 0) => s_axi_rresp(1 downto 0),
      s_axi_araddr(31 downto 0) => s_axi_araddr(31 downto 0),
      s_axi_arprot(2 downto 0) => s_axi_arprot(2 downto 0),
      s_axi_arready(0) => s_axi_arready(0),
      s_axi_arvalid(0) => s_axi_arvalid(0),
      s_axi_awaddr(31 downto 0) => s_axi_awaddr(31 downto 0),
      s_axi_awprot(2 downto 0) => s_axi_awprot(2 downto 0),
      s_axi_awready(0) => s_axi_awready(0),
      s_axi_awvalid(0) => s_axi_awvalid(0),
      s_axi_bready(0) => s_axi_bready(0),
      s_axi_bresp(1 downto 0) => s_axi_bresp(1 downto 0),
      s_axi_bvalid(0) => s_axi_bvalid(0),
      s_axi_rready(0) => s_axi_rready(0),
      s_axi_rvalid(0) => s_axi_rvalid(0),
      s_axi_wready(0) => s_axi_wready(0),
      s_axi_wvalid(0) => s_axi_wvalid(0)
    );
end STRUCTURE;
