----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:19:26 09/26/2016 
-- Design Name: 
-- Module Name:    binseven - Behavioral 
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

entity binseven is
    Port ( bin : in  STD_LOGIC_VECTOR (3 downto 0);
           seven : out  STD_LOGIC_VECTOR (6 downto 0));
end binseven;

architecture Behavioral of binseven is
begin
	process (bin)
	begin
		case bin is
			when "0000" => seven <= "0000001";	--0
			when "0001" => seven <= "1001111";	--1
			when "0010" => seven <= "0010010";	--2
			when "0011" => seven <= "0000110";	--3
			when "0100" => seven <= "1001100";	--4
			when "0101" => seven <= "0100100";	--5
			when "0110" => seven <= "0100000"; 	--6
			when "0111" => seven <= "0001111";	--7
			when "1000" => seven <= "0000000";	--8
			when "1001" => seven <= "0000100";	--9
			when "1010" => seven <= "0000010";	--A
			when "1011" => seven <= "1100000";	--B
			when "1100" => seven <= "0110001";	--C
			when "1101" => seven <= "1000010";	--D
			when "1110" => seven <= "0010000";	--E
			when "1111" => seven <= "0111000";	--F
		end case;
	end process;
end Behavioral;

