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
use IEEE.std_logic_unsigned.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSMsim is
--  Port ( );
end FSMsim;

architecture Behavioral of FSMsim is

component MAC
Port (reMAC : in std_logic;
weMAC : in std_logic;
din1 : in std_logic_vector(7 downto 0);
din2 : in std_logic_vector(7 downto 0);
clk : in std_logic;
cntrl : in std_logic;
dout : out std_logic_vector(15 downto 0));
end component;
component FSM
  Port (clk : in std_logic;
  data : in std_logic_vector(15 downto 0);
  lookup : in std_logic_vector(15 downto 0);
  seg : out std_logic_vector(6 downto 0);
  an : out std_logic_vector(3 downto 0);
  led : out std_logic_vector(15 downto 0);
  out_vector : out std_logic_vector(6 downto 0);
  addr1 : out std_logic_vector(13 downto 0) := "00000000000000";
  addr2 : out std_logic_vector(13 downto 0) := "00000000000000";
  addrRAM : out std_logic_vector(13 downto 0) := "00000000000000";
  cntrl : out std_logic := '0');
end component;
signal reMAC,weMAC,cntrl:std_logic;
signal clk : std_logic := '0';
signal din1,din2 : std_logic_vector(7 downto 0) := "00000000";
signal dout : std_logic_vector(15 downto 0);
signal out_vector : std_logic_vector(6 downto 0);
signal addr1,addr2,addrRAM : std_logic_vector(13 downto 0);
signal re1,re2 :std_logic;
signal data : std_logic_vector(15 downto 0);
signal lookup : std_logic_vector(15 downto 0);


begin
    a1 : FSM port map (clk => clk, cntrl => cntrl, addr1 => addr1, addr2 => addr2, addrRAM => addrRAM, out_vector => out_vector, data=>data, lookup=>lookup);
    UUT : MAC port map(reMAC => reMAC, weMAC => weMAC,din1 => din1,din2 => din2,clk => clk,cntrl => cntrl,dout => dout);
    reMAC <= out_vector(0);
    weMAC <= out_vector(1);
    re1 <= out_vector(6);
    re2 <= out_vector(5);
    clk <= not clk after 5 ns;
    process(re1,re2)
    begin
        if(re1 = '1') then
            din1 <= std_logic_vector(to_unsigned(to_integer(unsigned(din1) + 1),8));
            din2 <= std_logic_vector(to_unsigned(to_integer(unsigned(din2) + 1),8));
        end if;
    end process;
    
end Behavioral;