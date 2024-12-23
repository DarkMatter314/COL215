----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/17/2022 03:48:16 PM
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity FSM is
  Port (clk : in std_logic;
  data : in std_logic_vector(15 downto 0);
  seg : out std_logic_vector(6 downto 0);
  an : out std_logic_vector(3 downto 0);
  led : out std_logic_vector(15 downto 0);
  out_vector : out std_logic_vector(6 downto 0);
  addr1 : out std_logic_vector(15 downto 0) := "0000000000000000";
  addr2 : out std_logic_vector(15 downto 0) := "0000000000000000";
  addrRAM : out std_logic_vector(13 downto 0) := "00000000000000";
  cntrl : out std_logic := '0';
  outfsm : out std_logic);
  -- out_vector represents re1,re2,we1,we2,weR,weMAC,reMAC 
end FSM;

architecture Behavioral of FSM is

component Display
Port (an0 : in std_logic_vector(3 downto 0);
an1 : in std_logic_vector(3 downto 0);
an2 : in std_logic_vector(3 downto 0);
an3 : in std_logic_vector(3 downto 0);
clk : in std_logic;
seg : out std_logic_vector(6 downto 0);
an : out std_logic_vector(3 downto 0));
end component;

signal temp,fsmcntrl : std_logic := '0';
signal row1,col1,row2,col2 : integer := 0;
type state_type is (STROM,STReg_write,STReg_read,STMAC,STTransit,STRAM,STEND);
signal curr_state : state_type := STROM;
signal next_state : state_type := STROM;
begin
led <= lookup;
dp : Display port map(an0 => data(15 downto 12), an1 => data(11 downto 8), an2 => data(7 downto 4), an3 => data(3 downto 0),clk => clk,seg => seg,an => an);
-- Sequential block
process(clk)
begin
  if(rising_edge(clk)) then
    curr_state <= next_state;
    if(fsmcntrl = '0') then
      if(curr_state = STMAC) then
        if(col1 = 784) then
          row2 <= 0;
          col1 <= 0;
          if(col2 = 64) then
            row1 <= row1 + 1;
            col2 <= 0;
          else
            col2 <= col2 + 1;
            
          end if;
          else
          col1 <= col1 + 1;
          row2 <= row2 + 1;
          end if;
        end if;
      elsif(curr_state = STtransit) then
        fsmcntrl <= '1';
      end if;
    else
      if(curr_state = STMAC) then
        if(col1 = 64) then
          row2 <= 0;
          col1 <= 0;
    
          if(col2 = 9) then
            row1 <= row1 + 1;
            col2 <= 0;
          else
            col2 <= col2 + 1;
            
          end if;
          else
          col1 <= col1 + 1;
          row2 <= row2 + 1;
          end if;
        elsif(curr_state = STTransit) then
          row1 <= 0;
          col1 <= 0;
          row2 <= 0;
          col2 <= 0;
        end if;
    end if;
end process;

