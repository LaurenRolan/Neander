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
           segmentos : out  STD_LOGIC_VECTOR (7 downto 0));
end main;

architecture Behavioral of main is
signal PC, RDM: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal cargaPC, cargaRDM, wrtmem, selmux: STD_LOGIC := '0';
variable conta: STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
begin
	process(clk, rst)
	begin
		cargaPC <= '0';
		cargaRDM <= '0';
		wrtmem <= '0';
		selmux <= '0';
		if rst = '1' then
			PC <= (others => '0');
		elsif rising_edge(clk) then
			if matriz = '1' then
				case conta is
					when "0000" => PC <= "01100100"; -- 100
							cargaPC <= '1'; -- load PC
							selmux <= '0'; --seleciona PC
							-- escreve na memória o valor dos switches
							cargaRDM <= '1';
							RDM <= "0000" & switches;]
							wrtmem <= '1';
							conta <= conta + '1';
					when "1000" => PC <= "00000001"; -- 01 (no 00 tem NOP)
							cargaPC <= '1'; -- load PC
							selmux <= '0'; --seleciona PC
							-- roda programa
							conta <= (others => '0');
					when others => PC <= PC + '1';
							cargaPC <= '1'; -- load PC
							selmux <= '0'; --seleciona PC
							-- escreve na memória o valor dos switches
							cargaRDM <= '1';
							RDM <= "0000" & switches;
							wrtmem <= '1';
							conta <= conta + '1';
				end case;
			elsif contador = '1' then
				-- PC recebe início do programa contador
				PC <= "00011010"; --26
				cargaPC <= '1';-- load PC
				selmux <= '0'; --seleciona PC
				-- roda programa
			elsif fatorial = '1' then
				-- PC recebe endereço da entrada
				PC <= "01100000"; --96
				cargaPC <= '1';
				selmux <= '0'; --seleciona PC
				-- escreve na memória o valor dos switches
				cargaRDM <= '1';
				RDM <= "0000" & switches;
				wrtmem <= '1';
				-- PC recebe início do programa fatorial
				PC <= "00101110"; --46
				cargaPC <= '1'; -- load PC
				selmux <= '0'; --seleciona PC
			end if;
		end if;
	end process;
	-- Conectar todos os componentes
end Behavioral;

