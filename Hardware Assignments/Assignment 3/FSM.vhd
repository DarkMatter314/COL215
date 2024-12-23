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
  lookup : in std_logic_vector(15 downto 0);
  seg : out std_logic_vector(6 downto 0);
  an : out std_logic_vector(3 downto 0);
  led : out std_logic_vector(15 downto 0);
  out_vector : out std_logic_vector(6 downto 0);
  addr1 : out std_logic_vector(15 downto 0) := "0000000000000000";
  addr2 : out std_logic_vector(15 downto 0) := "0000000000000000";
  addrRAM : out std_logic_vector(13 downto 0) := "00000000000000";
  cntrl : out std_logic := '0';
  fsmcntrl : out std_logic := '0';
  bias : out std_logi_vector := '0';
  biasaddr : out std_logic_vector(15 downto 0) := "0000000000000000");
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

signal row1,col1,row2,col2 : integer := 0;
type state_type is (STROM,STReg_write,STReg_read,STMAC,STBias,STRAM,STEND);
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

        if(col1 = 783) then
          row2 <= 0;
          col1 <= 0;
    
          if(col2 = 63) then
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
      end if;
    else
      if(curr_state = STMAC) then


end process;

-- Combinational block
process(curr_state,row1,row2,col1,col2,lookup)
begin
  next_state <= curr_state;

  case curr_state is
    when STROM =>
      next_state <= STReg_write;
      out_vector <= "0000000";
      if(fsmcntrl = '0') then
        addr1 <= std_logic_vector(to_unsigned(col1,16));
        addr2 <= std_logic_vector(to_unsigned(1023 + row2 + 784*col2,16));
      else
        addr1 <= std_logic_vector(to_unsigned(col1,6));
        addr2 <= std_logic_vector(to_unsigned(51200 + row2 + 64*col2, 16));
      end if;
      cntrl <= '0';
      addrRAM <= std_logic_vector(col2,6);
    when STReg_write =>
      next_state <= STReg_read;
      if(fsmcntrl = '0') then
        out_vector <= "0011000";
        addr1 <= std_logic_vector(to_unsigned(col1,16));
        addr2 <= std_logic_vector(to_unsigned(1023 + row2 + 784*col2,16));
      else
        out_vector <= "";
        addr1 <= std_logic_vector(to_unsigned(col1,6));
        addr2 <= std_logic_vector(to_unsigned(51200 + row2 + 64*col2, 16));
      cntrl <= '0';
      addrRAM <= std_logic_vector(to_unsigned(128*row1 + col2,14));
    when STReg_read =>
      next_state <= STMAC;
      out_vector <= "1100000";
      addr1 <= std_logic_vector(to_unsigned(128*row1 + col1,14));
      addr2 <= std_logic_vector(to_unsigned(128*row2 + col2,14));
      cntrl <= '0';
addrRAM <= std_logic_vector(to_unsigned(128*row1 + col2,14));
    when STMAC =>
--      col1 <= col1 + 1;
--      row2 <= row2 + 1;
--      if(col1 = 127) then
--        row2 <= 0;
--        col1 <= 0;
--       else
--        col1 <= col1 + 1;
--        row2 <= row2 + 1;
--        if(col2 = 127) then
--          row1 <= row1 + 1;
--          col2 <= 0;
--        else
--          col2 <= col2 + 1;
--        end if;
--      end if;
            addr1 <= "00000000000000";
      addr2 <= "00000000000000";
      if ((row2 = 0) and (col1 = 0) and (row1 /= 0 or col1 /= 0 or row2/=0 or col2/=0))then
        next_state <= STBias ;
        addrRAM <= std_logic_vector(to_unsigned(128*row1 + col2,14));
        out_vector <= "1100111";
        cntrl <= '1';
      else 
        next_state <= STROM;
        out_vector <= "1100010";
        cntrl <= '0';
        addrRAM <= std_logic_vector(to_unsigned(128*row1 + col2,14));
      end if;

    when STBias =>
      next_state <= STRAM;
      bias <= '1';
      biasaddr <= std_logic_vector(to_unsigned(51840 + col1, 16));
      out_vector <= "1100010";

    when STRAM =>
      bias <= '0';
      if(row1 = 2) then
        if(fsmcntrl = '0') then
          next_state <= STROM;
          out_vector <= "0000101";
          fsmcntrl = '1';
        else
          next_state = STEND;
          out_vector <= "0000100"
        end if;
      else
        next_state <= STROM;
        out_vector <= "0000101";
      end if;
      cntrl <= '0';
      addr1 <= "00000000000000";
      addr2 <= "00000000000000";
      if(col2 = 0) then
        addrRAM <= std_logic_vector(to_unsigned(128*(row1-1) + col2+127,14));
      else
      addrRAM <= std_logic_vector(to_unsigned(128*row1 + col2-1,14));
      end if;
    when STEND =>
      next_state <= STEND;
      out_vector <= "0000000";
      addr1 <= "00000000000000";
      addr2 <= "00000000000000";
      cntrl <= '0';
      addrRAM <= lookup(13 downto 0);
    end case;
end process;
end Behavioral;