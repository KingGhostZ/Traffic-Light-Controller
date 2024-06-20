library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clockdivider is
    port(
        clk         : in std_logic;
        Clock   : out std_logic
    );
end entity;

architecture behavioral of clockdivider is
    signal cnt : unsigned(25 downto 0) := (others => '0');
    signal Clock_sig : std_logic := '0'; -- Initialize slowClock_sig

begin
    process
    begin
        wait until rising_edge(clk);
        
        cnt <= cnt + 1;

        Clock <= cnt(25);
     
        Clock_sig <= cnt(25);
        
    end process;
end behavioral;