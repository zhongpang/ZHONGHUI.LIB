**FREE
/COPY QSYSINC/QRPGLESRC,UNISTD
/COPY QSYSINC/QRPGLESRC,SYSTYPES
/COPY QSYSINC/QRPGLESRC,ESOEXTPT
//-- Host entry returned pointers --------------------------------

DCL-DS HostEnt                       Qualified;
  h_name                      POINTER;
  h_aliases                   POINTER;
  h_addrtype                  INT(10);
  h_length                    INT(10);
  h_addr_list                 POINTER;
END-DS;
//-- Host entry data ---------------------------------------------

DCL-DS netdb_control_block                    Qualified;
  open_flag                      INT(10);
f0                             POINTER;
  FileP0                         CHAR(260);
  Reserved0                      CHAR(150);
f1                             POINTER;
  FileP1                         CHAR(260);
  Reserved1                      CHAR(150);
F2                             POINTER;
  FileP2                         CHAR(260);
  Reserved2                      CHAR(150);
END-DS;

DCL-DS hostent_data                    Qualified;
  h_name                      CHAR(256);
  h_aliases_arrayp               POINTER Dim(65);
  h_aliases_array                CHAR(256) Dim(64);
  h_addr_arrayp                  POINTER Dim(101);
  h_addr_array                   LIKEDS(in_addr) Dim(100);
  host_control_blk               LIKEDS(netdb_control_block);
END-DS;
//-- in_addr in NETINET.H --------------------------------

//DCL-DS in_addr               Qualified;
//  s_addr                     UNS(10);
//END-DS;
//  QBFC_EXTERN char *            inet_ntoa(struct in_addr);
DCL-PR inet_ntoa                    POINTER  Extproc('inet_ntoa');
  in_addr                          LIKEDS(in_addr) value;
END-PR;

//   struct HostEnt *GetHostByName(char *host_name);
DCL-PR GetHostByName              POINTER  Extproc('gethostbyname');
  HOST_NAME                        POINTER   Value;
END-PR;

//-- TCP/IP interface addresses structure-------------------------

DCL-DS ifa_ifu_union              Template Qualified;
  ifu_broadaddr                  POINTER;
  ifu_dstaddr                    POINTER;
END-DS;


DCL-DS ifaddrs                    Template Qualified;
  ifa_next                       POINTER;
  ifa_name                       POINTER;
  ifa_flags                      UNS(10);
  ifa_addr                       POINTER;
  ifa_netmask                    POINTER;
  ifa_ifu                        LIKEDS(ifa_ifu_union);
  ifa_data                       POINTER;
END-DS;

//   QBFC_EXTERN int getifaddrs(struct ifaddrs **);
DCL-PR getifaddrs                INT(10)  Extproc('getifaddrs');
  ifaddrs                        POINTER   Value;
END-PR;

DCL-S  ServerName           CHAR(30) ;
DCL-S  ServerIP             CHAR(30) Based(PT_ServerIP);
DCL-DS DS_HostEnt           LIKEDS(HostEnt) BASED(PT_HostEnt);
DCL-DS DS_HostEntData       LIKEDS(hostent_data) BASED(PT_HostentData);
DCL-DS DS_in_addr           LIKEDS(in_addr) INZ;
DCL-DS DS_ifaddrs           LIKEDS(ifaddrs) BASED(PT_ifaddrs);
DCL-DS DS_socketaddr        LIKEDS(sockaddr_in) BASED(PT_socketaddr);



// Prepare the host name for the GetHostByName function
gethostname(%ADDR(ServerName): %SIZE(ServerName));

//   Get the host address if given the server name
PT_HOSTENT = GetHostByName(%Addr(ServerName));

//   If host name cannot be resolved - End the client program with dump
If PT_HOSTENT = *NULL;
  #SendMsg('iGit: Gethostbyname error');
  PT_ServerIP = %ADDR(ServerName);
else;
  // Set the pointer to the host entry data structure
  PT_HostEntData = DS_HOSTENT.h_name;

  // Copy the IP address from the host entry structure into
  //   the server IP address structure
  DS_in_addr = DS_HostEntData.h_addr_array(1);
  PT_ServerIP = inet_ntoa(DS_in_addr);
EndIf;
EndIf;

//Replace X'00' with X'40' (Space)
ServerIP = %XLATE(X'00': X'40': ServerIP);
