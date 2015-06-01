Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

Entity Timer is
Port(
		clk, seth, setm: in std_logic;
		ssig: out std_logic;
		hsigh, msigh: out std_logic_vector(2 downto 0);
		hsigl, msigl: out std_logic_vector(3 downto 0)
);
End Entity;
Architecture ArchTimer of Timer is
	Component Counter60
		Port(
			h:out std_logic_vector(2 downto 0);
			l:out std_logic_vector(3 downto 0);
			co:out std_logic;
			en:in std_logic;
			clk:in std_logic;
			rst:in std_logic
		);
	End Component Counter60;
	Component Counter24
		Port(
			h:out std_logic_vector(2 downto 0);
			l:out std_logic_vector(3 downto 0);
			co:out std_logic;
			en:in std_logic;
			clk:in std_logic;
			rst:in std_logic
		);
	End Component Counter24;
	Signal hclk, mclk, hco, mco, srst, en, gnd: std_logic;
Begin
	en <= '1';
	gnd <= '0';
	Sec:Counter60 
		Port Map(co=> mco, en=>en, clk=>clk, rst=>srst );
	Min:Counter60 
		Port Map(msigh, msigl, hco, en, mclk , gnd);
	Hor:Counter24 
		Port Map(h=>hsigh, l=>hsigl, en=>en, clk=>hclk, rst=>gnd );	
	ssig <= clk;
	hclk<= seth or hco;
	mclk<= setm or mco;
	srst<= seth or setm;
End Architecture;
