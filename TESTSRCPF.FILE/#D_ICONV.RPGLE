      *-----------Iconv APIs and types---------------------------
     D/COPY QSYSINC/QRPGLESRC,QTQICONV
      *
     D IConvOpen       Pr                  extproc('QtqIconvOpen')
     D                                     LIKEDS(iconv_t)
     D  fromcode                       *   value
     D  tocode                         *   value
     D IConv           Pr            10U 0 extproc('iconv')
     D  cd                                 VALUE LIKEDS(iconv_t)
     D  inbuf                          *   VALUE
     D  inbytesleft                    *   VALUE
     D  outbuf                         *   VALUE
     D  outbytesleft                   *   VALUE
     D IconvClose      Pr            10I 0 extproc('iconv_close')
     D  cd                                 LIKEDS(iconv_t)
     D iconv_t         Ds                  INZ
     D  t_return_v                   10I 0
     D  t_cd_arrary                  10I 0 Dim(12)
