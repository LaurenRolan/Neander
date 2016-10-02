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
    Port ( --insere : in  STD_LOGIC; -- switch 7
           clk : in  STD_LOGIC;
	   rst : in STD_LOGIC; -- switch 7
	   insere: in std_logic; --botao [?]
	   fim: in std_logic;		--botao [?]
	   ender: in std_logic_vector(2 downto 0);--switches 6 downto 4
           anodos : out  STD_LOGIC_VECTOR (3 downto 0);
           segmentos : out  STD_LOGIC_VECTOR (6 downto 0);
           switches : in  STD_LOGIC_VECTOR (3 downto 0); -- switches 3 downto 0
	   pc : out STD_LOGIC_VECTOR (7 DOWNTO 0));
end matriz;

architecture Behavioral of matriz is
signal rstFSM, clk_x: std_logic := '1';
signal insere_out,fim_out:std_logic := '0';
signal ant : std_logic := '0';
signal web : std_logic_vector (0 downto 0) := "0";
signal address, data, acc,acc2 : std_logic_vector (7 downto 0) := "00000000";
begin
	process (clk)
	begin
		if rst = '1' then
			rstFSM <= '1';
		elsif rising_edge(clk) then
			if(fim_out='1') then
				rstFSM<='0';
			elsif(insere_out='1' and rstFSM='1')then
				rstFSM<='1';
				data<="0000" & switches;
				address <= "00011110"+("000"&ender);
				web<="1";
			end if;			
		end if;
		if(rstFSM<='1')then
			acc2<="0000" & switches;
		else acc2<=acc;
		end if;
	end process;
DEBOUNCER1:entity work.debouncer port map (insere,clk,insere_out);
DEBOUNCER2:entity work.debouncer port map (fim,clk,fim_out);
DIVFREQ: entity work.freq_div port map (clk, rst, clk_x);
NEANDER: entity work.neander2 port map (address, data, web, clk_x, rstFSM, acc, pc);
VISOR:	entity work.visor port map (acc2, clk, anodos, segmentos);
end Behavioral;

