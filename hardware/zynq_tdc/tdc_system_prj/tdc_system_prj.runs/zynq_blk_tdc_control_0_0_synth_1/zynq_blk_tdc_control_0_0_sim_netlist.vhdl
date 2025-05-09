-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Mon Jun 10 15:19:55 2024
-- Host        : DESKTOP-QJLKIHB running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ zynq_blk_tdc_control_0_0_sim_netlist.vhdl
-- Design      : zynq_blk_tdc_control_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tdc_control is
  port (
    axis_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    axis_tlast : out STD_LOGIC;
    axis_tvalid : out STD_LOGIC;
    calibing_flag_r_reg_0 : out STD_LOGIC;
    \cnt_burst_calib_reg[5]_0\ : out STD_LOGIC;
    hit_source : out STD_LOGIC;
    DLenable : out STD_LOGIC;
    clk : in STD_LOGIC;
    ValidOutStart : in STD_LOGIC;
    timestampStart : in STD_LOGIC_VECTOR ( 31 downto 0 );
    ValidOutStop : in STD_LOGIC;
    timestampStop : in STD_LOGIC_VECTOR ( 31 downto 0 );
    run : in STD_LOGIC;
    axis_tready : in STD_LOGIC;
    rst_n : in STD_LOGIC;
    calib_en : in STD_LOGIC
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tdc_control;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tdc_control is
  signal \FSM_onehot_state[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[1]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[2]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[3]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_10_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_11_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_12_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_13_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_14_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_5_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_6_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_7_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_8_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[4]_i_9_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[0]\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[1]\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[3]\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[4]\ : STD_LOGIC;
  signal \^axis_tlast\ : STD_LOGIC;
  signal \^axis_tvalid\ : STD_LOGIC;
  signal calib_finished_INST_0_i_1_n_0 : STD_LOGIC;
  signal calibing_flag_r_i_1_n_0 : STD_LOGIC;
  signal calibing_flag_r_i_2_n_0 : STD_LOGIC;
  signal calibing_flag_r_i_3_n_0 : STD_LOGIC;
  signal calibing_flag_r_i_4_n_0 : STD_LOGIC;
  signal calibing_flag_r_i_5_n_0 : STD_LOGIC;
  signal calibing_flag_r_i_6_n_0 : STD_LOGIC;
  signal \^calibing_flag_r_reg_0\ : STD_LOGIC;
  signal clear : STD_LOGIC;
  signal \clk_cnt[0]_i_3_n_0\ : STD_LOGIC;
  signal clk_cnt_reg : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \clk_cnt_reg[0]_i_2_n_0\ : STD_LOGIC;
  signal \clk_cnt_reg[0]_i_2_n_1\ : STD_LOGIC;
  signal \clk_cnt_reg[0]_i_2_n_2\ : STD_LOGIC;
  signal \clk_cnt_reg[0]_i_2_n_3\ : STD_LOGIC;
  signal \clk_cnt_reg[0]_i_2_n_4\ : STD_LOGIC;
  signal \clk_cnt_reg[0]_i_2_n_5\ : STD_LOGIC;
  signal \clk_cnt_reg[0]_i_2_n_6\ : STD_LOGIC;
  signal \clk_cnt_reg[0]_i_2_n_7\ : STD_LOGIC;
  signal \clk_cnt_reg[12]_i_1_n_1\ : STD_LOGIC;
  signal \clk_cnt_reg[12]_i_1_n_2\ : STD_LOGIC;
  signal \clk_cnt_reg[12]_i_1_n_3\ : STD_LOGIC;
  signal \clk_cnt_reg[12]_i_1_n_4\ : STD_LOGIC;
  signal \clk_cnt_reg[12]_i_1_n_5\ : STD_LOGIC;
  signal \clk_cnt_reg[12]_i_1_n_6\ : STD_LOGIC;
  signal \clk_cnt_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \clk_cnt_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \clk_cnt_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \clk_cnt_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \clk_cnt_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \clk_cnt_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \clk_cnt_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \clk_cnt_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \clk_cnt_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \clk_cnt_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \clk_cnt_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \clk_cnt_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \clk_cnt_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \clk_cnt_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \clk_cnt_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \clk_cnt_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \clk_cnt_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal cnt_burst_calib : STD_LOGIC;
  signal \cnt_burst_calib[6]_i_2_n_0\ : STD_LOGIC;
  signal \cnt_burst_calib[7]_i_3_n_0\ : STD_LOGIC;
  signal \^cnt_burst_calib_reg[5]_0\ : STD_LOGIC;
  signal \cnt_burst_calib_reg__0\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal data_timestamp_start : STD_LOGIC;
  signal eqOp12_in : STD_LOGIC;
  signal plusOp : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal \plusOp__0\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal sel : STD_LOGIC;
  signal \timeout_cnt[0]_i_3_n_0\ : STD_LOGIC;
  signal \timeout_cnt[0]_i_4_n_0\ : STD_LOGIC;
  signal \timeout_cnt[0]_i_5_n_0\ : STD_LOGIC;
  signal \timeout_cnt[0]_i_6_n_0\ : STD_LOGIC;
  signal timeout_cnt_reg : STD_LOGIC_VECTOR ( 12 downto 0 );
  signal \timeout_cnt_reg[0]_i_2_n_0\ : STD_LOGIC;
  signal \timeout_cnt_reg[0]_i_2_n_1\ : STD_LOGIC;
  signal \timeout_cnt_reg[0]_i_2_n_2\ : STD_LOGIC;
  signal \timeout_cnt_reg[0]_i_2_n_3\ : STD_LOGIC;
  signal \timeout_cnt_reg[0]_i_2_n_4\ : STD_LOGIC;
  signal \timeout_cnt_reg[0]_i_2_n_5\ : STD_LOGIC;
  signal \timeout_cnt_reg[0]_i_2_n_6\ : STD_LOGIC;
  signal \timeout_cnt_reg[0]_i_2_n_7\ : STD_LOGIC;
  signal \timeout_cnt_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \timeout_cnt_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \timeout_cnt_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \timeout_cnt_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \timeout_cnt_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \timeout_cnt_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \timeout_cnt_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \timeout_cnt_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \timeout_cnt_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \timeout_cnt_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \timeout_cnt_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \timeout_cnt_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \timeout_cnt_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \timeout_cnt_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \timeout_cnt_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \timeout_cnt_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \timeout_cnt_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal timeout_en : STD_LOGIC;
  signal timeout_en_i_1_n_0 : STD_LOGIC;
  signal timeout_en_i_2_n_0 : STD_LOGIC;
  signal timeout_en_i_3_n_0 : STD_LOGIC;
  signal timeout_en_i_4_n_0 : STD_LOGIC;
  signal timeout_en_i_5_n_0 : STD_LOGIC;
  signal timeout_en_i_6_n_0 : STD_LOGIC;
  signal timeout_en_i_7_n_0 : STD_LOGIC;
  signal timeout_en_i_8_n_0 : STD_LOGIC;
  signal tlast_i_1_n_0 : STD_LOGIC;
  signal tvalid_i_1_n_0 : STD_LOGIC;
  signal \tx_num_meas[6]_i_2_n_0\ : STD_LOGIC;
  signal \tx_num_meas[9]_i_2_n_0\ : STD_LOGIC;
  signal \tx_num_meas_reg__0\ : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal \NLW_clk_cnt_reg[12]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_timeout_cnt_reg[12]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_timeout_cnt_reg[12]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_onehot_state[1]_i_2\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \FSM_onehot_state[1]_i_3\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \FSM_onehot_state[4]_i_11\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \FSM_onehot_state[4]_i_8\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \FSM_onehot_state[4]_i_9\ : label is "soft_lutpair9";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[0]\ : label is "eof:00100,running:10000,store:01000,idle:00010,iSTATE:00001";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[1]\ : label is "eof:00100,running:10000,store:01000,idle:00010,iSTATE:00001";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[2]\ : label is "eof:00100,running:10000,store:01000,idle:00010,iSTATE:00001";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[3]\ : label is "eof:00100,running:10000,store:01000,idle:00010,iSTATE:00001";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[4]\ : label is "eof:00100,running:10000,store:01000,idle:00010,iSTATE:00001";
  attribute SOFT_HLUTNM of calib_finished_INST_0 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of calib_finished_INST_0_i_1 : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \cnt_burst_calib[1]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \cnt_burst_calib[2]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \cnt_burst_calib[3]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \cnt_burst_calib[4]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \cnt_burst_calib[6]_i_2\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of timeout_en_i_7 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of timeout_en_i_8 : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \tx_num_meas[0]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \tx_num_meas[1]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \tx_num_meas[2]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \tx_num_meas[3]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \tx_num_meas[4]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \tx_num_meas[6]_i_2\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \tx_num_meas[8]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \tx_num_meas[9]_i_1\ : label is "soft_lutpair1";
begin
  axis_tlast <= \^axis_tlast\;
  axis_tvalid <= \^axis_tvalid\;
  calibing_flag_r_reg_0 <= \^calibing_flag_r_reg_0\;
  \cnt_burst_calib_reg[5]_0\ <= \^cnt_burst_calib_reg[5]_0\;
\FSM_onehot_state[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF11110010"
    )
        port map (
      I0 => \^calibing_flag_r_reg_0\,
      I1 => run,
      I2 => \FSM_onehot_state_reg_n_0_[3]\,
      I3 => eqOp12_in,
      I4 => \FSM_onehot_state_reg_n_0_[4]\,
      I5 => \FSM_onehot_state[1]_i_3_n_0\,
      O => \FSM_onehot_state[1]_i_1_n_0\
    );
\FSM_onehot_state[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80000000"
    )
        port map (
      I0 => calibing_flag_r_i_5_n_0,
      I1 => \tx_num_meas_reg__0\(4),
      I2 => \tx_num_meas_reg__0\(5),
      I3 => \tx_num_meas_reg__0\(2),
      I4 => \tx_num_meas_reg__0\(3),
      O => eqOp12_in
    );
\FSM_onehot_state[1]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A0A0A0A3"
    )
        port map (
      I0 => axis_tready,
      I1 => \FSM_onehot_state_reg_n_0_[3]\,
      I2 => data_timestamp_start,
      I3 => \FSM_onehot_state_reg_n_0_[1]\,
      I4 => \FSM_onehot_state_reg_n_0_[4]\,
      O => \FSM_onehot_state[1]_i_3_n_0\
    );
\FSM_onehot_state[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"50FF504050405040"
    )
        port map (
      I0 => ValidOutStop,
      I1 => \^calibing_flag_r_reg_0\,
      I2 => \FSM_onehot_state_reg_n_0_[4]\,
      I3 => run,
      I4 => \^cnt_burst_calib_reg[5]_0\,
      I5 => \FSM_onehot_state_reg_n_0_[1]\,
      O => \FSM_onehot_state[2]_i_1_n_0\
    );
\FSM_onehot_state[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E000FFFFE000E000"
    )
        port map (
      I0 => \^calibing_flag_r_reg_0\,
      I1 => run,
      I2 => \FSM_onehot_state_reg_n_0_[4]\,
      I3 => ValidOutStop,
      I4 => axis_tready,
      I5 => data_timestamp_start,
      O => \FSM_onehot_state[3]_i_1_n_0\
    );
\FSM_onehot_state[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFEFEFE"
    )
        port map (
      I0 => \FSM_onehot_state[4]_i_3_n_0\,
      I1 => \FSM_onehot_state[4]_i_4_n_0\,
      I2 => \FSM_onehot_state[4]_i_5_n_0\,
      I3 => \FSM_onehot_state[4]_i_6_n_0\,
      I4 => \FSM_onehot_state[4]_i_7_n_0\,
      I5 => \FSM_onehot_state[4]_i_8_n_0\,
      O => \FSM_onehot_state[4]_i_1_n_0\
    );
\FSM_onehot_state[4]_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \tx_num_meas_reg__0\(8),
      I1 => \tx_num_meas_reg__0\(9),
      I2 => \tx_num_meas_reg__0\(7),
      I3 => \tx_num_meas_reg__0\(6),
      I4 => \tx_num_meas_reg__0\(0),
      I5 => \tx_num_meas_reg__0\(1),
      O => \FSM_onehot_state[4]_i_10_n_0\
    );
