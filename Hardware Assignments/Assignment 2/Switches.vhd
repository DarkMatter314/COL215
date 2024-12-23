----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/17/2022 03:48:16 PM
-- Design Name: 
-- Module Name: Switches - Behavioral
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

entity Switches is
  Port (clk : in std_logic;
  start : in std_logic;
  pause : in std_logic;
  continue : in std_logic;
  reset : in std_logic;
  enable_watch : out std_logic := '0';
  reset_watch : out std_logic := '0');
end Switches;



architecture Behavioral of Switches is
signal prev_reset : std_logic := '0';
signal prev_continue : std_logic := '0';
signal prev_pause : std_logic := '0';
signal prev_start : std_logic := '0';
begin
process(clk) begin
if(rising_edge(clk)) then
  if(reset /= prev_reset) then
    if((reset = '1') and (prev_reset = '0')) then
        enable_watch <= '0';
        reset_watch <= '1';
        prev_reset <= '1';
    else
        prev_reset <= '0';
    end if;
  elsif(continue /= prev_continue) then
    if((continue = '1') and (prev_continue = '0')) then
        enable_watch <= '1';
        reset_watch <= '0';
        prev_continue <= '1';
    else
        prev_continue <= '0';
    end if;
  elsif(pause /= prev_pause) then
    if((pause = '1') and (prev_pause = '0')) then
        enable_watch <= '0';
        reset_watch <= '0';
        prev_pause <= '1';
    else
        prev_pause <= '0';
    end if;
  elsif(start /= prev_start) then
    if((start = '1') and (prev_start = '0')) then
        enable_watch <= '1';
        reset_watch <= '0';
        prev_start <= '1';
    else
        prev_start <= '0';
    end if;
  end if;
end if;
end process;
end Behavioral;