     H/COPY #PUB_H
     D/COPY #PUB_D
     D/COPY #IFS_D
      *
     D dird1           S               *
     D ptrdirent1      S               *
     D dirent1         DS                  likeds(dirent_t)
     D                                     based(ptrdirent1)
     D dird2           S               *
     D ptrdirent2      S               *
     D dirent2         DS                  likeds(dirent_t)
     D                                     based(ptrdirent2)
     D va_objname1     S            640
     D va_objname2     S            640
     D va_dirname2     S            640
     D rc              S             10I 0
     D fd              S               *
     D ptrdata         S               *
     D rddata          S           2048A
     D rddata2ccsid    S           2048A
     D flags           S             10U 0
     D mode            S             10U 0
     D ErrMsg          S            250A
     D Len             S             10I 0
     D*--------------------------------------------------------------------
     D mypath          S            128A
     D mydir           S            128A   INZ('/QSYS.LIB/ZHONGHUI.LIB')
     D*mypath          C                   const('ZHONGHUI.LIB/TEXT.DESC')
     D*mypath          C                   const('ZHONGHUI.LIB/QPGMSRC.FILE-
     D*                                    /GITOPT.CLLE')
     D*mypath          C                   CONST('/a.c')
      *
     c                   eval      rc = mkdir('DIRTEST':750)
     c                   if        rc <> 0
     c                   callp     #SendErrMsg('mkdir()')
     c                   endif
      * Read a dir
     c                   eval      dird1= opendir(%trim(mydir) + x'00')
     c                   if        dird1= *NULL
     c                   callp     #SendErrMsg('opendir()')
     C                   GOTO      L_END
     c                   endif
     c                   dow       1=1
     c                   eval      ptrdirent1= readdir(dird1)
     c                   if        ptrdirent1= *NULL
     c                   leave
     c                   endif
      *found a file or subdir
     C                   eval      va_objname1= %subst(dirent1.d_name
     c                                      :1
     c                                      :dirent1.d_namelen )
     c                   callp     #SendMsg('>' + %trim(va_objname1 ))
     c
     c                   if        %scan('.FILE': va_objname1) <=0
     c                   iter
     c                   endif
      *found a subdir
     c                   eval      va_dirname2 = %trim(mydir) + '/'
     c                                     +%trim(va_objname1)
     c                   eval      dird2= opendir(%trim(va_dirname2)+x'00')
     c                   if        dird2= *NULL
     c                   callp     #SendErrMsg('opendir()')
     C                   iter
     c                   endif
     c                   dow       2=2
     c                   eval      ptrdirent2= readdir(dird2)
     c                   if        ptrdirent2= *NULL
     c                   leave
     c                   endif
      *found a file or subdir
     C                   eval      va_objname2= %subst(dirent2.d_name
     c                                      :1
     c                                      :dirent2.d_namelen )
      *found a file
     c                   callp     #SendMsg('>>'+ %trim(va_objname2))
     c
     c                   enddo
     c                   eval      rc=closedir(dird2)
     c                   if        rc <> 0
     c                   callp     #SendErrMsg('closedir()')
     c                   endif
      *
     c                   enddo
     c                   eval      rc=closedir(dird1)
     c                   if        rc <> 0
     c                   callp     #SendErrMsg('closedir()')
     c                   endif
     C
      *
     c                   eval      mypath ='TEXT.DESC' + X'00'
     c                   eval      fd = fopen(mypath:
     c                                      'r+, o_ccsid = 1208')
     c                   if        fd = *NULL
     c                   callp     #SendErrMsg('fopen()')
     C                   GOTO      L_END
     c                   endif
     C                   Eval      len=0
     C                   dow       1=1
     c                   eval      rddata  = *blank
     c                   eval      ptrdata = fgets(%addr(rddata):%size(rddata):
     c                                            fd )
     c                   if        ptrdata = *NULL
     c                   callp     #SendErrMsg('fget()')
     C                   leave
     c                   endif
      *Remove the CR char
     C*                  eval      rddata = %subst(rddata:1
     c*                            :%len(%trimr(rddata)) - 2)
     C                   eval      rddata2ccsid = *blank
     C                   eval      rddata2ccsid =
     C                                     iconv2CCSID(rddata:1208: 0 )
     c                   if        %SCAN('hello':rddata2ccsid) > 0
     c                   leave
     c                   endif
     c                   callp     #SendMsg(rddata2ccsid)
     C                   eval      len = len + %len(%trimr(rddata))
      *
     C                   enddo
      *
      *Set to the 1st  record
     C                   eval      rc = fseek(fd: len: SEEK_SET)
     c                   if        rc <> 0
     c                   callp     #SendErrMsg('fseek()')
     c                   endif
      *
     c                   eval      rddata = 'mayiloveyou' + X'25' + X'00'
     C                   eval      rddata2ccsid =
     C                                     iconv2CCSID(rddata:0   :1208)
     c                   eval      rc = fputs(
     c                                   rddata2ccsid
     c                                   :fd)
     c                   callp     #SendErrMsg('fputs()')
     c                   if        1 = 2
     c                   eval      rc = fflush(fd)
     c                   if        rc <> 0
     c                   callp     #SendErrMsg('fflush()')
     c                   endif
     c                   endif

     C                   goto      L_END
      *
     C     L_END         TAG
     c                   callp     fclose(fd)
     c                   callp     #SendErrMsg('fclose()')

     c                   eval      *inlr = *on
     C                   RETURN
     C
     C

     C/COPY #PUB_PRC
