Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

Entity Counter24 is 
Port(
		h:out std_logic_vector(2 downto 0);
		l:out std_logic_vector(3 downto 0);
		co:out std_logic;
		en:in std_logic;
		clk:in std_logic;
		rst:in std_logic
	);
End Entity Counter24;
Architecture ArchCounter24 of Counter24 is
Begin
	Process(clk, rst)
	Variable	tlow:std_logic_vector(3 downto 0);
	Variable	thigh:std_logic_vector(2 downto 0);
	Begin
		If rst = '1' then 
			tlow := (Others => '0' );
			thigh := (Others => '0' );
		Elsif clk'event and clk='1' Then
			co<='0';
			If en = '1' Then
				If tlow < 10 Then
					tlow := tlow + 1;
				End If;
				If tlow = 10 Then
					thigh := thigh + 1;
					tlow := (Others => '0' );
				End If;
				If thigh = 2  Then
					if tlow = 4 Then
						thigh := (Others => '0');
						tlow := (Others => '0');
						co<='1';
					End If;
				End If;
				h<=thigh;
				l<=tlow;
			End If;
		End If;
	End Process;
End Architecture;