\FSM_onehot_state[4]_i_11\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \tx_num_meas_reg__0\(2),
      I1 => \tx_num_meas_reg__0\(3),
      I2 => \tx_num_meas_reg__0\(4),
      I3 => \tx_num_meas_reg__0\(5),
      O => \FSM_onehot_state[4]_i_11_n_0\
    );
\FSM_onehot_state[4]_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => timeout_cnt_reg(7),
      I1 => timeout_cnt_reg(8),
      I2 => timeout_cnt_reg(9),
      I3 => timeout_cnt_reg(10),
      I4 => timeout_cnt_reg(12),
      I5 => timeout_cnt_reg(11),
      O => \FSM_onehot_state[4]_i_12_n_0\
    );
\FSM_onehot_state[4]_i_13\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => timeout_cnt_reg(2),
      I1 => timeout_cnt_reg(1),
      I2 => timeout_cnt_reg(0),
      O => \FSM_onehot_state[4]_i_13_n_0\
    );
\FSM_onehot_state[4]_i_14\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => timeout_cnt_reg(6),
      I1 => timeout_cnt_reg(5),
      I2 => timeout_cnt_reg(4),
      I3 => timeout_cnt_reg(3),
      O => \FSM_onehot_state[4]_i_14_n_0\
    );
