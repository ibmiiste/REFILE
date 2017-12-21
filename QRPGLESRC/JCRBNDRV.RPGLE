      //---------------------------------------------------------
      // This program is free software, you can redistribute it and/or modify it
      // under the terms of the GNU General Public License as published by
      // the Free Software Foundation. See GNU General Public License for detail.
      // Copyright (C) 2015   Craig Rutledge  <www.jcrcmds.com>     v5r4
      //---------------------------------------------------------
      // JCRBNDRV - Object validity checking program with create outfile
      //--*COPY DEFINES------------------------------------------
      /Define ProgramHeaderSpecs
      /Define f_CheckObj
      /Define f_OutFileCrtDupObj
      /Define p_JCRBNDR
      /Define p_JCRBNDRV
      /COPY JCRCMDS,JCRCMDSCPY

      //--*ENTRY PARMS-------------------------------------------
     D p_JCRBNDRV      PI
     D  p_ObjQual                    20a
     D  p_ObjTyp                     10a
     D  p_Output                      8a
     D  p_OutFileQual                20a
     D  p_MbrOpt                     22a
      //---------------------------------------------------------
      /free
       f_CheckObj(p_ObjQual: p_ObjTyp);

 1b    if p_Output = '*OUTFILE ';
          f_OutFileCrtDupObj(p_OutFileQual: p_MbrOpt: 'JCRBNDPF  ');
 1e    endif;
       *inlr = *on;
       return;
