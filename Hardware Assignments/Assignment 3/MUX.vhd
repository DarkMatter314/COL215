----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/17/2022 02:29:20 PM
-- Design Name: 
-- Module Name: MUX - Behavioral
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

entity MUX is
  Port (an0 : in std_logic_vector(3 downto 0);
  an1 : in std_logic_vector(3 downto 0);
  an2 : in std_logic_vector(3 downto 0);
  an3 : in std_logic_vector(3 downto 0);
  s1 : in std_logic;
  s2 : in std_logic;
  num : out std_logic_vector(3 downto 0);
  an : out std_logic_vector(3 downto 0));
end MUX;

architecture Behavioral of MUX is
begin
process(s1,s2,an0,an1,an2,an3)
begin
if (s1 = '1') then
    if (s2 = '1') then
        num <= an3;
--        an(0) <= '1';
--        an(1) <= '1';
--        an(2) <= '1';
--        an(3) <= '0';
        an <= "0111";
    else
        num <= an2;
--        an(0) <= '1';
--        an(1) <= '1';
--        an(2) <= '0';
--        an(3) <= '1';
        an <= "1011";
    end if;
else
    if (s2 = '1') then
        num <= an1;
--        an(0) <= '1';
--        an(1) <= '0';
--        an(2) <= '1';
--        an(3) <= '1';
        an <= "1101";
    else
        num <= an0;
--        an(0) <= '0';
--        an(1) <= '1';
--        an(2) <= '1';
--        an(3) <= '1';
        an <= "1110";
    end if;
end if;
end process;

end Behavioral;