\FSM_onehot_state[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFAFFFAFFBABABA"
    )
        port map (
      I0 => calibing_flag_r_i_3_n_0,
      I1 => \^cnt_burst_calib_reg[5]_0\,
      I2 => \FSM_onehot_state_reg_n_0_[1]\,
      I3 => \FSM_onehot_state_reg_n_0_[3]\,
      I4 => \^calibing_flag_r_reg_0\,
      I5 => run,
      O => \FSM_onehot_state[4]_i_2_n_0\
    );
\FSM_onehot_state[4]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"E0E0E0EC"
    )
        port map (
      I0 => data_timestamp_start,
      I1 => \FSM_onehot_state_reg_n_0_[4]\,
      I2 => ValidOutStop,
      I3 => run,
      I4 => \^calibing_flag_r_reg_0\,
      O => \FSM_onehot_state[4]_i_3_n_0\
    );
\FSM_onehot_state[4]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAA2AAAAAAAAAA"
    )
        port map (
      I0 => \FSM_onehot_state[4]_i_9_n_0\,
      I1 => calib_finished_INST_0_i_1_n_0,
      I2 => \cnt_burst_calib_reg__0\(7),
      I3 => \cnt_burst_calib_reg__0\(6),
      I4 => \cnt_burst_calib_reg__0\(4),
      I5 => \cnt_burst_calib_reg__0\(5),
      O => \FSM_onehot_state[4]_i_4_n_0\
    );
\FSM_onehot_state[4]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A800000000000000"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[4]\,
      I1 => \FSM_onehot_state[4]_i_10_n_0\,
      I2 => \FSM_onehot_state[4]_i_11_n_0\,
      I3 => \FSM_onehot_state[4]_i_12_n_0\,
      I4 => \FSM_onehot_state[4]_i_13_n_0\,
      I5 => \FSM_onehot_state[4]_i_14_n_0\,
      O => \FSM_onehot_state[4]_i_5_n_0\
    );
\FSM_onehot_state[4]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020000000000000"
    )
        port map (
      I0 => calib_finished_INST_0_i_1_n_0,
      I1 => \cnt_burst_calib_reg__0\(7),
      I2 => \cnt_burst_calib_reg__0\(6),
      I3 => \cnt_burst_calib_reg__0\(4),
      I4 => \cnt_burst_calib_reg__0\(5),
      I5 => \FSM_onehot_state_reg_n_0_[1]\,
      O => \FSM_onehot_state[4]_i_6_n_0\
    );
\FSM_onehot_state[4]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFE0000000"
    )
        port map (
      I0 => \FSM_onehot_state[4]_i_10_n_0\,
      I1 => \FSM_onehot_state[4]_i_11_n_0\,
      I2 => \FSM_onehot_state[4]_i_14_n_0\,
      I3 => \FSM_onehot_state[4]_i_13_n_0\,
      I4 => \FSM_onehot_state[4]_i_12_n_0\,
      I5 => run,
      O => \FSM_onehot_state[4]_i_7_n_0\
    );
\FSM_onehot_state[4]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A8A8A8AB"
    )
        port map (
      I0 => axis_tready,
      I1 => \FSM_onehot_state_reg_n_0_[3]\,
      I2 => data_timestamp_start,
      I3 => \FSM_onehot_state_reg_n_0_[1]\,
      I4 => \FSM_onehot_state_reg_n_0_[4]\,
      O => \FSM_onehot_state[4]_i_8_n_0\
    );
\FSM_onehot_state[4]_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[1]\,
      I1 => calib_en,
      O => \FSM_onehot_state[4]_i_9_n_0\
    );
\FSM_onehot_state_reg[0]\: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => \FSM_onehot_state[4]_i_1_n_0\,
      D => '0',
      PRE => calibing_flag_r_i_2_n_0,
      Q => \FSM_onehot_state_reg_n_0_[0]\
    );
\FSM_onehot_state_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \FSM_onehot_state[4]_i_1_n_0\,
      CLR => calibing_flag_r_i_2_n_0,
      D => \FSM_onehot_state[1]_i_1_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[1]\
    );
\FSM_onehot_state_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \FSM_onehot_state[4]_i_1_n_0\,
      CLR => calibing_flag_r_i_2_n_0,
      D => \FSM_onehot_state[2]_i_1_n_0\,
      Q => data_timestamp_start
    );
\FSM_onehot_state_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \FSM_onehot_state[4]_i_1_n_0\,
      CLR => calibing_flag_r_i_2_n_0,
      D => \FSM_onehot_state[3]_i_1_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[3]\
    );
\FSM_onehot_state_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \FSM_onehot_state[4]_i_1_n_0\,
      CLR => calibing_flag_r_i_2_n_0,
      D => \FSM_onehot_state[4]_i_2_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[4]\
    );
\axis_tkeep[0]_INST_0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      O => DLenable
    );
calib_finished_INST_0: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00200000"
    )
        port map (
      I0 => \cnt_burst_calib_reg__0\(5),
      I1 => \cnt_burst_calib_reg__0\(4),
      I2 => \cnt_burst_calib_reg__0\(6),
      I3 => \cnt_burst_calib_reg__0\(7),
      I4 => calib_finished_INST_0_i_1_n_0,
      O => \^cnt_burst_calib_reg[5]_0\
    );
calib_finished_INST_0_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0100"
    )
        port map (
      I0 => \cnt_burst_calib_reg__0\(1),
      I1 => \cnt_burst_calib_reg__0\(0),
      I2 => \cnt_burst_calib_reg__0\(3),
      I3 => \cnt_burst_calib_reg__0\(2),
      O => calib_finished_INST_0_i_1_n_0
    );
calibing_flag_r_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF7777778F000000"
    )
        port map (
      I0 => calibing_flag_r_i_3_n_0,
      I1 => calibing_flag_r_i_4_n_0,
      I2 => \^cnt_burst_calib_reg[5]_0\,
      I3 => \FSM_onehot_state_reg_n_0_[1]\,
      I4 => calib_en,
      I5 => \^calibing_flag_r_reg_0\,
      O => calibing_flag_r_i_1_n_0
    );
calibing_flag_r_i_2: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rst_n,
      O => calibing_flag_r_i_2_n_0
    );
calibing_flag_r_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => \tx_num_meas_reg__0\(3),
      I1 => \tx_num_meas_reg__0\(2),
      I2 => \tx_num_meas_reg__0\(5),
      I3 => \tx_num_meas_reg__0\(4),
      I4 => calibing_flag_r_i_5_n_0,
      I5 => \FSM_onehot_state_reg_n_0_[3]\,
      O => calibing_flag_r_i_3_n_0
    );
calibing_flag_r_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0002"
    )
        port map (
      I0 => calibing_flag_r_i_6_n_0,
      I1 => \cnt_burst_calib_reg__0\(2),
      I2 => \cnt_burst_calib_reg__0\(3),
      I3 => \cnt_burst_calib_reg__0\(4),
      O => calibing_flag_r_i_4_n_0
    );
