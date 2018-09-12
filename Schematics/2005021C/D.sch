EESchema Schematic File Version 4
LIBS:module-cache
EELAYER 26 0
EELAYER END
$Descr E 44000 34000
encoding utf-8
Sheet 26 63
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text Notes 38425 31900 0    225  ~ 45
SCHEMATIC & FLOW DIAGRAM
Text Notes 40875 33100 0    250  ~ 50
2005021
Text Notes 38250 33100 0    250  ~ 50
80230
Text Notes 39400 32325 0    180  ~ 36
INTERFACE A25 - 26
Text Notes 38900 33425 0    140  ~ 28
____
Wire Notes Line width 6 style solid
	43500 1300 36461 1300
Wire Notes Line width 6 style solid
	43500 1600 36461 1600
Wire Notes Line width 6 style solid
	43500 1900 36460 1900
Wire Notes Line width 6 style solid
	36461 1900 36461 975 
Wire Notes Line width 6 style solid
	36839 1900 36839 975 
Wire Notes Line width 6 style solid
	37350 1899 37350 974 
Wire Notes Line width 6 style solid
	40831 1899 40831 974 
Wire Notes Line width 6 style solid
	41331 1899 41331 974 
Wire Notes Line width 6 style solid
	41831 1899 41831 974 
Wire Notes Line width 6 style solid
	42480 1899 42480 974 
Text Notes 36575 1250 0    160  ~ 32
A      REVISED PER TDRR 21853
Text Notes 36550 1575 0    160  ~ 32
B      REVISED PER TDRR 25017
Text Notes 36550 1875 0    160  ~ 32
C      REVISED PER TDRR ?????
Text Notes 42400 33450 0    140  ~ 28
3     6
Wire Notes Line style solid
	550  2050 25200 2050
Wire Notes Line style solid
	25200 2050 25200 13350
Wire Notes Line style solid
	550  8875 25200 8875
Wire Notes Line style solid
	17200 2050 17200 8850
Wire Notes Line
	17200 8850 17225 8850
Wire Notes Line
	17225 8850 17225 8875
Wire Notes Line style solid
	20325 8875 20325 13350
Wire Notes Line style solid
	12425 8875 12425 13350
Wire Notes Line style solid
	550  13350 25200 13350
Text Notes 20425 2700 0    200  ~ 40
D CIRCUIT
$Comp
L AGC_DSKY:Resistor R2601
U 1 1 5CD537B3
P 20225 3875
AR Path="/5B991DE9/5CD537B3" Ref="R2601"  Part="1" 
AR Path="/5B991C14/5CD537B3" Ref="R2001"  Part="1" 
AR Path="/5B991C27/5CD537B3" Ref="R2101"  Part="1" 
AR Path="/5B991C81/5CD537B3" Ref="R2201"  Part="1" 
AR Path="/5B991CDB/5CD537B3" Ref="R2301"  Part="1" 
AR Path="/5B991D35/5CD537B3" Ref="R2401"  Part="1" 
AR Path="/5B991D8F/5CD537B3" Ref="R2501"  Part="1" 
AR Path="/5B991E43/5CD537B3" Ref="R2701"  Part="1" 
AR Path="/5B991E9D/5CD537B3" Ref="R2801"  Part="1" 
AR Path="/5B991EF7/5CD537B3" Ref="R2901"  Part="1" 
F 0 "R2001" H 20200 4325 130 0000 C CNN
F 1 "20K" H 20200 4100 130 0000 C CNN
F 2 "" H 20225 3875 130 0001 C CNN
F 3 "" H 20225 3875 130 0001 C CNN
	1    20225 3875
	1    0    0    -1  
$EndComp
$Comp
L AGC_DSKY:Resistor R2602
U 1 1 5CD53849
P 22425 4675
AR Path="/5B991DE9/5CD53849" Ref="R2602"  Part="1" 
AR Path="/5B991C14/5CD53849" Ref="R2002"  Part="1" 
AR Path="/5B991C27/5CD53849" Ref="R2102"  Part="1" 
AR Path="/5B991C81/5CD53849" Ref="R2202"  Part="1" 
AR Path="/5B991CDB/5CD53849" Ref="R2302"  Part="1" 
AR Path="/5B991D35/5CD53849" Ref="R2402"  Part="1" 
AR Path="/5B991D8F/5CD53849" Ref="R2502"  Part="1" 
AR Path="/5B991E43/5CD53849" Ref="R2702"  Part="1" 
AR Path="/5B991E9D/5CD53849" Ref="R2802"  Part="1" 
AR Path="/5B991EF7/5CD53849" Ref="R2902"  Part="1" 
F 0 "R2002" V 22250 5000 130 0000 C CNN
F 1 "2000" V 22550 5050 130 0000 C CNN
F 2 "" H 22425 4675 130 0001 C CNN
F 3 "" H 22425 4675 130 0001 C CNN
	1    22425 4675
	0    1    1    0   
$EndComp
$Comp
L AGC_DSKY:Capacitor-Polarized C2601
U 1 1 5CD53908
P 21175 4675
AR Path="/5B991DE9/5CD53908" Ref="C2601"  Part="1" 
AR Path="/5B991C14/5CD53908" Ref="C2001"  Part="1" 
AR Path="/5B991C27/5CD53908" Ref="C2101"  Part="1" 
AR Path="/5B991C81/5CD53908" Ref="C2201"  Part="1" 
AR Path="/5B991CDB/5CD53908" Ref="C2301"  Part="1" 
AR Path="/5B991D35/5CD53908" Ref="C2401"  Part="1" 
AR Path="/5B991D8F/5CD53908" Ref="C2501"  Part="1" 
AR Path="/5B991E43/5CD53908" Ref="C2701"  Part="1" 
AR Path="/5B991E9D/5CD53908" Ref="C2801"  Part="1" 
AR Path="/5B991EF7/5CD53908" Ref="C2901"  Part="1" 
F 0 "C2001" H 21575 4850 130 0000 C CNN
F 1 "6.8" H 21575 4575 130 0000 C CNN
F 2 "" H 21175 5075 130 0001 C CNN
F 3 "" H 21175 5075 130 0001 C CNN
	1    21175 4675
	1    0    0    -1  
$EndComp
Text HLabel 23075 5425 2    140  UnSpc ~ 28
G
Text HLabel 23700 3875 2    140  Output ~ 28
F
Text HLabel 19400 3875 0    140  Input ~ 28
E
Wire Wire Line
	19400 3875 19825 3875
Wire Wire Line
	20625 3875 21175 3875
Wire Wire Line
	21175 3875 21175 4400
Connection ~ 21175 3875
Wire Wire Line
	21175 3875 22425 3875
Wire Wire Line
	22425 4275 22425 3875
Connection ~ 22425 3875
Wire Wire Line
	22425 3875 23700 3875
Wire Wire Line
	21175 4900 21175 4925
Wire Wire Line
	21175 5425 22425 5425
Wire Wire Line
	22425 5075 22425 5425
Connection ~ 22425 5425
Wire Wire Line
	22425 5425 23075 5425
Connection ~ 21175 4925
Wire Wire Line
	21175 4925 21175 5425
$EndSCHEMATC
