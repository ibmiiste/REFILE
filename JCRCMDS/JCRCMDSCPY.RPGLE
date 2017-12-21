      /If defined(Title)
      //---------------------------------------------------------
      // This program is free software, you can redistribute it and/or modify it
      // under the terms of the GNU General Public License as published by
      // the Free Software Foundation. See GNU General Public License for detail.
      // Copyright (C) 2015   Craig Rutledge  <www.jcrcmds.com>     v5r4 - v7r1
      //---------------------------------------------------------
      // JCRCMDSCPY - Copy Book for JCRCMDS
      //---------------------------------------------------------
      /endif
      /If defined(ProgramHeaderSpecs)
     H DFTACTGRP(*NO) ACTGRP(*CALLER) DATFMT(*ISO) TIMFMT(*ISO)
      /IF DEFINED(*V6R1M0)
     H OPTION(*NOUNREF: *NODEBUGIO)
      /ELSE
     H OPTION(*NODEBUGIO)
      /ENDIF
     H EXPROPTS(*RESDECPOS)
     H BNDDIR('JCRCMDSDIR':'QSYS/QC2LE')
      /endif
      /If defined(ApiErrDS)
      //---------------------------------------------------------
      // error return code parm for APIs.
     D ApiErrDS        DS                  qualified  import
     D  BytesProvided                10i 0
     D  BytesReturned                10i 0
     D  ErrMsgId                      7a
     D  ReservedSpace                 1a
     D  MsgReplaceVal               112a
      /endif
      /If defined(ApiStampDS)
      //---------------------------------------------------------
     D ApiStampDS      DS            16    qualified inz                        extract c yymmdd
     D  Century                       1a   overlay(ApiStampDS:1)                    0=19  1=20
     D  MMDD                          4a   overlay(ApiStampDS:2)
     D  YY                            2a   overlay(ApiStampDS:6)
     D  HHMMSS                        6a   overlay(ApiStampDS:8)
      /endif
      /If defined(Atof)
      //---------------------------------------------------------
     D atof            PR             8f   extproc('atof')                      string to float
     D                                 *   value options(*string)
      /endif
      /If defined(Atoi)
      //---------------------------------------------------------
     D atoi            PR            10i 0 extproc('atoi')                      string to integer
     D                                 *   value options(*string)
      /endif
      /If defined(Ceegsi)
      //---------------------------------------------------------
      // Parameters for CEEGSI - Get String Information
     D ceegsi          PR                  extproc('CEEGSI')                    get string info
     D                               10i 0 const                                position
     D                               10i 0                                      data type
     D                               10i 0                                      parm length
     D                               10i 0                                      max length
     D                               12a          options(*omit)                feedback
      // CEEGSI values used in multiple functions
     D MaxLength       s             10i 0
     D DataType        s             10i 0
     D LengthOfParm    s             10i 0
      /endif
      /If defined(Constants)
      //---------------------------------------------------------
     D rrn             s              5u 0
     D aa              s              5u 0
     D bb              s              5u 0
     D cc              s              5u 0
     D qs              c                   const('''')                          single quote
     D qd              c                   const('"')                           double quote
     D up              c                   const('ABCDEFGHIJKLMNOPQRSTUVWXYZ')
     D lo              c                   const('abcdefghijklmnopqrstuvwxyz')
     D IsExitPgm       s               n
     D IsRefresh       s               n
     D IsFirstTime     s               n
     D IsComment       s               n
      /endif
      /If defined(Cvthc)
      //---------------------------------------------------------
     D cvthc           PR                  ExtProc('cvthc')                     convert hex to char
     D                                 *   value                                receiver pointer
     D                                 *   value                                source pointer
     D                               10i 0 value                                number of nibbles
      /endif
      /If defined(Infds)
      //---------------------------------------------------------
      // File information Data Structure
     D Infds           DS
     D  InfdsFile                    10a   overlay(Infds:83)
     D  InfdsLib                     10a   overlay(Infds:93)
     D  InfdsRecLen                   5i 0 overlay(Infds:125)
     D  InfdsMbr                     10a   overlay(Infds:129)
     D  InfdsNumRcds                 10i 0 overlay(Infds:156)
     D  InfdsMiscFlag                 1a   overlay(Infds:196)
     D  InfdsCcsid                    5i 0 overlay(Infds:218)
     D  InfdsRcdfmt                  10a   overlay(Infds:261)
     D  InfdsFkey                     1a   overlay(Infds:369)
     D  SflRecNbrX                    5i 0 overlay(Infds:376)
     D  SflRecNbr                     5i 0 overlay(Infds:378)
      /endif
      /If defined(Dspatr)
      //---------------------------------------------------------
     D  Green          c                   const(x'20')
     D  White          c                   const(x'22')
     D  Red            c                   const(x'28')
     D  Turq           c                   const(x'30')
     D  Yellow         c                   const(x'32')
     D  Pink           c                   const(x'38')
     D  Blue           c                   const(x'3A')
     D  ND             c                   const(x'27')
     D  RI             c                   const(x'01')
     D  HI             c                   const(x'02')
     D  UL             c                   const(x'04')
     D  PR             c                   const(x'80')
      /endif
      /If defined(FieldsAttrDS)
      //---------------------------------------------------------
     D FieldsAttrDS    DS                  qualified inz
     D  Length                       10u 0
     D  DecimalPos                    2a
     D   DecimalPosN                  2s 0 overlay(DecimalPos)
     D  DataType                      1a
     D  FromFile                     10a
     D  QualifyingDS                 50a
     D  Text                         25a
      /If defined(FieldsArry)
     D FieldsArry_NumberOfEntries...
     D                 s             10u 0 IMPORT
     D FieldsArry      s            192a   dim(12767) IMPORT
     D                 DS                  based(FieldPtr)
     D FieldsArryDS                 192a   dim(%elem(FieldsArry))
     D FieldsNameArry               100a   overlay(FieldsArryDS:1)
     D FieldsAttrArry                      overlay(FieldsArryDS:101)
     D                                     like(FieldsAttrDS)
     D FieldPtr        s               *   inz(%addr(FieldsArry))
      /endif
      /endif
      /If defined(GetAllocSizeDS)
      //---------------------------------------------------------
     D GetAllocSizeDS  DS                  qualified
     D  SizeReturned                 10i 0 overlay(GetAllocSizeDS:5)
      /endif
      /If defined(Fild0100DS)
      //---------------------------------------------------------
      // file header offsets
     D Fild0100ds      DS                  qualified based(Fild0100ptr)
     D  BytesReturned                10i 0 overlay(Fild0100ds:001)
     D  TypeBits                      1a   overlay(Fild0100ds:009)
     D  NumOfBasedPf                  5i 0 overlay(Fild0100ds:015)
     D  MaxMbrs                       5i 0 overlay(Fild0100ds:042)
     D  NumMbrs                       5i 0 overlay(Fild0100ds:048)
     D  NumRcdFmts                    5i 0 overlay(Fild0100ds:062)
     D  FileText                     50a   overlay(Fild0100ds:085)
     D  NumOfFlds                     5i 0 overlay(Fild0100ds:207)
     D  FileRecLen                    5i 0 overlay(Fild0100ds:305)
     D  OffsFileScope                10i 0 overlay(Fild0100ds:317)
     D  AccessType                    2a   overlay(Fild0100ds:337)
     D  OffsPFAttr                   10i 0 overlay(Fild0100ds:365)
     D  OffsLfAttr                   10i 0 overlay(Fild0100ds:369)
      //  file scope array
     D FileScopeArry   DS           160    qualified based(fscopePtr)
     D  BasedOnPf                    10a   overlay(FileScopeArry:049)
     D  BasedOnPfLib                 10a   overlay(FileScopeArry:059)
     D  RcdFmt                       10a   overlay(FileScopeArry:069)
     D  NumOfKeys                     5i 0 overlay(FileScopeArry:116)
     D  NumSelectOmit                 5i 0 overlay(FileScopeArry:129)
     D OffsSelectOmit                10i 0 overlay(FileScopeArry:131)
     D  OffsKeySpecs                 10i 0 overlay(FileScopeArry:135)
      // key specification array
     D KeySpecsDS      DS                  qualified based(KeySpecsPtr)
     D  KeyFieldName                 10a   overlay(KeySpecsDS:1)
     D  KeySequenBits                 1a   overlay(KeySpecsDS:14)
      // select/omit specification array.
     D SelectOmitSpec  DS                  qualified based(SelectOmitSpecPtr)
     D  StatementRule                 1a   overlay(SelectOmitSpec:3)
     D  CompRelation                  2a   overlay(SelectOmitSpec:4)
     D  FieldName                    10a   overlay(SelectOmitSpec:6)
     D  NumberOfParms                 5i 0 overlay(SelectOmitSpec:16)
     D  OffsToParms                  10i 0 overlay(SelectOmitSpec:29)
      // select/omit parameters.
     D SelectOmitParm  DS                  qualified based(SelectOmitParmPtr)
     D  OffsToNext                   10i 0 overlay(SelectOmitParm:1)
     D  ParmLength                    5i 0 overlay(SelectOmitParm:5)
     D  ParmValue                    30a   overlay(SelectOmitParm:21)
      // Logical file specific attributes section.
     D LfSpecific      DS            48    qualified based(lfSpecificPtr)
     D  JoinOffset                   10i 0 overlay(LfSpecific:1)
     D  AttrBits                      1a   overlay(LfSpecific:31)
      // join specifications linked list section.
     D JoinSpecDS      DS            48    qualified based(JoinSpecPtr)
     D  NextLink                     10i 0 overlay(JoinSpecDs:1)
     D  NumJFlds                      5i 0 overlay(JoinspecDS:9)
     D  JoinFileNum                   5i 0 overlay(JoinspecDS:13)
     D  OffsToJSA                    10i 0 overlay(JoinspecDS:41)
      // join specification array.  (JSA)
     D JoinSpecArryDS  DS            48    qualified based(JoinSpecArryPtr )
     D  FromField                    10a   overlay(JoinSpecArryDS:1)
     D  FromNumber                    5i 0 overlay(JoinSpecArryDS:11)
     D  ToField                      10a   overlay(JoinSpecArryDS:17)
     D  ToNumber                      5i 0 overlay(JoinSpecArryDS:27)
      // physical file attributes
     D PfAttrDS        DS                  based(PfAttrPtr)  qualified
     D  OffsTriggers                 10i 0 overlay(PfAttrDS:25)
     D  NumOfTriggers                 5i 0 overlay(PfAttrDS:29)
      // trigger information array
     D TriggerDS       DS                  based(TriggerPtr) qualified
     D  TTime                         1a   overlay(TriggerDS:1)
     D  TEvent                        1a   overlay(TriggerDS:2)
     D  TPrgNam                      10a   overlay(TriggerDS:3)
     D  TPrgLib                      10a   overlay(TriggerDS:13)
      /endif
      /If defined(FunctionKeys)
      //---------------------------------------------------------
     D f01             c                   const(x'31')
     D f02             c                   const(x'32')
     D f03             c                   const(x'33')
     D f04             c                   const(x'34')
     D f05             c                   const(x'35')
     D f06             c                   const(x'36')
     D f07             c                   const(x'37')
     D f08             c                   const(x'38')
     D f09             c                   const(x'39')
     D f10             c                   const(x'3A')
     D f11             c                   const(x'3B')
     D f12             c                   const(x'3C')
     D f13             c                   const(x'B1')
     D f14             c                   const(x'B2')
     D f15             c                   const(x'B3')
     D f16             c                   const(x'B4')
     D f17             c                   const(x'B5')
     D f18             c                   const(x'B6')
     D f19             c                   const(x'B7')
     D f20             c                   const(x'B8')
     D f21             c                   const(x'B9')
     D f22             c                   const(x'BA')
     D f23             c                   const(x'BB')
     D f24             c                   const(x'BC')
     D fPageup         c                   const(x'F4')
     D fPageDown       c                   const(x'F5')
      /endif
      /If defined(Ind)
      //---------------------------------------------------------
      // name screen indicators
     D ind             DS                  qualified inz
     D IsActivateF14                   n   overlay(ind:04)
     D IsKeysMode                      n   overlay(ind:05)
     D sfldrop                         n   overlay(ind:06)
     D IsMoreScreens                   n   overlay(ind:08)
     D IsShowViewPFs                   n   overlay(ind:09)
     D HeadingSwitch                   n   overlay(ind:10)
     D sflnxtchg                       n   overlay(ind:11)
     D IsChangedDate                   n   overlay(ind:20)
     D ShowSrcData                     n   overlay(ind:27)
     D sfldsp                          n   overlay(ind:31)
     D sfldspctl                       n   overlay(ind:32)
     D sflclr                          n   overlay(ind:33)
     D sflend                          n   overlay(ind:34)
     D sfldsp2                         n   overlay(ind:41)
     D sfldspctl2                      n   overlay(ind:42)
     D sflclr2                         n   overlay(ind:43)
     D sflend2                         n   overlay(ind:44)
     D sfldsp3                         n   overlay(ind:51)
     D sfldspctl3                      n   overlay(ind:52)
     D sfldsp4                         n   overlay(ind:61)
     D sfldspctl4                      n   overlay(ind:62)
      /endif
      /If defined(ListHeaderDS)
      //---------------------------------------------------------
      // Get user header info from list user space
     D ListHeaderDS    DS                  qualified based(ListHeaderPtr)
     D  FileActual                   10a
     D  LibActual                    10a
     D  FileType                     10a
     D  FileText                     50a
      /endif
      /If defined(Qbnlpgmi)
      //---------------------------------------------------------
     D Qbnlpgmi        PR                  extpgm('QBNLPGMI')                   list ile pgm info
     D                               20a                                        user space
     D                                8a   const                                api format
     D                               20a   const                                object and lib
     Db                                    like(ApiErrDS)
      /endif
      /If defined(Qbnlspgm)
      //---------------------------------------------------------
     D Qbnlspgm        PR                  extpgm('QBNLSPGM')                   list srvpgm info
     D                               20a                                        user space
     D                                8a   const                                api format
     D                               20a   const                                object and lib
     Db                                    like(ApiErrDS)
      /endif
      /If defined(Qbnrmodi)
      //---------------------------------------------------------
     D Qbnrmodi        PR                  extpgm('QBNRMODI')                   retrieve module info
     Db                             200a                                        receiver
     D                               10i 0 const                                receiver length
     D                                8a   const                                api format
     D                               20a   const                                object and lib
     Db                                    like(ApiErrDS)
      /endif
      /If defined(Qclrpgmi)
      //---------------------------------------------------------
     D Qclrpgmi        PR                  extpgm('QCLRPGMI')                   retrieve pgm info
     D                              528a                                        receiver
     D                               10i 0 const                                receiver length
     D                                8a   const                                api format
     D                               20a   const                                file and lib
     Db                                    like(ApiErrDS)
      /endif
      /If defined(Qcmdchk)
      //---------------------------------------------------------
     D Qcmdchk         PR                  extpgm('QCMDCHK')                    cl syntax checking
     D                              500a
     D                               15p 5 const
      /endif
      /If defined(Qcmdexc)
      //---------------------------------------------------------
     D Qcmdexc         PR                  extpgm('QCMDEXC')                    cl command processor
     D                              125a   options(*VarSize)
     D                               15p 5 const
      /endif
      /If defined(Qdbldbr)
      //---------------------------------------------------------
     D Qdbldbr         PR                  extpgm('QDBLDBR ')                   data base relations
     D                               20a                                        user space
     D                                8a   const                                api format
     D                               20a   const                                file and lib
     D                               10a   const                                mbr
     D                               10a   const                                record format
     Db                                    like(ApiErrDS)
      //-DBRL0100 format-
     D  QdbldbrDS      DS                  qualified based(QdbldbrPtr)
     D  DependentLF                  10a   overlay(QdbldbrDS:21)
     D  DependentLib                 10a   overlay(QdbldbrDS:31)
     D  DependentFile                20a   overlay(QdbldbrDS:21)
      /endif
      /If defined(Qdbrtvfd)
      //---------------------------------------------------------
     D Qdbrtvfd        PR                  extpgm('QDBRTVFD')                   retrieve file desc
     D                            16000a   options(*varsize)                    receiver
     D                               10i 0 const                                receiver length
     D                               20a                                        return file and lib
     D                                8a   const                                api format
     D                               20a   const                                file and lib
     D                               10a   const                                record format
     D                                1a   const                                overrides
     D                               10a   const                                system
     D                               10a   const                                format type
     Db                                    like(ApiErrDS)
     D ReturnFileQual  s             20a
      //---------------------------------------------------------
      // get size of memory to allocate for QDBRTVFD call
     D f_GetAllocSize01...
     D                 PR            10i 0                                      memory size
     D                               20a   const                                qualified file name
     D                               10a   const                                record format name
     D AllocateSize    s             10i 0
      /endif
      /If defined(Qeccvtec)
      //---------------------------------------------------------
     D Qeccvtec        PR                  extpgm('QECCVTEC')                   generate edit mask
     D                              256a                                        receiver
     D                               10i 0                                      mask length
     D                               10i 0                                      receiver length
     D                                1a   const                                0 balance file
     D                                1a   const                                edit code
     D                                1a   const                                blank fill
     D                               10i 0 const                                field length
     D                               10i 0 const                                decimal location
     Db                                    like(ApiErrDS)
      /endif
      /If defined(Qecedt)
      //---------------------------------------------------------
     D Qecedt          PR                  extpgm('QECEDT')                     apply edit mask
     D                              256a                                        receiver
     D                               10i 0                                      mask length
     D                               30p 9                                      to be edited
     D                               10a   const                                type
     D                               10i 0 const                                field length
     D                              256a                                        edit mask
     D                               10i 0                                      mask length
     D                                1a   const                                0 balance file
     Db                                    like(ApiErrDS)
      /endif
      /If defined(Qlgsort)
      //---------------------------------------------------------
      // QLGSORT Sort Control Block
     D qlgSortDS       DS          1024    qualified inz
     D BlockLength                   10i 0 overlay(qlgSortDS:1)
     D TypeRequest                   10i 0 overlay(qlgSortDS:5)  inz(5)
     D Reserved1                     10i 0 overlay(qlgSortDS:9)
     D Options                       10i 0 overlay(qlgSortDS:13)
     D RecordLength                  10i 0 overlay(qlgSortDS:17)
     D RecordCount                   10i 0 overlay(qlgSortDS:21)
     D OffToKeyList                  10i 0 overlay(qlgSortDS:25) inz(80)
     D NumOfKeys                     10i 0 overlay(qlgSortDS:29)
     D OffNatLangInf                 10i 0 overlay(qlgSortDS:33)
     D OffInpFileList                10i 0 overlay(qlgSortDS:37)
     D NumOfInpFiles                 10i 0 overlay(qlgSortDS:41)
     D OffOutFileList                10i 0 overlay(qlgSortDS:45)
     D NumofOutFiles                 10i 0 overlay(qlgSortDS:49)
     D KeyEntryLength                10i 0 overlay(qlgSortDS:53) inz(16)
     D SortSeqLength                 10i 0 overlay(qlgSortDS:57)
     D LenInFileEntry                10i 0 overlay(qlgSortDS:61)
     DLenOutFileEntry                10i 0 overlay(qlgSortDS:65)
     D OffToNullMap                  10i 0 overlay(qlgSortDS:69)
     D OffToVarRecInf                10i 0 overlay(qlgSortDS:73)
     D Reserved2                     10i 0 overlay(qlgSortDS:77)
      //--*CALL PROTOTYPES---------------------------------------
     D qlgsort         PR                  extpgm('QLGSORT')
     D                             1024a   options(*varsize)                    sort ds
     D                               20a   dim(10)                              in buffer
     D                               20a   dim(10)                              out buffer
     D                               10i 0 const                                length in buffer
     D                               10i 0 const                                length out buffer
     Db                                    like(ApiErrDS)                       error ds
      /endif
      /If defined(Qmhqrdqd)
      //---------------------------------------------------------
     D Qmhqrdqd        PR                  extpgm('QMHQRDQD')                   dataq description
     Db                                    like(QmhqrdqdDS)                     receiver
     D                               10i 0 const                                receiver length
     D                                8a   const                                api format
     Db                              20a                                        dtaq and lib
     D QmhqrdqdDS      DS                  qualified inz
     D  MsgLength                    10i 0 overlay(QmhqrdqdDS:9)
     D  KeyLength                    10i 0 overlay(QmhqrdqdDS:13)
     D  Sequence                      1a   overlay(QmhqrdqdDS:17)
     D  SenderID                      1a   overlay(QmhqrdqdDS:18)
     D  Text                         50a   overlay(QmhqrdqdDS:20)
     D  LocalOrDDM                    1a   overlay(QmhqrdqdDS:70)
     D  EntryCount                   10i 0 overlay(QmhqrdqdDS:73)
     D  CurrAllocated                10i 0 overlay(QmhqrdqdDS:77)
     D  DtaqName                     10a   overlay(QmhqrdqdDS:81)
     D  DtaqLib                      10a   overlay(QmhqrdqdDS:91)
     D  MaxAllowed                   10i 0 overlay(QmhqrdqdDS:101)
     D  CreateSize                   10i 0 overlay(QmhqrdqdDS:109)
      /endif
      /If defined(Qmhrcvm)
      //---------------------------------------------------------
     D Qmhrcvm         PR                  extpgm('QMHRCVM')                    receive non-pgm msg
     Db                                    like(QmhrcvmDS) options(*varsize)    message info
     D                               10i 0 const                                length
     D                                8a   const                                format name
     D                               20a   const                                queue and lib
     D                               10a   const                                type
     D                                4a   const                                key
     D                               10i 0 const                                wait time
     D                               10a   const                                message action
     Db                                    like(ApiErrDS) options(*varsize)
      // parms for QMHRCVM retrieve non program messages
     D QmhrcvmDS       DS                  qualified
     D  BytesReturned                10i 0 overlay(QmhrcvmDS:1)
     D  BytesAvail                   10i 0 overlay(QmhrcvmDS:5)
     D  MsgSeverity                  10i 0 overlay(QmhrcvmDS:9)
     D  MsgID                         7a   overlay(QmhrcvmDS:13)
     D  MsgType                       2a   overlay(QmhrcvmDS:20)
     D  MsgKey                        4a   overlay(QmhrcvmDS:22)
     D  Reserved                      7a   overlay(QmhrcvmDS:26)
     D  CcsidConvStat                10i 0 overlay(QmhrcvmDS:33)
     D  Ccsid                        10i 0 overlay(QmhrcvmDS:37)
     D  MsgLenReturn                 10i 0 overlay(QmhrcvmDS:41)
     D  MsgLenAvail                  10i 0 overlay(QmhrcvmDS:45)
     D  ReplaceData                 512a   overlay(QmhrcvmDS:49)
      /endif
      /If defined(Qmhsndpm)
      //---------------------------------------------------------
     D Qmhsndpm        PR                  extpgm('QMHSNDPM')                   send program message
     D                                7a   const                                message id
     D                               20a   const                                file and lib
     D                               75a   const                                text
     D                               10i 0 const                                length
     D                               10a   const                                type
     D                               10a   const                                queue
     D                               10i 0 const                                stack entry
     D                                4a   const                                key
     Db                                    like(ApiErrDS)
      /endif
      /If defined(QsnGetCsrAdr)
      //---------------------------------------------------------
      //get cursor Row and Column
     D QsnGetCsrAdr    PR            10i 0 extproc('QsnGetCsrAdr')              get cursor row,colum
     D                               10i 0 const                                row
     D                               10i 0 const                                col
     D                               10i 0 const                                low level handle
     Db                                    like(ApiErrDS)
     D QsnCursorRow    s             10i 0
     D QsnCursorCol    s             10i 0
      /endif
      /If defined(Qspclosp)
      //---------------------------------------------------------
     D Qspclosp        PR                  extpgm('QSPCLOSP')                   close spooled file
     D                               10i 0                                      splf handle
     Db                                    like(ApiErrDS)
      /endif
      /If defined(Qspgetsp)
      //---------------------------------------------------------
     D Qspgetsp        PR                  extpgm('QSPGETSP')                   get spooled data
     D                               10i 0                                      splf handle
     D                               20a                                        user space
     D                                8a   const                                api format
     D                               10i 0                                      ordinal number
     D                               10a   const                                end of open
     Db                                    like(ApiErrDS)
      /endif
      /If defined(Qspopnsp)
      //---------------------------------------------------------
     D Qspopnsp        PR                  extpgm('QSPOPNSP')                   open spool file
     D                               10i 0                                      splf handle
     D                               26a   const                                qualified job
     D                               16a                                        internal job id
     D                               16a                                        internal spool num
     D                               10a   const                                spool file name
     D                               10i 0 const                                spool file num
     D                               10i 0 const                                number of buffers
     Db                                    like(ApiErrDS)
      /endif
      /If defined(Quscmdln)
      //---------------------------------------------------------
     D Quscmdln        PR                  extpgm('QUSCMDLN')                   command line
      /endif
      /If defined(Qusdltus)
      //---------------------------------------------------------
     D Qusdltus        PR                  extpgm('QUSDLTUS')                   delete user space
     D                               20a                                        user space
     Db                                    like(ApiErrDS)
      /endif
      /If defined(UserProfiles)
      //---------------------------------------------------------
     D Autu0200DS      DS                  based(Autu0200ptr)
     D  UsrPrf                       10a   overlay(Autu0200DS:1)
     D  UsrPrfTxt                    33a   overlay(Autu0200DS:21)
     D Usri0300DS      DS                  qualified inz
     D  PrvSignDatTim                13a   overlay(usri0300DS:19)
     D  Status                       10a   overlay(usri0300DS:37)
     D  UserClass                     7a   overlay(usri0300DS:74)
     D  SpecialAuth                  15a   overlay(usri0300DS:84)
     D   AllObj                       1a   overlay(SpecialAuth:1)
     D   Secadm                       1a   overlay(SpecialAuth:2)
     D   JobCtl                       1a   overlay(SpecialAuth:3)
     D   SplCtl                       1a   overlay(SpecialAuth:4)
     D   SavSys                       1a   overlay(SpecialAuth:5)
     D   Service                      1a   overlay(SpecialAuth:6)
     D   Audit                        1a   overlay(SpecialAuth:7)
     D   ApiAuthArry                  1a   overlay(SpecialAuth:1) dim(15)
     D   IoSysCfg                     1a   overlay(SpecialAuth:8)
     D   JobdQual                    20a   overlay(usri0300DS:290)
     D   OutqQual                    20a   overlay(usri0300DS:361)

      //--*CALL PROTOTYPES---------------------------------------
     D qsylautu        PR                  extpgm('QSYLAUTU')                   authorized user list
     D                               20a                                        user space
     D                                8a   const                                format
     Db                                    like(ApiErrDS)
     D qsyrusri        PR                  extpgm('QSYRUSRI')
     D                              309a                                        user profile info
     D                               10i 0 const                                receiver len
     D                                8a   const                                format
     D                               10a                                        user profile
     Db                                    like(ApiErrDS)
      /endif
      /If defined(Quslfld)
      //---------------------------------------------------------
     D Quslfld         PR                  extpgm('QUSLFLD')                    field descriptions
     D                               20a                                        user space
     D                                8a   const                                api format
     D                               20a   const                                file and lib
     D                               10a   const                                record format
     D                                1a   const                                overrides
     Db                                    like(ApiErrDS)
      // data structure for Quslfld user space list entries
     D QuslfldDS       DS                  qualified based(QuslfldPtr)
     D FieldName                     10a   overlay(QuslfldDS:1)
     D FieldType                      1a   overlay(QuslfldDS:11)
     D OutputPosition                10i 0 overlay(QuslfldDS:13)
     D InputPosition                 10i 0 overlay(QuslfldDS:17)
     D FieldLengthA                  10i 0 overlay(QuslfldDS:21)
     D FieldLengthN                  10i 0 overlay(QuslfldDS:25)
     D DecimalPos                    10i 0 overlay(QuslfldDS:29)
     D FieldText                     50a   overlay(QuslfldDS:33)
     D AliasName                     10a   overlay(QuslfldDS:223)
     D ScreenFieldRow                10i 0 overlay(QuslfldDS:449)
     D ScreenFieldCol                10i 0 overlay(QuslfldDS:453)
      /endif
      /If defined(Quslmbr)
      //---------------------------------------------------------
     D Quslmbr         PR                  extpgm('QUSLMBR')                    list mbr
     D                               20a                                        user space
     D                                8a   const                                api format
     D                               20a   const                                file and lib
     D                               10a   const                                mbr
     D                                1a   const                                override
     Db                                    like(ApiErrDS)
      // list members information.
     D QuslmbrDS       DS                  qualified based(QuslmbrPtr)
     D MbrName                       10a   overlay(QuslmbrDS:1)
     D MbrType                       10a   overlay(QuslmbrDS:11)
     D CreateDateTime                13a   overlay(QuslmbrDS:21)
     D ChangeDateTime                13a   overlay(QuslmbrDS:34)
     D Text                          50a   overlay(QuslmbrDS:47)
     D Ccsid                         10i 0 overlay(QuslmbrDS:97)
      /endif
      /If defined(Quslobj)
      //---------------------------------------------------------
     D Quslobj         PR                  extpgm('QUSLOBJ')                    list objects
     D                               20a                                        user space
     D                                8a   const                                api format
     D                               20a   const                                object and lib
     D                               10a   const                                object type
     Db                                    like(ApiErrDS)
     D QuslobjDS       DS                  qualified based(QuslobjPtr)
     D  ObjNam                       10a   overlay(QuslobjDS:1)
     D  ObjLib                       10a   overlay(QuslobjDS:11)
     D  ObjTyp                       10a   overlay(QuslobjDS:21)
     D  ExtendedAttr                 10a   overlay(QuslobjDS:32)
     D  ObjText                      50a   overlay(QuslobjDS:42)
     D  CreateStamp                   8a   overlay(QuslobjDS:125)
     D  CreatedByUser                10a   overlay(QuslobjDS:216)
     D  LastUseStamp                  8a   overlay(QuslobjDS:533)
     D  NumDaysUsed                  10i 0 overlay(QuslobjDS:549)
     D  ObjSize                      10i 0 overlay(QuslobjDS:577)
     D  MultiplySize                 10i 0 overlay(QuslobjDS:581)
      /endif
      /If defined(Quslspl)
      //---------------------------------------------------------
     D Quslspl         PR                  extpgm('QUSLSPL')                    list spooled files
     D                               20a                                        user space
     D                                8a   const                                api format
     D                               10a   const                                user profile
     D                               20a                                        outq and lib
     D                               10a   const                                form type
     D                               10a   const                                user data
     Db                                    like(ApiErrDS)
     D QuslsplDS       DS                  qualified based(QuslsplPtr)
     D InternalJobID                 16a   overlay(QuslsplDS:51)
     D InternalSplfID                16a   overlay(QuslsplDS:67)
      //---------------------------------------------------------
      // DS of spooled file attributes return variable.
     D splf0300DS      DS                  qualified based(splf0300Ptr)
     D  JobName                      10a   overlay(splf0300DS:1)
     D  UserID                       10a   overlay(splf0300DS:11)
     D  JobNo                         6a   overlay(splf0300DS:21)
     D  SplfName                     10a   overlay(splf0300DS:27)
     D  SplfNum                      10i 0 overlay(splf0300DS:37)
     D  Status                       10i 0 overlay(splf0300DS:41)
     D  CreateYYMMDD                  6a   overlay(splf0300DS:46)
     D  CreateHHMMSS                  6a   overlay(splf0300DS:52)
     D  UsrDta                       10a   overlay(splf0300DS:69)
     D  FormType                     10a   overlay(splf0300DS:79)
     D  Outq                         10a   overlay(splf0300DS:89)
     D  OutqLib                      10a   overlay(splf0300DS:99)
     D  ASP                          10i 0 overlay(splf0300DS:109)
     D  SplfSize                     10i 0 overlay(splf0300DS:113)
     D  MultiplySize                 10i 0 overlay(splf0300DS:117)
     D  PageNum                      10i 0 overlay(splf0300DS:121)
     D  Copies                       10i 0 overlay(splf0300DS:125)
     D  Priority                      1a   overlay(splf0300DS:129)
      /endif
      /If defined(Qusptrus)
      //---------------------------------------------------------
     D Qusptrus        PR                  extpgm('QUSPTRUS')                   retrieve pointer
     D                               20a                                        user space
     D                                 *                                        pointer
     Db                                    like(ApiErrDS)
      /endif
      /If defined(Qusrjobi)
      //---------------------------------------------------------
     D Qusrjobi        PR                  extpgm('QUSRJOBI')                   retrieve job info
     Db                             200a   options(*varsize)                    receiver
     D                               10i 0 const                                receiver length
     D                                8a   const                                api format
     D                               26a   const                                qualified job name
     D                               16a   const                                internal job num
     Db                                    like(ApiErrDS)
      /endif
      /If defined(Qusrusat)
      //---------------------------------------------------------
      // Retrieve User Space Attributes
     D Qusrusat        PR                  extpgm('QUSRUSAT')                   user space sttribute
     Db                                    like(QusrusatDS)                     receiver
     D                               10i 0 const                                receiver length
     D                                8a   const                                api format
     D                               20a                                        user space
     Db                                    like(ApiErrDS)
      // --return values for user space attributes--
     D QusrusatDS      DS                  qualified inz
     D BytesReturned                 10i 0 overlay(QusrusatDS:1)
     D BytesAvailable                10i 0 overlay(QusrusatDS:5)
     D SpaceSize                     10i 0 overlay(QusrusatDS:9)
     D Extendability                  1a   overlay(QusrusatDS:13)
     D InitialValue                   1a   overlay(QusrusatDS:14)
     D SpaceLibrary                  10a   overlay(QusrusatDS:15)
      /endif
      /If defined(Qwccvtdt)
      //---------------------------------------------------------
     D Qwccvtdt        PR                  extpgm('QWCCVTDT')                   spi date converter
     D                               10a   const                                from format
     D                                8a                                        api date stamp
     D                               10a   const                                to format
     Db                              16a                                        to date
     Db                                    like(ApiErrDS)
      /endif
      /If defined(Qwdrjobd)
      //---------------------------------------------------------
     D Qwdrjobd        PR                  extpgm('QWDRJOBD')                   load jobd data
     Db                            1000a   options(*varsize)                    receiver
     D                               10i 0 const                                receiver length
     D                                8    const                                api format
     D                               20    const                                jobd and lib
     Db                                    like(ApiErrDS)
      /endif
      /If defined(Sds)
      //---------------------------------------------------------
     D                Sds
     D ProgId                        10a
      /endif
      /If defined(Tstbts)
      //---------------------------------------------------------
     D tstbts          PR            10i 0 extproc('_TSTBTS')                   mi test bits
     D                                 *   value options(*string)               bit string
     D                               10u 0 value                                bit offset
      /endif
      /If defined(SrcDS)
      //---------------------------------------------------------
      // Define fields from different spec types.
     D SrcDS           DS                  qualified inz
     D  SeqNum4A               1      4a
     D  SeqNum6                1      6s 2
     D  SrcChgDat              7     12s 0
     D  CompileArray          13     15a
     D  SpecType              18     18a
     D  Asterisk              19     19a
     D  SlashComment          19     20a
     D  SlashIF               19     22a
     D  SlashELSEIF           19     26a
     D  FreeForm              19     27a
     D  Src80                 19     92a
     D  Src112                13    112a
      // F specs
      // rpg 4 locations
     D fFileName              19     28a
     D fUsage                 29     29a                                        I U O
     D fEorF                  34     34a                                        E or F
     D fDevice                48     55a                                        DISK, PRINTER, etc
      // rpg 3 locations
     D fFileName3             19     26a                                        z
     D fUsage3                27     27a                                        I U O
     D fEorF3                 31     31a                                        E or F
     D fDevice3               52     58a                                        DISK, PRINTER, etc
     D fBeingRenamed3         31     40a                                        KRENAME
     D fKeyWord3              65     71a                                        KRENAME
     D fRenamed3              72     81a                                        KRENAME
                // D specs
     D dTestPopulated         19     54a
     D dFieldName             19     33a
     D dDSext                 34     34a
     D dDS                    36     37a
     D dAllDStypes            34     37a
     D dStandAlone            35     37a
     D dProtoProcedur         35     38a
     D dAttribute             52     52a
     D dFromPos               40     44a
     D dFromPosN              40     44s 0
     D dStatusWords           38     45a
     D dToPos                 47     51a
     D dToPosN                47     51s 0
     D dDecimalPos            53     54a
     D dKeyWord               56     92a
                // I specs
     D iAttribute             48     48a
     D iFromPos               49     53a
     D iToPos                 54     58a
     D iDecimalPos            59     60a
     D iExternalFld           33     42a
     D iFieldName             61     74a
                // C specs
     D  SubRoutine            19     20a
     D  Conditioning          22     23a
     D  Factor1               24     37a
     D  OpCode                38     47a
     D   Opcode1                      1a   overlay(OpCode:1)
     D   Opcode2                      2a   overlay(OpCode:1)
     D   Opcode3                      3a   overlay(OpCode:1)
     D   Opcode4                      4a   overlay(OpCode:1)
     D   Opcode6                      6a   overlay(OpCode:1)
     D  Factor2               48     61a
     D  ExtendFactor2         48     92a
     D  ResultField           62     75a
     D  FieldLength           76     80a
     D  FieldLengthN          76     80s 0
     D  DecimalPos            81     82a
     D  ResultingInd          83     88a
     D   HIind                        2a   overlay(ResultingInd:1)
     D   LOind                        2a   overlay(ResultingInd:3)
     D   EQind                        2a   overlay(ResultingInd:5)
     D  SrcComment            93    112a
                // 0 specs
     D oAndOr                 28     31a
     D oLineType              29     29a
     D oIndicator             33     41a
     D oSpaceB                52     54a
     D oSpaceA                55     57a
     D oSkipB                 58     60a
     D oSkipA                 61     63a
     D oEname                 42     55a
     D oEditCode              56     56a
     D oEndPos                59     63a
     D oConstant              65     92a
     D CopyStatement          25     60a
     D Src57                  19     75a
     D Src63                  13     75a
                // DDS specs
     D ddsCondIn1             21     22a
     D ddsCondIn2             24     25a
     D ddsCondIn3             27     28a
     D ddsParenthesis         61     61a
     D ddsField               57     68a
     D ddsField2              57     58a
     D ddsField4              57     60a
     D ddsField5              57     61a
     D ddsField6              57     62a
     D ddsField7              57     63a
     D ddsField9              57     65a
     D ddsField10             57     66a
      /endif
      /If defined(SqlCLI)
      //---------------------------------------------------------
      // SQL Column types
     D SqlCHAR         c                   const(  1)
     D SqlNUMERIC      c                   const(  2)
     D SqlDECIMAL      c                   const(  3)
     D SqlLONG         c                   const(  4)
     D SqlSHORT        c                   const(  5)
     D SqlFLOAT        c                   const(  6)
     D SqlREAL         c                   const(  7)
     D SqlDOUBLE       c                   const(  8)
     D SqlDATE         c                   const( 91)
     D SqlTIME         c                   const( 92)
     D SqlTIMESTAMP...
     D                 c                   const( 93)
      // Sql constants
     D SqlNts          c                   const(-3)
     D SqlTrue         c                   const(  1)
     D SqlDrop         c                   const(  1)
     D CommitNone      c                   const(  1)
     D SysNaming       c                   const(10002)
     D AttrCommit      c                   const(  0)
     D SqlNumRcd       s             10i 0
     D retCode         s             10i 0
     D henv            s             10i 0
     D hdbc            s             10i 0
     D server          s             10a   inz('*LOCAL')
     D hstmt           s             10i 0
     D cOptVal         s             10i 0
      // Retrieve Error Information
     D sqlState        s              5a
     D pfNativeErr     s             10i 0
     D szErrMsg        s            256a
     D cbErrMsg        s              5i 0
      // Set environment attribute
     D envAttr         s             10i 0
      //---------------------------------------------------------
      // Allocate Environment Handle
     D SQLAllocEnv     PR            10i 0 extproc('SQLAllocEnv')
     D                                 *   value                                enviroment handle
     D SQLBindCol      PR            10i 0 extproc('SQLBindCol')
     D                               10i 0 value                                statement handle
     D                                5i 0 value                                column number
     D                                5i 0 value                                data type
     D                                 *   value                                rgb value
     D                               10i 0 value                                cb max value
     D                                 *   value                                pcb value
     D SQLSetEnvAttr   PR            10i 0 extproc('SQLSetEnvAttr')
     D                               10i 0 value                                enviroment handle
     D                               10i 0 value                                attr
     D                                 *   value                                p value
     D                               10i 0 value                                strlen
     DSQLAllocConnect  PR            10i 0 extproc('SQLAllocConnect')
     D                               10i 0 value                                enviroment handle
     D                                 *   value                                ptr to connection
     D SQLConnect      PR            10i 0 extproc('SQLConnect')
     D                               10i 0 value                                connection handle
     D                                 *   value  options(*string)              szdsn
     D                                5i 0 value                                cbdsn
     D                                 *   value  options(*string)              szuid
     D                                5i 0 value                                cbuid
     D                                 *   value  options(*string)              szauthstr
     D                                5i 0 value                                cbauthstr
     D SQLSetConnectOption...
     D                 PR            10i 0 extproc('SQLSetConnectOption')
     D                               10i 0 value                                connection handle
     D                                5i 0 value                                foption
     D                                 *   value                                vparam
     D SQLAllocStmt    PR            10i 0 extproc('SQLAllocStmt')
     D                               10i 0 value                                connection handle
     D                                 *   value                                phstmt
     D SQLFetch        PR            10i 0 extproc('SQLFetch')
     D                               10i 0 value                                statement handle
     D SQLExecDirect   PR            10i 0 extproc('SQLExecDirect')
     D                               10i 0 value                                statement handle
     D                                 *   value  options(*string)              szSqlStr
     D                               10i 0 value                                cbSqlStr
     D SQLFreeStmt     PR            10i 0 extproc('SQLFreeStmt')
     D                               10i 0 value                                statement handle
     D                                5i 0 value                                foption
     D SQLDisconnect   PR            10i 0 extproc('SQLDisconnect')
     D                               10i 0 value                                connection handle
     D SQLFreeConnect  PR            10i 0 extproc('SQLFreeConnect')
     D                               10i 0 value                                connection handle
     D SQLFreeEnv      PR            10i 0 extproc('SQLFreeEnv')
     D                               10i 0 value                                rnvironment handle
     D SQLError        PR            10i 0 extproc('SQLError')
     D                               10i 0 value                                environment handle
     D                               10i 0 value                                hdbc
     D                               10i 0 value                                hstmt
     D                                 *   value                                szSqlState
     D                                 *   value                                pfNativeErr
     D                                 *   value                                szErrMsg
     D                                5i 0 value                                cbErrMsgMax
     D                                 *   value                                pcbErrMsg
      /endif
      /If defined(System)
      //---------------------------------------------------------
     D System          PR            10i 0 extproc('system')                    cl command processor
     D                                 *   value options(*string)
      /endif
      /If defined(UserSpaceHeaderDS)
      //---------------------------------------------------------
      // Get user space list info from header section.
     D GenericHeader   DS                  qualified based(GenericHeaderPtr)
     D SizeOfUsrSpc                  10i 0 overlay(GenericHeader:105)
     D OffSetToHeader                10i 0 overlay(GenericHeader:117)
     D OffSetToList                  10i 0 overlay(GenericHeader:125)
     D ListEntryCount                10i 0 overlay(GenericHeader:133)
     D ListEntrySize                 10i 0 overlay(GenericHeader:137)
     D UserSpaceName   s             20a   inz('JCRCMDS   QTEMP     ')
     D ForCount        s             10i 0
      /endif
      /If defined(UserSpaceHeaderDS2)
      //---------------------------------------------------------
      // Get second user space list info from header section.
     D GenericHeader2  DS                  likeds(GenericHeader)
     D                                     based(GenericHeaderPtr2)
     D UserSpacename2  s             20a   inz('JCRCMDS2  QTEMP     ')
     D ForCount2       s             10i 0
      /endif
      /If defined(f_CrtCmdString)
      //---------------------------------------------------------
     Df_CrtCmdString...
     D                 PR           500a   varying
     D                               20a   const                                cmd name and lib
      /endif
      /If defined(f_AddSortKey)
      //---------------------------------------------------------
     Df_AddSortKey     PR            16a
     D                               10i 0 const                                start pos
     D                               10i 0 const                                string size
     D                               10i 0 const  options(*nopass)              data type
     D                               10i 0 const  options(*nopass)              sort order
      /endif
      /If defined(f_BringDataBaseRecords)
      //---------------------------------------------------------
     D f_BringDataBaseRecords...
     D                 PR
     D                               10a   const                                file
     D                               10a   const                                lib
     D                               10a   const                                mbr
     D                               10i 0                                      number of recs
      /endif
      /If defined(f_BuildString)
      //---------------------------------------------------------
     D f_BuildString...
     D                 PR          2048a   opdesc
     D                             2048a   const options(*varsize)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
     D                              100a   const options(*nopass:*varsize:*trim)
      /endif
      /If defined(f_Centertext)
      //---------------------------------------------------------
     D f_CenterText...
     D                 PR           100a   opdesc
     D                              100a   const  options(*varsize)
     D                                3u 0 const  options(*nopass)
      /endif
      /If defined(f_CheckMbr)
      //---------------------------------------------------------
     D f_CheckMbr      PR
     D                               20a   const                                file and lib
     D                               10a   const                                mbr
      /endif
      /If defined(f_CheckObj)
      //---------------------------------------------------------
      // validate Object exists
     D f_CheckObj      PR
     D                               20a   const                                object and lib
     D                               10a   const                                object type
      /endif
      /If defined(f_GetDayName)
      //---------------------------------------------------------
     D f_GetDayName    PR             9a
     D                                 d   const options(*nopass)
      /endif
      /If defined(f_MondaysDate)
      //---------------------------------------------------------
     D f_MondaysDate...
     D                 PR              d
     D                                 d   const options(*nopass)
      /endif
      /If defined(f_DayOfWeekNumber)
      //---------------------------------------------------------
     D f_DayOfWeekNumber...
     D                 PR             3u 0
     D                                 d   const
      /endif
      /If defined(f_DecodeApiTimeStamp)
      //---------------------------------------------------------
     D f_DecodeApiTimeStamp...
     D                 PR            16a                                        api time stamp ds
     D                                8a                                        api date stamp
      /endif
      /If defined(f_DelayJobSeconds)
      //---------------------------------------------------------
     D f_DelayJobSeconds...
     D                 PR
     D                                5u 0 const                                seconds to delay
      /endif
      /If defined(f_DltOvr)
      //---------------------------------------------------------
     D f_DltOvr        PR
     D                               10a   const                                spooled file
      /endif
      /If defined(f_DspLastSplf)
      //---------------------------------------------------------
     D f_DspLastSplf   PR                                                       display last splf
     D                               10a   const                                program name
     D                                8a   const                                * or *PRINT
      /endif
      /If defined(f_DupFileToQtemp)
      //---------------------------------------------------------
     D f_DupFileToQtemp...
     D                 PR
     D                               10a   const                                file name
     D                               10a   const                                library name
     D                                1a   const options(*nopass)               override (Y N)
      /endif
      /If defined(f_RunOptionFile)
      //---------------------------------------------------------
     D f_RunOptionFile...
     D                 PR
     D                                1p 0 const                                option selected
     D                               10a   const                                file
     D                               10a   const                                lib
     D                               10a   const                                record format
     D                               10a   const                                member
     D                               10a                                        program id
      /endif
      /If defined(f_RunOptionJob)
      //---------------------------------------------------------
     D f_RunOptionJob...
     D                 PR
     D                                1p 0                                      option selected
     D                               10a                                        job name
     D                               10a                                        User Name
     D                                6a                                        job number
     D                               10a                                        program id
      /endif
      /If defined(f_RunOptionObject)
      //---------------------------------------------------------
     D f_RunOptionObject...
     D                 PR
     D                                1p 0                                      option selected
     D                               10a                                        Object Name
     D                               10a                                        Object Lib
     D                               10a                                        Object type
     D                               10a                                        program id
      /endif
      /If defined(f_RunOptionSplf)
      //---------------------------------------------------------
     D f_RunOptionSplf...
     D                 PR
     D                                1a                                        option selected
     D                               10a                                        spool file name
     D                                6a                                        spool file number
     D                               10a                                        job name
     D                               10a                                        User Name
     D                                6a                                        job number
     D                               60a                                        email address
     D                               10a                                        program id

 2b  D IsSndSplf       s               n
 2b  D IsEsend         s               n
 2b  D IsOneTime       s               n   inz(*on)
     D EmailAddr       s             60a
     D oE              c                   const('E=ESndMail   ')
     D oS              c                   const('S=SndSplf  ')
     D o2              c                   const('2=Change  ')
     D o3              c                   const('3=Hold   ')
     D o4              c                   const('4=Delete   ')
     D o5              c                   const('5=Display')
      /endif
      /If defined(f_RunDBUtility)
      //---------------------------------------------------------
     D f_RunDBUtility...
     D                 PR            60a                                        Execution string
     D                               21a                                        Lib/File
     D                               10a   const                                Member
      /endif
      /If defined(f_FakeEditWord)
      //---------------------------------------------------------
     D f_FakeEditWord...
     D                 PR            28a   opdesc
     D                              288a   options(*varsize)                    date/time format
     D                                1a   const                                date or time
      /endif
      /If defined(f_GetCardFace)
      //---------------------------------------------------------
     D f_GetCardFace   PR             2a
     D                                3u 0
      /endif
      /If defined(f_GetCardColor)
      //---------------------------------------------------------
     D f_GetCardColor  PR             1a                                        hex color attribute
     D                                1a                                        suite (H D C S)
      /endif
      /If defined(f_GetRowColumn)
      //---------------------------------------------------------
     D f_GetRowColumn  PR             6a
     D                               10a   const                                field name
     D                               10a                                        file
     D                               10a                                        lib
     D                               10a                                        record format
     D CsrRowColDS     DS
     D  CsrRow                        3s 0 inz
     D  CsrCol                        3s 0 inz
      /endif
      /If defined(f_GetApiISO)
      //---------------------------------------------------------
     D f_GetApiISO     PR            10a                                        return ISO from api
     D                               13a   const
      /endif
      /If defined(f_GetFileUtil)
      //---------------------------------------------------------
     D f_GetFileUtil...
     D                 PR             6a                                        Set DBU,DFU,WRKDB
      /endif
      /If defined(f_GetQual)
      //---------------------------------------------------------
     D f_GetQual       PR            21a
     D                               20a   const                                name and lib
     D ExtIfile        s             21a
     D ExtOFile        s             21a
      /endif
      /If defined(f_GetRandom)
      //---------------------------------------------------------
     D f_GetRandom     PR             3u 0
     D                                3u 0 const                                upper limit value
      /endif
      /If defined(f_GetApiHMS)
      //---------------------------------------------------------
     D f_GetApiHMS     PR             8a                                        from 13 digit api
     D                               13a
      /endif
      /If defined(f_IsValidMbr)
      //---------------------------------------------------------
     D f_IsValidMbr    PR              n
     D                               10a   const                                file
     D                               10a   const                                lib
     D                               10a   const options(*nopass)               mbr
      /endif
      /If defined(f_IsValidMbrType)
      //---------------------------------------------------------
     D f_IsValidMbrType...
     D                 PR              n
     D                               20a                                        file and lib
     D                               10a   const                                mbr
     D                               10a   const                                mbr type 1
     D                               10a   const  options(*nopass)              mbr type 2
     D                               10a   const  options(*nopass)              mbr type 3
     D                               10a   const  options(*nopass)              mbr type 4
      /endif
      /If defined(f_IsValidObj)
      //---------------------------------------------------------
     D f_IsValidObj    PR              n
     D                               10a   const                                object
     D                               10a   const                                library
     D                               10a   const                                object type
      /endif
      /If defined(f_OutFileAddPfm)
      //---------------------------------------------------------
     D f_OutFileAddPfm...
     D                 PR
     D                               20a   const                                new file qual
     D                               10a   const                                new mbr
     D                                8a   const                                mbr type
     D                               50a   const options(*nopass)               mbr text
     D                               20a   const options(*nopass)               org file qual
     D                               10a   const options(*nopass)               org mbr
      /endif
      /If defined(f_OutFileCrtDupObj)
      //---------------------------------------------------------
     D f_OutFileCrtDupObj...
     D                 PR
     D                               20a   const                                out file and lib
     D                               22a   const                                mbr options
     D                               10a   const                                from object
      /endif
      /If defined(f_OvrPrtf)
      //---------------------------------------------------------
     D f_OvrPrtf       PR
     D                               10a   const                                spooled file
     D                               10a   const options(*omit)                 outq
     D                               10a   const options(*nopass)               usrdta
      /endif
      /If defined(f_ParmListCount)
      //---------------------------------------------------------
     D f_ParmListCount...
     D                 PR             5u 0
     D                                2a
      /endif
      /If defined(f_Pgm)
      //---------------------------------------------------------
     D f_Pgm           PR          4096a
     D                               10a   const                                program
     D                               10a   const                                lib
     D                              256a   const options(*nopass)               parm 1 to 10
     D                              256a   const options(*nopass)
     D                              256a   const options(*nopass)
     D                              256a   const options(*nopass)
     D                              256a   const options(*nopass)
     D                              256a   const options(*nopass)
     D                              256a   const options(*nopass)
     D                              256a   const options(*nopass)
     D                              256a   const options(*nopass)
     D                              256a   const options(*nopass)
      /endif
      /If defined(f_Quscrtus)
      //---------------------------------------------------------
     D f_Quscrtus      PR              *
     D                               20a                                        user space
      /endif
      /If defined(f_Qmhrcvpm)
      //---------------------------------------------------------
     D f_Qmhrcvpm      PR            75a                                        receive program msg
     D                               10i 0 const                                call stack counter
      /endif
      /If defined(f_Qusrmbrd)
      //---------------------------------------------------------
     D f_Qusrmbrd      PR           256                                         retrieve mbr desc
     D                               20a   const                                file and lib
     D                               10a   const                                mbr
     D                                8a   const                                api format
     D QusrmbrdDS      DS           256    qualified inz
     D File                          10a   overlay(QusrmbrdDS:9)
     D Lib                           10a   overlay(QusrmbrdDS:19)
     D Mbr                           10a   overlay(QusrmbrdDS:29)
     D Attribute                     10a   overlay(QusrmbrdDS:39)
     D MbrType                       10a   overlay(QusrmbrdDS:49)
     D CreateDateTime                13a   overlay(QusrmbrdDS:59)
     D Text                          50a   overlay(QusrmbrdDS:85)
     D IsSrcPF                         n   overlay(QusrmbrdDS:135)
     D CurrNumberRecs                10i 0 overlay(QusrmbrdDS:141)
     D DeletedRecs                   10i 0 overlay(QusrmbrdDS:145)
     D SizeOfData                    10i 0 overlay(QusrmbrdDS:149)
     D SizeOfPath                    10i 0 overlay(QusrmbrdDS:153)
     D ChangeDateTime                13a   overlay(QusrmbrdDS:161)
     D SaveDateTime                  13a   overlay(QusrmbrdDS:174)
     DRestoreDateTime                13a   overlay(QusrmbrdDS:187)
     D LastUseCount                  10i 0 overlay(QusrmbrdDS:213)
     DLastUseDateTime                13a   overlay(QusrmbrdDS:217)
     D SizeOfDataMLT                 10i 0 overlay(QusrmbrdDS:233)
     D SizeOfPathMLT                 10i 0 overlay(QusrmbrdDS:237)
     D Ccsid                         10i 0 overlay(QusrmbrdDS:241)
      /endif
      /If defined(f_Qusrobjd)
      //---------------------------------------------------------
     D f_Qusrobjd      PR           480                                         retrieve object desc
     D                               20a   const                                object and lib
     D                               10a   const                                oblect type
     D                                8a   const options(*nopass)               api format
     D QusrObjDS       DS                  qualified inz
     D ObjNam                        10a   overlay(QusrObjDS:9)
     D Lib                           10a   overlay(QusrObjDS:19)
     D ReturnLib                     10a   overlay(QusrObjDS:39)
     D ExtendedAttr                  10a   overlay(QusrObjDS:91)
     D CreateDateTime                13a   overlay(QusrObjDS:65)
     D ChangeDateTime                13a   overlay(QusrObjDS:78)
     D Text                          50a   overlay(QusrObjDS:101)
     D SrcFile                       10a   overlay(QusrObjDS:151)
     D SrcLib                        10a   overlay(QusrObjDS:161)
     D SrcMbr                        10a   overlay(QusrObjDS:171)
     D SaveDateTime                  13a   overlay(QusrObjDS:194)
     DRestoreDateTime                13a   overlay(QusrObjDS:207)
     D CreatedByUser                 10a   overlay(QusrObjDS:220)
     D LastUsedDate                   7a   overlay(QusrObjDS:461)               cyymmdd format
     D NumDaysUsed                   10i 0 overlay(QusrObjDS:469)
     D ObjSize                       10i 0 overlay(QusrObjDS:473)
     D MultiplySize                  10i 0 overlay(QusrObjDS:477)
      /endif
      /If defined(f_RmvSflMsg)
      //---------------------------------------------------------
     D f_RmvSflMsg     PR
     D                               10a   const                                program name
      /endif
      /If defined(f_RtvMsgAPI)
      //---------------------------------------------------------
     D f_RtvMsgAPI     PR           232a                                        retrieve messages
     D                                7a   const                                message id
     D                              112a                                        replace value
     D                               20a   const options(*nopass)               msg file qual
      /endif
      /If defined(f_SbmJob)
      //---------------------------------------------------------
     D f_SbmJob        PR
     D                             4096a   options(*varsize) const              program info
     D                               10a   const options(*nopass)               jobq
     D                               10a   const options(*nopass)               jobd
      /endif
      /If defined(f_ShuffleDeck)
      //---------------------------------------------------------
     D f_ShuffleDeck   PR             2a   dim(52)
      /endif
      /If defined(f_SndCompMsg)
      //---------------------------------------------------------
     D f_SndCompMsg...
     D                 PR
     D                               75a   const                                message text
      /endif
      /If defined(f_SndEscapeMsg)
      //---------------------------------------------------------
     D f_SndEscapeMsg  PR                                                       send error message
     D                               75a   value
      /endif
      /If defined(f_SndSflMsg)
      //---------------------------------------------------------
     D f_SndSflMsg     PR
     D                               10a   const                                program name
     D                               75a   const                                msg text
     D                                7a   const   options(*nopass)             msg id
     D                               10a   const   options(*nopass)             msg file
     D                               10a   const   options(*nopass)             msg lib
      /endif
      /If defined(f_SndStatMsg)
      //---------------------------------------------------------
     D f_SndStatMsg...
     D                 PR
     D                               75a   const                                message text
      /endif
      /If defined(f_System)
      //---------------------------------------------------------
     D f_System        PR                  opdesc                               cl command processor
     D                             2048a   const options(*varsize)
      /endif
      /If defined(f_BlankCommentsCL)
      //---------------------------------------------------------
     D f_BlankCommentsCL...
     D                 PR           100a
     D                              100a   const
      /endif
      //---------------------------------------------------------
      /If defined(p_JCRBNDR)
      /If defined(p_JCRBNDRV)
     D p_JCRBNDRV      PR                  extpgm('JCRBNDRV')
      /else
     D p_JCRBNDR       PR                  extpgm('JCRBNDR')
      /endif
     D                               20a                                        object and lib
     D                               10a                                        object type
     D                                8a                                        output type
     D                               20a                                        outfile and lib
     D                               22a                                        mbropt
      /endif
      /If defined(p_JCRCALLR)
      //---------------------------------------------------------
      /If defined(p_JCRCALLRV)
     D p_JCRCALLRV     PR                  extpgm('JCRCALLRV')
      /else
     D p_JCRCALLR      PR                  extpgm('JCRCALLR')
      /endif
     D                               20a                                        program and lib
     D                               10a                                        src file
     D                               10a                                        src lib
     D                               10a                                        src mbr
     D                               10a                                        program attributes
      /endif
      /If defined(p_JCRDUMPR3)
      //---------------------------------------------------------
     D p_JCRDUMPR3     PR                  extpgm('JCRDUMPR3')                  display program
     D                               10a   const                                program
     D                               10a   const                                library
     D                               10a   const                                outq
     D                                 n                                        refresh
      /endif
      /If defined(p_JCRFFDR)
      //---------------------------------------------------------
      /If defined(p_JCRFFDRV)
     D p_JCRFFDRV      PR                  extpgm('JCRFFDRV')
      /else
     D p_JCRFFDR       PR                  extpgm('JCRFFDR')
      /endif
     D                               20a                                        file and lib
     D                               10a                                        record format name
     D                                4a                                        unpack format?
     D                                8a                                        *print or *outfile
     D                               20a                                        outfile and lib
     D                               22a                                        mbr option
      /endif
      /If defined(p_JCRGETFLDR)
      //---------------------------------------------------------
     D p_JCRGETFLDR    PR                  extpgm('JCRGETFLDR')
     D                               20a   const                                src file and lib
     D                               10a                                        src mbr
     D                                2a                                        severity
     D DiagSeverity    s              2a
      /endif
      /If defined(p_JCRGETCLPR)
      //---------------------------------------------------------
     D p_JCRGETCLPR    PR                  extpgm('JCRGETCLPR')
     D                               20a   const                                src file and lib
     D                               10a                                        src mbr
     D                                2a                                        severity
      /endif
      /If defined(p_JCRFDMBRR)
      //---------------------------------------------------------
     D p_JCRFDMBRR     PR                  extpgm('JCRFDMBRR')
     D                               20a
      /endif
      /If defined(p_JCRJOBIOR)
      //---------------------------------------------------------
     D p_JCRJOBIOR     PR                  extpgm('JCRJOBIOR')
     D                               10a
     D                               10a
     D                                6a
      /endif
      /If defined(p_JCRSUBRR2)
      //---------------------------------------------------------
     D p_JCRSUBRR2     PR                  extpgm('JCRSUBRR2')
     D                               10a                                        src mbr
     D                               20a                                        src file and lib
      /endif
