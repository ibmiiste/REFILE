/*--------------------------------------------------------------------------*/
/* This program is free software, you can redistribute it and/or modify it  */
/* under the terms of the GNU General Public License as published by        */
/* the Free Software Foundation. See GNU General Public License for detail. */
/* Copyright (C) 2015   Craig Rutledge  <www.jcrcmds.com>     v5r4          */
/*--------------------------------------------------------------------------*/
/* JCRBND - Procedure names list - CMD                                      */
/*--------------------------------------------------------------------------*/
             CMD        PROMPT('Procedure Names List')
             PARM       KWD(BINDING) TYPE(BINDING) MIN(1) PROMPT('Binding Object:')
 BINDING:    QUAL       TYPE(*NAME) LEN(10) MIN(1)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) SPCVAL((*LIBL)) PROMPT('Library:')
             PARM       KWD(OBJTYPE) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*BNDDIR) VALUES(*BNDDIR *SRVPGM +
                          *MODULE) MIN(0) PGM(*YES) PROMPT('Object type:')
             PARM       KWD(OUTPUT) TYPE(*CHAR) LEN(8) RSTD(*YES) +
                          DFT(*) VALUES(*PRINT *OUTFILE *) PROMPT('Output:')
             PARM       KWD(OUTFILE) TYPE(OUTFILE) PMTCTL(PMTCTL1) PROMPT('Outfile:')
 OUTFILE:    QUAL       TYPE(*NAME) LEN(10) MIN(0)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) SPCVAL((*LIBL) (*CURLIB)) PROMPT('Library:')
             PARM       KWD(OUTMBR) TYPE(OUTMBR) PMTCTL(PMTCTL1) PROMPT('Output member options:')
 OUTMBR:     ELEM       TYPE(*NAME) LEN(10) DFT(*FIRST) +
                          SPCVAL((*FIRST)) PROMPT('Member to receive output')
             ELEM       TYPE(*CHAR) LEN(10) RSTD(*YES) DFT(*REPLACE) +
                          VALUES(*REPLACE *ADD) PROMPT('Replace or add records')
 PMTCTL1:    PMTCTL     CTL(OUTPUT) COND((*EQ '*OUTFILE')) NBRTRUE(*EQ 1)
