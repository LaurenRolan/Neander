----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:21:18 09/11/2016 
-- Design Name: 
-- Module Name:    PC - Behavioral 
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
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC is
    Port ( carga : in  STD_LOGIC_VECTOR (7 downto 0);
           load : in  STD_LOGIC;
			  inc: in STD_LOGIC;
			  clk : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end PC;

architecture Behavioral of PC is
signal temp: STD_LOGIC_VECTOR(7 downto 0):= (others => '0') ;
begin
	process (clk, load, carga)
	begin
		if load = '1' then
			temp <= carga;
		elsif rising_edge(clk) then
			if inc = '1' then
				temp <= temp + "00000001";
			else
				temp <= temp;
			end if;
		end if;
	end process;
	output <= temp;
end Behavioral;

