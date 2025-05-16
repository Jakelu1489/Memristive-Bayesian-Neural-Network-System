-----------------------------------------------------------------------------------------------------
---- TDC delayLine counter testbench
---- Version: 1.0
----
---- Author: Liu Yanxu
---- Created: 23.5.2024
---- Modified: 23.5.2024
----
---- Checks if the delayLine runs correct.
-----------------------------------------------------------------------------------------------------

--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
----use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx leaf cells in this code.
----library UNISIM;
----use UNISIM.VComponents.all;

--entity delayLineTb is
--end delayLineTb;

--architecture Behavioral of delayLineTb is

--   --Inputs
--   signal clk : std_logic := '0';
--   signal start :   std_logic:= '0';
--   signal stop :   std_logic:= '0';
--   signal enable :   std_logic:= '0';
--   --Outputs
--   constant BITS : integer := 8;    -- counter bit range
--   constant NTaps : integer := 48;    -- counter bit range
----   signal coarse : std_logic_vector(BITS-1 downto 0);
 
--   signal thermo: std_logic_vector(NTaps-1 downto 0); -- synchronized TDL output (thermometer code)
--   signal valid: std_logic;


--   -- Clock period definitions 
--   constant T_C : time := 10.0 ns; -- Clock period constant
   
--begin

--   -- Instantiate the Unit Under Test (UUT)
--   uut: entity work.delayLine
--   generic map (NTaps => NTaps)
--      PORT MAP (
--         clk => clk,
--         start => start,
--         stop => stop,
--         enable => enable,
--         thermo => thermo,
--         valid=> valid
--      );
      

      
      
--   -- Clock generation
--      p_SyncClkGen : process
--      begin
--         clk <= '0';
--         wait for T_C/2;
--         clk <= '1';
--         wait for T_C/2;
--      end process;

--   -- Simulation
--   p_Sim: process
--   begin
--   wait for T_C * 10;  
--   enable <= '1';
--      wait for T_C * 10;  
--      start <= '1';
--      wait for 40 ns;
--      stop <= '1';
--      wait for 10 ns;
--      start <= '0';
--      wait for 1 ns;
--      stop <= '0';
--      wait for T_C * 10;  
--      start <= '1';
--      wait for 50 ns;
--      stop <= '1';
--      start <= '0';
--      wait for 50ns;
--      stop <= '0';
      
----      wait for T_C * 2**(BITS+1);   -- Take me around the world one more time, James
      
--      -- Stop simulation
--      assert false report "SIMULATION COMPLETED" severity failure;
      
--   end process;
--end Behavioral;
