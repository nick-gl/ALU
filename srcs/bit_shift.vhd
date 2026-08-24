library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bit_shift is
    Port ( byte_1: in std_logic_vector ( 3 downto 0 );
           byte_2: in std_logic_vector ( 3 downto 0);
           switches: in std_logic_vector ( 1 downto 0);
           display_byte: inout STD_LOGIC_VECTOR ( 3 downto 0));
end bit_shift;

architecture Behavioral of bit_shift is
    
begin
    process(byte_1,byte_2,switches,display_byte)
    begin
        if (switches = "00") then
        case byte_2 (1 downto 0) is
        when "00" =>
            display_byte <= (byte_1 ( 2 downto 0) & "0");
        when "01" => 
            display_byte <= (byte_1 ( 1 downto 0) & "00");
        when "10" => 
            display_byte <= (byte_1 ( 0 downto 0) & "000");
        when "11" => 
            display_byte <= "0000";
        end case;
        end if;
    end process;
end Behavioral;