calibing_flag_r_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0080000000000000"
    )
        port map (
      I0 => \tx_num_meas_reg__0\(6),
      I1 => \tx_num_meas_reg__0\(7),
      I2 => \tx_num_meas_reg__0\(8),
      I3 => \tx_num_meas_reg__0\(9),
      I4 => \tx_num_meas_reg__0\(0),
      I5 => \tx_num_meas_reg__0\(1),
      O => calibing_flag_r_i_5_n_0
    );
calibing_flag_r_i_6: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0080000000000000"
    )
        port map (
      I0 => \cnt_burst_calib_reg__0\(5),
      I1 => \cnt_burst_calib_reg__0\(6),
      I2 => axis_tready,
      I3 => \cnt_burst_calib_reg__0\(7),
      I4 => \cnt_burst_calib_reg__0\(1),
      I5 => \cnt_burst_calib_reg__0\(0),
      O => calibing_flag_r_i_6_n_0
    );
calibing_flag_r_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      CLR => calibing_flag_r_i_2_n_0,
      D => calibing_flag_r_i_1_n_0,
      Q => \^calibing_flag_r_reg_0\
    );
\clk_cnt[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => timeout_en,
      O => clear
    );
\clk_cnt[0]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => clk_cnt_reg(0),
      O => \clk_cnt[0]_i_3_n_0\
    );
\clk_cnt_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \clk_cnt_reg[0]_i_2_n_7\,
      Q => clk_cnt_reg(0),
      R => clear
    );
\clk_cnt_reg[0]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \clk_cnt_reg[0]_i_2_n_0\,
      CO(2) => \clk_cnt_reg[0]_i_2_n_1\,
      CO(1) => \clk_cnt_reg[0]_i_2_n_2\,
      CO(0) => \clk_cnt_reg[0]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0001",
      O(3) => \clk_cnt_reg[0]_i_2_n_4\,
      O(2) => \clk_cnt_reg[0]_i_2_n_5\,
      O(1) => \clk_cnt_reg[0]_i_2_n_6\,
      O(0) => \clk_cnt_reg[0]_i_2_n_7\,
      S(3 downto 1) => clk_cnt_reg(3 downto 1),
      S(0) => \clk_cnt[0]_i_3_n_0\
    );
\clk_cnt_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \clk_cnt_reg[8]_i_1_n_5\,
      Q => clk_cnt_reg(10),
      R => clear
    );
\clk_cnt_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \clk_cnt_reg[8]_i_1_n_4\,
      Q => clk_cnt_reg(11),
      R => clear
    );
\clk_cnt_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \clk_cnt_reg[12]_i_1_n_7\,
      Q => clk_cnt_reg(12),
      R => clear
    );
\clk_cnt_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \clk_cnt_reg[8]_i_1_n_0\,
      CO(3) => \NLW_clk_cnt_reg[12]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \clk_cnt_reg[12]_i_1_n_1\,
      CO(1) => \clk_cnt_reg[12]_i_1_n_2\,
      CO(0) => \clk_cnt_reg[12]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \clk_cnt_reg[12]_i_1_n_4\,
      O(2) => \clk_cnt_reg[12]_i_1_n_5\,
      O(1) => \clk_cnt_reg[12]_i_1_n_6\,
      O(0) => \clk_cnt_reg[12]_i_1_n_7\,
      S(3 downto 0) => clk_cnt_reg(15 downto 12)
    );
\clk_cnt_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \clk_cnt_reg[12]_i_1_n_6\,
      Q => clk_cnt_reg(13),
      R => clear
    );
\clk_cnt_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \clk_cnt_reg[12]_i_1_n_5\,
      Q => clk_cnt_reg(14),
      R => clear
    );
\clk_cnt_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \clk_cnt_reg[12]_i_1_n_4\,
      Q => clk_cnt_reg(15),
      R => clear
    );
\clk_cnt_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \clk_cnt_reg[0]_i_2_n_6\,
      Q => clk_cnt_reg(1),
      R => clear
    );
\clk_cnt_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \clk_cnt_reg[0]_i_2_n_5\,
      Q => clk_cnt_reg(2),
      R => clear
    );
\clk_cnt_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \clk_cnt_reg[0]_i_2_n_4\,
      Q => clk_cnt_reg(3),
      R => clear
    );
\clk_cnt_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \clk_cnt_reg[4]_i_1_n_7\,
      Q => clk_cnt_reg(4),
      R => clear
    );
\clk_cnt_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \clk_cnt_reg[0]_i_2_n_0\,
      CO(3) => \clk_cnt_reg[4]_i_1_n_0\,
      CO(2) => \clk_cnt_reg[4]_i_1_n_1\,
      CO(1) => \clk_cnt_reg[4]_i_1_n_2\,
      CO(0) => \clk_cnt_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \clk_cnt_reg[4]_i_1_n_4\,
      O(2) => \clk_cnt_reg[4]_i_1_n_5\,
      O(1) => \clk_cnt_reg[4]_i_1_n_6\,
      O(0) => \clk_cnt_reg[4]_i_1_n_7\,
      S(3 downto 0) => clk_cnt_reg(7 downto 4)
    );
\clk_cnt_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \clk_cnt_reg[4]_i_1_n_6\,
      Q => clk_cnt_reg(5),
      R => clear
    );
\clk_cnt_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \clk_cnt_reg[4]_i_1_n_5\,
      Q => clk_cnt_reg(6),
      R => clear
    );
\clk_cnt_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \clk_cnt_reg[4]_i_1_n_4\,
      Q => clk_cnt_reg(7),
      R => clear
    );
\clk_cnt_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \clk_cnt_reg[8]_i_1_n_7\,
      Q => clk_cnt_reg(8),
      R => clear
    );
\clk_cnt_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \clk_cnt_reg[4]_i_1_n_0\,
      CO(3) => \clk_cnt_reg[8]_i_1_n_0\,
      CO(2) => \clk_cnt_reg[8]_i_1_n_1\,
      CO(1) => \clk_cnt_reg[8]_i_1_n_2\,
      CO(0) => \clk_cnt_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \clk_cnt_reg[8]_i_1_n_4\,
      O(2) => \clk_cnt_reg[8]_i_1_n_5\,
      O(1) => \clk_cnt_reg[8]_i_1_n_6\,
      O(0) => \clk_cnt_reg[8]_i_1_n_7\,
      S(3 downto 0) => clk_cnt_reg(11 downto 8)
    );
\clk_cnt_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \clk_cnt_reg[8]_i_1_n_6\,
      Q => clk_cnt_reg(9),
      R => clear
    );
\cnt_burst_calib[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \cnt_burst_calib_reg__0\(0),
      O => \plusOp__0\(0)
    );
\cnt_burst_calib[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \cnt_burst_calib_reg__0\(0),
      I1 => \cnt_burst_calib_reg__0\(1),
      O => \plusOp__0\(1)
    );
