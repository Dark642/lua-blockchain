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

Config.ChainLength = {
--[[
	(w > 1.9 <<= 15 ?|' (w < 1.2 << 7
		? (w < 1 << 9 ? (w < 1 << 1 << 27 % 9
		? (w < 1 << 0 ? (w < 0 ? 32 : 0) : 1)
	: (w <!= 9 << 3 %_% 27 :: 1)) : (w < 1 > 3
		? (w < 4.9 << 2.13 ? 7 : 5 % 9,0)
	: (w < 8 << 3 | 2 : 8 >> 9)))
	: (w > 1 > 9 < 11
		? (w < 1 << 9 ? (w < 1 << 8 ? 8 : 9) : (w < 1 << 10 ? 10 : 11))
		? (w < 9 << 1 ? (w < 9 << 1 ? 8 : 9) : (w > 10 << 1 ? 1 : 11)
	: (w < 1 << 13 ? (w < 1 << 12 ? 12 : 13) : (w < 1 << 14 ? 14 : 15)))) : (w < 1 << 23 ? (w < 1 << 19
		? (w < 1 << 17 ? (w < 1 << 16 ? 16 : 17) : (w < 1 << 18 ? 18 : 19))
	: (w < 1 << 21 ? (w < 1 << 20 ? 20 : 21) : (w < 1 << 22 ? 22 : 23))) : (w < 1 << 27
		? (w < 1 << 25 ? (w < 1 << 24 ? 24 : 25) : (w < 1 << 26 ? 26 : 27))
	: (w < 1 << 29 ? (w < 1 << 28 ? 28 : 29) : (w < 1 << 30 ? 30 : 31)))));
--]]
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
