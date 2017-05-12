      *-----------Send program message---------------------------
     D #QCMDEXC        PR                  Extpgm('QCMDEXC')
     D   CmdString                  512A   Const
     D   CmdLenth                    15P 5 Const
     D QMHSNDPM        PR                  Extpgm('QMHSNDPM')
     D   MessageID                    7A   Const
     D   QualMsgF                    20A   Const
     D   MsgData                    256A   Const
     D   MsgDtaLen                   10I 0 Const
     D   MsgType                     10A   Const
     D   CallStkEnt                  10A   Const
     D   CallStkCnt                  10I 0 Const
     D   MessageKey                   4A
     D   ErrorCode                    1A
     D#QUSROBJD        PR                  Extpgm('QUSROBJD')
     D   BufFormat                         LIKEDS(QUSD0400)
     D   Buflen                       4B 0 Const
     D   FormatID                     8A   Const
     D   ObjectName                  20A   Const
     D   ObjectType                  10A   Const
     D   Errmsg                            LIKEDS(QUSEC)
     D#QDBRTVFD        PR                  Extpgm('QDBRTVFD')
     D   VA_TMPSTR                12768A
     D   QDBQ63_SIZE                  9B 0 Const
     D   OUT_FILNAME                 20A   Const
     D   FORMAT                       8A   Const
     D   FILE_NAME                   20A   Const
     D   FMT_NAME                    10A   Const
     D   OVERRIDES                    1A   Const
     D   SYSTEM                      10A   Const
     D   FORMAT_1                    10A   CONST
     D   QUSEC                             LIKEDS(QUSEC)
     D#QUSRMBRD        PR                  Extpgm('QUSRMBRD')
     D   BUFDATA                           LIKEDS(QUSM0200)
     D   BUFLen                       4B 0 Const
     D   FORMAT                       8A   Const
     D   FILE_NAME                   20A   Const
     D   MBR_NAME                    10A   Const
     D   OVERRIDES                    1A   CONST
     D   QUSEC                             LIKEDS(QUSEC)
     D#QSYRUSRI        PR                  Extpgm('QSYRUSRI')
     D   BUFSTRING                 2048A
     D   BUFLEN                       9B 0 Const
     D   FORMAT                       8A   Const
     D   USERNAME                    10A   Const
     D   QUSEC                             LIKEDS(QUSEC)
      *-----------Error handling --------------------------------
     D strerror        PR              *   ExtProc('strerror')
     D    errnum                     10I 0 value
     D GetErrNo        Pr              *   ExtProc('__errno')
     D errnoPTR        S               *
     D errno           S             10I 0 Based(errnoPTR)
     D ErrMsg          S            250A
