library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- ============================================================
-- ENTITY
-- ============================================================
entity mux32to1 is
    port (
        -- 32 data inputs, each 32-bit wide
        D0,  D1,  D2,  D3  : in  STD_LOGIC_VECTOR(31 downto 0);
        D4,  D5,  D6,  D7  : in  STD_LOGIC_VECTOR(31 downto 0);
        D8,  D9,  D10, D11 : in  STD_LOGIC_VECTOR(31 downto 0);
        D12, D13, D14, D15 : in  STD_LOGIC_VECTOR(31 downto 0);
        D16, D17, D18, D19 : in  STD_LOGIC_VECTOR(31 downto 0);
        D20, D21, D22, D23 : in  STD_LOGIC_VECTOR(31 downto 0);
        D24, D25, D26, D27 : in  STD_LOGIC_VECTOR(31 downto 0);
        D28, D29, D30, D31 : in  STD_LOGIC_VECTOR(31 downto 0);

        SEL : in  STD_LOGIC_VECTOR(4 downto 0);   -- 5-bit select
        Y   : out STD_LOGIC_VECTOR(31 downto 0)   -- 32-bit output
    );
end entity mux32to1;

-- ============================================================
-- ARCHITECTURE
-- ============================================================
architecture behavioral of mux32to1 is
begin
    process(SEL,
            D0,  D1,  D2,  D3,  D4,  D5,  D6,  D7,
            D8,  D9,  D10, D11, D12, D13, D14, D15,
            D16, D17, D18, D19, D20, D21, D22, D23,
            D24, D25, D26, D27, D28, D29, D30, D31)
    begin
        case SEL is
            when "00000" => Y <= D0;
            when "00001" => Y <= D1;
            when "00010" => Y <= D2;
            when "00011" => Y <= D3;
            when "00100" => Y <= D4;
            when "00101" => Y <= D5;
            when "00110" => Y <= D6;
            when "00111" => Y <= D7;
            when "01000" => Y <= D8;
            when "01001" => Y <= D9;
            when "01010" => Y <= D10;
            when "01011" => Y <= D11;
            when "01100" => Y <= D12;
            when "01101" => Y <= D13;
            when "01110" => Y <= D14;
            when "01111" => Y <= D15;
            when "10000" => Y <= D16;
            when "10001" => Y <= D17;
            when "10010" => Y <= D18;
            when "10011" => Y <= D19;
            when "10100" => Y <= D20;
            when "10101" => Y <= D21;
            when "10110" => Y <= D22;
            when "10111" => Y <= D23;
            when "11000" => Y <= D24;
            when "11001" => Y <= D25;
            when "11010" => Y <= D26;
            when "11011" => Y <= D27;
            when "11100" => Y <= D28;
            when "11101" => Y <= D29;
            when "11110" => Y <= D30;
            when "11111" => Y <= D31;
            when others  => Y <= (others => '0');
        end case;
    end process;
end architecture behavioral;
