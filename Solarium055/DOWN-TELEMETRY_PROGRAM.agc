### FILE="Main.annotation"
## Copyright:	Public domain.
## Filename:	DOWN-TELEMETRY_PROGRAM.agc
## Purpose:	Part of the source code for Solarium build 55. This
##		is for the Command Module's (CM) Apollo Guidance
##		Computer (AGC), for Apollo 6.
## Assembler:	yaYUL --block1
## Contact:	Jim Lawton <jim DOT lawton AT gmail DOT com>
## Website:	www.ibiblio.org/apollo/index.html
## Page Scans:	www.ibiblio.org/apollo/ScansForConversion/Solarium055/
## Mod history:	2009-09-29 JL	Created.
##		2016-08-19 RSB	Typo.

## Page 151

# TELEMETRY PROCESSOR
# --------- ---------
#
#	THE FOLLOWING TELEMETRY PROGRAM IS DESIGNED TO TRANSMIT TELEMETRY DATA VIA OUT4 WHEN AN ENDPULSE 
# FROM THE NORTH AMERICAN TELEMETRY PROGRAMMER TRIGGERS INTERRUPT 6, WHICH INITIATES THIS ROUTINE. IT OPERATES
# IN CONJUNCTION WITH (BUT ASYNCHRONOUSLY FROM) THE T4RUPT PROGRAM, WHICH IS INITIATED EVERY 60 MS, VIA INTERRUPT
# 3. 


		BANK	1
DOWNRUPT	CCS	TELCOUNT	# PNZ IS NORMAL SETTING - +0 INDICATES
		TC	DOWNTMOK	# TM FAILURE SINCE ENDPULSE ARE OCCURING
		TC	TMFAIL		# TOO FREQUENTLY. THE COUNTER IS SET TO +7
		
		CS	BIT10		# BLOCK TM ENDPULSES UNTIL  ERROR RESET
		MASK	OUT1		# COMMAND IS GIVEN.
		AD	BIT10
		TS	OUT1
		
		TC	NBRESUME	# BY DSRUPT EVERY 120 MS.
		
DOWNTMOK	TS	TELCOUNT	# NORMAL MODE - STORE DECREMENTED COUNT.
		TC	DNTMGOTO	# JUMP TO APPROPRIATE DOWNLINK PHASE.

# 	IN PHASE 7, SEND REQUIRED NUMBER OF DUMMY MARKS, ENTERING PHASE 1 WHEN FINISHED. ANY REAL MARKERS
# OCCURRING HERE WILL NOT BE SENT UNTIL PHASE 3.

DNPHASE7	CCS	MARKERCT	# REDUCE TO ZERO.
		TC	DUMMARK

# 	PHASE 1 SENDS LIST ID AND SETS UP PHASE 2.

DNPHASE1	CAF	LPHASE2
		TS	DNTMGOTO
		CAF	LTHCOMA		# NUMBER OF WORDS IN COMMON LIST A.
		TS	TMINDEX
		CS	DNLSTADR	# CHANGES IN DNLSTADR NOT HONORED UNTIL
		COM			# THIS PHASE.
		TS	LDATALST
		MASK	LOW11
		AD	60K		# AT FOD'S REQUEST.
		TC	W.O.=1

## Page 152

#	PHASE 2 SENDS COMMON LIST A: DSPTAB, T2, T1, I/O, CDUS, ETC. NO MARKERS ARE INTERSPERSED WITH THE DATA.

DNPHASE2	CCS	TMINDEX		# SEE IF MORE DATA TO BE SENT.
		TC	PHASE2A
		
		CAF	LPHASE3		# IF NOT, BEGIN PHASE 3.
		TS	DNTMGOTO
		CAF	NOMRKRS		# NUMBER OF MARKERS/SECOND.
		TS	MARKERCT
		CAF	LTHLSTA		# NUMBER OF WORDS IN PARTICULAR LISTS A.
		TS	TMINDEX

#	PHASE 3 - SEND DOWN PARTICULAR LIST A WITH REAL MARKERS INTER-LEAVED.

DNPHASE3	CCS	TMMARKER	# SEE IF ANY MARKERS TO BE SENT.
		TC	DOMARKER
		
		CCS	TMINDEX		# SEND DOWN PART. LIST A ENTRY IF ANY.
		TC	PHASE36A	# (COMMON TO PHASES 3 AND 6.)
		
		CAF	LPHASE4		# END OF PHASE 3, START PHASE 4.
		TS	DNTMGOTO

# 	PHASE 4: SEND DUMMY MARKERS UNTIL MARKERCT = 0.

