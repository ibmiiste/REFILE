# REFILE
Cross-Reference Your Procedures

April 28, 2004 Bruce Guetzkow

[The code for this article is available for download.]

With the advent of procedures, it has become much simpler for iSeries programmers to write reusable snippets of code. But keeping track of those snippets is a bit more involved. Since a source member can contain multiple procedures, how do you know which procedures are found in which modules and where they are used? If you have the *MODULE objects, from IBM, you have the tools to answer those questions. With the code provided in this article, you can create your own procedure cross-reference files and commands.

THE PRELIMINARIES

Before we can load the cross-reference files, we must first create them. Instead of using DDS and the Create Physical File (CRTPF) command to build the files, we’ll use the Display Module (DSPMOD) command. This command will be used in the cross-reference load process, described below, so this will ensure that the files have the correct format. To create the files, select any module on your system and execute the following commands:

DSPMOD MODULE(library/module)
       DETAIL(*EXPORT)
       OUTPUT(*OUTFILE)
       OUTFILE(library/PRCWHRFNDP)

DSPMOD MODULE(library/module)
       DETAIL(*IMPORT)
       OUTPUT(*OUTFILE)
       OUTFILE(library/PRCWHRUSDP)

The module used in creating the cross-reference files doesn’t matter. This is done for the sole purpose of creating the physical file objects. When you run the cross-reference load program it will clear the files and load information from all modules that you specify.

Next, create logical files over the physical files, using the DDS provided, and PRCWHRFNDL and PRCWHRUSDL respectively, as well as the following commands:

CRTLF FILE(library/PRCWHRFNDL)
      SRCFILE(library/QDDSSRC)
      SRCMBR(PRCWHRFNDL)
       
CRTLF FILE(library/PRCWHRUSDL)
      SRCFILE(library/QDDSSRC)
      SRCMBR(PRCWHRUSDL)

LOADING THE CROSS-REFERENCE FILES

The program LODPRCXRFC is used to load the cross-reference files from information stored in the module objects. Remember, you must have the module (*MODULE) objects for this process to work. The program begins by clearing the physical files we created above. It then uses the Display Object Description (DSPOBJD) command to create a temporary file containing a list of all modules that you want to cross-reference. The first instance of the DSPOBJD command loads a temporary file with modules from the first library that you want included. The second instance adds modules from a second library and should be repeated for third and subsequent libraries, if needed. You will need to modify this part of the program according to the number of libraries you want included in the cross-reference.

After the temporary file is loaded, it is then read to end-of-file and the DSPMOD commands are executed for each module to load the cross-reference files. Specifying DETAIL(*EXPORT) loads file PRCWHRFNDP, with “where found” references indicating the module containing the specified procedure; DETAIL(*IMPORT) loads file PRCWHRUSDP, with “where used” references indicating modules that call the specified procedure. Duplicate entries are then removed from the cross-reference files, and they are reorganized.

I’ve chosen to use SQL statements to remove the duplicates by way of the Start Query Management Query (STRQMQRY) command. Query Management Query (QMQRY) is a way to execute SQL statements even if you don’t have SQL loaded on your system. It also can be used with variables, as I will explain later. If you have never used a QMQRY, you will need to create the source file for your SQL statements, as follows:

CRTSRCPF FILE(library/QQMQRYSRC)
         RCDLEN(91)

It is important to set the record length to 91 when creating the source physical file, instead of the command default of 92, because QMQRY requires a statement length of no more than 79 characters. If the record length is greater than 91, your SQL statements will not run.

The QMQRY objects can be created using the following commands:

CRTQMQRY QMQRY(library/RMVWHRFNDQ)
         SRCFILE(library/QQMQRYSRC)
         SRCMBR(*QMQRY)

CRTQMQRY QMQRY(library/RMVWHRUSDQ)
         SRCFILE(library/QQMQRYSRC)
         SRCMBR(*QMQRY)

To create the CLLE program, use this command:

CRTBNDCL PGM(library/LODPRCXRFC)
         SRCFILE(library/QCLLESRC)
         SRCMBR(LODPRCXRFC)

I run the LODPRCXRFC program daily to make sure that it is always up to date, using the Add Job Schedule Entry (ADDJOBSCDE) command:

ADDJOBSCDE JOB(LODPRCXRF)
           CMD(CALL PGM(LODPRCXRFC))
           FRQ(*WEEKLY)
           SCDDATE(*NONE)
           SCDDAY(*MON *TUE *WED *THU *FRI)
           SCDTIME(050000)
           JOBD(library/jobd)
           JOBQ(library/jobq)
           USER(*CURRENT)
           MSGQ(*USRPRF)
           TEXT('Load Procedure Cross-Reference')

