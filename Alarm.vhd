Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
Library work;
use work.all;

Entity Alarm is
Port(
	hlow, mlow: out std_logic_vector(3 downto 0);
	hhigh,mhigh: out  std_logic_vector(2 downto 0);
	en, hadd, madd: in std_logic
);
End Entity Alarm;
Architecture ArchAlarm of Alarm is
	Component Counter60
		Port(
			h:out std_logic_vector(2 downto 0);
			l:out std_logic_vector(3 downto 0);
			en:in std_logic;
			clk:in std_logic;
			rst:in std_logic
		);
	End Component Counter60;
	Component Counter24
		Port(
			h:out std_logic_vector(2 downto 0);
			l:out std_logic_vector(3 downto 0);
			en:in std_logic;
			clk:in std_logic;
			rst:in std_logic
		);
	End Component Counter24;
	Signal rst :std_logic;
Begin
rst<='0';
CM: Counter60
	Port Map (mhigh, mlow, en, madd, rst);
CH: Counter24
	Port Map (hhigh, hlow, en, hadd, rst);

End Architecture;
