      * Initilize the product repository on remote Git Server
      *ssh -t zhonghui@9.123.96.23 "git init --bare /home/gitrepo/zh"
     C                   CALLP     #RUNQSH('ssh -t '
     C                              + %TRIM(#A_PRCUSR) + '@'
     C                              + %TRIM(VA_GITSRVNAM) + ' "'
     C                              + 'git init --bare '
     c                              + %TRIM(VA_GITREPOS)
     C                              + '"')
      *git remote add origin ssh://9.123.96.23/home/gitrepo/zh
     C                   CALLP     #RUNQSH('git remote add origin "ssh://'
     C                              + %TRIM(VA_GITSRVNAM)
     c                              + %TRIM(VA_GITREPOS) +'"'
     C                              )
     C                   Exsr      SR_EXIT
      *-------------------------------------------------
      * SR_EXIT
      * Desc: Clern up and exit
      *-------------------------------------------------
     C     SR_EXIT       BEGSR
     C                   callp     IConvclose(iconv_ifs2mbr)
     C                   callp     IConvclose(iconv_mbr2ifs)
     C                   callp     IConvclose(iconv_ifs2job)
     C                   callp     IConvclose(iconv_job2ifs)
      *
     C                   SETON                                          LR
     C                   RETURN
     C                   ENDSR
      *
     C/COPY #PRC_PUB
