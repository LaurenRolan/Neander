----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:46:34 09/11/2016 
-- Design Name: 
-- Module Name:    UAL - Behavioral 
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

entity UAL is
    Port ( X : in  STD_LOGIC_VECTOR (7 downto 0);
           Y : in  STD_LOGIC_VECTOR (7 downto 0);
           sel : in  STD_LOGIC_VECTOR (2 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0);
           Z : out  STD_LOGIC;
           N : out  STD_LOGIC);
end UAL;

architecture Behavioral of UAL is
signal temporario: std_logic_vector(7 downto 0);
begin
	process (sel, X, Y)
	begin
		case sel is
			when "000" => 	temporario <= X + Y;
			when "001" => 	temporario <= X and Y;
			when "010" => 	temporario <= X or Y;
			when "011" => 	temporario <= not X;
			when "100" =>	temporario <= Y;
			when others => temporario <= "00000000";
		end case;
		if temporario(7) = '1' then
			N <= '1'; Z <= '0';
		elsif temporario = "00000000" then
			Z <= '1'; N <= '0';
		else Z <= '0'; N <= '0';
		end if;
	end process;
	
	output <= temporario;
end Behavioral;

