-- ============================================================
-- File     : tb_register_file.vhd
-- ============================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_register_file is
end entity tb_register_file;

architecture sim of tb_register_file is

    component register_file is
        port (
            CLK             : in  STD_LOGIC;
            Write           : in  STD_LOGIC;
            Register_Number : in  STD_LOGIC_VECTOR(4 downto 0);
            Register_Data   : in  STD_LOGIC_VECTOR(31 downto 0);
            RS1             : in  STD_LOGIC_VECTOR(4 downto 0);
            RS2             : in  STD_LOGIC_VECTOR(4 downto 0);
            RD1             : out STD_LOGIC_VECTOR(31 downto 0);
            RD2             : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    constant HALF_PERIOD : time := 10 ns;
    constant CLK_PERIOD  : time := 20 ns;

    signal CLK            : STD_LOGIC := '1';
    signal Write          : STD_LOGIC := '0';
    signal Register_Number: STD_LOGIC_VECTOR(4 downto 0)  := (others => '0');
    signal Register_Data  : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal RS1            : STD_LOGIC_VECTOR(4 downto 0)  := (others => '0');
    signal RS2            : STD_LOGIC_VECTOR(4 downto 0)  := (others => '0');
    signal RD1            : STD_LOGIC_VECTOR(31 downto 0);
    signal RD2            : STD_LOGIC_VECTOR(31 downto 0);

begin

    DUT : register_file
        port map (
            CLK             => CLK,
            Write           => Write,
            Register_Number => Register_Number,
            Register_Data   => Register_Data,
            RS1             => RS1,
            RS2             => RS2,
            RD1             => RD1,
            RD2             => RD2
        );

    CLK_PROC : process
    begin
        CLK <= '1'; wait for HALF_PERIOD;
        CLK <= '0'; wait for HALF_PERIOD;
    end process CLK_PROC;

    Write <= CLK;

    STIMULUS : process
    begin
       
        Register_Number <= "00011";
        Register_Data   <= x"AAAAAAAA";
        RS1             <= "00011";
        RS2             <= "00011";
        wait for CLK_PERIOD;

        
        Register_Number <= "00111";
        Register_Data   <= x"12345678";
        RS1             <= "00111";
        RS2             <= "00011";
        wait for CLK_PERIOD;

       
        Register_Number <= "01111";
        Register_Data   <= x"DEADBEEF";
        RS1             <= "01111";
        RS2             <= "00111";
        wait for CLK_PERIOD;

        
        Register_Number <= "00000";
        Register_Data   <= x"00FF00FF";
        RS1             <= "00000";
        RS2             <= "01111";
        wait for CLK_PERIOD;

        
        Register_Number <= "11111";
        Register_Data   <= x"CAFEBABE";
        RS1             <= "11111";
        RS2             <= "00000";
        wait for CLK_PERIOD;

        
        Register_Number <= "10000";
        Register_Data   <= x"BEEFCAFE";
        RS1             <= "10000";
        RS2             <= "11111";
        wait for CLK_PERIOD;

        wait;
    end process STIMULUS;

end architecture sim;
