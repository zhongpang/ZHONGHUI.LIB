#include <stdio.h>
#include <stdlib.h>
#include <qp2user.h>         test112
void main() 秦时明月汉时关 yyyy xxx
{
char *pase_pgm="/QOpenSys/usr/bin/env";
char **args_list;
args_list=(char **)malloc(2 * sizeof(char *));
args_list[0] = pase_pgm;
args_list[1] = 0;
Qp2RunPase(pase_pgm, NULL, NULL, 0,1208,args_list,NULL);
return;
}
