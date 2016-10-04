----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:39:27 09/30/2016 
-- Design Name: 
-- Module Name:    contador - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity contador is
    Port ( clk : in STD_LOGIC;
			  start : in  STD_LOGIC; -- swt 0
           rst : in  STD_LOGIC; -- sw1
           segmentos : out  STD_LOGIC_VECTOR (6 downto 0);
           anodos : out  STD_LOGIC_VECTOR (3 downto 0));
end contador;

architecture Behavioral of contador is
signal rstFSM : std_logic := '1';
signal clk_x : std_logic;
signal web : std_logic_vector (0 downto 0) := "0";
signal acc, data, address, sai_mem, pc: std_logic_vector (7 downto 0) := "00000000";
begin
	process(clk, rst, start)
	begin
		if rst = '1' then
			rstFSM <= '1';
		elsif start <= '1' then
			rstFSM <= '0';
		else rstFSM <= '0';
		end if;
	end process;
DIVFREQ: entity work.freq_div port map (clk, rst, clk_x);
NEANDER:	entity work.neander2 port map (address, data, web, clk_x, rstFSM, acc, pc);
VISOR:	entity work.visor port map (acc, clk, anodos, segmentos);
end Behavioral;

