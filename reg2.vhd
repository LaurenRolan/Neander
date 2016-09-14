----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:52:56 09/14/2016 
-- Design Name: 
-- Module Name:    reg2 - Behavioral 
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

entity reg2 is
    Port ( input : in  STD_LOGIC_VECTOR (1 downto 0);
           load : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           F : out  STD_LOGIC_VECTOR (1 downto 0));
end reg2;

architecture Behavioral of reg2 is
signal saida: STD_LOGIC_VECTOR(1 downto 0);
begin
	process (clk, reset)
	begin
		if reset = '1' then
			saida <= "00";
		elsif rising_edge(clk) then
			if load = '1' then
				saida <= input;
			else 
				saida <= saida;
			end if;
		end if;
	end process;
	F <= saida;
end Behavioral;

