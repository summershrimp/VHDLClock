Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

Entity c42to1 is
Port(
	A,B:in std_logic_vector(3 downto 0);
	O: out std_logic_vector(3 downto 0);
	en, ch: in std_logic
);
End Entity c42to1;

Architecture Archc42to1 of c42to1 is
Begin
	Process(en,ch,A,B)
	Begin
		If en = '1' Then
			If ch = '1' Then
				O <= B;
			Else
				O <= A;
			End If;
		End If;
	End Process;
End;