----------------------------------------------------------------------------------
-- Rising Edge Detector
-- Version: 1.0
--
-- Author: Liu Yanxu
-- Created: 23.5.2024
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity risingEdgeDetector is
   Port (
      clk: in std_logic;
      sig_i : in std_logic;
      sig_o : out std_logic
   );
end risingEdgeDetector;

architecture rtl of risingEdgeDetector is
   signal q : std_logic;
begin

   FF: process(clk)  -- flip-flop
   begin
      if rising_edge(clk) then
         q <= sig_i;
      end if;
   end process;
   
   sig_o <= sig_i and not q;  -- AND gate

end rtl;
