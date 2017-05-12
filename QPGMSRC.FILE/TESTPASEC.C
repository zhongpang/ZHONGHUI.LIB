#include <stdio.h>
#include <stdlib.h>
#include <qp2user.h>
void main()
{
char *pase_pgm="/QOpenSys/bin/ls";
char **args_list;
int rc=0;
args_list=(char **)malloc(3 * sizeof(char *));
args_list[0] = pase_pgm;
args_list[1] = "-l"  ;
args_list[2] = 0;
rc=
Qp2RunPase(pase_pgm, NULL, NULL, 0,1208,args_list,NULL);
printf("rc:%d   \n", rc);
return;
}
