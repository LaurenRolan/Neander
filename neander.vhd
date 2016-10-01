----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:41:44 09/30/2016 
-- Design Name: 
-- Module Name:    neander - Behavioral 
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

entity neander is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           acc : out  STD_LOGIC_VECTOR (7 downto 0));
end neander;

architecture Behavioral of neander is
signal out_decoder :STD_LOGIC_VECTOR (12 downto 0);
signal sinal_NZ,selRDM,selREM,entradaNZ :STD_LOGIC_vector(1 downto 0);
signal cargaAC,cargaPC,incrementaPC,cargaNZ,cargaRI,cargaREM,cargaRDM: std_logic;
signal selUAL: std_logic_vector (2 downto 0);
signal wea: std_logic_vector(0 downto 0);
signal saidaUAL,mem250,entrada_rem,entrada_rdm: std_logic_vector(7 downto 0);
signal saida_ac, saida_mem, saida_rdm, saida_ri, saida_rem, saida_pc: STD_LOGIC_VECTOR (7 downto 0) := "00000000"; -- adicionados
begin
AC: entity work.reg8 port map(saidaUAL,cargaAC,clk,reset,saida_ac);
cunit: entity work.uctrl port map(reset,clk,out_decoder,sinal_NZ,selRDM,cargaAC,selUAL,cargaPC,incrementaPC,cargaNZ,selREM,cargaRI,cargaREM,wea,cargaRDM);
memory: entity work.memcont port map(clk,wea,saida_rem,saida_rdm,saida_mem);
PCreg: entity work.PC port map(saida_rdm,cargaPC,incrementaPC,clk,reset,saida_pc);
UAL: entity work.UAL port map(saida_ac,saida_rdm,selUAL,saidaUAL,entradaNZ,mem250);
NZreg: entity work.reg2 port map(entradaNZ,cargaNZ,clk,reset,sinal_NZ);
RIreg: entity work.reg8 port map(saida_rdm,cargaRI,clk,reset,saida_ri);
decoder: entity work.decoder port map(saida_ri,out_decoder);
REMreg: entity work.reg8 port map(entrada_rem,cargaREM,clk,reset,saida_rem);
RDMreg: entity work.reg8 port map(entrada_rdm,cargaRDM,clk,reset,saida_rdm);
MUXrem: entity work.mux31 port map(saida_pc,saida_rdm,"11111010",selREM, entrada_rem);
MUXrdm: entity work.mux31 port map(saida_mem,saida_ac,mem250,selRDM, entrada_rdm);
acc <= saida_ac;
end Behavioral;

