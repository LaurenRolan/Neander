----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:39:21 10/01/2016 
-- Design Name: 
-- Module Name:    matriz - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity matriz is
    Port ( insere : in  STD_LOGIC; -- switch 7
           clk : in  STD_LOGIC;
			  rst : in STD_LOGIC; -- switch 6
           anodos : out  STD_LOGIC_VECTOR (3 downto 0);
           segmentos : out  STD_LOGIC_VECTOR (6 downto 0);
           switches : in  STD_LOGIC_VECTOR (3 downto 0); -- switches 0 to 3
			  pc : out STD_LOGIC_VECTOR (7 DOWNTO 0));
end matriz;

architecture Behavioral of matriz is
signal rstFSM, clk_x: std_logic := '1';
signal ant : std_logic := '0';
signal web : std_logic_vector (0 downto 0) := "0";
signal address, data, acc : std_logic_vector (7 downto 0) := "00000000";
begin
	process (clk)
	variable count : integer range 0 to 9 := 0;
	begin
		if rst = '1' then
			count := 0;
			rstFSM <= '1';
		elsif rising_edge(clk) then
			if insere = '1' and ant = '0' then
				if count <= 8 then count := count + 1; end if;
				case count is
					when 1 => web <= "1"; rstFSM <= '1'; address <= "00011110"; data <= "0000" & switches;
					when 9 => web <= "0"; rstFSM <= '0'; address <= "10000000"; data <= "0000" & switches;
					when others => web <= "1"; rstFSM <= '1'; address <= address + '1'; data <= "0000" & switches;
				end case;
				ant <= insere;
			else ant <= insere;
			end if;
		end if;
	end process;
DIVFREQ: entity work.freq_div port map (clk, rst, clk_x);
NEANDER: entity work.neander2 port map (address, data, web, clk_x, rstFSM, acc, pc);
VISOR:	entity work.visor port map (acc, clk, anodos, segmentos);
end Behavioral;

