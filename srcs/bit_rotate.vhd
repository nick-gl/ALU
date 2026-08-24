library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bit_rotate is
    Port ( byte_1: in std_logic_vector ( 3 downto 0 );
           byte_2: in std_logic_vector ( 3 downto 0);
           switches: in std_logic_vector ( 1 downto 0);
           display_byte: inout STD_LOGIC_VECTOR ( 3 downto 0));
end bit_rotate;

architecture Behavioral of bit_rotate is

begin
    process(byte_1,byte_2,switches,display_byte)
    begin
        if (switches = "01") then
        case byte_2 (1 downto 0) is
        when "00" =>
            display_byte <= byte_1 ( 2 downto 0) & byte_1(3);
        when "01" => 
            display_byte <= byte_1 ( 1 downto 0) & byte_1(3) & byte_1(2);
        when "10" => 
            display_byte <= byte_1(0) & byte_1(3) & byte_1(2) & byte_1(1);
        when "11" => 
            display_byte <= byte_1;
        end case;
        elsif ( switches = "00" or switches  = "11" ) then
            display_byte <= "0000";
        end if;
    end process;
end Behavioral;

