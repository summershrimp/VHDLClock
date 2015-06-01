Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
Library work;
use work.all;

Entity VHDLClock is
Port(
	clk, ch, seth, setm:in std_logic;
	houth, mouth:out std_logic_vector(2 downto 0);
	houtl, moutl:out std_logic_vector(3 downto 0);
	sout, bout, cstat:out std_logic
);
End Entity VHDLClock;

Architecture ArchVHDLClock of VHDLClock is 
	Component c42to1
	Port(
		A,B:in std_logic_vector(3 downto 0);
		O: out std_logic_vector(3 downto 0);
		en, ch: in std_logic
	);
	End Component;
	Component c32to1
	Port(
		A,B:in std_logic_vector(2 downto 0);
		O: out std_logic_vector(2 downto 0);
		en, ch: in std_logic
	);
	End Component;
	Component Alarm 
	Port(
		hlow, mlow: out std_logic_vector(3 downto 0);
		hhigh,mhigh: out  std_logic_vector(2 downto 0);
		en, hadd, madd: in std_logic
	);
	End Component;
	Component Timer
	Port(
			clk, seth, setm: in std_logic;
			ssig: out std_logic;
			hsigh, msigh: out std_logic_vector(2 downto 0);
			hsigl, msigl: out std_logic_vector(3 downto 0)
	);
	End Component;
	Signal choice, tseth, tsetm, aseth, asetm:std_logic;
	Signal thsigh, tmsigh, ahsigh, amsigh:std_logic_vector(2 downto 0);
	Signal thsigl, tmsigl, ahsigl, amsigl:std_logic_vector(3 downto 0);
	Signal en :std_logic;
Begin
	en <= '1';
	TT: Timer
		Port Map(clk, tseth, tsetm ,sout, thsigh, tmsigh, thsigl, tmsigl);
	AA: Alarm
		Port Map(ahsigl, amsigl, ahsigh, amsigh, en, aseth, asetm);
	Chlow: c42to1 
		Port Map(thsigl, ahsigl, houtl, en, choice);
	Cmlow: c42to1 
		Port Map(tmsigl, amsigl, moutl, en, choice);
	Chhigh: c32to1 
		Port Map(thsigh, ahsigh, houth, en, choice);
	Cmhigh: c32to1 
		Port Map(tmsigh, amsigh, mouth, en, choice);
	Process(clk, thsigh, tmsigh, ahsigh, amsigh, thsigl, tmsigl, ahsigl, amsigl)	
	Variable beepcount:integer range 0 to 31 :=0;
	Variable bstat:std_logic := '0';
	Begin
		If clk'event and clk = '1' Then
			If thsigh = ahsigh And thsigl = ahsigl And tmsigh = amsigh And tmsigl = amsigl And choice = '0'Then
				beepcount := 30;
			End If;
			If beepcount > 0 Then 
				beepcount:= beepcount - 1;
				bstat := not bstat;
			End If;
			If beepcount = 0 and bstat /= '0' Then
				bstat := '0';
			End If;
		End If;
		bout <= bstat;
	End Process;
	Process(clk, ch, seth, setm)
	Begin
		If ch'event and ch='0' Then
			choice <= not choice;
		End If;
		If choice = '1' Then
			aseth <= seth;
			asetm <= setm;
		Else
			tseth <=seth;
			tsetm <=setm;
		End if;
		cstat <= choice;
	End Process;
	
End Architecture;
