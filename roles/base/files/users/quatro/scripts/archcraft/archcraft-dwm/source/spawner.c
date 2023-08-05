#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <limits.h>
#include <unistd.h>

void spawntermcmd() {
    int fds[2];
    if(pipe(fds) == -1) {
        abort();
    }

    int child_pid = fork();
    if(child_pid == -1) {
        abort();
    }

    if(child_pid == 0) {
        close(fds[1]);
        char f[PATH_MAX + 1];
        sprintf(f, "/dev/fd/%d", fds[0]);
        execlp("st", "st", "-e", "cat", f, NULL);
        abort();
    }

    close(fds[0]);
    write(fds[1], "Hi there!\n", sizeof("Hi there!\n"));
    sleep(10);
    close(fds[1]);
    sleep(3);
}
