library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

    entity top is
    Port(
    led: inout std_logic_vector (3 downto 0 );
    carry_in: std_logic;
    byte_1: in std_logic_vector ( 3 downto 0);
    byte_2: in std_logic_vector (3 downto 0);
    switches: in std_logic_vector ( 1 downto 0);
    seg: inout std_logic_vector ( 6 downto 0);
    anodes: inout std_logic_vector ( 3 downto 0);
    led_2: inout std_logic_vector ( 3 downto 0);
    clk: in std_logic 
    );
end top;

architecture Structural of top is
    signal display_byte: std_logic_vector (3 downto 0);
    
    Begin
    U0: entity work.bit_compare port map(
        byte_1 => byte_1, byte_2 => byte_2,
        switches => switches,
        display_byte => led_2
    );
    U1: entity work.bit_shift port map(
        byte_1 => byte_1, byte_2 => byte_2,
        switches => switches,
        display_byte => display_byte   
    );
    U2: entity work.bit_rotate port map(
        byte_1 => byte_1, byte_2 => byte_2,
        switches => switches,
        display_byte => led  
    );
    U4: entity work.display_driver port map (
        inputs => display_byte,
        seg => seg,
        switches => switches,
        anodes => anodes
        );
    U5: entity work.FourBitAdder
    port map (
        A      => byte_1,
        switch => switches,
        B      => byte_2,
        clk => clk,
        seg => seg,
        carry_in => carry_in,
        anodes => anodes
    );
    
    end Structural;
