----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:52:48 09/25/2016 
-- Design Name: 
-- Module Name:    main - Behavioral 
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

entity main is
    Port ( matriz : in  STD_LOGIC; -- btn3
           contador : in  STD_LOGIC; -- btn2
           fatorial : in  STD_LOGIC; -- bnt1
           switches : in  STD_LOGIC_VECTOR (3 downto 0); -- sw3 a sw0
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC; -- btn0
           segmentos : out  STD_LOGIC_VECTOR (6 downto 0);
			  anodos: out STD_LOGIC_VECTOR (3 downto 0));
end main;

architecture Behavioral of main is
--COMPONENT memoria
--  PORT (
--    clka : IN STD_LOGIC;
--    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
--    addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
--    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
--    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
--    clkb : IN STD_LOGIC;
--    web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
--    addrb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
--    dinb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
--    doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
--  );
--END COMPONENT;

signal out_decoder :STD_LOGIC_VECTOR (12 downto 0);
signal sinal_NZ,selRDM,selREM,entradaNZ :STD_LOGIC_vector(1 downto 0);
signal cargaAC,cargaPC,incrementaPC,cargaNZ,cargaRI,cargaREM,cargaRDM: std_logic;
signal selUAL: std_logic_vector (2 downto 0);
signal wea: std_logic_vector(0 downto 0);
signal saidaUAL,mem250,entrada_rem,entrada_rdm: std_logic_vector(7 downto 0);
signal saida_ac, saida_mem, saida_rdm, saida_ri, saida_rem, saida_pc: STD_LOGIC_VECTOR (7 downto 0); -- adicionados

--Sinais da main
signal valorPC, valorRDM : STD_LOGIC_vECTOR (7 downto 0);
signal ligaWEA : STD_LOGIC_VECtoR (0 downto 0);
signal reset : STD_LOGIC;
signal conta : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal botao : STD_LOGIC_VECTOR (2 downto 0) := (others => '0');

begin
	process(clk, rst)
	begin
		if rst = '1' then
			valorPC <= (others => '0');
			wea <= "0";
			selREM <= "11"; -- carrega o valorPC direto no REM
		elsif rising_edge(clk) then
			if matriz = '1' then
				botao <= "001";
				conta <= conta + '1';
			elsif contador = '1' then botao <= "010";
			elsif fatorial = '1' then botao <= "100";
			else botao <= "000";
			end if;
			
			case botao is
				when "001" => 
					case conta is
					when "0001" => valorPC <= "01100100"; --100
										selREM <= "11"; --seleciona valorPC
										-- escreve na memória o valor dos switches
										valorRDM <= "0000" & switches;
										selRDM <= "11"; --seleciona valorRDM
										ligaWEA <= "1";
					when "1001" => valorPC <= "00000001";
										selREM <= "11"; --seleciona valorPC
										-- roda programa
										reset <= '1';
										conta <= (others => '0');
										botao <= "000";
					when others => valorPC <= valorPC + '1';
										selREM <= "11"; --seleciona valorPC
										-- escreve na memória o valor dos switches
										valorRDM <= "0000" & switches;
										selRDM <= "11";
										ligaWEA <= "1";
					end case;
				when "010" => -- PC receb início do programa contador
					valorPC <= "00011010"; --26
					selREM <= "11"; --seleciona PC
					-- roda programa
					reset <= '1';
					botao <= "000";
					ligaWEA <= "0";
				when "100" => 
					valorPC <= "01100000"; --96
					selREM <= "11"; --seleciona PC
					-- escreve na memória o valor dos switches
					valorRDM <= "0000" & switches;
					selRDM <= "11";
					cargaRDM <= '1';
					ligaWEA <= "1";
					botao <= "101";
				when "101" =>
					-- PC recebe início do programa fatorial
					valorPC <= "00101110"; --46
					selREM <= "11"; --seleciona PC
					reset <= '1';
					botao <= "000";
				when others => reset <= '1';
			end case;
		end if;
	end process;
	-- Conectar todos os componentes

AC: entity work.reg8 port map(saidaUAL,cargaAC,clk,reset,saida_ac);
cunit: entity work.uctrl port map(reset,clk,out_decoder,sinal_NZ,selRDM,cargaAC,selUAL,cargaPC,incrementaPC,cargaNZ,selREM,cargaRI,cargaREM,wea,cargaRDM);
memory: entity work.memoria port map(clk,wea,saida_rem,saida_rdm,saida_mem);
PCreg: entity work.PC port map(saida_rdm,cargaPC,incrementaPC,clk,reset,saida_pc);
UAL: entity work.UAL port map(saida_ac,saida_mem,selUAL,saidaUAL,entradaNZ,mem250);
NZreg: entity work.reg2 port map(entradaNZ,cargaNZ,clk,reset,sinal_NZ);
RIreg: entity work.reg8 port map(saida_rdm,cargaRI,clk,reset,saida_ri);
decoder: entity work.decoder port map(saida_ri,out_decoder);
REMreg: entity work.reg8 port map(entrada_rem,cargaREM,clk,reset,saida_rem);
RDMreg: entity work.reg8 port map(entrada_rdm,cargaRDM,clk,reset,saida_rdm);
MUXrem: entity work.mux31 port map(saida_pc, saida_rdm, "11111010", valorPC, selREM, entrada_rem);
MUXrdm: entity work.mux31 port map(saida_mem, saida_ac, mem250, valorRDM, selRDM, entrada_rdm);
SETE: entity work.binseven port map (saida_ac(7 downto 4), segmentos); -- adicionado
end Behavioral;
