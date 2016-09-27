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
           saida : out  STD_LOGIC_VECTOR (7 downto 0);
           NZ : out  STD_LOGIC_VECTOR (1 downto 0);
           mem : out STD_LOGIC_VECTOR (7 downto 0));
end UAL;

architecture Behavioral of UAL is
signal temporario: std_logic_vector(15 downto 0);
signal baixo: std_logic_vector(7 downto 0);
signal N, Z : std_logic;
begin
	process (sel, X, Y)
	begin
		case sel is
			when "000" => 	baixo <= X + Y; temporario <= "00000000" & baixo; -- ADD
			when "001" => 	temporario <= "00000000" & (X and Y); -- AND
			when "010" => 	temporario <= "00000000" & (X or Y); -- OR
			when "011" => 	temporario <= "00000000" & (not X); -- NOT X
			when "100" =>	temporario <= "00000000" & Y; -- Y
			when "101" =>   temporario <= ("00000000" & X) - '1'; -- DEC AC
			when "110" =>   temporario <= X * Y; -- MULT
			when others => temporario <= "0000000000000000";
		end case;
		if temporario(7) = '1' then
			N <= '1'; Z <= '0';
		elsif temporario = "0000000000000000" then
			Z <= '1'; N <= '0';
		else Z <= '0'; N <= '0';
		end if;
	end process;
	NZ(1) <= N;
	NZ(0) <= Z;
	saida <= temporario(7 downto 0);
	mem <= temporario(15 downto 8);
end Behavioral;

