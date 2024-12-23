----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/21/2022 05:38:45 AM
-- Design Name: 
-- Module Name: Decoder_sim - Behavioral
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

entity Decoder_sim is
--  Port ( );
end Decoder_sim;

architecture Behavioral of Decoder_sim is
component Decoder
  Port (input : in std_logic_vector(3 downto 0);
  seg : out std_logic_vector(6 downto 0));
end component;
signal a : std_logic_vector(3 downto 0) := "1101";
signal seg : std_logic_vector(6 downto 0);
begin
UUT : Decoder port map(input => a,seg => seg);
end Behavioral;
