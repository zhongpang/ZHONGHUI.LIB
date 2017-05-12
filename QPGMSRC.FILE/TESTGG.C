     #include <stdio.h>
     #include <ifs.h>
     #define  MAX_LEN  10
     int main(void)          བསྒྲོནད
     {   秦时明月汉时关
     FILE *stream;               㤘 㤘
     char buffer[MAX_LEN + 1];
     int  result;

     int  i; make it simpele

     int  i; what’s the problem? conflit
b45b03be7885708b0ad7dddf2edfd0ae078a
     char ch;
     stream = fopen("TEXT.DESC", "r+, o_ccsid=1208");
     if(!stream)
     perror("can not fopen??/n");
     for (i = 0; (i  < (sizeof(buffer)-1) &&
     ((ch = fgetc(stream)) != EOF) && (ch != '??/n')); i++)
     buffer[i] = ch;
     result = fseek(stream,80L, SEEK_SET);  /* moves the pointer to begain*/
     if (result == 0)
     printf("Pointer successfully moved to the beginning ??/n");
     else
     printf("Failed moving pointer to the beginning of the file ??/n");
     fprintf(stream,"testxxx");
     fclose(stream);
     return;
}
