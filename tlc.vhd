library ieee;
use ieee.std_logic_1164.all;

entity tlc is
	port(NSG, NSY, NSR, SNG, SNY, SNR, EWG, EWY, EWR, TLG, TLY, TLR : out std_logic;
		d3, d5, d8 : out std_logic_vector(6 downto 0);
		  EWS, WES, TLS, CLOCK, RESET                                    : in std_logic);
end entity;

architecture beh of tlc is
signal CLK, t3, t3done, t5, t5done, t8, t8done : std_logic;
signal BCD3, BCD5, BCD8 : std_logic_vector(3 downto 0);

component clockdivider is
    port(
        clk         : in std_logic;
        Clock   : out std_logic
    );
end component;

component timer3 is
     port(clk : in std_logic;
          start_timer : in std_logic;-- clock enable input
			 timerout    : out std_logic_vector(3 downto 0);
			timer_done: out std_logic); -- intended clock speed
end component;

component timer5 is
     port(clk : in std_logic;
          start_timer : in std_logic;-- clock enable input
			 timerout    : out std_logic_vector(3 downto 0);
			timer_done: out std_logic); -- intended clock speed
end component;

component timer8 is
     port(clk : in std_logic;
          start_timer : in std_logic;-- clock enable input
			 timerout    : out std_logic_vector(3 downto 0);
			timer_done: out std_logic); -- intended clock speed
end component;

component fsm is
	port(nsg, nsy, nsr, sng, sny, snr, ewg, ewy, ewr, tlg, tly, tlr, start_timer3, start_timer5, start_timer8 : out std_logic;
		  ews, wes, tls, clk, rst, timer_done3, timer_done5, timer_done8                               : in std_logic);
end component;

component sevensegmentdisplay is
    Port ( BCD : in  std_logic_vector(3 downto 0);
           SEG : out std_logic_vector(6 downto 0));
end component;

begin

	timing : clockdivider port map(
	clk => CLOCK,
	Clock => CLK);
	
	t3time : timer3 port map(
	clk => CLK,
	start_timer => t3,
	timerout => BCD3,
	timer_done => t3done);
	
	t5time : timer5 port map(
	clk => CLK,
	start_timer => t5,
	timerout => BCD5,
	timer_done => t5done);
	
	t8time : timer8 port map(
	clk => CLK,
	start_timer => t8,
	timerout => BCD8,
	timer_done => t8done);
	
	brain : fsm port map(
	nsg => NSG, 
	nsy => NSY, 
	nsr => NSR, 
	sng => SNG, 
	sny => SNY, 
	snr => SNR, 
	ewg => EWG, 
	ewy => EWY, 
	ewr => EWR, 
	tlg => TLG, 
	tly => TLY, 
	tlr => TLR, 
	start_timer3 => t3, 
	start_timer5 => t5, 
	start_timer8 => t8,
	ews => EWS, 
	wes => WES, 
	tls => TLS, 
	clk => CLK, 
	rst => RESET, 
	timer_done3 => t3done, 
	timer_done5 => t5done, 
	timer_done8 => t8done);
	
	display1 : sevensegmentdisplay port map(
	BCD => BCD3, 
	SEG => d3);
	
	display2 : sevensegmentdisplay port map(
	BCD => BCD5, 
	SEG => d5);
	
	display3 : sevensegmentdisplay port map(
	BCD => BCD8, 
	SEG => d8);
	
end beh;