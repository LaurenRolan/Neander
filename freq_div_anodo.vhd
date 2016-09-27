----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:35:56 09/27/2016 
-- Design Name: 
-- Module Name:    bin_to_sevenseg - Behavioral 
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

entity freq_div_anodo is
    Port ( clk : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
           saida : out  STD_LOGIC);
end freq_div_anodo;

architecture Behavioral of freq_div_anodo is
signal temp: std_logic:='0';
begin

process (clk,reset)
variable counter: integer range 0 to 400000 :=0;
begin  
   if (clk'event and clk = '1') then
      if counter=400000 then
			temp<=not temp;
			counter:=0;
		else
			counter:=counter+1;
		end if;
   end if;
end process;
saida<=temp;	
end Behavioral;

