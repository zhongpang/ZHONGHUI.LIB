     D iconv_t         DS                  Qualified INZ
     D  rtn_value                    10I 0
     D  cd                           10I 0 Dim(12)
     D QtqCode_T       DS                  Qualified
     D  CCSID                        10I 0 Inz(0)
     D  CvtAlt                       10I 0 Inz(0)
     D  SubAlt                       10I 0 Inz(0)
     D  ShiftState                   10I 0 Inz(1)
     D  InLenOpt                     10I 0 Inz(0)
     D  MixDataErrorOpt...
     D                               10I 0 Inz(0)
     D  Reserved                      8A   Inz(*ALLX'00')
     D QtqIConvOpen    PR                  ExtProc('QtqIconvOpen')
     D                                     LikeDS(iconv_T)
     D  toCCSID                            LikeDS(QtqCode_T)
     D  fromCCSID                          LikeDS(QtqCode_T)
     D iconv           PR            10U 0 ExtProc('iconv')
     D  hConv                              LikeDS(iconv_t) VALUE
     D  pInBuff                        *   VALUE
     D  nInLen                         *   VALUE
     D  pOutBuff                       *   VALUE
     D  nOutLen                        *   VALUE
     D iconv_close     PR            10I 0 ExtProc('iconv_close')
     D  hConv                              LikeDS(iconv_t) VALUE
      *
     D fromCCSID       DS                  LikeDS(QtqCode_T)
     D                                     Inz(*LIKEDS)
     D toCCSID         DS                  LikeDS(QtqCode_T)
     D                                     Inz(*LIKEDS)
     D hConv           DS                  LikeDS(iconv_T)
     D                                     Inz(*LIKEDS)
      *
     D MyData          S             30A   Inz('ABCD测试123')
     D pData           S               *   Inz
     D ppData          S               *   Inz(%addr(pData))
     D nInLen          S             10I 0
     D nOutLen         S             10I 0
     D rc              S             10U 0

      /free
       fromCCSID.CCSID = 0;
       toCCSID.CCSID = 1208;
       hConv = *ALLX'00';
       hConv = QtqIconvOpen(toCCSID:fromCCSID);
      /end-free

     C                   eval      nInLen = %len(%TrimR(mydata))
     C                   eval      nOutLen = %size(mydata)
     C                   eval      pData = %addr(myData)
     C                   eval      rc=iconv(hConv : ppData : %addr(nInLen):
     C                               ppData:%addr(nOutLen))
     C                   callp     iconv_close(hConv)
     c                   eval      *inlr = *on
     C                   RETURN
     C
     C

