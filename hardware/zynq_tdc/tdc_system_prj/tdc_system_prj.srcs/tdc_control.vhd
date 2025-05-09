----------------------------------------------------------------------------------
-- TDC Control Unit
-- Version: 2.0 (based on 1.0)
--
-- Author: Liu yanxu
-- Created: 24.5.2024
-- TDC enable controlled by FSM
-- FIFO rst controlled by FSM  
-- FIFO mode: FWFT 
-- Finite state machine.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.all;
use ieee.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity tdc_control is
   generic (
      Calib_SIZE : integer := 100; -- Code Density Test for delay time, number of Brust_size : 100 means 100*Brust_SIZE, max 255
      Brust_SIZE : integer := 512; -- max number of measurements for once DMA transfer 
      TimeOut_SIZE : integer := 12 -- timeout is 1.5 seconds
   );
   port (
      --TDC channel 
      clk : in std_logic; -- TDC System clk 
      rst_n : in std_logic; -- System rst_n
      ValidOutStart : in std_logic; -- TDC valid 
      ValidOutStop : in std_logic; -- TDC valid                  
      timestampStart : in std_logic_vector(31 downto 0);-- incoming timestamp
      timestampStop : in std_logic_vector(31 downto 0);-- incoming timestamp

      -- TDC control signals
      DLenable : out std_logic; -- delay line enable
      run : in std_logic; -- collect data
      -- PS control 
      calib_en : in std_logic; -- refresh TDC calibration parameters
      -- rdy : out std_logic; -- FSM ready
      calibing_flag : out std_logic; -- 正在校正中，校正完拉低
      calib_finished : out std_logic; -- calibration finished,校正后持续拉高
      -- start and stop hit source  choose
      hit_source : out std_logic; -- 0: normal mode, 1: calibration mode 
      -- master_axi
      axis_tready : in std_logic;
      axis_tdata : out std_logic_vector(63 downto 0);
      axis_tkeep : out std_logic_vector(7 downto 0);
      axis_tlast : out std_logic;
      axis_tvalid : out std_logic

   );
end tdc_control;

architecture RTL of tdc_control is
   constant EOF_DMA : std_logic_vector(31 downto 0) := (others => '1');
   constant MAX_BURST_SIZE : std_logic_vector(9 downto 0) := conv_std_logic_vector(Brust_SIZE - 1, 10);
   constant max_timeout_cnt : std_logic_vector(TimeOut_SIZE downto 0) := (others => '1');
   -- constant max_timeout_cnt_ready : std_logic_vector(1 downto 0) := ('1', others => '0');
   constant max_cnt_burst_calib : std_logic_vector(7 downto 0) := conv_std_logic_vector(Calib_SIZE, 8);
   constant max_cnt_burst_calib_finish : std_logic_vector(7 downto 0) := conv_std_logic_vector(Calib_SIZE - 1, 8);

   -- inter-signal
   signal data_timestamp_start, data_timestamp_stop : std_logic_vector(31 downto 0) := (others => '1');
   signal tx_num_meas : std_logic_vector(9 downto 0) := (others => '0');-- 
   signal timeout_cnt : std_logic_vector(TimeOut_SIZE downto 0) := (others => '0');
   signal hit_source_r : std_logic;
   signal cnt_burst_calib : std_logic_vector(7 downto 0) := (others => '0');

   signal tlast, tvalid : std_logic;
   signal clk_cnt : std_logic_vector(15 downto 0) := (others => '0'); -- real 43.75MHz
   -- signal tx_cnt_valid_en : std_logic := '0';
   -- signal tx_cnt_clr_en : std_logic := '0';

   type StateType is (-- FSM states
      INIT,
      IDLE,
      RUNNING,
      -- MEASWait,
      STORE,
      EOF
   );
   signal state : StateType := INIT;
   -- signal flag_calib_init : std_logic := '0';
   signal calibing_flag_r : std_logic := '0';
   signal timeout_en : std_logic := '0';

