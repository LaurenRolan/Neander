----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:38:06 09/12/2016 
-- Design Name: 
-- Module Name:    reg8 - Behavioral 
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

entity reg8 is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           load : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           F : out  STD_LOGIC_VECTOR (7 downto 0));
end reg8;

architecture Behavioral of reg8 is
signal saida: std_logic_vector(7 downto 0);
begin
process (clk, reset)
begin
	if(reset = '1')then
		saida <= "00000000";
	elsif(rising_edge(clk))then
		if(load = '1')then
			saida <= A;
		else saida <= saida; -- Esse else tem que existir, senão dá cocô.
		end if;
	end if;
end process;

F <= saida;

end Behavioral;

