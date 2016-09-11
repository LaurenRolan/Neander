----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:46:36 09/11/2016 
-- Design Name: 
-- Module Name:    MUX21 - Behavioral 
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

entity MUX21 is
    Port ( In0 : in  STD_LOGIC_VECTOR (7 downto 0);
           In1 : in  STD_LOGIC_VECTOR (7 downto 0);
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end MUX21;

architecture Behavioral of MUX21 is
begin
	process (sel, In0, In1)
	begin
		if sel = '0' then
			output <= In0;
		else output <= In1;
		end if;
	end process;
end Behavioral;

