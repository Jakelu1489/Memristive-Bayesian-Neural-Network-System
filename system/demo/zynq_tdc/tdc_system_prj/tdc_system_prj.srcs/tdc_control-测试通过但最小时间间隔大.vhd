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
      Calib_SIZE : integer := 50000; -- Code Density Test for delay time
      Brust_SIZE : integer := 512; -- max number of measurements for once DMA transfer 
      TimeOut_SIZE : integer := 28 -- timeout is 2 seconds
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
      --    rst : IN STD_LOGIC;
      --    wr_clk : IN STD_LOGIC;
      --    rd_clk : IN STD_LOGIC;
      --    
      --    
      --    rd_en : IN STD_LOGIC;
      --    dout : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
      --    
      --    empty : OUT STD_LOGIC;
      --    prog_full : OUT STD_LOGIC;
      --    
      --    rd_rst_busy : OUT STD_LOGIC
      -- FIFO signals 
      -- rst : out std_logic;
      -- wr_en : out std_logic;
      -- din : out std_logic_vector(63 downto 0);
      -- full : in std_logic;
      -- wr_rst_busy : in std_logic;

   );
end tdc_control;

architecture RTL of tdc_control is
   constant EOF_DMA : std_logic_vector(31 downto 0) := (others => '1');
   constant MAX_BURST_SIZE : std_logic_vector(15 downto 0) := conv_std_logic_vector(Brust_SIZE - 1, 16);
   constant max_timeout_cnt : std_logic_vector(TimeOut_SIZE downto 0) := (others => '1');
   constant max_timeout_cnt_ready : std_logic_vector(1 downto 0) := ('1', others => '0');

   -- inter-signal
   signal data_timestamp_start, data_timestamp_stop : std_logic_vector(31 downto 0);
   signal cnt : std_logic_vector(15 downto 0);-- address counter 
   signal timeout_cnt : std_logic_vector(TimeOut_SIZE downto 0) := (others => '0');
   signal hit_source_r : std_logic;
   type StateType is (-- FSM states
      INIT,
      IDLE,
      RUNNING,
      MEASWait,
      STORE,
      EOF
   );
   signal state : StateType := INIT;
   signal flag_calib_init : std_logic := '0'; -- 
   signal calibing_flag_r : std_logic := '0';
   signal timeout_en : std_logic := '0';

