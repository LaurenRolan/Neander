----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:26:28 09/27/2016 
-- Design Name: 
-- Module Name:    MUX31 - Behavioral 
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

entity MUX31 is
    Port ( in0 : in  STD_LOGIC_VECTOR (7 downto 0);
           in1 : in  STD_LOGIC_VECTOR (7 downto 0);
           in2 : in  STD_LOGIC_VECTOR (7 downto 0);
			  sel : in  STD_LOGIC_VECTOR (1 downto 0);
           saida : out  STD_LOGIC_VECTOR (7 downto 0));
end MUX31;

architecture Behavioral of MUX31 is

begin
	process (sel, in0, in1, in2)
	begin
		case sel is
			when "00" => saida <= in0;
			when "01" => saida <= in1;
			when "10" => saida <= in2;
			when others => saida <= "00000000";
		end case;
	end process;

end Behavioral;