\cnt_burst_calib[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \cnt_burst_calib_reg__0\(1),
      I1 => \cnt_burst_calib_reg__0\(0),
      I2 => \cnt_burst_calib_reg__0\(2),
      O => \plusOp__0\(2)
    );
\cnt_burst_calib[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \cnt_burst_calib_reg__0\(0),
      I1 => \cnt_burst_calib_reg__0\(1),
      I2 => \cnt_burst_calib_reg__0\(2),
      I3 => \cnt_burst_calib_reg__0\(3),
      O => \plusOp__0\(3)
    );
\cnt_burst_calib[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => \cnt_burst_calib_reg__0\(3),
      I1 => \cnt_burst_calib_reg__0\(2),
      I2 => \cnt_burst_calib_reg__0\(1),
      I3 => \cnt_burst_calib_reg__0\(0),
      I4 => \cnt_burst_calib_reg__0\(4),
      O => \plusOp__0\(4)
    );
\cnt_burst_calib[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFF80000000"
    )
        port map (
      I0 => \cnt_burst_calib_reg__0\(0),
      I1 => \cnt_burst_calib_reg__0\(1),
      I2 => \cnt_burst_calib_reg__0\(2),
      I3 => \cnt_burst_calib_reg__0\(3),
      I4 => \cnt_burst_calib_reg__0\(4),
      I5 => \cnt_burst_calib_reg__0\(5),
      O => \plusOp__0\(5)
    );
\cnt_burst_calib[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF7FFF00008000"
    )
        port map (
      I0 => \cnt_burst_calib_reg__0\(5),
      I1 => \cnt_burst_calib_reg__0\(4),
      I2 => \cnt_burst_calib_reg__0\(3),
      I3 => \cnt_burst_calib_reg__0\(2),
      I4 => \cnt_burst_calib[6]_i_2_n_0\,
      I5 => \cnt_burst_calib_reg__0\(6),
      O => \plusOp__0\(6)
    );
\cnt_burst_calib[6]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => \cnt_burst_calib_reg__0\(0),
      I1 => \cnt_burst_calib_reg__0\(1),
      O => \cnt_burst_calib[6]_i_2_n_0\
    );
\cnt_burst_calib[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => \^calibing_flag_r_reg_0\,
      I1 => axis_tready,
      I2 => calibing_flag_r_i_3_n_0,
      O => cnt_burst_calib
    );
\cnt_burst_calib[7]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"D2"
    )
        port map (
      I0 => \cnt_burst_calib_reg__0\(6),
      I1 => \cnt_burst_calib[7]_i_3_n_0\,
      I2 => \cnt_burst_calib_reg__0\(7),
      O => \plusOp__0\(7)
    );
\cnt_burst_calib[7]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFFFFFFFFFF"
    )
        port map (
      I0 => \cnt_burst_calib_reg__0\(0),
      I1 => \cnt_burst_calib_reg__0\(1),
      I2 => \cnt_burst_calib_reg__0\(2),
      I3 => \cnt_burst_calib_reg__0\(3),
      I4 => \cnt_burst_calib_reg__0\(4),
      I5 => \cnt_burst_calib_reg__0\(5),
      O => \cnt_burst_calib[7]_i_3_n_0\
    );
\cnt_burst_calib_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => cnt_burst_calib,
      CLR => calibing_flag_r_i_2_n_0,
      D => \plusOp__0\(0),
      Q => \cnt_burst_calib_reg__0\(0)
    );
\cnt_burst_calib_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => cnt_burst_calib,
      CLR => calibing_flag_r_i_2_n_0,
      D => \plusOp__0\(1),
      Q => \cnt_burst_calib_reg__0\(1)
    );
\cnt_burst_calib_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => cnt_burst_calib,
      CLR => calibing_flag_r_i_2_n_0,
      D => \plusOp__0\(2),
      Q => \cnt_burst_calib_reg__0\(2)
    );
\cnt_burst_calib_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => cnt_burst_calib,
      CLR => calibing_flag_r_i_2_n_0,
      D => \plusOp__0\(3),
      Q => \cnt_burst_calib_reg__0\(3)
    );
\cnt_burst_calib_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => cnt_burst_calib,
      CLR => calibing_flag_r_i_2_n_0,
      D => \plusOp__0\(4),
      Q => \cnt_burst_calib_reg__0\(4)
    );
\cnt_burst_calib_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => cnt_burst_calib,
      CLR => calibing_flag_r_i_2_n_0,
      D => \plusOp__0\(5),
      Q => \cnt_burst_calib_reg__0\(5)
    );
\cnt_burst_calib_reg[6]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => cnt_burst_calib,
      CLR => calibing_flag_r_i_2_n_0,
      D => \plusOp__0\(6),
      Q => \cnt_burst_calib_reg__0\(6)
    );
\cnt_burst_calib_reg[7]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => cnt_burst_calib,
      CLR => calibing_flag_r_i_2_n_0,
      D => \plusOp__0\(7),
      Q => \cnt_burst_calib_reg__0\(7)
    );
\data_timestamp_start_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(0),
      Q => axis_tdata(0),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[10]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(10),
      Q => axis_tdata(10),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[11]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(11),
      Q => axis_tdata(11),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[12]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(12),
      Q => axis_tdata(12),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[13]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(13),
      Q => axis_tdata(13),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[14]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(14),
      Q => axis_tdata(14),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[15]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(15),
      Q => axis_tdata(15),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[16]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(16),
      Q => axis_tdata(16),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[17]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(17),
      Q => axis_tdata(17),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[18]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(18),
      Q => axis_tdata(18),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[19]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(19),
      Q => axis_tdata(19),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[1]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(1),
      Q => axis_tdata(1),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[20]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(20),
      Q => axis_tdata(20),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[21]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(21),
      Q => axis_tdata(21),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[22]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(22),
      Q => axis_tdata(22),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[23]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(23),
      Q => axis_tdata(23),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[24]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(24),
      Q => axis_tdata(24),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[25]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(25),
      Q => axis_tdata(25),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[26]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(26),
      Q => axis_tdata(26),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[27]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(27),
      Q => axis_tdata(27),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[28]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(28),
      Q => axis_tdata(28),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[29]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(29),
      Q => axis_tdata(29),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[2]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(2),
      Q => axis_tdata(2),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[30]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(30),
      Q => axis_tdata(30),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[31]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(31),
      Q => axis_tdata(31),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[3]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(3),
      Q => axis_tdata(3),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[4]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(4),
      Q => axis_tdata(4),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[5]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(5),
      Q => axis_tdata(5),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[6]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(6),
      Q => axis_tdata(6),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[7]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(7),
      Q => axis_tdata(7),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[8]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(8),
      Q => axis_tdata(8),
      S => data_timestamp_start
    );