begin
   Counter : process (clk)
   begin
      if rising_edge(clk) then
         if (timeout_en = '1') then
            timeout_cnt <= timeout_cnt + '1';
         else
            timeout_cnt <= (others => '0');
         end if;
      end if;
   end process;

   StateMachine : process (clk, rst_n)
   begin
      if (rst_n = '0') then
         state <= INIT;
         calibing_flag_r <= '0';
         hit_source_r <= '0'; -- normal source
         flag_calib_init <= '0';
         cnt <= (others => '0');
         axis_tvalid <= '0';
         axis_tlast <= '0';
      elsif rising_edge(clk) then
         case state is
            when IDLE =>
               data_timestamp_start <= (others => '0');
               data_timestamp_stop <= (others => '0');
               axis_tvalid <= '0';
               axis_tlast <= '0';
               if (flag_calib_init = '0') then
                  if (calib_en = '1') then -- from ps
                     calibing_flag_r <= '1';
                     hit_source_r <= '1'; -- calibreation mode 
                     state <= RUNNING;
                  end if;
               else
                  if (run = '1') then -- capture tdc measurement
                     state <= RUNNING;
                  elsif (not(cnt = 0)) then -- timeout 
                     if (timeout_cnt = max_timeout_cnt) then
                        timeout_en <= '0';
                        cnt <= (others => '0');
                        state <= EOF;
                     else
                        timeout_en <= '1';
                     end if;
                  end if;
               end if;
               -- timeout_cnt <= (others => '0');

               -- elsif () then
               --    timeout_cnt <= timeout_cnt + 1;
               -- else
               --    -- timeout_cnt <= (others => '0');
               --    state <= IDLE; 
            when RUNNING => -- wait for vaildstart signal , sync start and stop
               axis_tvalid <= '0';
               axis_tlast <= '0';
               if (run = '0' and calibing_flag_r = '0') then -- stop collecting data
                  state <= IDLE;
               elsif (ValidOutStart = '1') then -- timestamp arrived
                  data_timestamp_start <= timestampStart;
                  state <= MEASWait;
               elsif (ValidOutStop = '1') then -- stop frist arrived  ,wait for vaildstart signal
                  -- data_timestamp_stop <= (others => '0');
                  state <= RUNNING;
               elsif (not(cnt = 0)) then -- timeout 
                  if (timeout_cnt = max_timeout_cnt) then
                     timeout_en <= '0';
                     cnt <= (others => '0');
                     state <= EOF;
                  else
                     timeout_en <= '1';
                  end if;
                  -- elsif (not (cnt = 0) and timeout_cnt = max_timeout_cnt) then -- timeout detection
                  --    cnt <= (others => '0');
                  --    -- timeout_cnt <= (others => '0');
                  --    state <= EOF;
                  --    -- elsif (not (cnt = 0)) then --  timeout for tdc measurement
                  --    --    timeout_cnt <= timeout_cnt + 1;
                  --    -- else
                  --    --    timeout_cnt <= (others => '0');
                  --    -- data_timestamp_start <= (others => '0');
                  --    -- data_timestamp_stop <= (others => '0');
               end if;

            when MEASWait => -- wait for reset of RUN bit
               if (ValidOutStop = '1') then -- stop arrived
                  data_timestamp_stop <= timestampStop;
                  state <= STORE;
                  -- else
                  --    data_timestamp_stop <= (others => '0');
               end if;

               if (run = '0' and calibing_flag_r = '0') then -- stop collecting data
                  state <= IDLE;
               end if;
               timeout_en <= '0';

            when STORE => -- write to AXI Stream 
               if axis_tready = '1' then --
                  -- if (run = '1') then
                  axis_tvalid <= '1';
                  state <= RUNNING;
                  if (calibing_flag_r = '1' and cnt = Calib_SIZE - 1) then -- calibration mode 
                     calibing_flag_r <= '0'; -- stop and exit calibration
                     hit_source_r <= '0';
                     axis_tlast <= '1';
                     cnt <= (others => '0');
                     flag_calib_init <= '1'; -- finish calibration after power up
                  elsif ((cnt and MAX_BURST_SIZE) = MAX_BURST_SIZE) then
                     axis_tlast <= '1';
                     if (calibing_flag_r = '0') then -- normal mode 
                        cnt <= (others => '0');
                     else -- calibration  mode
                        cnt <= cnt + 1;
                     end if;
                  else
                     cnt <= cnt + 1;
                  end if;
                  -- else
                  --    state <= IDLE;
                  -- end if;
               elsif (timeout_cnt = max_timeout_cnt_ready) then -- 超时未存储
                  -- timeout_cnt <= (others => '0');
                  timeout_en <= '0';
                  state <= RUNNING;
                  axis_tvalid <= '0';
               else
                  timeout_en <= '1';
                  -- timeout_cnt <= timeout_cnt + 1;
               end if;
               -- timeout_cnt <= (others => '0');

            when EOF =>
               data_timestamp_start <= EOF_DMA;
               data_timestamp_stop <= EOF_DMA;
               state <= IDLE;
               if (axis_tready = '1') then --
                  axis_tvalid <= '1';
                  axis_tlast <= '1';
               end if;
            when others => -- INIT
               state <= IDLE;
               timeout_en <= '0';
               cnt <= (others => '0');
         end case;
      end if;
   end process;
   axis_tdata <= data_timestamp_stop & data_timestamp_start;
   DLenable <= '0' when (state = INIT) else
      '1'; --TDC         
   axis_tkeep <= (others => '0') when(state = INIT) else
      (others => '1');
   calib_finished <= flag_calib_init;
   calibing_flag <= calibing_flag_r;
   hit_source <= hit_source_r;
end RTL;