begin
   clk_50m : process (clk)
   begin
      if rising_edge(clk) then
         if (timeout_en = '1') then
            clk_cnt <= clk_cnt + '1';
         else
            clk_cnt <= (others => '0');
         end if;
      end if;
   end process;
   Counter : process (clk)
   begin
      if rising_edge(clk) then
         if (timeout_en = '1') then
            if (clk_cnt = 0) then
               timeout_cnt <= timeout_cnt + '1';
            end if;
         else
            timeout_cnt <= (others => '0');
         end if;
      end if;
   end process;

   TimeStamp : process (clk)
   begin
      if rising_edge(clk) then
         if (state = EOF) then
            data_timestamp_start <= EOF_DMA;
            data_timestamp_stop <= EOF_DMA;
         else
            if (ValidOutStart = '1') then
               data_timestamp_start <= timestampStart;
            end if;
            if (ValidOutStop = '1') then
               data_timestamp_stop <= timestampStop;
            end if;
         end if;
      end if;
   end process;

   txCnt : process (clk)
   begin
      if rising_edge(clk) then
         if (tlast = '1') then
            tx_num_meas <= (others => '0');
         elsif (tvalid = '1') then
            tx_num_meas <= tx_num_meas + '1';
         end if;
      end if;
   end process;

   StateMachine : process (clk, rst_n)
   begin
      if (rst_n = '0') then
         state <= INIT;
         calibing_flag_r <= '0';
         -- flag_calib_init <= '0';
         tvalid <= '0';
         tlast <= '0';
         cnt_burst_calib <= (others => '0');
      elsif rising_edge(clk) then
         case state is
            when IDLE =>
               tvalid <= '0';
               tlast <= '0';
               if (not (cnt_burst_calib = max_cnt_burst_calib)) then -- calibtion finished
                  if (calib_en = '1') then -- from ps
                     calibing_flag_r <= '1';
                     state <= RUNNING;
                  end if;
               else
                  if (run = '1') then -- capture tdc measurement
                     state <= RUNNING;
                  elsif (not(tx_num_meas = 0)) then -- wait for  timeout
                     if (timeout_cnt = max_timeout_cnt) then
                        timeout_en <= '0';
                        state <= EOF;
                     else
                        timeout_en <= '1';
                     end if;
                  end if;
               end if;
            when RUNNING => -- wait for stop signal 
               tvalid <= '0';
               tlast <= '0';
               if (run = '0' and calibing_flag_r = '0') then -- stop collecting data
                  state <= IDLE;
               elsif (ValidOutStop = '1') then -- stop frist arrived  ,wait for vaildstart signal
                  state <= STORE;
               elsif (not(tx_num_meas = 0)) then -- timeout 
                  if (timeout_cnt = max_timeout_cnt) then
                     timeout_en <= '0';
                     state <= EOF;
                  else
                     timeout_en <= '1';
                  end if;
               else
                  timeout_en <= '0';
               end if;
            when STORE => -- write to AXI Stream 
               if axis_tready = '1' then -- 
                  tvalid <= '1';
                  timeout_en <= '0';
                  state <= RUNNING;
                  if (tx_num_meas = MAX_BURST_SIZE) then
                     tlast <= '1';
                     if (cnt_burst_calib = max_cnt_burst_calib_finish) then
                        calibing_flag_r <= '0'; -- stop and exit calibration
                     end if;
                     if (calibing_flag_r = '1') then -- calibration mode 
                        cnt_burst_calib <= cnt_burst_calib + '1';
                     end if;
                  elsif (run = '0') then
                     if (calibing_flag_r = '0') then -- normal mode : go to IDLE; calibing mode : wait for ready signal
                        state <= IDLE;
                     end if;
                  end if;
               end if;

            when EOF =>
               if (axis_tready = '1') then --
                  tvalid <= '1';
                  tlast <= '1';
                  state <= IDLE;
               elsif (ValidOutStop = '1') then -- stop frist arrived  ,wait for vaildstart signal
                  state <= STORE;
                  -- elsif (timeout_cnt = max_timeout_cnt_ready) then -- 超时未存储, 14ns
                  --    timeout_en <= '0';
                  --    state <= IDLE;
                  --    axis_tvalid <= '1';
                  -- else
                  --    timeout_en <= '1';
               end if;

            when others => -- INIT
               state <= IDLE;
               timeout_en <= '0';
               -- tx_cnt_clr_en <= '1';
               -- tx_valid_en <= '0';
         end case;
      end if;
   end process;
   axis_tdata <= data_timestamp_stop & data_timestamp_start;
   axis_tvalid <= tvalid;
   axis_tlast <= tlast;

   DLenable <= '0' when (state = INIT) else
      '1'; --TDC         
   axis_tkeep <= (others => '0') when(state = INIT) else
      (others => '1');
   calib_finished <= '1' when (cnt_burst_calib = max_cnt_burst_calib) else
      '0';
   calibing_flag <= calibing_flag_r;
   hit_source <= '0' when (cnt_burst_calib = max_cnt_burst_calib) else-- normal source 
      '1'; -- calibreation mode 
end RTL;