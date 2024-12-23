----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/17/2022 03:26:02 PM
-- Design Name: 
-- Module Name: Clock - Behavioral
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

entity Clock is
  Port (s1 : out std_logic := '0';
  s2 : out std_logic := '0';
  clk : in std_logic);
end Clock;

architecture Behavioral of Clock is
signal count1: integer := 0;
signal count2 : integer := 0;
signal a: std_logic := '0';
signal b: std_logic := '0';
begin
--process (clk)
--begin
--if(rising_edge(clk)) then
--    if(count1 = 1000000000) then
--        a <= not a;
--        count1 <= 1;
--     else
--        count1 <= count1 + 1;
--     end if;
--  end if;
--if(falling_edge(clk)) then
--    if(count1 = 1000000000) then
--        a <= not a;
--        count1 <= 1;
--    else
--        count1 <= count1 +1;
--     end if;
--    if(count2 = 1000000000) then
--        b <= not b;
--        count2 <= 1;
--    else    
--        count2 <= count2 +1;
--    end if;
--  end if;
--end process;
process(clk)
begin
if(rising_edge(clk)) then
    if(count1 <= 250000) then
        s1 <= '1';
        s2 <= '1';
        count1 <= count1 + 1;
    elsif(count1 <= 500000) then
         s1 <= '1';
         s2 <= '0';
        count1 <= count1 + 1;
    elsif(count1 <= 750000) then
        s1 <= '0';
        s2 <= '1';
        count1 <= count1 + 1;
     elsif(count1 <= 1000000) then
        s1 <= '0';
        s2 <= '0';
        count1 <= count1 + 1;
     else
        count1 <= 1;
     end if;
 end if;
 end process;
        
-- s1<=a;
-- s2<=b;
end Behavioral;