DNPHASE4	CCS	MARKERCT	# (NONE MAY BE REQUIRED)
		TC	DUMMARK
		
		CAF	LPHASE5		# END OF PHASE 4 - BEGIN PHASE 5.
		TS	DNTMGOTO
		CAF	LTHCOMB		# NUMBER OF WORDS IN COMMON LIST B - 1.

#	PHASE 5: SEND COMMON LIST B WITH NO MARKERS INTER-LEAVED.

PHASE5A		TS	TMINDEX		# (ENTERS HERE FIRST TIME ONLY).
		INDEX	A
		INDEX	COMLSTB
		CS	0
		TC	DATADWNF
		
DNPHASE5	CCS	TMINDEX		# NORMAL PHASE 5 ENTRY.
		TC	PHASE5A

## Page 153

#	AT END OF PHASE 5, BEGIN PHASE 6. THE ADDRESS OF PARTICULAR LIST B IMMEDIATELY PROCEEDS
# PARTICULAR LIST A.

		CAF	LPHASE6
		TS	DNTMGOTO
		CAF	LTHLSTB		# NUMBER OF WORDS IN PARTICULAR LISTS B.
		TS	TMINDEX
		CAF	NOMRKRS
		TS	MARKERCT
		
		CAF	LISTBANK	# GET ADDRESS OF PART. LIST B.
		XCH	BANKREG
		XCH	LDATALST
		AD	MINUS1
		INDEX	A
		CS	0		# SO WE CAN RUN IN ERASABLE.
		COM
		XCH	LDATALST
		TS	BANKREG

#	PHASE 6: PARTICULAR LIST B AND REAL MARKERS.

DNPHASE6	CCS	TMMARKER
		TC	DOMARKER
		
		CCS	TMINDEX
		TC	PHASE36A
		
		CAF	LPHASE7		# SWITCH TO PHASE 7 TO SUPPLY REQUIRED
		TS	DNTMGOTO	# NUMBER OF DUMMY MARKS.
		TC	DNPHASE7

## Page 154

#	OUT OF SEQUENCE ROUTINES.

PHASE2A		TS	TMINDEX		# SELECT DATA WORD FOR COMMON LIST A IN
		INDEX	A		# IN FIXED-FIXED.
		INDEX	COMLSTA
		CS	0
DATADWNF	COM			# PHASE 5 (COMMON LIST B) EXITS HERE.
		TS	OUT4
		CS	BIT9
		MASK	OUT1
		TS	OUT1
		TC	NBRESUME	# NO BANK SWITCH REQUIRED.

PHASE36A	TS	TMINDEX		# PHASES 3 AND 6 (PARTICULAR DATA LISTS)
		CAF	LISTBANK	# EXIT HERE
		XCH	BANKREG
		TS	BANKRUPT	# PARTICULAR LISTS IN SWITCHED BANK.
		
		CCS	LDATALST	# (SAVES 2 MCT).
		AD	TMINDEX
		INDEX	A
		INDEX	1		# (1 COMPENSATES FOR ABOVE CCS.)
		CS	0
		COM
		TS	OUT4
		CS	BIT9
		MASK	OUT1
		TS	OUT1
		TC	RESUME

DOMARKER	CCS	MARKERCT	# COME HERE TO SHIP DOWN REAL MARKER.
		TC	+2		# PROTECT AGAINST TOO MANY TMMARKERS
		TC	Q		#   BEING SENT DOWN WITHIN ONE SECOND
DUMMARK		TS	MARKERCT	# REDUCE MARKERCT (NEVER IS ZERO ABOVE).
		CAF	ZERO
		XCH	TMMARKER
		AD	DN74K		# AT FOD'S REQUEST.
W.O.=1		TS	OUT4		# PHASE 1 EXITS HERE.
		CS	BIT9
		MASK	OUT1
		AD	BIT9
		TS	OUT1
		TC	NBRESUME

## Page 155

# CONSTANTS.

LPHASE2		ADRES	DNPHASE2	# ADDRESSES FOR DNTMGOTO.
LPHASE3		ADRES	DNPHASE3
LPHASE4		ADRES	DNPHASE4
LPHASE5		ADRES	DNPHASE5
LPHASE6		ADRES	DNPHASE6
LPHASE7		ADRES	DNPHASE7

LTHCOMA		DEC	26		# LENGTH OF COMMON LIST A.
LTHCOMB		DEC	13		# LENGTH OF COMMON LIST B - 1.
LTHLSTA		DEC	21		# PARTICULAR LIST A.
LTHLSTB		DEC	32		# PARTICULAR LIST B.
DN74K		OCT	74000
NOMRKRS		EQUALS	THREE

LDNLST1		ADRES	501LSTA1
LDNLST2		ADRES	501LSTA2
LISTBANK	CADR	501LSTA1

