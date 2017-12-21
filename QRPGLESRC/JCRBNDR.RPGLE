      //---------------------------------------------------------
      // This program is free software, you can redistribute it and/or modify it
      // under the terms of the GNU General Public License as published by
      // the Free Software Foundation. See GNU General Public License for detail.
      // Copyright (C) 2015   Craig Rutledge  <www.jcrcmds.com>     v5r4
      //---------------------------------------------------------
      // JCRBNDR - Procedure names list from bnddir/svcpgm/mod
      // determine type selected on input (bnddir,svcpgm, or module).
      // call list object API to load object names to user space.
      // call Qbnlspgm API to extract proc exports from service programs.
      // call Qbnlmodi API to extract symbols from modules information.
      //
      // If object is BNDDIR, must execute CL command dspbnddir to outfile to get info.
      // Wish there was API for that!
      //---------------------------------------------------------
      /Define ProgramHeaderSpecs
      /COPY JCRCMDS,JCRCMDSCPY
      /UnDefine ProgramHeaderSpecs

     FJCRBNDPFB if   e             disk    usropn
     FJCRBNDPF  o    e             disk    extfile(extOfile) extmbr(ExtOmbr)
     F                                     usropn
     FJCRBNDRP  o    e             printer oflind(IsOverFlow)  usropn

      //--*STAND ALONE-------------------------------------------
     D extOmbr         s             10a
     D LibObjQual      s             21a
     D ListSpace       s             20a   inz('JCRBNDLST QTEMP     ')
     D ModuleSpace     s             20a   inz('JCRMODULE QTEMP     ')
     D SrvPgmSpace     s             20a   inz('JCRSRVPGM QTEMP     ')

      //--*COPY DEFINES------------------------------------------
      /Define ApiErrDS
      /Define Qbnlspgm
      /Define Quslobj
      /Define Qusptrus
      /Define UserSpaceHeaderDS
      /Define f_BuildString
      /Define f_GetQual
      /Define f_OvrPrtf
      /Define f_Dltovr
      /Define f_Quscrtus
      /Define f_Qusrobjd
      /Define f_SndCompMsg
      /Define f_SndStatMsg
      /Define f_System
      /Define f_DspLastSplf
      /Define f_GetDayName
      /Define p_JCRBNDR
      /COPY JCRCMDS,JCRCMDSCPY

      //--*FUNCTION PROTOTYPES-----------------------------------
     D f_GetBndDir     PR
     D                               10a                                        Object
     D                               10a                                        Lib
     D f_GetSrvPgm     PR
     D                               10a                                        Object
     D                               10a                                        Lib
     D f_GetModule     PR
     D                               10a                                        Object
     D                               10a                                        Lib
     D f_PutPrint      PR
     D                               10a                                        Binding Directory
     D                               10a                                        Lib
     D                               10a                                        Service Program
     D                               10a                                        Lib
     D                               10a                                        Module
     D                               10a                                        Lib
     D                              256a                                        Procedure Name
     D Qbnlmodi        PR                  extpgm('QBNLMODI')                   list module info
     D                               20a                                        user space
     D                                8a   const                                api format
     D                               20a   const                                object and lib
     Db                                    like(ApiErrDS)
      //--*ENTRY PARMS-------------------------------------------
     D p_JCRBNDR       PI
     D  p_ObjQual                    20a
     D  p_ObjTyp                     10a
     D  p_Output                      8a
     D  p_OutFileQual                20a
     D  p_OutMbrOpt                  22a
      //---------------------------------------------------------
      /free
       QusrObjDS = f_QUSROBJD(p_ObjQual: p_ObjTyp: 'OBJD0200');
       %subst(p_ObjQual: 11: 10) = QusrObjDS.ReturnLib;

       LibObjQual = f_GetQual(p_ObjQual);
       f_SndStatMsg(f_BuildString(
       'List procedures for & type & - in progress':
       LibObjQual: p_ObjTyp));

       // depending on output selection
 1b    if p_Output = '*OUTFILE';
          extOmbr = %subst(p_OutMbrOpt: 3: 10);
          extOfile = f_GetQual(p_OutFileQual);
          open JCRbndpf;

 1x    else;
          f_OvrPrtf('JCRBNDRP ': *OMIT: %subst(p_ObjQual: 1: 10));
          open JCRbndrp ;
          evalr scDow = %trimr(f_GetDayName());
          scObjHead =  f_BuildString('&  &   &   &':
                       QusrObjDS.ObjNam: QusrObjDS.ReturnLib:
                       p_ObjTyp: QusrObjDS.Text);
 2b       if p_ObjTyp = '*BNDDIR';
             HeadVar = 'Bnddir     Srv Pgm    Lib        Module    ' +
             ' Lib        Procedure Name';
 2x       elseif p_ObjTyp = '*SRVPGM';
             HeadVar = 'Srv Pgm    Procedure Name';
 2x       elseif p_ObjTyp = '*MODULE';
             HeadVar = 'Module     Procedure Name';
 2e       endif;
          write PrtHead;
 1e    endif;

       GenericHeaderPtr = f_Quscrtus(ListSpace);
       f_Quscrtus(ModuleSpace);
       f_Quscrtus(SrvPgmSpace);

       // load object names into user space.
       callp QUSLOBJ(
             ListSpace:
             'OBJL0100':
             p_ObjQual:
             p_ObjTyp:
             ApiErrDS);

       // Process objects in user space by moving pointer.
       QuslobjPtr = GenericHeaderPtr + GenericHeader.OffSetToList;

 1b    for ForCount = 1 to GenericHeader.ListEntryCount;
 2b       if QuslobjDS.ObjTyp = '*BNDDIR';
             f_GetBndDir(QuslobjDS.ObjNam: QuslobjDS.ObjLib);
 2x       elseif QuslobjDS.ObjTyp = '*SRVPGM';
             f_GetSrvPgm(QuslobjDS.ObjNam: QuslobjDS.ObjLib);
 2x       elseif QuslobjDS.ObjTyp = '*MODULE';
             f_GetModule(QuslobjDS.ObjNam: QuslobjDS.ObjLib);
 2e       endif;

          QuslobjPtr += GenericHeader.ListEntrySize;
 1e    endfor;
       f_System('CLRPFM JCRBNDPF');

 1b    if p_Output = '*PRINT  '
          or p_Output = '*       ';
          close JCRBNDRP;
          f_Dltovr('JCRBNDRP ');
          f_DspLastSplf('JCRBNDR   ': p_Output);
 1x    elseif p_Output = '*OUTFILE';
          f_SndCompMsg('File ' +%trimr(extOfile) + ' member ' +
          %trimr(ExtOmbr) + ' generated by JCRBND.');
 1e    endif;

       *inlr = *on;
       return;
      /end-free

      //---------------------------------------------------------
      // There is no system API to get bind directory
      // entries.  (I can't imagine why not!)  Anyway,
      // execute DSPBNDDIR command to *OUTFILE
      // then process outfile.
     P f_GetBndDir     B
     D f_GetBndDir     PI
     D p_ObjName                     10a
     D p_ObjLib                      10a
     D CmdString       s            160a   varying

      /free
       CmdString = 'DSPBNDDIR BNDDIR(' +
       %trimr(f_GetQual(p_ObjName + p_ObjLib)) +
              ') OUTPUT(*OUTFILE) ' +
              ' OUTFILE(JCRBNDPFB) OUTMBR(*FIRST *REPLACE)';
       f_System(CmdString);

       JCRBndDir = p_ObjName;
       JCRBndDirL = p_ObjLib;
       open JCRBNDPFB;
       read JCRBNDPFB;
 1b    dow not %eof;

 2b       if bnobtp = '*SRVPGM';
             f_GetSrvPgm(bnobnm: bnolnm);
 2x       elseif bnobtp = '*MODULE';
             f_GetModule(bnobnm: bnolnm);
 2e       endif;

          read JCRBNDPFB;
 1e    enddo;
       close JCRBNDPFB;
       return;
      /end-free
     P f_GetBndDir     E
      //---------------------------------------------------------
     P f_GetSrvPgm     B
     D f_GetSrvPgm     PI
     D  p_ObjName                    10a
     D  p_ObjLib                     10a
     D GenericHeaderPtr...
     D                 s               *   inz(*null)
     D ForCount        s             10i 0

     D GenericHeader   ds                  qualified based(GenericHeaderPtr)
     D OffSetToList                  10i 0 overlay(GenericHeader: 125)
     D ListEntryCount                10i 0 overlay(GenericHeader: 133)
     D ListEntrySize                 10i 0 overlay(GenericHeader: 137)

     D ListEntryDS     ds                  qualified based(ListEntryPtr)
     D  LengthOfName                 10i 0 overlay(ListEntryDS:25)
     D  BigProcName                 256a   overlay(ListEntryDS:29)
      /free
       JCRSrvPgm = p_ObjName;
       JCRSrvPgmL = p_ObjLib;
       JCRModule = *blanks;
       JCRModuleL = *blanks;
       callp QUSPTRUS(
             SrvPgmSpace:
             GenericHeaderPtr:
             ApiErrDS);
       callp QBNLSPGM(
             SrvPgmSpace:
             'SPGL0600':
             p_ObjName + p_ObjLib:
             ApiErrDS);
       ListEntryPtr = GenericHeaderPtr + GenericHeader.OffSetToList;

 1b    for ForCount = 1 to GenericHeader.ListEntryCount;
          JCRProc =
          %subst(ListEntryDS.BigProcName: 1: ListEntryDS.LengthOfName);
          f_PutPrint(
          JCRBNDDIR:
          JCRBNDDIRL:
          JCRSRVPGM:
          JCRSRVPGML:
          JCRMODULE:
          JCRMODULEL:
          JCRPROC);
          ListEntryPtr += GenericHeader.ListEntrySize;
 1e    endfor;
       JCRSrvPgm = *blanks;
       JCRSrvPgmL = *blanks;
       return;
      /end-free
     P f_GetSrvPgm     E
      //---------------------------------------------------------
     P f_GetModule     B
     D f_GetModule     PI
     D  p_ObjName                    10a
     D  p_ObjLib                     10a
     D ForCount        s             10i 0
     D ProcNameRaw     s            256a   based(RawNamePtr)
     D GenericHeader   ds                  qualified based(mhPtr)
     D OffSetToList                  10i 0 overlay(GenericHeader: 125)           offset to list
     D ListEntryCount                10i 0 overlay(GenericHeader: 133)           number list entries
     D ListEntrySize                 10i 0 overlay(GenericHeader: 137)           list entry size

     D ListEntryDS     ds                  qualified based(ListEntryPtr)
     D  SizeOfThisEnt                10i 0 overlay(ListEntryDS: 1)
     D  OffsetToProc                 10i 0 overlay(ListEntryDS:29)
     D  LengthOfName                 10i 0 overlay(ListEntryDS:33)

      /free
       JCRModule = p_ObjName;
       JCRModuleL = p_ObjLib;
       callp QBNLMODI(
             ModuleSpace:
             'MODL0300':
             p_ObjName + p_ObjLib:
             ApiErrDS);
       callp QUSPTRUS(ModuleSpace: mHPtr: ApiErrDS);
       ListEntryPtr = mHPtr + GenericHeader.OffSetToList;
 1b    for ForCount = 1 to GenericHeader.ListEntryCount;

 2b       if ListEntryDS.LengthOfName > %size(JCRProc);
             ListEntryDS.LengthOfName = %size(JCRProc);
 2e       endif;
          RawNamePtr = mHPtr + ListEntryDS.OffsetToProc;
          JCRProc = %subst(procNameRaw: 1: ListEntryDS.LengthOfName);
 2b       if %subst(JCRProc: 1: 2) <> '_Q';
             f_PutPrint(
             JCRBNDDIR:
             JCRBNDDIRL:
             JCRSRVPGM:
             JCRSRVPGML:
             JCRMODULE:
             JCRMODULEL:
             JCRPROC);
 2e       endif;
          ListEntryPtr += ListEntryDS.SizeOfThisEnt;
 1e    endfor;
       JCRModule = *blanks;
       JCRModuleL = *blanks;
       return;
      /end-free
     P f_GetModule     E
      //---------------------------------------------------------
     P f_PutPrint      B
     D f_PutPrint      PI
     D JCRBNDDIR                     10a
     D JCRBNDDIRL                    10a
     D JCRSRVPGM                     10a
     D JCRSRVPGML                    10a
     D JCRMODULE                     10a
     D JCRMODULEL                    10a
     D JCRPROC                      256a
      /free
 1b    if p_Output = '*PRINT  ' or p_Output = '*         ';
 2b       if QuslobjDS.ObjTyp = '*BNDDIR';
             DetailVar =
             JCRBNDDIR + ' ' +
             JCRSRVPGM + ' ' +
             JCRSRVPGML + ' ' +
             JCRMODULE + ' ' +
             JCRMODULEL + ' ' +
             JCRPROC;
 2x       elseif QuslobjDS.ObjTyp = '*SRVPGM';
             DetailVar =
             JCRSRVPGM + ' ' +
             JCRPROC;
 2x       elseif QuslobjDS.ObjTyp = '*MODULE';
             DetailVar =
             JCRMODULE + ' ' +
             JCRProc;
 2e       endif;
          write PrtDetail;
 2b       if IsOverFlow;
             write PrtHead;
             IsOverFlow = *off;
 2e       endif;
 1x    elseif p_Output = '*OUTFILE';
          write JCRbndpfr;
 1e    endif;
      /end-free
     P f_PutPrint      E
