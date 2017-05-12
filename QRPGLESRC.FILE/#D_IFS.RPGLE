     */COPY QSYSINC/QRPGLESRC,SYSSTAT
     */COPY QSYSINC/QRPGLESRC,UNISTD
     D CI_IFSCCSID     S             10I 0 INZ(1208)
      *------------- Standar C I/O for file members-----------
     D fopen           PR              *   extproc('fopen')
     D   filename                      *   VALUE OPTIONS(*STRING)
     D   mode                          *   VALUE OPTIONS(*STRING)

     D fclose          PR            10I 0 extproc('fclose')
     D   FileD                         *   VALUE

     D feof            PR            10I 0 extproc('feof')
     D   FileD                         *   VALUE

     D fflush          PR            10I 0 extproc('fflush')
     D   FileD                         *   VALUE

     D fgets           PR              *   extproc('fgets')
     D   buf                           *   value
     D   nbyte                       10U 0 value
     D   fildes                        *   value

     D fputs           PR            10I 0 extproc('fputs')
     D   buf                           *   value OPTIONS(*STRING)
     D   fildes                        *   value

     D fseek           PR            10I 0 extproc('fseek')
     D   fildes                        *   value
     D   len                         10I 0 value
     D   type                        10I 0 value

     D fread           PR            10I 0 extproc('fread')
     D   buf                           *   value
     D   size                        10I 0 value
     D   count                       10I 0 value
     D   fildes                        *   value

     D fwrite          PR            10I 0 extproc('fwrite')
     D   buf                           *   value
     D   size                        10I 0 value
     D   count                       10I 0 value
     D   fildes                        *   value
      *------------- C record I/O for file member ------------
     D FR_open         PR              *   extproc('_Ropen')
     D   filename                      *   VALUE OPTIONS(*STRING)
     D   mode                          *   VALUE OPTIONS(*STRING)
     D FR_close        PR            10I 0 extproc('_Rclose')
     D   FileD                         *   VALUE
     D FR_readn        PR              *   extproc('_Rreadn')
     D   fildes                        *   value
     D   buf                           *   value
     D   size                        10I 0 value
     D   count                       10I 0 value
     D FR_DFT          C                   CONST(X'0B000100')
     D FR_RIOFB_T      DS
     D  key                            *
     D  sysparm                        *
     D  rrn                          10U 0
     D  num_bytes                    10I 0
     D  blk_count                     5I 0
     D  blk_filled_by                 1A
     D  dup_key                      10I 0
     D  icf_locate                   10I 0
     D  reserved1                    10I 0
     D  reserved2                    20A
      *
      *
     D FR_write        PR              *   extproc('_Rwrite')
     D   fildes                        *   value
     D   buf                           *   value
     D   size                        10I 0 value

      *------------- C I/O for IFS----------------------------
      * IFS operations now
     D IFS_fopen       PR              *   extproc('_C_IFS_fopen')
     D   filename                      *   VALUE OPTIONS(*STRING)
     D   mode                          *   VALUE OPTIONS(*STRING)

     D IFS_fclose      PR            10I 0 extproc('_C_IFS_fclose')
     D   FileD                         *   VALUE

     D IFS_feof        PR            10I 0 extproc('_C_IFS_feof')
     D   FileD                         *   VALUE

     D IFS_fflush      PR            10I 0 extproc('_C_IFS_fflush')
     D   FileD                         *   VALUE

     D IFS_fgets       PR              *   extproc('_C_IFS_fgets')
     D   buf                           *   value
     D   nbyte                       10U 0 value
     D   fildes                        *   value

     D IFS_fputs       PR            10I 0 extproc('_C_IFS_fputs')
     D   buf                           *   value OPTIONS(*STRING)
     D   fildes                        *   value

     D IFS_fseek       PR            10I 0 extproc('_C_IFS_fseek')
     D   fildes                        *   value
     D   len                         10I 0 value
     D   type                        10I 0 value

     D IFS_fread       PR            10I 0 extproc('_C_IFS_fread')
     D   buf                           *   value
     D   size                        10I 0 value
     D   count                       10I 0 value
     D   fildes                        *   value

     D IFS_fwrite      PR            10I 0 extproc('_C_IFS_fwrite')
     D   buf                           *   value
     D   size                        10I 0 value
     D   count                       10I 0 value
     D   fildes                        *   value

     D IFSFILE_T       DS
     D  bufptr                         *
     D  countIn                      10I 0
     D  countOut                     10I 0
     D  fcbgetc                        *
     D  fcbputc                        *
     D  stdfile                        *
      * IFS folder APIs
     D opendir         PR              *   extproc('opendir')
     D   dirname                       *   VALUE OPTIONS(*STRING)
     D readdir         PR              *   extproc('readdir')
     D   DIR                           *   VALUE

     D closedir        PR            10I 0 extproc('closedir')
     D   DIR                           *   VALUE
     D dirent_t        DS                  qualified
     D   d_reserved1                 16
     D   d_fileno_gid                10U 0
     D   d_fileno                    10U 0
     D   d_reclen                    10U 0
     D   d_reserved3                 10I 0
     D   d_reserved4                  8
     D   d_nlsinfo                         likeds(qlg_nls_t)
     D   d_namelen                   10U 0
     D   d_name                     640
      *
      *------------- PASE/QSHELL environment variable operations-
     D getenv          Pr              *   ExtProc( 'getenv')
     D  VarName                        *   VALUE OPTIONS(*STRING)
     D putenv          Pr            10I 0 ExtProc( 'putenv' )
     D  VarString                      *   VALUE OPTIONS(*STRING)
