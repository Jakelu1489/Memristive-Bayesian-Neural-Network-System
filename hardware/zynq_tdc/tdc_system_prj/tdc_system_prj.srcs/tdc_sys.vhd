----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2024/05/24 00:34:20
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--use work.tdc_sys.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tdc_sys is
    Port ( 
    sys_clk : IN STD_LOGIC;
    sys_rst_n : IN STD_LOGIC;
    
--    tdc_clk : IN STD_LOGIC; -- TDC clk 350MHz
--    axi_clk : IN STD_LOGIC; -- AXI clk 100MHz
    
    start_hit : IN STD_LOGIC;
    stop_hit : IN STD_LOGIC
    );
end tdc_sys;


architecture rtl of tdc_sys is
-- inter signal 
signal tdc_clk, axi_clk : STD_LOGIC;
signal DLenable : STD_LOGIC; -- TDC enable


begin


SysPLL: work.clk_wiz_0
port map (
      clk_in1 => sys_clk,
      resetn  => sys_rst_n,
      clk_out1 => tdc_clk, -- 350MHz
      clk_out2 => axi_clk  -- 100MHz
);



TDCstart : work.TDCchannel_0(rtl)
port map (
      clk => tdc_clk,
      hit => start_hit,
      DLenable => DLenable,
      ValidOut => ValidOutStop,
      timestamp => timestampStop
);

--TDCstop : work.TDCchannel_0(rtl)
--port map (
--      clk => tdc_clk,
--      hit => stop_hit,
--      DLenable => DLenable,
--      ValidOut => ValidOutStop,
--      timestamp => timestampStop
--);			
			

--TDCstop123:
--   entity work.TDCchannel_stop(rtl)
--   port map (
--      clk => clk,
--      hit => hit,
--      DLenable => DLenable,
--      ValidOut => ValidOutStop,
--      timestamp => timestampStop
--   );

end rtl;
