----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/19/2022 02:31:48 PM
-- Design Name: 
-- Module Name: MUX_sim - Behavioral
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

entity MUX_sim is
--  Port ( );
end MUX_sim;

architecture Behavioral of MUX_sim is

component MUX
  Port (an0 : in std_logic_vector(3 downto 0);
  an1 : in std_logic_vector(3 downto 0);
  an2 : in std_logic_vector(3 downto 0);
  an3 : in std_logic_vector(3 downto 0);
  s1 : in std_logic;
  s2 : in std_logic;
  num : out std_logic_vector(3 downto 0);
  an : out std_logic_vector(3 downto 0));
 end component;

signal an0 : std_logic_vector(3 downto 0);
signal an1 : std_logic_vector(3 downto 0);
signal an2 : std_logic_vector(3 downto 0);
signal an3 : std_logic_vector(3 downto 0);
signal s1 : std_logic;
signal s2 : std_logic;
signal num : std_logic_vector(3 downto 0);
signal an : std_logic_vector(3 downto 0);
begin
an0 <= "0000";an1 <= "0000";an2 <= "0000";an3 <= "0000";
s1 <= '0','1' after 10ns,'0' after 20ns,'1' after 30ns;
s2 <= '1','0' after 20ns;
UUT : MUX port map(an0=> an0,an1 => an1,an2=>an2,an3=>an3,s1=>s1,s2=>s2,num => num,an=>an);


end Behavioral;
