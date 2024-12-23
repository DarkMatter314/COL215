----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/28/2022 01:07:01 PM
-- Design Name: 
-- Module Name: countersim - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity countersim is
--  Port ( );
end countersim;

architecture Behavioral of countersim is

component Counter
Port (clk: in std_logic;  
  enable : in std_logic;
  reset: in std_logic;
  an0 : out std_logic_vector(3 downto 0) := "0000";
  an1 : out std_logic_vector(3 downto 0) := "0000";
  an2 : out std_logic_vector(3 downto 0) := "0000";
  an3 : out std_logic_vector(3 downto 0) := "0000");
end component;
 
signal a : std_logic := '0';
signal an0 : std_logic_vector(3 downto 0);
signal an1 : std_logic_vector(3 downto 0);
signal an2 : std_logic_vector(3 downto 0);
signal an3 : std_logic_vector(3 downto 0);
signal enablew : std_logic:='0';
signal resetw : std_logic:='0';
begin
a <= not a after 10 ns;
enablew <= '1', '0' after 5000 ns, '1' after 13000 ns;
resetw <= '0', '1' after 10000 ns, '0' after 11000 ns;
UUT : Counter port map(clk=>a, an0=>an0, an1=>an1, an2=>an2, an3=>an3, enable=>enablew, reset=>resetw);

end Behavioral;
