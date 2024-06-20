library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity timer3 is
     port(clk : in std_logic;
          start_timer : in std_logic;-- clock enable input
			 timerout    : out std_logic_vector(3 downto 0);
			timer_done: out std_logic); -- intended clock speed
end entity;


architecture behavioral of timer3 is
begin
     process  
          
	variable cnt :	std_logic_vector(3 downto 0):= "0000"; -- counter variable to continiously increments


          begin					 
	     
		wait until ((clk'EVENT) AND (clk = '1'));
	       
		if (start_timer = '0') then -- if start timer is 0, don't increment
	            cnt := "0000"; 
	       else  -- otherwise increment
               cnt := cnt + '1';
	       end if;
   	if(cnt="0011") then
			timer_done<='1';
		else
			timer_done<='0';
		end if;
		timerout <= cnt;
	  end process;
	 
end behavioral;