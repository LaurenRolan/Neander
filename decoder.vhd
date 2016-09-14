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
           do_nop : out  STD_LOGIC;
           do_sta : out  STD_LOGIC;
           do_lda : out  STD_LOGIC;
           do_add : out  STD_LOGIC;
           do_or : out  STD_LOGIC;
           do_and : out  STD_LOGIC;
           do_not : out  STD_LOGIC;
           do_jmp : out  STD_LOGIC;
           do_jn : out  STD_LOGIC;
           do_jz : out  STD_LOGIC;
           do_hlt : out  STD_LOGIC);
end decoder;

architecture Behavioral of decoder is

begin	
	process (instruction)
	begin
		-- Inicializa todos em 0
		do_nop <= '0';
		do_sta <= '0';
		do_lda <= '0';
		do_add <= '0';
		do_or  <= '0';
		do_and <= '0';
		do_not <= '0';
		do_jmp <= '0';
		do_jn  <= '0';
		do_jz  <= '0';
		do_hlt <= '0';
		case instruction(7 downto 4) is
			when "0000" => do_nop <= '1';
			when "0001" => do_sta <= '1';
			when "0010" => do_lda <= '1';
			when "0011" => do_add <= '1';
			when "0100" => do_or  <= '1';
			when "0101" => do_and <= '1';
			when "0110" => do_not <= '1';
			when "1000" => do_jmp <= '1';
			when "1001" => do_jn  <= '1';
			when "1010" => do_jz  <= '1';
			when "1111" => do_hlt <= '1';
			when others => do_hlt <= '0';
		end case;
	end process;
end Behavioral;

