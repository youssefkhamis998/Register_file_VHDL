
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_file is
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
end entity register_file;

architecture structural of register_file is

    -- --------------------------------------------------------
    -- COMPONENT: mux32to1
    -- --------------------------------------------------------
    component mux32to1 is
        port (
            D0,  D1,  D2,  D3  : in  STD_LOGIC_VECTOR(31 downto 0);
            D4,  D5,  D6,  D7  : in  STD_LOGIC_VECTOR(31 downto 0);
            D8,  D9,  D10, D11 : in  STD_LOGIC_VECTOR(31 downto 0);
            D12, D13, D14, D15 : in  STD_LOGIC_VECTOR(31 downto 0);
            D16, D17, D18, D19 : in  STD_LOGIC_VECTOR(31 downto 0);
            D20, D21, D22, D23 : in  STD_LOGIC_VECTOR(31 downto 0);
            D24, D25, D26, D27 : in  STD_LOGIC_VECTOR(31 downto 0);
            D28, D29, D30, D31 : in  STD_LOGIC_VECTOR(31 downto 0);
            SEL : in  STD_LOGIC_VECTOR(4 downto 0);
            Y   : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    -- --------------------------------------------------------
    -- COMPONENT: Decoder
    -- --------------------------------------------------------
    component decoder5to32 is
        port (
            A : in  STD_LOGIC_VECTOR(4 downto 0);
            Y : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    -- --------------------------------------------------------
    -- COMPONENT: and_gate
    -- --------------------------------------------------------
    component and_gate is
        port (
            A : in  STD_LOGIC;
            B : in  STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    -- --------------------------------------------------------
    -- INTERNAL SIGNALS
    -- --------------------------------------------------------
    type reg_array is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
    signal REGS : reg_array := (others => (others => 'X'));
    signal DEC_OUT : STD_LOGIC_VECTOR(31 downto 0);
    signal REG_WE  : STD_LOGIC_VECTOR(31 downto 0);

begin

    -- --------------------------------------------------------
    -- DECODER
    -- --------------------------------------------------------
    U_DECODER : decoder5to32
        port map (
            A => Register_Number,
            Y => DEC_OUT
        );

    -- --------------------------------------------------------
    -- AND GATES : 32 instances
    -- REG_WE(i) = DEC_OUT(i) AND Write
    -- --------------------------------------------------------
    GEN_AND : for i in 0 to 31 generate
        U_AND : and_gate
            port map (
                A => DEC_OUT(i),
                B => Write,
                Y => REG_WE(i)
            );
    end generate GEN_AND;

    -- --------------------------------------------------------
    -- WRITE : latched on FALLING edge of CLK
    -- At falling edge ? Write was 1 during HIGH half
    -- After falling edge ? Write=0, REGS holds new value
    -- --------------------------------------------------------
    WRITE_PROC : process(CLK)
    begin
        if falling_edge(CLK) then
            for i in 0 to 31 loop
                if REG_WE(i) = '1' then
                    REGS(i) <= Register_Data;
                end if;
            end loop;
        end if;
    end process WRITE_PROC;

    -- --------------------------------------------------------
    -- READ : purely combinational, always visible
    -- MUX directly connects REGS to RD1 and RD2
    -- No gating ? shows current REGS value at all times
    -- --------------------------------------------------------
    U_MUX1 : mux32to1
        port map (
            D0  => REGS(0),  D1  => REGS(1),  D2  => REGS(2),  D3  => REGS(3),
            D4  => REGS(4),  D5  => REGS(5),  D6  => REGS(6),  D7  => REGS(7),
            D8  => REGS(8),  D9  => REGS(9),  D10 => REGS(10), D11 => REGS(11),
            D12 => REGS(12), D13 => REGS(13), D14 => REGS(14), D15 => REGS(15),
            D16 => REGS(16), D17 => REGS(17), D18 => REGS(18), D19 => REGS(19),
            D20 => REGS(20), D21 => REGS(21), D22 => REGS(22), D23 => REGS(23),
            D24 => REGS(24), D25 => REGS(25), D26 => REGS(26), D27 => REGS(27),
            D28 => REGS(28), D29 => REGS(29), D30 => REGS(30), D31 => REGS(31),
            SEL => RS1,
            Y   => RD1
        );

    U_MUX2 : mux32to1
        port map (
            D0  => REGS(0),  D1  => REGS(1),  D2  => REGS(2),  D3  => REGS(3),
            D4  => REGS(4),  D5  => REGS(5),  D6  => REGS(6),  D7  => REGS(7),
            D8  => REGS(8),  D9  => REGS(9),  D10 => REGS(10), D11 => REGS(11),
            D12 => REGS(12), D13 => REGS(13), D14 => REGS(14), D15 => REGS(15),
            D16 => REGS(16), D17 => REGS(17), D18 => REGS(18), D19 => REGS(19),
            D20 => REGS(20), D21 => REGS(21), D22 => REGS(22), D23 => REGS(23),
            D24 => REGS(24), D25 => REGS(25), D26 => REGS(26), D27 => REGS(27),
            D28 => REGS(28), D29 => REGS(29), D30 => REGS(30), D31 => REGS(31),
            SEL => RS2,
            Y   => RD2
        );

end architecture structural;
