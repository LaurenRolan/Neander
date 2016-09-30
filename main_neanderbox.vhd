----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:07:02 09/30/2016 
-- Design Name: 
-- Module Name:    main_neanderbox - Behavioral 
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

entity main_neanderbox is
    Port ( clk : in  STD_LOGIC;
			  reset: in std_logic;		--btn4?
			  matriz : in  STD_LOGIC; -- btn3
           contador : in  STD_LOGIC; -- btn2
           fatorial : in  STD_LOGIC; -- bnt1
           switches : in  STD_LOGIC_VECTOR (3 downto 0); -- sw3 a sw0
			  segmentos : out  STD_LOGIC_VECTOR (6 downto 0);
			  anodos: out STD_LOGIC_VECTOR (3 downto 0)
			  );
end main_neanderbox;

architecture Behavioral of main_neanderbox is
--memoria
signal wea: std_logic_vector(0 downto 0);
signal adressa,dina,douta,doutb: std_logic_vector(7 downto 0);
--neander
signal saida_ac,saida_pc,saida_ri,start: std_logic_vector(7 downto 0);
--segmentos
signal clk_x: std_logic;
signal anodo_temp: std_logic_vector(3 downto 0):="1110";
signal seg3,seg2,seg1,seg0,to_seven: std_logic_vector(3 downto 0);

begin
----display de sete segmentos; atribuir em seg3-0 para exibir
------------------------------------------------------------------------------------
process(clk_x)						--a cada ciclo de clk_x  exibe um numero dos displays
begin
	if(rising_edge(clk_x))then
		case anodo_temp is
			when "1110"=> anodo_temp<="1101"; to_seven<=seg1;
			when "1101"=> anodo_temp<="1011"; to_seven<=seg2;
			when "1011"=> anodo_temp<="0111"; to_seven<=seg3;
			when "0111"=> anodo_temp<="1110"; to_seven<=seg0;
			when others=>anodo_temp<="1110";  to_seven<=seg0;
		end case;
	end if;
end process;

process(clk)						--um ciclo de clk_x eh 100.000 ciclos de clk (funciona?)
variable count: integer range 0 to 50000:=0;
begin
if(rising_edge(clk))then
	if(count=50000)then
		count:=0;
		clk_X<=not clk_x;
	else
		count:=count+1;
	end if;
end if;
end process;
anodos<=anodo_temp;
SETE: entity work.binseven port map (to_seven, segmentos);
------------------------------------------------------------------------------------




memory: entity work.mem3 port map(clk,wea,adressa,dina,douta, clk, "0", "00000000", "00000000", doutb);
neander: entity work.neanderbox port map(reset,clk,douta,start,saida_ac,saida_pc,saida_ri,wea,dina,adressa);




end Behavioral;