The above command schedules a call to program LODPRCXRFC to run Monday through Friday at 5:00 a.m. You will need to modify this command based on your needs and practices.

USING THE CROSS-REFERENCE

I’ve created two commands to make use of the cross-reference: Procedure Where Found (PRCWHRFND) and Procedure Where Used (PRCWHRUSD). Command PRCWHRFND returns a list of modules that contain the procedure indicated, while command PRCWHRUSD returns a list of modules that use the procedure. Both commands have the same parameter list: Procedure lists the full or partial procedure name. Wildcard indicates if and how a wildcard is to be used with the procedure name. Output indicates whether the result is to be displayed or printed.

The command processing programs (PRCWHRFNDC and PRCWHRUSDC) are nearly identical, and the logic is quite simple. The wildcard parameter is used to append the percent sign (%) as needed to the procedure name. If you are familiar with Query/400, you will recognize the percent sign as the wildcard used in the “select records” option for test condition “LIKE,” identifying a text pattern to search for. A condition value is also set, based on this parameter. These values are used to run another QMQRY (PRCWHRFNDQ or PRCWHRUSDQ) to present the results. Here is where the strength of QMQRY comes into play.

Let’s examine QMQRY PRCWHRFNDQ. If you are familiar with SQL, you will notice that it merely selects three fields from logical file PRCWHRFNDL, but the WHERE statement seems to be missing something. It is missing the condition (equals, less than, etc.) and something to compare to. In their places are two parameters: &COND and &PATTERN. These parts of the WHERE statement are constructed in the CLLE program and are passed to the QMQRY as parameters on the STRQMQRY command. Here is an example to illustrate how this works.

Suppose we execute the following command:

PRCWHRFND PROCEDURE(OPEN) 
          WILDCARD(*AFTER) 
          OUTPUT(*)

Because parameter WILDCARD contains *AFTER, program PRCWHRFNDC builds fields &COND and &PROCEDURE with the values like and OPEN% respectively. When passed to the QMQRY, the WHERE statement becomes:

where trim(exsynm) like 'OPEN%'

When the QMQRY is executed, this will return a list of all modules containing procedure names that begin with OPEN, such as OPEN_CUSTOMER_MASTER, OPEN_INVOICE_HEADER, or OPEN_INVOICE_DETAIL.

The commands needed to create these objects are:

CRTCMD CMD(library/PRCWHRFND)
       PGM(*LIBL/PRCWHRFNDC)
       SRCFILE(library/QCMDSRC)
       SRCMBR(PRCWHRFND)

CRTCMD CMD(library/PRCWHRUSD)
       PGM(*LIBL/PRCWHRUSDC)
       SRCFILE(library/QCMDSRC)
       SRCMBR(PRCWHRFND)

CRTQMQRY QMQRY(library/PRCWHRFNDQ)
         SRCFILE(library/QQMQRYSRC)
         SRCMBR(*QMQRY)

CRTQMQRY QMQRY(library/PRCWHRUSDQ)
         SRCFILE(library/QQMQRYSRC)
         SRCMBR(*QMQRY)

CRTBNDCL PGM(library/PRCWHRFNDC)
         SRCFILE(library/QCLLESRC)
         SRCMBR(PRCWHRFNDC)

CRTBNDCL PGM(library/PRCWHRFNDC)
         SRCFILE(library/QCLLESRC)
         SRCMBR(PRCWHRFNDC)

A POINT TO CONSIDER

I chose to use QMQRY to present the results of the command inquiries because it was a lot less effort than writing RPG programs, display files, etc. You will have to decide if running these commands interactively will have a negative impact on your system, as executing QMQRY interactively is the equivalent of running Query/400 interactively. Depending on the frequency with which you execute the commands and the resources available on your system, you could cause your system performance to degrade. Submitting the command to batch will alleviate the problem and will generate a report regardless of the value specified for the OUTPUT parameter. To force these commands to run in batch only, add the following parameter to the CRTCMD commands:

ALLOW(*BATCH *BPGM)

That’s all there is to it. I find these commands invaluable for impact analysis or just for finding examples of how a procedure is used. I hope you will find them useful as well.

Bruce Guetzkow has programmed on the AS/400 and iSeries since 1990, in manufacturing, distribution and other industries. He is currently the IS director at United Credit Service in Elkhorn, Wisconsin. E-mail: bguetzkow@itjungle.com 
