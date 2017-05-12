#include <stdio.h>
#include <qshell.h>
#include <sys/wait.h>
#include <errno.h>
#include <fcntl.h>
#include <stdlib.h>

/* NOTE: You may want to include exception and/or cancel
         handlers to clean up the descriptors that are
         opened. */

int main(int argc, char *argv[])
{
  char *command;
  char *shellCommand;
  char *filename;
  int status;
  char envbuf[50];
  char oldvalue;
  char *value;
  int fd0 = -1;
  int fd1 = -1;
  int fd2 = -1;
    int rc;
  char bufstdout[2048];

  /* Set the command and the name of the output file. */
  switch (argc) {
    case 1:
      command = "ls";
      filename = "/dev/null";
      break;
    case 2:
      command = argv[1];
      filename = "/dev/null";
      break;
    default:
      command = argv[1];
      filename = argv[2];
  }

  /* Make sure the standard descriptors are allocated in
     this process. */
  if (fcntl(0, F_GETFL) == -1) {
    fd0 = open("/dev/null", O_RDONLY);
    if (fd0 == -1) {
      printf("Error %d opening file /dev/null\n", errno);
    }
  }
  if (fcntl(1, F_GETFL) == -1) {
    fd1 = open(filename, O_WRONLY|O_CREAT|O_TRUNC, S_IRWXU);
    if (fd1 == -1) {
      fprintf(stderr, "Error %d opening file %s\n", errno, filename);
    }
  }

  if (fcntl(2, F_GETFL) == -1) {
    fd2 = open(filename, O_WRONLY|O_CREAT|O_TRUNC, S_IRWXU);
    if (fd2 == -1) {
      fprintf(stderr, "Error %d opening file %s\n", errno, filename);
    }
  }

  shellCommand = (char *)malloc(strlen(command) * sizeof(char));
  strcpy(shellCommand, command);
  shellCommand = strtok(shellCommand, " ");

  /* Verify the user has access to the specified command. */
  if (QzshCheckShellCommand(shellCommand, NULL) == 0) {
    /* Run the specified command while saving and restoring the value of
       the QIBM_USE_DESCRIPTOR_STDIO environment variable. */
    if ((value = getenv("QIBM_USE_DESCRIPTOR_STDIO")) != NULL) {
      oldvalue = *value;
    }
    else {
      oldvalue = 'N';
    }
    putenv("QIBM_USE_DESCRIPTOR_STDIO=I");
    status = QzshSystem(command);
    sprintf(envbuf, "QIBM_USE_DESCRIPTOR_STDIO=%c", oldvalue);
    putenv(envbuf);

    /* Check the results of the command. */
    if (WIFEXITED(status)) {
      printf("Command %s completed with exit status %d.\n",
             command, WEXITSTATUS(status));
    }
    else if (WIFSIGNALED(status)) {
      printf("Command %s ended with signal %d.\n",
             command, WTERMSIG(status));
    }
    else if (WIFEXCEPTION(status)) {
      printf("Command %s ended with exception.\n", command);
    }
    rc = read(1, bufstdout, sizeof(bufstdout));
    printf ("stdout: %s \n", bufstdout);
	}
	else
    printf("Error %d finding command %s\n", errno, command);

  if (fd0 != -1) {
    close(fd0);
  }
  if (fd1 != -1) {
    close(fd1);
  }
  if (fd2 != -1) {
    close(fd2);
  }

  exit(0);
}
