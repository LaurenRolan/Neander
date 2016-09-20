----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:09:59 09/17/2016 
-- Design Name: 
-- Module Name:    uctrl - Behavioral 
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
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uctrl is
    Port ( 
			  reset: in std_logic;
			  clk : in  STD_LOGIC;
	   -- Substituindo as 15 mil portas pelo "busão" out_decoder
           out_decoder : in STD_LOGIC_VECTOR (12 downto 0);
           sinal_NZ : in  STD_LOGIC_vector(1 downto 0);
			  cargaAC: out std_logic;
			  selUAL: out std_logic_vector (2 downto 0);
			  cargaPC: out std_logic;
			  incrementaPC: out std_logic;
			  cargaNZ: out std_logic;
			  sel: out std_logic;
			  cargaRI: out std_logic;
			  cargaREM: out std_logic;
			  do_read: out std_logic;
			  do_write: out std_logic;
			  cargaRDM: out std_logic
			  );
end uctrl;

architecture Behavioral of uctrl is

type t_state is (fetch1,fetch2,fetch3,REMgetsPC,RDMgetsMEM1,RDMgetsMEM2,ACgetsULAop,
						RDMgetsAC,MEMgetsRDM,PCgetsRDM,REMgetsRDM,didntJMP,not1,hlt1);
signal estado: t_state;
signal saida: std_logic_vector(12 downto 0);

begin

process(clk, reset)
begin
	if(reset='1')then
		estado<=fetch1;
	elsif(rising_edge(clk))then
		case estado is
			when fetch1 => estado<=fetch2;
			when fetch2 => estado<=fetch3;
			when fetch3 => 
				case out_decoder is
					when "0000000000001" =>	estado<=hlt1;
					when "0000000000010" =>	estado<=inc1;		--oq fazer
					when "0000000000100" =>	estado<=mul1;		--oq fazer
					when "0000000001000" =>	if sinal_NZ(0)='1' then estado<=REMgetsPC;else estado<=didntJMP;end if;
					when "0000000010000" =>	if sinal_NZ(1)='1' then estado<=REMgetsPC;else estado<=didntJMP;end if;
					when "0000000100000" =>	estado<=REMgetsPC;
					when "0000001000000" =>	estado<=not1;
					when "0000010000000" =>	estado<=REMgetsPC;
					when "0000100000000" =>	estado<=REMgetsPC;
					when "0001000000000" =>	estado<=REMgetsPC;
					when "0010000000000" =>	estado<=REMgetsPC;
					when "0100000000000" =>	estado<=REMgetsPC;
					when "1000000000000" =>	estado<=fetch1;				
					when others 	     => estado<=estado;
				end case;
			when didntJMP => estado<=fetch1;
			when REMgetsPC => estado<=RDMgetsMEM1;
			when RDMgetsMEM1 => if(out_decoder(3)='1')or(out_decoder(4)='1')or(out_decoder(5)='1')then
											estado<=PCgetsRDM;
										else estado<=REMgetsRDM; end if;
			when REMgetsRDM=> if (out_decoder(11)='1')then
											estado<=RDMgetsAC;
									else 	estado<=RDMgetsMEM2; end if;
			when RDMgetsMEM2 => estado<=ACgetsULAop;
			when ACgetsULAop => estado<=fetch1;
			when MEMgetsRDM => estado<=fetch1;
			when RDMgetsAC => estado<=MEMgetsRDM;
			when PCgetsRDM => estado<=fetch1;
			when not1 => estado<=fetch1;
			when hlt1 => estado<=estado;
			when others =>
		end case;
	end if;
end process;
process(estado)
begin
--AVISO: feio adiante!
	case estado is
		when fetch1 =>	saida<=(3=>'1',2=>'1',others=>'0'); --liga cargaREM e do_read
		when fetch2 =>	saida<=(7=>'1',0=>'1',others=>'0'); --liga cargaRDM e inc PC
		when fetch3 => saida<=(4=>'1',others=>'0'); --liga cargaRI
		
		when others => cargaAC<='0'; cargaPC<='0'; incrementaPC<='0'; cargaNZ<='0'; 
			       cargaRI<='0'; cargaREM<='0'; do_read<='0'; do_write<='0'; cargaRDM<='0';
	end case;
end process;
	
cargaAC<=saida(12);
selUAL<=saida(11 downto 9);
cargaPC<=saida(8);
incrementaPC<=saida(7);
cargaNZ<=saida(6);
sel<=saida(5);
cargaRI<=saida(4);
cargaREM<=saida(3);
do_read<=saida(2);
do_write<=saida(1);
cargaRDM<=saida(0);

end Behavioral;

