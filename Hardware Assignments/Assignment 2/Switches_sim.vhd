----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/19/2022 03:02:10 PM
-- Design Name: 
-- Module Name: Switches-sim - Behavioral
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

entity Switches_sim is
--  Port ( );
end Switches_sim;

architecture Behavioral of Switches_sim is

component Switches
    Port (clk : in std_logic;
    start : in std_logic;
    pause : in std_logic;
    continue : in std_logic;
    reset : in std_logic;
    enable_watch : out std_logic := '0';
    reset_watch : out std_logic := '0');
end component;

signal start : std_logic;
signal pause : std_logic;
signal continue : std_logic;
signal reset : std_logic;
signal clk : std_logic:='0';
signal enablew  : std_logic:='0';
signal resetw : std_logic:='1';
begin
clk <= not clk after 10 ns;
start <= '1','0' after 1000 ns, '1' after 3000 ns;
pause <= '0', '1' after 1500 ns, '0' after 2300 ns;
continue <= '0', '1' after 2000 ns, '0' after 2400 ns;
reset <= '0', '1' after 2500 ns, '0' after 2800 ns;
UUT : Switches port map (start => start,pause => pause,continue => continue,reset => reset,clk=>clk, enable_watch=>enablew, reset_watch=>resetw);
end Behavioral;
