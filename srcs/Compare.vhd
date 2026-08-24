library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bit_compare is
    Port ( byte_1: in std_logic_vector ( 3 downto 0 );
           byte_2: in std_logic_vector ( 3 downto 0);
           switches: in std_logic_vector ( 1 downto 0);
           display_byte: inout STD_LOGIC_VECTOR ( 3 downto 0));
end bit_compare;

architecture Behavioral of bit_compare is
begin
    process(byte_1, byte_2, switches)
    begin
        if (switches = "10") then
            if (byte_1 = byte_2) then
                display_byte <= "0001";
            elsif (byte_1 > byte_2) then
                display_byte <= "0010";
            elsif (byte_1 < byte_2) then
                display_byte <= "0011";
            end if;
        end if;
    end process;
End Behavioral;
