----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/07/2022 01:30:34 PM
-- Design Name: 
-- Module Name: MAC - Behavioral
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
use IEEE.std_logic_signed.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MAC is
  Port (reMAC : in std_logic;
        weMAC : in std_logic;
    din1 : in std_logic_vector(15 downto 0);
  din2 : in std_logic_vector(7 downto 0);
  clk : in std_logic;
cntrl : in std_logic;
dout : out std_logic_vector(15 downto 0));
end MAC;

architecture Behavioral of MAC is

signal ac : std_logic_vector(15 downto 0):="0000000000000000";
signal temp : integer;

begin
process(clk)
begin
if(rising_edge(clk)) then
  if(weMAC = '1') then
    if(cntrl = '0') then
        ac <= std_logic_vector(to_signed(to_integer(unsigned(din1))*to_integer(signed(din2)) + to_integer(signed(ac)),16));
    else
        ac<=std_logic_vector(to_unsigned(to_integer(unsigned(din1))*to_integer(signed(din2)),16));
    end if;
  end if;
  if(reMAC = '1') then
    -- ReLU
    temp <= to_integer(signed(ac));
    if(temp >= 0) then
      dout <= "00000"&ac(15 downto 5);
    else
      dout <= "0000000000000000";
    end if;
    -- To shifter or not to shifter
    -- ac <= "00000"&ac(15 downto 5);
  end if;
end if;
end process;
end Behavioral;