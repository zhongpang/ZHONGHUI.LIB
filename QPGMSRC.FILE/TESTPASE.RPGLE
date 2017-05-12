     HDFTACTGRP(*NO)
     HCVTOPT(*VARCHAR:*VARGRAPHIC:*GRAPHIC)
     HALWNULL(*USRCTL)
     HBNDDIR('QC2LE')
     D iconv2CCSID     PR         32767    Varying
     D IA_INSTRING                32767    varying const
     D IS_CCSIDFRM                    5  0 const
     D IS_CCSIDTO                     5  0 const

     D SNDMSG          PR
     D    msgText                   256A   const
     D errnoPTR        S               *
     D errno           S             10I 0 Based(errnoPTR)
     D strerror        PR              *   ExtProc('strerror')
     D    errnum                     10I 0 value
     D GetErrNo        Pr              *   ExtProc('__errno')

     D fopen           PR              *   extproc('_C_IFS_fopen')
     D   filename                      *   VALUE OPTIONS(*STRING)
     D   mode                          *   VALUE OPTIONS(*STRING)

     D fclose          PR                  extproc('_C_IFS_fopen')
     D   FileD                         *

     D fgets           PR              *   extproc('_C_IFS_fgets')
     D   buf                           *   value
     D   nbyte                       10U 0 value
     D   fildes                        *   value


     D fd              S               *
     D ptrdata         S               *
     D rddata          S           2048A
     D rddata2ccsid    S           2048A
     D flags           S             10U 0
     D mode            S             10U 0
     D ErrMsg          S            250A
     D Len             S             10I 0
     D IFSFILE         DS                  BASED(fd)
     D  bufptr                         *
     D  countIn                      10I 0
     D  countOut                     10I 0
     D  fcbgetc                        *
     D  fcbputc                        *
     D  stdfile                        *
     D*--------------------------------------------------------------------
     D mypath          S            128A
     D*mypath          C                   const('ZHONGHUI.LIB/TEXT.DESC')
     D*mypath          C                   const('ZHONGHUI.LIB/QPGMSRC.FILE-
     D*                                    /GITOPT.CLLE')
     D*mypath          C                   CONST('/a.c')
      *
     D runPASE         PR            10I 0 extproc('Qp2RunPase')
     D  pathname                       *   VALUE OPTIONS(*STRING)
     D  symbolName                     *   VALUE OPTIONS(*STRING)
     D  symbolData                     *   VALUE
     D  symbolDataLen                10U 0 value
     D  ccsid                        10I 0 value
     D  argv                           *   dim(32767)
     D                                     OPTIONS(*VARSIZE) CONST
     D  env                            *   dim(32767)
     D                                     OPTIONS(*VARSIZE) CONST
      *
     D*runShell        PR            10I 0 extproc('Qp2shell2')
     D* pathname                       *   VALUE OPTIONS(*STRING)
     D* argv                           *   dim(256) options(*varsize)
      *
     D  RC             S             10I 0
     D  NULL           S               *   DIM(5 ) INZ(*NULL)
     D  ptr_argv       S               *   DIM(5 )
     D  VA_ARGV1       S            128
     D  VA_ARGV2       S            128
     D  VA_ARGV3       S            128
     D  VA_ARGV4       S            128
     D  VA_ARGV5       S            128
     D  ptr_env        S               *   DIM(5 )
     D  VA_ENV1        S            128
     D  VA_ENV2        S            128
     D  VA_ENV3        S            128
     D  VA_ENV4        S            128
     D  VA_ENV5        S            128
     C                   Eval      ptr_env(1) = %addr(VA_ENV1 )
     C                   Eval      ptr_env(2) = %addr(VA_ENV2 )
     C                   Eval      ptr_env(3) = %addr(VA_ENV3 )
     C                   Eval      ptr_env(4) = %addr(VA_ENV4 )
     C                   Eval      ptr_env(5) = %addr(VA_ENV5 )
     C                   Eval      VA_ENV1    = X'00'
     C                   Eval      VA_ENV2    = X'00'
     C                   Eval      VA_ENV3    = X'00'
     C                   Eval      VA_ENV4    = X'00'
     C                   Eval      VA_ENV5    = X'00'
     C                   Eval      ptr_argv(1)= %addr(VA_ARGV1)
     C                   Eval      ptr_argv(2)= %addr(VA_ARGV2)
     C                   Eval      ptr_argv(3)= %addr(VA_ARGV3)
     C                   Eval      ptr_argv(4)= %addr(VA_ARGV4)
     C                   Eval      ptr_argv(5)= %addr(VA_ARGV5)
     C                   Eval      mypath
     C                             ='/QOpenSys/QIBM/ProdData/OPS/tools/bin/git'
     C                   Eval      VA_ARGV1   = mypath
     C                   Eval      VA_ARGV2   = ' push' + X'00'
     C                   Eval      VA_ARGV3   = X'00'
     C                   Eval      VA_ARGV4   = X'00'
     C                   Eval      VA_ARGV5   = X'00'
     C                   eval      RC = runPASE(mypath
     C                             :*NULL :*NULL
     C                             :0
     C                             :1208
     C                             :ptr_argv
     C                             :ptr_env )
     C                   if        RC <> 0
     c                   eval      errnoptr   = GetErrNo()
     c                   eval      ErrMsg = %str(strerror(errno))
     c                   callp     SNDMSG('runPASE err:' + ErrMsg)
     c                   endif
      *
     C     L_END         TAG
     c                   eval      *inlr = *on
     C                   RETURN
     C
     C

     P SNDMSG          B
     D SNDMSG          PI
     D    IA_MSGTEXT                256A   const
     D/COPY QSYSINC/QRPGLESRC,QUSEC

     D QMHSNDPM        PR                  ExtPgm('QMHSNDPM')
     D   MessageID                    7A   Const
     D   QualMsgF                    20A   Const
     D   MsgData                    256A   Const
     D   MsgDtaLen                   10I 0 Const
     D   MsgType                     10A   Const
     D   CallStkEnt                  10A   Const
     D   CallStkCnt                  10I 0 Const
     D   MessageKey                   4A
     D   ErrorCode                    1A
     D VA_MSGKEY       S              4A   INZ(*BLANK)

     C                   callp     QMHSNDPM('CPF9897'
     C                               : 'QCPFMSG   *LIBL'
     C                               : IA_MSGTEXT: %len(%trimr(IA_MSGTEXT))
     C                               : '*INFO'
     C                               : '*': 3:VA_MSGKEY:QUSEC)
     C                   Return
     P                 E

     P iconv2CCSID     B                   Export
     D                 PI         32767    varying
     D IA_INSTRING                32767    varying const
     D IS_CCSIDFRM                    5  0 const
     D IS_CCSIDTO                     5  0 const

     D/COPY QSYSINC/QRPGLESRC,QTQICONV
     D IConvOpen       Pr            52a   extproc('QtqIconvOpen')
     D  fromcode                       *   value
     D  tocode                         *   value
     D IConv           Pr            10i 0 extproc('iconv')
     D  cd                           52a   value
     D  inbuf                          *
     D  inbytesleft                  10i 0
     D  outbuf                         *
     D  outbytesleft                 10i 0
     D IconvClose      Pr            10i 0 extproc('iconv_close')
     D  cd                           52a   value

     D iconv_t         Ds
     D  t_return_v                   10i 0
     D  t_cd
     D  t_cd_arrary                  10i 0 Dim(12) Overlay(t_cd)

     D fromcode        DS                  likeds(QTQCODE) inz
     D tocode          DS                  likeds(QTQCODE) inz
     D inputPtr        S               *
     D inputLen        S             10I 0
     D outputPtr       S               *
     D outputLen       S             10I 0
     D input           S          32767
     D output          S          32767
     D VI_RC           S             10I 0
      *
     C                   Eval      fromcode.QTQCCSID = IS_CCSIDFRM
     C                   Eval      fromcode.QTQERVED02 = *allx'00'
     C                   Eval      tocode.QTQCCSID = IS_CCSIDTO
     C                   Eval      tocode.QTQERVED02 = *allx'00'
     C                   Eval      iconv_t = IConvOpen(%addr(tocode)
     C                             : %addr(fromcode))
     C                   Eval      input = IA_INSTRING
     C                   Eval      inputPtr = %addr(input)
     C                   Eval      inputlen = %len(%trimr(input))
     C                   Eval      outputPtr = %addr(output)
     C                   Eval      outputLen = %size(output)
     C                   Eval      VI_RC = IConv   (iconv_t :
     C                             inputPtr    : inputlen      :
     C                             outputptr    : outputlen )
     C                   Eval      VI_RC = IconvClose   ( iconv_t )
     C                   Return    %TRIMR(output)
     P                 E
