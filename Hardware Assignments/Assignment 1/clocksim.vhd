----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/19/2022 03:02:10 PM
-- Design Name: 
-- Module Name: clocksim - Behavioral
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

entity clocksim is
--  Port ( );
end clocksim;

architecture Behavioral of clocksim is

component Clock
  Port (s1 : out std_logic;
  s2 : out std_logic;
  clk : in std_logic);
end component;
signal s1 : std_logic;
signal s2 : std_logic;
signal clk : std_logic := '0';
--signal count : integer := 0;
begin
--process begin
--lp : for k in 0 to 10000000 loop
--    if(count = 10) then
--        clk <= not clk;
--        count <= 0;
--        count <= count +1;
--     else
--        count <= count + 1;
--      end if;
-- end loop;
-- end process;
clk <= not clk after 10 ns;
UUT : Clock port map (s1 =>s1,s2=>s2,clk=>clk);
end Behavioral;
