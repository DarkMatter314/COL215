----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2022 02:25:44 AM
-- Design Name: 
-- Module Name: Mainsim - Behavioral
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

entity Mainsim is
--  Port ( );
end Mainsim;

architecture Behavioral of Mainsim is

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
-- out_vector represents re1,re2,we1,we2,weR,weMAC,reMAC 
end component;

component MAC 
  Port (reMAC : in std_logic;
  weMAC : in std_logic;
  din1 : in std_logic_vector(7 downto 0);
  din2 : in std_logic_vector(7 downto 0);
  clk : in std_logic;
cntrl : in std_logic;
dout : out std_logic_vector(15 downto 0));
end component;

component Register8
  Port (din : in std_logic_vector(7 downto 0);
  clk : in std_logic;
  we : in std_logic;
  re : in std_logic;
  dout : out std_logic_vector(7 downto 0) );
end component;

component Register8_1
  Port (din : in std_logic_vector(7 downto 0);
  clk : in std_logic;
  we : in std_logic;
  re : in std_logic;
  dout : out std_logic_vector(7 downto 0) );
end component;

component dist_mem_gen_0
    Port(a : in std_logic_vector(13 downto 0);
    clk : in std_logic;
    spo : out std_logic_vector(7 downto 0));
end component;

component dist_mem_gen_2
    Port(a : in std_logic_vector(13 downto 0);
    clk : in std_logic;
    spo : out std_logic_vector(7 downto 0));
end component;

component dist_mem_gen_1
    Port(a : std_logic_vector(13 downto 0);
    clk : in std_logic;
    d : in std_logic_vector(15 downto 0);
    we : in std_logic;
    spo : out std_logic_vector(15 downto 0));
end component;

signal clk : std_logic:='0';
--component Display
--Port (an0 : in std_logic_vector(3 downto 0);
--an1 : in std_logic_vector(3 downto 0);
--an2 : in std_logic_vector(3 downto 0);
--an3 : in std_logic_vector(3 downto 0);
--clk : in std_logic;
--seg : out std_logic_vector(6 downto 0);
--an : out std_logic_vector(3 downto 0);
--led : out std_logic_vector(15 downto 0));
--end component;

signal out_vector : std_logic_vector(6 downto 0);
--signal re1 : std_logic;
--signal re2 : std_logic;
--signal we1 : std_logic;
--signal we2 : std_logic;
--signal weR : std_logic;
--signal weMAC : std_logic;
--signal reMAC : std_logic;
signal cntrl : std_logic;
signal dout : std_logic_vector(15 downto 0);
signal din1 : std_logic_vector(7 downto 0);
signal din2 : std_logic_vector(7 downto 0);
signal addr1 : std_logic_vector(13 downto 0);
signal addr2 : std_logic_vector(13 downto 0);
signal addrRAM : std_logic_vector(13 downto 0);
signal complete : std_logic;
signal outpt : std_logic_vector(15 downto 0);
signal dtemp1 : std_logic_vector(7 downto 0);
signal dtemp2 : std_logic_vector(7 downto 0);
signal data : std_logic_vector(15 downto 0):="0000000000000000";
signal lookup : std_logic_vector(15 downto 0):="0000000000000000";
signal seg : std_logic_vector(6 downto 0):="0000000";
signal an : std_logic_vector(3 downto 0):="0000";
signal led : std_logic_vector(15 downto 0):="0000000000000000";

begin
clk <= not clk after 1 ns;
mainfsm : FSM port map(clk => clk,cntrl => cntrl,out_vector => out_vector,addr1 => addr1,addr2 => addr2, addrRAM => addrRAM,data => outpt,lookup => lookup, seg => seg, an => an, led => led);
mainMAC : MAC port map(reMAC => out_vector(0),weMAC => out_vector(1),din1 => dtemp1,din2 => dtemp2,clk => clk,cntrl => cntrl,dout => dout);
Reg1 : Register8_1 port map(din => din1,clk => clk,we => out_vector(4),re => out_vector(6),dout => dtemp1);
Reg2 : Register8 port map(din => din2,clk => clk,we => out_vector(3),re => out_vector(5),dout => dtemp2);
ROM1 : dist_mem_gen_0 port map(a => addr1, spo => din1, clk=>clk);
ROM2 : dist_mem_gen_2 port map(a => addr2, spo => din2, clk=>clk);
RAM : dist_mem_gen_1 port map(a => addrRAM,d => dout, clk => clk, we => out_vector(2),spo => outpt);
--dp : Display port map(an0 => output(15 downto 12), an1 => output(11 downto 8), an2 => output(7 downto 4), an3 => output(3 downto 0), clk => clk, seg => seg, led => led, an => an);
--re1 <= out_vector(6);
--re2 <= out_vector(5);
--we1 <= out_vector(4);
--we2 <= out_vect3r(3);
--weR <= out_vector(2);
--weMAC <= out_vector(1);
--reMAC <= out_vector(0);
--process(an0,an1,an2,an3)
--begin
--  if(complete = '1') then
--    addrRAM <= an0(1 downto 0) & an1 & an2 & an3;
--    led <= an0 & an1 & an2 & an3;
--  end if;
--end process;
end Behavioral;
