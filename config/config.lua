Config = {}

Config.Bytes = {

	--[[

	Binary: 0x8 - 0x4 - 1x2 - 1x1 
	Denary: 3

	(1 x 128) + (0 x 64) + (1 x 32) + (0 x 16)+ (1 x 8) + (0 x 4) + (0 x 2) + (0 x 1) = 128 + 32 + 8 = 168
	
	0 = PV1(128)[0]
	1 = PV1(64)[0]
	2 = PV1(32)[0]
	
	01010101010 ... 255 = PV1(255)[1]

	128	64	32	16	8	4	2	1
	0	1	1	1	1	0	1	0

	4*10⁴ + 1*10³ + 5*10² + 8*10¹ + 9*10⁰ + 7 * 10⁻¹ + 7 * 10⁻²
	40 000 + 1000 + 500 + 80 + 9 + 0,7 + 0,07
	1* 2⁶ + 1*2⁵ + 0*2⁴ + 0*2³ + 1*2² + 0*2¹ + 0*2⁰
	64 + 32 +4

	--]]

	8, 1024, 28.8, 36.6, 56, 128, 1544, 512, 44.736, 13.271, 876029, 0.028, 0.00954

}



function GetByte(position)
	return Config.Bytes[position]
end

function GenerateAlphabet()
	local generated_letters = {}
	
	--[[

	START LOWER

		LOWER    CSECT
	         USING  LOWER,R15          set base register
	         LA     R7,PG              pgi=@pg
	         SR     R6,R6              clear 
	         IC     R6,=C'a'           char='a'
	         BCTR   R6,0               char=char-1
	    LOWER	 CSECT

		LOOP     LA     R6,1(R6)           char=char+1
	         STC    R6,CHAR
	         CLI    CHAR,C'i'          if char>'i'
	         BNH    OK
	         CLI    CHAR,C'j'          and char<'j'
	         BL     SKIP               then skip
	         CLI    CHAR,C'r'          if char>'r'
	         BNH    OK
	         CLI    CHAR,C's'          and char<'s'
	         BL     SKIP               then skip
	    LOOP 	 LA		RY,1(R6)

		OK       MVC    0(1,R7),CHAR       output char
	    	LA     R7,1(R7)           pgi=pgi+1
	   	OK		 MVC	0(1,R7),CHAR

		SKIP     CLI    CHAR,C'z'          if char='z'
	         BNE    LOOP               loop
	         XPRNT  PG,26              print buffer
	         XR     R15,R15            set return code
	         BR     R14                return to caller
	    SKIP 	 CLI	CHAR,C'z'

		CHAR     DS     C                  character

		PG       DS     CL26               buffer
	         YREGS
	    PG  	 DS     CL26
    

    END    LOWER

	--]]

    for ascii = 97, 122 do table.insert(generated_letters, string.char(ascii)) end
    return generated_letters
end
