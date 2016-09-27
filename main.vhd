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
           segmentos : out  STD_LOGIC_VECTOR (7 downto 0);
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

-- Sinais do programa principal
signal PC, RDM: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal cargaPC, cargaRDM, do_write, rstFSM: STD_LOGIC := '0';
signal selREM: STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
signal conta: STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal botao: STD_LOGIC_VECTOR(2 downto 0) := (others => '0');

--Sinais para a conexão dos componentes
signal saiUAL, saiAC, saiPC, saiRDM, saiMUX, saiREM, saiMEM: std_logic_vector (7 downto 0) := (others => '0');
signal selUAL: std_logic_vector (2 downto 0) := (others => '0');
signal nz: std_logic_vector(1 downto 0) := (others => '0');
signal cargaAC, cargaNZ, cargaREM, cargaRI, incPC, do_read: std_logic := '0';

begin
	process(clk, rst)
	begin
		if rst = '1' then
			PC <= (others => '0');
			cargaPC <= '0';
			cargaRDM <= '0';
			do_write <= '0';
			selREM <= "00";
		elsif rising_edge(clk) then
			if matriz = '1' then
				botao <= "001";
				conta <= conta + '1';
			elsif contador = '1' then botao <= "010";
			elsif fatorial = '1' then botao <= "100";
			end if;
			
			case botao is
				when "001" => 
					case conta is
					when "0001" => PC <= "01100100"; --100
										cargaPC <= '1'; -- load PC
										selREM <= "00"; --seleciona PC
										-- escreve na memória o valor dos switches
										cargaRDM <= '1';
										RDM <= "0000" & switches;
										do_write <= '1';
										conta <= conta + '1';
					when "1001" => PC <= "00000001";
										cargaPC <= '1'; -- load PC
										selREM <= "00"; --seleciona PC
										-- roda programa
										rstFSM <= '1';
										conta <= (others => '0');
					when others => PC <= PC + '1';
										cargaPC <= '1'; -- load PC
										selREM <= "00"; --seleciona PC
										-- escreve na memória o valor dos switches
										cargaRDM <= '1';
										RDM <= "0000" & switches;
										do_write <= '1';
										conta <= conta + '1';
					end case;
				when "010" => -- PC receb início do programa contador
					PC <= "00011010"; --26
					cargaPC <= '1';-- load PC
					selREM <= "00"; --seleciona PC
					-- roda programa
					rstFSM <= '1';
				when "100" => 
					PC <= "01100000"; --96
					cargaPC <= '1';
					selREM <= "00"; --seleciona PC
					-- escreve na memória o valor dos switches
					cargaRDM <= '1';
					RDM <= "0000" & switches;
					do_write <= '1';
					botao <= "101";
				when "101" =>
					-- PC recebe início do programa fatorial
					PC <= "00101110"; --46
					cargaPC <= '1'; -- load PC
					selREM <= "00"; --seleciona PC
					rstFSM <= '1';
				when others => rstFSM <= '1';
			end case;
		end if;
	end process;
	-- Conectar todos os componentes
	
	--Para fins de debug
	anodos <= "0"&botao;
	segmentos <= PC;
end Behavioral;
