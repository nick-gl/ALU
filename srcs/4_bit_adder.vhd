----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/11/2026 06:22:21 PM
-- Design Name: 
-- Module Name: 4_bit_adder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity FourBitAdder is
    Port (
        A      : in  STD_LOGIC_VECTOR (3 downto 0);
        B      : in  STD_LOGIC_VECTOR (3 downto 0);
        switch: in std_logic_vector (1 downto 0);
        clk    : in  STD_LOGIC;
        seg    : inout STD_LOGIC_VECTOR (6 downto 0);
        carry_in: in std_logic;
        anodes : inout STD_LOGIC_VECTOR (3 downto 0)
    );
end FourBitAdder;

architecture Behavioral of FourBitAdder is

    signal S    : STD_LOGIC_VECTOR(3 downto 0);
    signal C    : STD_LOGIC_VECTOR(4 downto 0);
    signal SUM  : STD_LOGIC_VECTOR(4 downto 0);

    signal right_digit : STD_LOGIC_VECTOR(3 downto 0);
    signal left_digit  : STD_LOGIC_VECTOR(3 downto 0);

    signal refresh_counter : integer range 0 to 100000 := 0;
    signal active_digit    : STD_LOGIC := '0';

begin
    
    -- Ripple carry adder
    C(0) <= carry_in;

    S(0) <= A(0) xor B(0) xor C(0);
    C(1) <= (A(0) and B(0)) or (A(0) and C(0)) or (B(0) and C(0));

    S(1) <= A(1) xor B(1) xor C(1);
    C(2) <= (A(1) and B(1)) or (A(1) and C(1)) or (B(1) and C(1));

    S(2) <= A(2) xor B(2) xor C(2);
    C(3) <= (A(2) and B(2)) or (A(2) and C(2)) or (B(2) and C(2));

    S(3) <= A(3) xor B(3) xor C(3);
    C(4) <= (A(3) and B(3)) or (A(3) and C(3)) or (B(3) and C(3));

    -- True 5-bit result
    SUM <= C(4) & S;

    -- Split into two display digits
    right_digit <= SUM(3 downto 0);
    left_digit  <= "000" & SUM(4);  -- 0 or 1

    --------------------------------------------------
    -- Refresh counter (multiplexing)
    --------------------------------------------------
    process(clk)
    begin
        if rising_edge(clk) then
            if refresh_counter = 100000 then
                refresh_counter <= 0;
                active_digit <= not active_digit;
            else
                refresh_counter <= refresh_counter + 1;
            end if;
        end if;
    end process;


    process(switch,active_digit, right_digit, left_digit)
    begin
        if (switch = "11") then
        if active_digit = '0' then
            -- RIGHT digit
            anodes <= "1110";

            case right_digit is
                when "0000" => seg <= "1000000";
                when "0001" => seg <= "1111001";
                when "0010" => seg <= "0100100";
                when "0011" => seg <= "0110000";
                when "0100" => seg <= "0011001";
                when "0101" => seg <= "0010010";
                when "0110" => seg <= "0000010";
                when "0111" => seg <= "1111000";
                when "1000" => seg <= "0000000";
                when "1001" => seg <= "0010000";
                when "1010" => seg <= "0001000";
                when "1011" => seg <= "0000011";
                when "1100" => seg <= "1000110";
                when "1101" => seg <= "0100001";
                when "1110" => seg <= "0000110";
                when others => seg <= "0001110";
            end case;

        else
            -- LEFT digit (carry)
            anodes <= "1101";

            if left_digit = "0001" then
                seg <= "1111001"; -- "1"
            else
                seg <= "1000000"; -- "0"
            end if;
        end if;
        else 
            anodes <= "ZZZZ";
            seg <= "ZZZZZZZ";
        end if;
    end process;

end Behavioral;
