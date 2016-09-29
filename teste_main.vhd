--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:46:33 09/27/2016
-- Design Name:   
-- Module Name:   C:/Lauren/Neander/teste_main.vhd
-- Project Name:  Neander
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: main
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY teste_main IS
END teste_main;
 
ARCHITECTURE behavior OF teste_main IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT main
    PORT(
         matriz : IN  std_logic;
         contador : IN  std_logic;
         fatorial : IN  std_logic;
         switches : IN  std_logic_vector(3 downto 0);
         clk : IN  std_logic;
         rst : IN  std_logic;
         segmentos : OUT  std_logic_vector(6 downto 0);
         anodos : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal matriz : std_logic := '0';
   signal contador : std_logic := '0';
   signal fatorial : std_logic := '0';
   signal switches : std_logic_vector(3 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal segmentos : std_logic_vector(6 downto 0);
   signal anodos : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: main PORT MAP (
          matriz => matriz,
          contador => contador,
          fatorial => fatorial,
          switches => switches,
          clk => clk,
          rst => rst,
          segmentos => segmentos,
          anodos => anodos
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		matriz <= '1';		--1 : 11
		switches <= "0101";
		wait for 10 ns;
		matriz <= '0';
		wait for 10 ns;
		matriz <= '1';		--1 : 12
		switches <= "0101";
		wait for 10 ns;
		matriz <= '0';
		wait for 10 ns;
		matriz <= '1';  	--1 : 21
		switches <= "0101";
		wait for 10 ns;
		matriz <= '0';
		wait for 10 ns;
		matriz <= '1';		--1 : 22
		switches <= "0101";
		wait for 10 ns;
		matriz <= '0';
		wait for 10 ns;
		matriz <= '1';		--2 : 11
		switches <= "0011";
		wait for 10 ns;
		matriz <= '0';
		wait for 10 ns;
		matriz <= '1';		--2 : 12
		switches <= "0100";
		wait for 10 ns;
		matriz <= '0';
		wait for 10 ns;
		matriz <= '1';		--2 : 21
		switches <= "0101";
		wait for 10 ns;
		matriz <= '0';
		wait for 10 ns;
		matriz <= '1';		--2 : 22
		switches <= "0110";
		wait for 10 ns;
		matriz <= '0';
		wait for 10 ns;
		matriz <= '1';		-- Inicia
		wait for 10 ns;
		matriz <= '0';
      wait for clk_period*10;
		contador <= '1';	-- Inicia
		wait for 10 ns;
		contador <= '0';
		wait for 100 ns;
		switches <= "0011"; -- 3!
		fatorial <= '1';	-- Inicia
		wait for 10 ns;
		fatorial <= '0';
      -- insert stimulus here 

      wait;
   end process;

END;