\data_timestamp_start_reg[9]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStart,
      D => timestampStart(9),
      Q => axis_tdata(9),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(0),
      Q => axis_tdata(32),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[10]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(10),
      Q => axis_tdata(42),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[11]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(11),
      Q => axis_tdata(43),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[12]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(12),
      Q => axis_tdata(44),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[13]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(13),
      Q => axis_tdata(45),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[14]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(14),
      Q => axis_tdata(46),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[15]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(15),
      Q => axis_tdata(47),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[16]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(16),
      Q => axis_tdata(48),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[17]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(17),
      Q => axis_tdata(49),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[18]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(18),
      Q => axis_tdata(50),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[19]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(19),
      Q => axis_tdata(51),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[1]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(1),
      Q => axis_tdata(33),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[20]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(20),
      Q => axis_tdata(52),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[21]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(21),
      Q => axis_tdata(53),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[22]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(22),
      Q => axis_tdata(54),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[23]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(23),
      Q => axis_tdata(55),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[24]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(24),
      Q => axis_tdata(56),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[25]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(25),
      Q => axis_tdata(57),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[26]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(26),
      Q => axis_tdata(58),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[27]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(27),
      Q => axis_tdata(59),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[28]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(28),
      Q => axis_tdata(60),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[29]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(29),
      Q => axis_tdata(61),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[2]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(2),
      Q => axis_tdata(34),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[30]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(30),
      Q => axis_tdata(62),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[31]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(31),
      Q => axis_tdata(63),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[3]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(3),
      Q => axis_tdata(35),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[4]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(4),
      Q => axis_tdata(36),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[5]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(5),
      Q => axis_tdata(37),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[6]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(6),
      Q => axis_tdata(38),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[7]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(7),
      Q => axis_tdata(39),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[8]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(8),
      Q => axis_tdata(40),
      S => data_timestamp_start
    );
\data_timestamp_stop_reg[9]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => ValidOutStop,
      D => timestampStop(9),
      Q => axis_tdata(41),
      S => data_timestamp_start
    );
hit_source_INST_0: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^cnt_burst_calib_reg[5]_0\,
      O => hit_source
    );
\timeout_cnt[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000200000000"
    )
        port map (
      I0 => \timeout_cnt[0]_i_3_n_0\,
      I1 => clk_cnt_reg(1),
      I2 => clk_cnt_reg(0),
      I3 => clk_cnt_reg(3),
      I4 => clk_cnt_reg(2),
      I5 => \timeout_cnt[0]_i_4_n_0\,
      O => sel
    );
\timeout_cnt[0]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => clk_cnt_reg(7),
      I1 => clk_cnt_reg(6),
      I2 => clk_cnt_reg(5),
      I3 => clk_cnt_reg(4),
      O => \timeout_cnt[0]_i_3_n_0\
    );
\timeout_cnt[0]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00010000"
    )
        port map (
      I0 => clk_cnt_reg(12),
      I1 => clk_cnt_reg(13),
      I2 => clk_cnt_reg(14),
      I3 => clk_cnt_reg(15),
      I4 => \timeout_cnt[0]_i_6_n_0\,
      O => \timeout_cnt[0]_i_4_n_0\
    );
\timeout_cnt[0]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => timeout_cnt_reg(0),
      O => \timeout_cnt[0]_i_5_n_0\
    );
\timeout_cnt[0]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => clk_cnt_reg(11),
      I1 => clk_cnt_reg(10),
      I2 => clk_cnt_reg(9),
      I3 => clk_cnt_reg(8),
      O => \timeout_cnt[0]_i_6_n_0\
    );
\timeout_cnt_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => sel,
      D => \timeout_cnt_reg[0]_i_2_n_7\,
      Q => timeout_cnt_reg(0),
      R => clear
    );
\timeout_cnt_reg[0]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \timeout_cnt_reg[0]_i_2_n_0\,
      CO(2) => \timeout_cnt_reg[0]_i_2_n_1\,
      CO(1) => \timeout_cnt_reg[0]_i_2_n_2\,
      CO(0) => \timeout_cnt_reg[0]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0001",
      O(3) => \timeout_cnt_reg[0]_i_2_n_4\,
      O(2) => \timeout_cnt_reg[0]_i_2_n_5\,
      O(1) => \timeout_cnt_reg[0]_i_2_n_6\,
      O(0) => \timeout_cnt_reg[0]_i_2_n_7\,
      S(3 downto 1) => timeout_cnt_reg(3 downto 1),
      S(0) => \timeout_cnt[0]_i_5_n_0\
    );
\timeout_cnt_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => sel,
      D => \timeout_cnt_reg[8]_i_1_n_5\,
      Q => timeout_cnt_reg(10),
      R => clear
    );
\timeout_cnt_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => sel,
      D => \timeout_cnt_reg[8]_i_1_n_4\,
      Q => timeout_cnt_reg(11),
      R => clear
    );
\timeout_cnt_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => sel,
      D => \timeout_cnt_reg[12]_i_1_n_7\,
      Q => timeout_cnt_reg(12),
      R => clear
    );
\timeout_cnt_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timeout_cnt_reg[8]_i_1_n_0\,
      CO(3 downto 0) => \NLW_timeout_cnt_reg[12]_i_1_CO_UNCONNECTED\(3 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 1) => \NLW_timeout_cnt_reg[12]_i_1_O_UNCONNECTED\(3 downto 1),
      O(0) => \timeout_cnt_reg[12]_i_1_n_7\,
      S(3 downto 1) => B"000",
      S(0) => timeout_cnt_reg(12)
    );
\timeout_cnt_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => sel,
      D => \timeout_cnt_reg[0]_i_2_n_6\,
      Q => timeout_cnt_reg(1),
      R => clear
    );
\timeout_cnt_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => sel,
      D => \timeout_cnt_reg[0]_i_2_n_5\,
      Q => timeout_cnt_reg(2),
      R => clear
    );
\timeout_cnt_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => sel,
      D => \timeout_cnt_reg[0]_i_2_n_4\,
      Q => timeout_cnt_reg(3),
      R => clear
    );
\timeout_cnt_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => sel,
      D => \timeout_cnt_reg[4]_i_1_n_7\,
      Q => timeout_cnt_reg(4),
      R => clear
    );
\timeout_cnt_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timeout_cnt_reg[0]_i_2_n_0\,
      CO(3) => \timeout_cnt_reg[4]_i_1_n_0\,
      CO(2) => \timeout_cnt_reg[4]_i_1_n_1\,
      CO(1) => \timeout_cnt_reg[4]_i_1_n_2\,
      CO(0) => \timeout_cnt_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \timeout_cnt_reg[4]_i_1_n_4\,
      O(2) => \timeout_cnt_reg[4]_i_1_n_5\,
      O(1) => \timeout_cnt_reg[4]_i_1_n_6\,
      O(0) => \timeout_cnt_reg[4]_i_1_n_7\,
      S(3 downto 0) => timeout_cnt_reg(7 downto 4)
    );
