----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/07/2022 01:18:04 PM
-- Design Name: 
-- Module Name: Register8_1 - Behavioral
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

entity Register8_1 is
  Port (din : in std_logic_vector(7 downto 0);
  clk : in std_logic;
  we : in std_logic;
  re : in std_logic;
  dout : out std_logic_vector(7 downto 0) );
end Register8_1;

architecture Behavioral of Register8_1 is

signal store : std_logic_vector(7 downto 0):="00000000";

begin
process(clk)
begin
if(rising_edge(clk)) then
    if(re = '1') then
        dout <= store;
    elsif(we = '1') then
        store <= din;
    end if;
end if;
end process;

end Behavioral;