#	SUBROUTINE COMMON TO UPLINK AND DOWNLINK TO TURN ON THE TM FAIL LIGHT.

TMFAIL		CS	BIT4
		MASK	OUT1
		AD	BIT4
		TS	OUT1
		TC	Q

## Page 156

#	COMMON LISTS A AND B.

COMLSTA		ADRES	CDUZ		# 27
		ADRES	CDUY		# 26
		ADRES	CDUX		# 25
		ADRES	FLAGWRD2	# 24
		ADRES	FLAGWRD1	# 23
		ADRES	STATE		# 22
		ADRES	OUT1		# 21
		ADRES	IN3		# 20
		ADRES	IN2		# 19
		ADRES	IN0		# 18
		ADRES	TIME1		# 17
		ADRES	TIME2		# 16

COMLSTB		ADRES	DSPTAB +13D	# 15/65
		ADRES	DSPTAB +12D	# 14/64
		ADRES	DSPTAB +11D	# 13/63
		ADRES	DSPTAB +10D	# 12/62
		ADRES	DSPTAB +9D	# 11/61
		ADRES	DSPTAB +8D	# 10/60
		ADRES	DSPTAB +7	# 9/59
		ADRES	DSPTAB +6	# 8/58
		ADRES	DSPTAB +5	# 7/57
		ADRES	DSPTAB +4	# 6/56
		ADRES	DSPTAB +3	# 5/55
		ADRES	DSPTAB +2	# 4/54
		ADRES	DSPTAB +1	# 3/53
		ADRES	DSPTAB		# 2/52

## Page 157

#	PARTICULAR DATA LISTS FOR FLIGHT 501. LIST 1 PROVIDES DATA FOR THE ENTIRE FLIGHT EXCEPT DURING
# STATE VECTOR UPDATES, FOR WHICH LIST 2 IS USED.

		SETLOC	20000
		
		ADRES	501LSTB2
501LSTA2	ADRES	COMPNUMB
		ADRES	UPOLDMD
		ADRES	DNSPARE
		ADRES	DNSPARE
		ADRES	DNSPARE
501LSTB2	ADRES	STBUFF +13D
		ADRES	STBUFF +12D
		ADRES	STBUFF +11D
		ADRES	STBUFF +10D
		ADRES	STBUFF +9D
		ADRES	STBUFF +8D
		ADRES	STBUFF +7
		ADRES	STBUFF +6
		ADRES	STBUFF +5
		ADRES	STBUFF +4
		ADRES	STBUFF +3
		ADRES	STBUFF +2
		ADRES	STBUFF +1
		ADRES	STBUFF
		ADRES	STCNTR
		ADRES	DNSPARE
501LSTB1	ADRES	TAVEGON +1	# COMMON TO LISTS 1 AND 2
		ADRES	TAVEGON
		ADRES	VAVEGON +5
		ADRES	VAVEGON +4
		ADRES	VAVEGON +3
		ADRES	VAVEGON +2
		ADRES	VAVEGON +1
		ADRES	VAVEGON
		ADRES	RAVEGON +5
		ADRES	RAVEGON +4
		ADRES	RAVEGON +3
		ADRES	RAVEGON +2
		ADRES	RAVEGON +1
		ADRES	RAVEGON
		ADRES	TCUTOFF +1	# EVENT TIME
		ADRES	TCUTOFF
		ADRES	TIME1GR
		ADRES	TIME2GR
		
		ADRES	PIPTIME +1
		ADRES	PIPTIME
		ADRES	VN +5
		ADRES	VN +4
## Page 158
		ADRES	VN +3
		ADRES	VN +2
		ADRES	VN +1
		ADRES	VN
		ADRES	RN +5
		ADRES	RN +4
		ADRES	RN +3
		ADRES	RN +2
		ADRES	RN +1
		ADRES	RN
		
		ADRES	501LSTB1
501LSTA1	ADRES	TFF +1
		ADRES	TFF
		ADRES	VRECT +5
		ADRES	VRECT +4
		ADRES	VRECT +3
		ADRES	VRECT +2
		ADRES	VRECT +1
		ADRES	VRECT
		ADRES	RRECT +5
		ADRES	RRECT +4
		ADRES	RRECT +3
		ADRES	RRECT +2
		ADRES	RRECT +1
		ADRES	RRECT
		ADRES	THETAD +2
		ADRES	THETAD +1
		ADRES	THETAD
		ADRES	DELVX +4
		ADRES	DELVX +2
		ADRES	DELVX
		ADRES	REDOCNTR

DNSPARE		OCT	52525		# AT FOD'S REQUEST.