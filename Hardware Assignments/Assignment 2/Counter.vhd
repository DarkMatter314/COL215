---------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/28/2022 12:21:50 PM
-- Design Name: 
-- Module Name: Counter - Behavioral
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
use IEEE.std_logic_unsigned.ALL;
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter is
  Port (clk: in std_logic;
  enable : in std_logic;
  reset: in std_logic;
  an0 : out std_logic_vector(3 downto 0) := "0000";
  an1 : out std_logic_vector(3 downto 0) := "0000";
  an2 : out std_logic_vector(3 downto 0) := "0000";
  an3 : out std_logic_vector(3 downto 0) := "0000");
end Counter;

architecture Behavioral of Counter is
signal count1: integer := 0;
signal count2: integer := 0;
signal ts : integer := 0;
signal s1 : integer := 0;
signal s2 : integer := 0;
signal m : integer  := 0;
begin
--process(pause, continue) begin
--if(pause = '1') then
--    enable <= '0'; 
--end if;
--if(enable = '0' and continue = '1') then
--    enable <= '1';
--end if;
--end process;

--process(enable) begin
--if(enable = '0' and continue = '1') then
--    enable <= '1';
--end if;
--end process;
process(clk, enable, reset)
begin
if(rising_edge(clk)) then
if(enable = '1') then
    count1 <= count1 + 1;
if(count1 > 100) then
        count2 <= count2 + 1;
        count1 <= 0;
end if;
    an3 <= std_logic_vector(to_unsigned(count2 mod 10, 4));
    an2 <= std_logic_vector(to_unsigned(((count2/10) mod 60) mod 10, 4));
    an1 <= std_logic_vector(to_unsigned(((count2/10) mod 60)/10, 4));
    an0 <= std_logic_vector(to_unsigned(count2/600, 4));
elsif(reset = '1') then
    count1 <= 0;
    count2 <= 0;
    an0 <= "0000";
    an1 <= "0000";
    an2 <= "0000";
    an3 <= "0000";
else
    an3 <= std_logic_vector(to_unsigned(count2 mod 10, 4));
    an2 <= std_logic_vector(to_unsigned(((count2/10) mod 60) mod 10, 4));
    an1 <= std_logic_vector(to_unsigned(((count2/10) mod 60)/10, 4));
    an0 <= std_logic_vector(to_unsigned(count2/600, 4));
end if;
end if;       
end process;
--process(count)
--begin

--end process;     
            
end Behavioral;