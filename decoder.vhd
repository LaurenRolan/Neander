----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:35:16 09/14/2016 
-- Design Name: 
-- Module Name:    decoder - Behavioral 
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

entity decoder is
    Port ( instruction : in  STD_LOGIC_VECTOR (7 downto 0);
    	   out_decoder : out STD_LOGIC_VECTOR(12 downto 0)
end decoder;

architecture Behavioral of decoder is

begin	
	process (instruction)
	begin
		-- Inicializa todos em 0
		out_decoder <= "0000000000000";
		case instruction(7 downto 4) is
			when "0000" => out_decoder <= "1000000000000";--do_nop <= '1';
			when "0001" => out_decoder <= "0100000000000";--do_sta <= '1';
			when "0010" => out_decoder <= "0010000000000";--do_lda <= '1';
			when "0011" => out_decoder <= "0001000000000";--do_add <= '1';
			when "0100" => out_decoder <= "0000100000000";--do_or  <= '1';
			when "0101" => out_decoder <= "0000010000000";--do_and <= '1';
			when "0110" => out_decoder <= "0000001000000";--do_not <= '1';
			when "1000" => out_decoder <= "0000000100000";--do_jmp <= '1';
			when "1001" => out_decoder <= "0000000010000";--do_jn  <= '1';
			when "1010" => out_decoder <= "0000000001000";--do_jz  <= '1';
			when "1011" => out_decoder <= "0000000000100";--do_mul <= '1';
			when "1100" => out_decoder <= "0000000000010";--do_inc <= '1';
			when "1111" => out_decoder <= "0000000000001";--do_hlt <= '1';
			when others => out_decoder <= "0000000000000";--do_hlt <= '0';
		end case;
	end process;
end Behavioral;

