
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- ============================================================
-- ENTITY
-- ============================================================
entity decoder5to32 is
    port (
        A : in  STD_LOGIC_VECTOR(4 downto 0);    -- 5-bit input address
        Y : out STD_LOGIC_VECTOR(31 downto 0)    -- 32-bit one-hot output
    );
end entity decoder5to32;

-- ============================================================
-- ARCHITECTURE
-- ============================================================
architecture behavioral of decoder5to32 is
begin
    process(A)
    begin
        Y <= (others => '0');   -- default: all outputs low
        case A is
            when "00000" => Y(0)  <= '1';
            when "00001" => Y(1)  <= '1';
            when "00010" => Y(2)  <= '1';
            when "00011" => Y(3)  <= '1';
            when "00100" => Y(4)  <= '1';
            when "00101" => Y(5)  <= '1';
            when "00110" => Y(6)  <= '1';
            when "00111" => Y(7)  <= '1';
            when "01000" => Y(8)  <= '1';
            when "01001" => Y(9)  <= '1';
            when "01010" => Y(10) <= '1';
            when "01011" => Y(11) <= '1';
            when "01100" => Y(12) <= '1';
            when "01101" => Y(13) <= '1';
            when "01110" => Y(14) <= '1';
            when "01111" => Y(15) <= '1';
            when "10000" => Y(16) <= '1';
            when "10001" => Y(17) <= '1';
            when "10010" => Y(18) <= '1';
            when "10011" => Y(19) <= '1';
            when "10100" => Y(20) <= '1';
            when "10101" => Y(21) <= '1';
            when "10110" => Y(22) <= '1';
            when "10111" => Y(23) <= '1';
            when "11000" => Y(24) <= '1';
            when "11001" => Y(25) <= '1';
            when "11010" => Y(26) <= '1';
            when "11011" => Y(27) <= '1';
            when "11100" => Y(28) <= '1';
            when "11101" => Y(29) <= '1';
            when "11110" => Y(30) <= '1';
            when "11111" => Y(31) <= '1';
            when others  => Y <= (others => '0');
        end case;
    end process;
end architecture behavioral;
