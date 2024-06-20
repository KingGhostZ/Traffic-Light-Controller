library ieee;
use ieee.std_logic_1164.all;

entity fsm is
	port(nsg, nsy, nsr, sng, sny, snr, ewg, ewy, ewr, tlg, tly, tlr, start_timer3, start_timer5, start_timer8 : out std_logic;
		  ews, wes, tls, clk, rst, timer_done3, timer_done5, timer_done8                               : in std_logic);
end entity;

architecture beh of fsm is
 type states is (AllRed, NSGreen, NSYellow, NSRed, TlGreen, TlYellow, TlRed, EWGreen, EWYellow, EWRed);
 signal ns, cs : states;

begin

process(clk, rst)
begin
	if (rst = '1') then
		cs <= AllRed;
	elsif (clk'event and clk = '1') then
		cs <= ns;
	end if;
end process;

process(ews, wes, tls, cs, timer_done3, timer_done5, timer_done8)
begin
	case cs is
		when AllRed =>
			nsg <= '0';
			nsy <= '0';
			nsr <= '1';
			sng <= '0';
			sny <= '0';
			snr <= '1';
			ewg <= '0';
			ewy <= '0';
			ewr <= '1';
			tlg <= '0';
			tly <= '0';
			tlr <= '1';
			ns <= NSGreen;
		when NSGreen =>
			nsg <= '1';
			nsy <= '0';
			nsr <= '0';
			sng <= '1';
			sny <= '0';
			snr <= '0';
			ewg <= '0';
			ewy <= '0';
			ewr <= '1';
			tlg <= '0';
			tly <= '0';
			tlr <= '1';
			if (ews = '1' or wes = '1' or tls = '1') then
				start_timer3 <= '1';
				start_timer5 <= '0';
				start_timer8 <= '0';
				ns <= NSGreen;
				if (timer_done3 = '1') then
					ns <= NSYellow;
				end if;
			else 
				ns <= NSGreen;
			end if;
		when NSYellow =>
			nsg <= '0';
			nsy <= '1';
			nsr <= '0';
			sng <= '0';
			sny <= '1';
			snr <= '0';
			ewg <= '0';
			ewy <= '0';
			ewr <= '1';
			tlg <= '0';
			tly <= '0';
			tlr <= '1';
			ns <= NSRed;
		when NSRed =>
			nsg <= '0';
			nsy <= '0';
			nsr <= '1';
			sng <= '0';
			sny <= '0';
			snr <= '1';
			ewg <= '0';
			ewy <= '0';
			ewr <= '1';
			tlg <= '0';
			tly <= '0';
			tlr <= '1';
			if (tls = '0')  then
				ns <= TlGreen;
			else 
				ns <= EWGreen;
			end if;
		when TlGreen =>
			nsg <= '1';
			nsy <= '0';
			nsr <= '0';
			sng <= '0';
			sny <= '0';
			snr <= '1';
			ewg <= '0';
			ewy <= '0';
			ewr <= '1';
			tlg <= '1';
			tly <= '0';
			tlr <= '0';
			start_timer3 <= '0';
			start_timer5 <= '1';
			start_timer8 <= '0';
			if (timer_done5 = '1') then
				ns <= TlYellow;
			else
			ns <= TlGreen;
			end if;
		when TlYellow =>
			nsg <= '0';
			nsy <= '1';
			nsr <= '0';
			sng <= '0';
			sny <= '0';
			snr <= '1';
			ewg <= '0';
			ewy <= '0';
			ewr <= '1';
			tlg <= '0';
			tly <= '1';
			tlr <= '0';
			ns <= TlRed;
		when TlRed =>
			nsg <= '0';
			nsy <= '0';
			nsr <= '1';
			sng <= '0';
			sny <= '0';
			snr <= '1';
			ewg <= '0';
			ewy <= '0';
			ewr <= '1';
			tlg <= '0';
			tly <= '0';
			tlr <= '1';
			if (ews = '1' or wes = '1') then
				ns <= EWGreen;
			else 
				ns <= NSGreen;
			end if;
		when EWGreen =>
			nsg <= '0';
			nsy <= '0';
			nsr <= '1';
			sng <= '0';
			sny <= '0';
			snr <= '1';
			ewg <= '1';
			ewy <= '0';
			ewr <= '0';
			tlg <= '0';
			tly <= '0';
			tlr <= '1';
			start_timer3 <= '0';
			start_timer5 <= '0';
			start_timer8 <= '1';
			if (timer_done8 = '1') then
				ns <= EWYellow;
			else
			ns <= EWGreen;
			end if;
		when EWYellow =>
			nsg <= '0';
			nsy <= '0';
			nsr <= '1';
			sng <= '0';
			sny <= '0';
			snr <= '1';
			ewg <= '0';
			ewy <= '1';
			ewr <= '0';
			tlg <= '0';
			tly <= '0';
			tlr <= '1';
			ns <= EWRed;
		when EWRed =>
			nsg <= '0';
			nsy <= '0';
			nsr <= '1';
			sng <= '0';
			sny <= '0';
			snr <= '1';
			ewg <= '0';
			ewy <= '0';
			ewr <= '1';
			tlg <= '0';
			tly <= '0';
			tlr <= '1';
			ns <= NSGreen;
	end case;
end process;
end beh;