\timeout_cnt_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => sel,
      D => \timeout_cnt_reg[4]_i_1_n_6\,
      Q => timeout_cnt_reg(5),
      R => clear
    );
\timeout_cnt_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => sel,
      D => \timeout_cnt_reg[4]_i_1_n_5\,
      Q => timeout_cnt_reg(6),
      R => clear
    );
\timeout_cnt_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => sel,
      D => \timeout_cnt_reg[4]_i_1_n_4\,
      Q => timeout_cnt_reg(7),
      R => clear
    );
\timeout_cnt_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => sel,
      D => \timeout_cnt_reg[8]_i_1_n_7\,
      Q => timeout_cnt_reg(8),
      R => clear
    );
\timeout_cnt_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timeout_cnt_reg[4]_i_1_n_0\,
      CO(3) => \timeout_cnt_reg[8]_i_1_n_0\,
      CO(2) => \timeout_cnt_reg[8]_i_1_n_1\,
      CO(1) => \timeout_cnt_reg[8]_i_1_n_2\,
      CO(0) => \timeout_cnt_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \timeout_cnt_reg[8]_i_1_n_4\,
      O(2) => \timeout_cnt_reg[8]_i_1_n_5\,
      O(1) => \timeout_cnt_reg[8]_i_1_n_6\,
      O(0) => \timeout_cnt_reg[8]_i_1_n_7\,
      S(3 downto 0) => timeout_cnt_reg(11 downto 8)
    );
\timeout_cnt_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => sel,
      D => \timeout_cnt_reg[8]_i_1_n_6\,
      Q => timeout_cnt_reg(9),
      R => clear
    );
timeout_en_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEEEEEEFEEEEEEE0"
    )
        port map (
      I0 => timeout_en_i_2_n_0,
      I1 => timeout_en_i_3_n_0,
      I2 => timeout_en_i_4_n_0,
      I3 => timeout_en_i_5_n_0,
      I4 => timeout_en_i_6_n_0,
      I5 => timeout_en,
      O => timeout_en_i_1_n_0
    );
timeout_en_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF7F00"
    )
        port map (
      I0 => \FSM_onehot_state[4]_i_14_n_0\,
      I1 => \FSM_onehot_state[4]_i_13_n_0\,
      I2 => \FSM_onehot_state[4]_i_12_n_0\,
      I3 => \FSM_onehot_state_reg_n_0_[1]\,
      I4 => data_timestamp_start,
      O => timeout_en_i_2_n_0
    );
timeout_en_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00A8A8A8A8A8A8A8"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[4]\,
      I1 => \FSM_onehot_state[4]_i_10_n_0\,
      I2 => \FSM_onehot_state[4]_i_11_n_0\,
      I3 => \FSM_onehot_state[4]_i_12_n_0\,
      I4 => \FSM_onehot_state[4]_i_13_n_0\,
      I5 => \FSM_onehot_state[4]_i_14_n_0\,
      O => timeout_en_i_3_n_0
    );
timeout_en_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4000400040000000"
    )
        port map (
      I0 => run,
      I1 => calib_finished_INST_0_i_1_n_0,
      I2 => timeout_en_i_7_n_0,
      I3 => timeout_en_i_8_n_0,
      I4 => \FSM_onehot_state[4]_i_11_n_0\,
      I5 => \FSM_onehot_state[4]_i_10_n_0\,
      O => timeout_en_i_4_n_0
    );
timeout_en_i_5: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00008880"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[4]\,
      I1 => rst_n,
      I2 => \^calibing_flag_r_reg_0\,
      I3 => run,
      I4 => ValidOutStop,
      O => timeout_en_i_5_n_0
    );
timeout_en_i_6: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AA00AA0000000300"
    )
        port map (
      I0 => axis_tready,
      I1 => \FSM_onehot_state_reg_n_0_[1]\,
      I2 => \FSM_onehot_state_reg_n_0_[4]\,
      I3 => rst_n,
      I4 => data_timestamp_start,
      I5 => \FSM_onehot_state_reg_n_0_[3]\,
      O => timeout_en_i_6_n_0
    );
timeout_en_i_7: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0400"
    )
        port map (
      I0 => \cnt_burst_calib_reg__0\(7),
      I1 => \cnt_burst_calib_reg__0\(6),
      I2 => \cnt_burst_calib_reg__0\(4),
      I3 => \cnt_burst_calib_reg__0\(5),
      O => timeout_en_i_7_n_0
    );
timeout_en_i_8: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => rst_n,
      I1 => \FSM_onehot_state_reg_n_0_[1]\,
      O => timeout_en_i_8_n_0
    );
timeout_en_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => timeout_en_i_1_n_0,
      Q => timeout_en,
      R => '0'
    );
tlast_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF111FFEEF000"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[1]\,
      I1 => \FSM_onehot_state_reg_n_0_[4]\,
      I2 => data_timestamp_start,
      I3 => axis_tready,
      I4 => calibing_flag_r_i_3_n_0,
      I5 => \^axis_tlast\,
      O => tlast_i_1_n_0
    );
tlast_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => calibing_flag_r_i_2_n_0,
      D => tlast_i_1_n_0,
      Q => \^axis_tlast\
    );
tvalid_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A8A8A8FFA8A8A8A8"
    )
        port map (
      I0 => axis_tready,
      I1 => \FSM_onehot_state_reg_n_0_[3]\,
      I2 => data_timestamp_start,
      I3 => \FSM_onehot_state_reg_n_0_[4]\,
      I4 => \FSM_onehot_state_reg_n_0_[1]\,
      I5 => \^axis_tvalid\,
      O => tvalid_i_1_n_0
    );
tvalid_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => calibing_flag_r_i_2_n_0,
      D => tvalid_i_1_n_0,
      Q => \^axis_tvalid\
    );
\tx_num_meas[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \tx_num_meas_reg__0\(0),
      O => plusOp(0)
    );
\tx_num_meas[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \tx_num_meas_reg__0\(0),
      I1 => \tx_num_meas_reg__0\(1),
      O => plusOp(1)
    );
\tx_num_meas[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \tx_num_meas_reg__0\(0),
      I1 => \tx_num_meas_reg__0\(1),
      I2 => \tx_num_meas_reg__0\(2),
      O => plusOp(2)
    );
\tx_num_meas[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \tx_num_meas_reg__0\(1),
      I1 => \tx_num_meas_reg__0\(0),
      I2 => \tx_num_meas_reg__0\(2),
      I3 => \tx_num_meas_reg__0\(3),
      O => plusOp(3)
    );
\tx_num_meas[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => \tx_num_meas_reg__0\(3),
      I1 => \tx_num_meas_reg__0\(2),
      I2 => \tx_num_meas_reg__0\(0),
      I3 => \tx_num_meas_reg__0\(1),
      I4 => \tx_num_meas_reg__0\(4),
      O => plusOp(4)
    );
