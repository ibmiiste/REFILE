/*  Procedure Where Found                                                     */
/*  CPP:  PRCWHRFNDC                                                          */

             CMD        PROMPT('Procedure Where Found')

             PARM       KWD(PROCEDURE) TYPE(*CHAR) LEN(256) MIN(1) PROMPT('Procedure')

             PARM       KWD(WILDCARD) TYPE(*CHAR) LEN(10) RSTD(*YES) DFT(*NONE) SPCVAL((*NONE) +
                          (*BEFORE) (*AFTER) (*BOTH)) PROMPT('Wild Card')

             PARM       KWD(OUTPUT) TYPE(*CHAR) LEN(10) RSTD(*YES) DFT(*) SPCVAL((*) (*PRINT)) +
                          PROMPT('Output')

/******************************************************************************/
/*  CRTCMD CMD(library/PRCWHRFND)                                             */
/*           PGM(*LIBL/PRCWHRFNDC)                                            */
/*           SRCFILE(library/QCMDSRC)                                         */
/*           SRCMBR(PRCWHRFND)                                                */
/******************************************************************************/