-- Combinational block
process(curr_state,row1,row2,col1,col2)
begin
  next_state <= curr_state;
  case curr_state is
    when STROM =>
      next_state <= STReg_write;
      if(fsmcntrl = '0') then
        out_vector <= "0000000";
        addr1 <= std_logic_vector(to_unsigned(col1,10));
        addr2 <= std_logic_vector(to_unsigned(785*(row2) + col2,16));
        cntrl <= '0';
        addrRAM <= std_logic_vector(to_unsigned(row1 + col2,7));
        outfsm <= '0';
      else
        out_vector <= "0000000"; 
        addr1 <= std_logic_vector(to_unsigned(col1,7));
        addr2 <= std_logic_vector(to_unsigned(785*(51024 + row2) + col2, 16));
        cntrl <= '0';
        addrRAM <= std_logic_vector(to_unsigned(row1 + col2,4));
        outfsm <= '1';
      end if;
    when STReg_write =>
      next_state <= STReg_read;
      if(fsmcntrl = '0') then
        out_vector <= "0011000";
        addr1 <= std_logic_vector(to_unsigned(col1,10));
        addr2 <= std_logic_vector(to_unsigned(785*(row2) + col2,16));
        cntrl <= '0';
        addrRAM <= std_logic_vector(to_unsigned(row1 + col2,7));
        outfsm <= '0';
      else
        out_vector <= "0011000";
        addr1 <= std_logic_vector(to_unsigned(col1,7));
        addr2 <= std_logic_vector(to_unsigned(785*(51024 + row2) + col2, 16));
        cntrl <= '0';
        addrRAM <= std_logic_vector(to_unsigned(row1 + col2,4));
        outfsm <= '1';
      end if;
    when STReg_read =>
      next_state <= STMAC;
      if(fsmcntrl = '0') then 
        out_vector <= "1100000";
        addr1 <= std_logic_vector(to_unsigned(col1,10));
        addr2 <= std_logic_vector(to_unsigned(785*(row2) + col2,16));
        cntrl <= '0';
        addrRAM <= std_logic_vector(to_unsigned(row1 + col2,7));
        outfsm <= '0';
      else 
        out_vector <= "1100000";
        addr1 <= std_logic_vector(to_unsigned(col1,7));
        addr2 <= std_logic_vector(to_unsigned(785*(51024 + row2) + col2, 16));
        cntrl <= '0';
        addrRAM <= std_logic_vector(to_unsigned(row1 + col2,4));
        outfsm <= '1';
      end if;
    when STMAC =>
      if(fsmcntrl = '0') then
        addr1 <= "0000000000";
        addr2 <= "0000000000000000";
        outfsm <= '0';
        if ((row2 = 0) and (col1 = 0) and (row1 /= 0 or col1 /= 0 or row2/=0 or col2/=0))then
          next_state <= STEND;
          addrRAM <= std_logic_vector(to_unsigned(row1 + col2,7));
          out_vector <= "1100111";
          cntrl <= '1';
          else
          next_state <= STROM;
          out_vector <= "1100010";
          cntrl <= '0';
          addrRAM <= std_logic_vector(to_unsigned(row1 + col2,7));
        end if;
      else
        addr1 <= "0000000";
        addr2 <= "0000000000000000";
        outfsm <= '1';
        if ((row2 = 0) and (col1 = 0) and (row1 /= 0 or col1 /= 0 or row2/=0 or col2/=0))then
          next_state <= STEND;
          addrRAM <= std_logic_vector(to_unsigned(row1 + col2,4));
          out_vector <= "1100111";
          cntrl <= '1';
        else 
          next_state <= STROM;
          out_vector <= "1100010";
          cntrl <= '0';
          addrRAM <= std_logic_vector(to_unsigned(row1 + col2,4));
        end if;
      end if;
    when STRAM =>
    if(fsmcntrl = '0') then
      outfsm <= '0';
      if(row1 = 2) then
        next_state <= STEND;
        out_vector <= "0000100";
      else
        next_state <= STROM;
        out_vector <= "0000101";
      end if;
      cntrl <= '0';
      addr1 <= "0000000000";
      addr2 <= "0000000000000000";
      if(col2 = 0) then
        addrRAM <= std_logic_vector(to_unsigned((row1-1) + col2+64,7));
      else
        addrRAM <= std_logic_vector(to_unsigned(row1 + col2-1,7));
      end if;
    else 
      outfsm <= '1';
      if(row1 = 2) then
        next_state <= STEND;
        out_vector <= "0000100";
      else
        next_state <= STROM;
        out_vector <= "0000101";
      end if;
      cntrl <= '0';
      addr1 <= "0000000";
      addr2 <= "0000000000000000";
      if(col2 = 0) then
        addrRAM <= std_logic_vector(to_unsigned(row1 + col2,4));
      else
        addrRAM <= std_logic_vector(to_unsigned(row1 + col2,4));
      end if;
    end if;
    when STEND =>
      if(fsmcntrl = '0') then
        outfsm <= '0';
        next_state <= STTransit;
        out_vector <= "0000000";
        addr1 <= "0000000000";
        addr2 <= "0000000000000000";
        cntrl <= '0';
        addrRAM <= "0000000";
      else 
        outfsm <= '1';
        next_state <= STEND;
        out_vector <= "0000000";
        addr1 <= "0000000000";
        addr2 <= "0000000000000000";
        cntrl <= '0';
        addrRAM <= "0000";
      end if;
    when STTransit =>
      outfsm <= '1';
      next_state <= STROM;
      out_vector <= "0000000";
      addr1 <= "0000000000";
      addr2 <= "0000000000000000";
      cntrl <= '0';
      addrRAM <= "0000";
    end case;
end process;
end Behavioral;