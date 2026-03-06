-- ============================================================
-- File     : tb2_register_file.vhd
-- ============================================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb2_register_file is
end entity tb2_register_file;

architecture sim of tb2_register_file is

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

    signal CLK             : STD_LOGIC := '1';
    signal Write           : STD_LOGIC := '0';
    signal Register_Number : STD_LOGIC_VECTOR(4 downto 0)  := (others => '0');
    signal Register_Data   : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal RS1             : STD_LOGIC_VECTOR(4 downto 0)  := (others => '0');
    signal RS2             : STD_LOGIC_VECTOR(4 downto 0)  := (others => '0');
    signal RD1             : STD_LOGIC_VECTOR(31 downto 0);
    signal RD2             : STD_LOGIC_VECTOR(31 downto 0);

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

    STIMULUS : process
    begin

        -- --------------------------------------------------------
        -- TC1: Read from unwritten registers (Write=0)
        --      RS1=R5, RS2=R10 were never written
        --      Expected: RD1=X, RD2=X  (don't care, not 0)
        -- --------------------------------------------------------
        Write           <= '0';
        Register_Number <= "00101";
        Register_Data   <= x"00000000";
        RS1             <= "00101";
        RS2             <= "01010";
        wait for CLK_PERIOD;

        -- --------------------------------------------------------
        -- TC2: RegWrite=0 - write should be ignored
        --      Attempt to write 0xBADC0DED into R2 with Write=0
        --      Expected: RD1=X (R2 unchanged, still unwritten)
        -- --------------------------------------------------------
        Write           <= '0';
        Register_Number <= "00010";
        Register_Data   <= x"BADC0DED";
        RS1             <= "00010";
        RS2             <= "00010";
        wait for CLK_PERIOD;

        -- --------------------------------------------------------
        -- TC3: Normal write then read (Write=1)
        --      Write 0xAAAAAAAA to R3
        --      Expected: RD1=AAAAAAAA, RD2=AAAAAAAA
        -- --------------------------------------------------------
        Write           <= '1';
        Register_Number <= "00011";
        Register_Data   <= x"AAAAAAAA";
        RS1             <= "00011";
        RS2             <= "00011";
        wait for CLK_PERIOD;

        -- --------------------------------------------------------
        -- TC4: Write and read the SAME register in the same cycle
        --      Write 0x12345678 to R7, RS1 also points to R7
        --      RS2 reads R3 to verify it still holds old value
        --      Expected: RD1=12345678, RD2=AAAAAAAA
        -- --------------------------------------------------------
        Write           <= '1';
        Register_Number <= "00111";
        Register_Data   <= x"12345678";
        RS1             <= "00111";
        RS2             <= "00011";
        wait for CLK_PERIOD;

        -- --------------------------------------------------------
        -- TC5: Write 0xDEADBEEF to R15
        --      RS2 reads R7 to verify previous write persists
        --      Expected: RD1=DEADBEEF, RD2=12345678
        -- --------------------------------------------------------
        Write           <= '1';
        Register_Number <= "01111";
        Register_Data   <= x"DEADBEEF";
        RS1             <= "01111";
        RS2             <= "00111";
        wait for CLK_PERIOD;

        -- --------------------------------------------------------
        -- TC6: Overwrite R3 (was 0xAAAAAAAA) with 0x55555555
        --      RS2 reads R5 which is still unwritten -> X
        --      Expected: RD1=55555555, RD2=X
        -- --------------------------------------------------------
        Write           <= '1';
        Register_Number <= "00011";
        Register_Data   <= x"55555555";
        RS1             <= "00011";
        RS2             <= "00101";
        wait for CLK_PERIOD;

        -- --------------------------------------------------------
        -- TC7: Write boundary register R0
        --      RS2 reads R15 to verify it persists
        --      Expected: RD1=00FF00FF, RD2=DEADBEEF
        -- --------------------------------------------------------
        Write           <= '1';
        Register_Number <= "00000";
        Register_Data   <= x"00FF00FF";
        RS1             <= "00000";
        RS2             <= "01111";
        wait for CLK_PERIOD;

        -- --------------------------------------------------------
        -- TC8: Write boundary register R31
        --      RS1 reads R31, RS2 reads R0
        --      Expected: RD1=CAFEBABE, RD2=00FF00FF
        -- --------------------------------------------------------
        Write           <= '1';
        Register_Number <= "11111";
        Register_Data   <= x"CAFEBABE";
        RS1             <= "11111";
        RS2             <= "00000";
        wait for CLK_PERIOD;

        -- --------------------------------------------------------
        -- TC9: Write=1 then Write=0 - no spurious overwrite
        --      Try writing 0x00000000 to R31 with Write=0
        --      Expected: RD1=CAFEBABE (unchanged), RD2=CAFEBABE
        -- --------------------------------------------------------
        Write           <= '0';
        Register_Number <= "11111";
        Register_Data   <= x"00000000";
        RS1             <= "11111";
        RS2             <= "11111";
        wait for CLK_PERIOD;

        -- --------------------------------------------------------
        -- TC10: Write R16, read two different registers simultaneously
        --       RS1=R16 (just written), RS2=R3 (previously overwritten)
        --       Expected: RD1=BEEFCAFE, RD2=55555555
        -- --------------------------------------------------------
        Write           <= '1';
        Register_Number <= "10000";
        Register_Data   <= x"BEEFCAFE";
        RS1             <= "10000";
        RS2             <= "00011";
        wait for CLK_PERIOD;

        wait;
    end process STIMULUS;

end architecture sim;
