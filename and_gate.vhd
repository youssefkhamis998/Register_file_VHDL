library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ============================================================
-- ENTITY
-- ============================================================
entity and_gate is
    port (
        A : in  STD_LOGIC;    -- decoder output (one-hot bit)
        B : in  STD_LOGIC;    -- write enable signal (global)
        Y : out STD_LOGIC     -- result: write enable for specific register
    );
end entity and_gate;

-- ============================================================
-- ARCHITECTURE
-- ============================================================
architecture behavioral of and_gate is
begin
    Y <= A AND B;
end architecture behavioral;
