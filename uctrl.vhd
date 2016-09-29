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
           out_decoder : in STD_LOGIC_VECTOR (12 downto 0);
           sinal_NZ : in  STD_LOGIC_vector(1 downto 0);
			  selRDM: out std_logic_vector (1 downto 0);
			  cargaAC: out std_logic;
			  selUAL: out std_logic_vector (2 downto 0);
			  cargaPC: out std_logic;
			  incrementaPC: out std_logic;
			  cargaNZ: out std_logic;
			  selREM: out std_logic_vector (1 downto 0);
			  cargaRI: out std_logic;
			  cargaREM: out std_logic;
			  wea: out std_logic_vector(0 downto 0);
			  cargaRDM: out std_logic
			  );
end uctrl;

architecture Behavioral of uctrl is

type t_state is (fetch1,fetch2,fetch3,REMgetsPC,RDMgetsMEM1,RDMgetsMEM2,ACgetsULAop,
						RDMgetsAC,MEMgetsRDM,PCgetsRDM,REMgetsRDM,didntJMP,hlt1, mul1,mul2, fetch4,fetch5);
signal estado: t_state;
signal saida: std_logic_vector(15 downto 0);

begin

process(clk, reset)
begin
	if(reset='1')then
		estado<=fetch1;
	elsif(rising_edge(clk))then
		case estado is
			when fetch1 => estado<=fetch2;
			when fetch2 => estado<=fetch3;
			when fetch3 => estado<=fetch4;
			when fetch4 => estado<=fetch5;
			when fetch5 => 
				case out_decoder is
					when "0000000000001" =>	estado<=hlt1;
					when "0000000000000" => estado<=hlt1;
					when "0000000000010" =>	estado<=ACgetsULAop;		
					when "0000000000100" =>	estado<=REMgetsPC;		
					when "0000000001000" =>	if sinal_NZ(0)='1' then estado<=REMgetsPC;else estado<=didntJMP;end if;
					when "0000000010000" =>	if sinal_NZ(1)='1' then estado<=REMgetsPC;else estado<=didntJMP;end if;
					when "0000000100000" =>	estado<=REMgetsPC;
					when "0000001000000" =>	estado<=ACgetsULAop;
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
			when ACgetsULAop => if (out_decoder(2)='1')then
											estado<=mul1;
									else 	estado<=fetch1; end if;
			when MEMgetsRDM => estado<=fetch1;
			when RDMgetsAC => estado<=MEMgetsRDM;
			when PCgetsRDM => estado<=fetch1;
			when hlt1 => estado<=hlt1;
			when mul1 => estado<=mul2;
			when mul2 => estado<=fetch1;
			when others =>
		end case;
	end if;
end process;
process(estado,out_decoder)
begin
	case estado is
		when fetch1 =>	saida<=(2=>'1',others=>'0'); --liga cargaREM 																	--
		when fetch2 =>	saida<=(7=>'1',others=>'0'); -- inc PC													--
		when fetch3 =>	saida<=(0=>'1',others=>'0'); --liga cargaRDM	
		when fetch4 => saida<=(3=>'1',others=>'0'); --liga cargaRI																		--
		when REMgetsPC => saida<=(2=>'1',others=>'0'); --liga cargaREM																	--												
		when RDMgetsMEM1 => saida<=(7=>'1',0=>'1',others=>'0'); --liga cargaRDM, e incPC											--
		when RDMgetsMEM2 =>	saida<=(0=>'1',others=>'0'); --liga cargaRDM																--
		when ACgetsULAop => case out_decoder is
										when "0001000000000"=> saida<=(6=>'1',12=>'1',others=>'0'); --liga cargaAC, selUAL<="000"; --x+y
										when "0000000000010"=> saida<=(6=>'1',12=>'1',11=>'1',9=>'1',others=>'0'); --liga cargaAC, selUAL<="101"; --x--
										when "0000010000000"=> saida<=(6=>'1',12=>'1',9=>'1',others=>'0'); --liga cargaAC, selUAL<="001"; --x and y
										when "0000100000000"=> saida<=(6=>'1',12=>'1',10=>'1',others=>'0'); --liga cargaAC, selUAL<="010"; --x or y
										when "0000001000000"=> saida<=(6=>'1',12=>'1',10=>'1',9=>'1',others=>'0'); --liga cargaAC, selUAL<="011"; --not x
										when "0000000000100"=> saida<=(6=>'1',12=>'1',11=>'1',10=>'1',others=>'0'); --liga cargaAC, selUAL<="110"; --x*y
										when others 		  => saida<=(6=>'1',11=>'1',others=>'0'); --selUAL<="100"; --y
									end case;															--
		when RDMgetsAC => saida<=(0=>'1',13=>'1',others=>'0'); --liga cargaRDM, selRDM<=ac(01)									--
		when MEMgetsRDM => saida<=(1=>'1',others=>'0'); --liga wea															--
		when PCgetsRDM => saida<=(8=>'1',others=>'0'); --liga cargaPC																--
		when REMgetsRDM => saida<=(4=>'1',2=>'1',others=>'0'); --selREM<=rdm(01), carga_rem					--
		when didntJMP => saida<=(7=>'1',others=>'0'); --liga incPC																	--
		when mul1 => saida<=(14=>'1',5=>'1',0=>'1',2=>'1',others=>'0'); --selRDM<=altoMUL(10), selREM<=250(10), liga cargaRDM e carga REM			 
		when mul2 => saida<=(1=>'1',others=>'0'); --liga wea
		when others => saida<=(others=>'0');
	end case;
end process;

selRDM<=saida(14 downto 13);
cargaAC<=saida(12);
selUAL<=saida(11 downto 9);
cargaPC<=saida(8);
incrementaPC<=saida(7);
cargaNZ<=saida(6);
selREM<=saida(5 downto 4);
cargaRI<=saida(3);
cargaREM<=saida(2);
wea(0)<=saida(1);
cargaRDM<=saida(0);

end Behavioral;