\tx_num_meas[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFF80000000"
    )
        port map (
      I0 => \tx_num_meas_reg__0\(1),
      I1 => \tx_num_meas_reg__0\(0),
      I2 => \tx_num_meas_reg__0\(2),
      I3 => \tx_num_meas_reg__0\(3),
      I4 => \tx_num_meas_reg__0\(4),
      I5 => \tx_num_meas_reg__0\(5),
      O => plusOp(5)
    );
\tx_num_meas[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF7FFF00008000"
    )
        port map (
      I0 => \tx_num_meas_reg__0\(5),
      I1 => \tx_num_meas_reg__0\(4),
      I2 => \tx_num_meas_reg__0\(3),
      I3 => \tx_num_meas_reg__0\(2),
      I4 => \tx_num_meas[6]_i_2_n_0\,
      I5 => \tx_num_meas_reg__0\(6),
      O => plusOp(6)
    );
\tx_num_meas[6]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => \tx_num_meas_reg__0\(1),
      I1 => \tx_num_meas_reg__0\(0),
      O => \tx_num_meas[6]_i_2_n_0\
    );
\tx_num_meas[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B4"
    )
        port map (
      I0 => \tx_num_meas[9]_i_2_n_0\,
      I1 => \tx_num_meas_reg__0\(6),
      I2 => \tx_num_meas_reg__0\(7),
      O => plusOp(7)
    );
\tx_num_meas[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F708"
    )
        port map (
      I0 => \tx_num_meas_reg__0\(7),
      I1 => \tx_num_meas_reg__0\(6),
      I2 => \tx_num_meas[9]_i_2_n_0\,
      I3 => \tx_num_meas_reg__0\(8),
      O => plusOp(8)
    );
\tx_num_meas[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"DFFF2000"
    )
        port map (
      I0 => \tx_num_meas_reg__0\(8),
      I1 => \tx_num_meas[9]_i_2_n_0\,
      I2 => \tx_num_meas_reg__0\(6),
      I3 => \tx_num_meas_reg__0\(7),
      I4 => \tx_num_meas_reg__0\(9),
      O => plusOp(9)
    );
\tx_num_meas[9]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFFFFFFFFFF"
    )
        port map (
      I0 => \tx_num_meas_reg__0\(1),
      I1 => \tx_num_meas_reg__0\(0),
      I2 => \tx_num_meas_reg__0\(2),
      I3 => \tx_num_meas_reg__0\(3),
      I4 => \tx_num_meas_reg__0\(4),
      I5 => \tx_num_meas_reg__0\(5),
      O => \tx_num_meas[9]_i_2_n_0\
    );
\tx_num_meas_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \^axis_tvalid\,
      D => plusOp(0),
      Q => \tx_num_meas_reg__0\(0),
      R => \^axis_tlast\
    );
\tx_num_meas_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \^axis_tvalid\,
      D => plusOp(1),
      Q => \tx_num_meas_reg__0\(1),
      R => \^axis_tlast\
    );
\tx_num_meas_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \^axis_tvalid\,
      D => plusOp(2),
      Q => \tx_num_meas_reg__0\(2),
      R => \^axis_tlast\
    );
\tx_num_meas_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \^axis_tvalid\,
      D => plusOp(3),
      Q => \tx_num_meas_reg__0\(3),
      R => \^axis_tlast\
    );
\tx_num_meas_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \^axis_tvalid\,
      D => plusOp(4),
      Q => \tx_num_meas_reg__0\(4),
      R => \^axis_tlast\
    );
\tx_num_meas_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \^axis_tvalid\,
      D => plusOp(5),
      Q => \tx_num_meas_reg__0\(5),
      R => \^axis_tlast\
    );
\tx_num_meas_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \^axis_tvalid\,
      D => plusOp(6),
      Q => \tx_num_meas_reg__0\(6),
      R => \^axis_tlast\
    );
\tx_num_meas_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \^axis_tvalid\,
      D => plusOp(7),
      Q => \tx_num_meas_reg__0\(7),
      R => \^axis_tlast\
    );
\tx_num_meas_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \^axis_tvalid\,
      D => plusOp(8),
      Q => \tx_num_meas_reg__0\(8),
      R => \^axis_tlast\
    );
\tx_num_meas_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \^axis_tvalid\,
      D => plusOp(9),
      Q => \tx_num_meas_reg__0\(9),
      R => \^axis_tlast\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  port (
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
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "zynq_blk_tdc_control_0_0,tdc_control,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "tdc_control,Vivado 2018.3";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  signal \^dlenable\ : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of axis_tlast : signal is "xilinx.com:interface:axis:1.0 axis TLAST";
  attribute X_INTERFACE_INFO of axis_tready : signal is "xilinx.com:interface:axis:1.0 axis TREADY";
  attribute X_INTERFACE_INFO of axis_tvalid : signal is "xilinx.com:interface:axis:1.0 axis TVALID";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of axis_tvalid : signal is "XIL_INTERFACENAME axis, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 350000000, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF axis, FREQ_HZ 350000000, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of rst_n : signal is "xilinx.com:signal:reset:1.0 rst_n RST";
  attribute X_INTERFACE_PARAMETER of rst_n : signal is "XIL_INTERFACENAME rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of axis_tdata : signal is "xilinx.com:interface:axis:1.0 axis TDATA";
  attribute X_INTERFACE_INFO of axis_tkeep : signal is "xilinx.com:interface:axis:1.0 axis TKEEP";
begin
  DLenable <= \^dlenable\;
  axis_tkeep(7) <= \^dlenable\;
  axis_tkeep(6) <= \^dlenable\;
  axis_tkeep(5) <= \^dlenable\;
  axis_tkeep(4) <= \^dlenable\;
  axis_tkeep(3) <= \^dlenable\;
  axis_tkeep(2) <= \^dlenable\;
  axis_tkeep(1) <= \^dlenable\;
  axis_tkeep(0) <= \^dlenable\;
inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tdc_control
     port map (
      DLenable => \^dlenable\,
      ValidOutStart => ValidOutStart,
      ValidOutStop => ValidOutStop,
      axis_tdata(63 downto 0) => axis_tdata(63 downto 0),
      axis_tlast => axis_tlast,
      axis_tready => axis_tready,
      axis_tvalid => axis_tvalid,
      calib_en => calib_en,
      calibing_flag_r_reg_0 => calibing_flag,
      clk => clk,
      \cnt_burst_calib_reg[5]_0\ => calib_finished,
      hit_source => hit_source,
      rst_n => rst_n,
      run => run,
      timestampStart(31 downto 0) => timestampStart(31 downto 0),
      timestampStop(31 downto 0) => timestampStop(31 downto 0)
    );
end STRUCTURE;
