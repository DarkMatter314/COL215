----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/17/2022 03:48:16 PM
-- Design Name: 
-- Module Name: Display - Behavioral
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

entity Display is
  Port (an0 : in std_logic_vector(3 downto 0);
  an1 : in std_logic_vector(3 downto 0);
  an2 : in std_logic_vector(3 downto 0);
  an3 : in std_logic_vector(3 downto 0);
  clk : in std_logic;
  seg : out std_logic_vector(6 downto 0);
  an : out std_logic_vector(3 downto 0));
end Display;



architecture Behavioral of Display is
component Clock
    Port (s1 : out std_logic;
  s2 : out std_logic;
  clk : in std_logic);
end component;

component MUX
   Port (an0 : in std_logic_vector(3 downto 0);
  an1 : in std_logic_vector(3 downto 0);
  an2 : in std_logic_vector(3 downto 0);
  an3 : in std_logic_vector(3 downto 0);
  s1 : in std_logic;
  s2 : in std_logic;
  an : out std_logic_vector(3 downto 0);
  num : out std_logic_vector(3 downto 0));
 end component;
 
 component Decoder
   Port (input : in std_logic_vector(3 downto 0);
  seg : out std_logic_vector(6 downto 0));
end component;
signal s1temp : std_logic;
signal s2temp : std_logic;
signal temp : std_logic_vector(3 downto 0);
signal antemp :std_logic_vector(3 downto 0);
begin
ck : Clock port map(s1 => s1temp,s2 => s2temp, clk => clk);
mx : MUX port map(an0 => an0,an1=>an1,an2=>an2,an3=>an3,s1=>s1temp,s2=>s2temp,num=>temp, an=>antemp);
an <= antemp;
dc : Decoder port map(input => temp,seg => seg);
end Behavioral;