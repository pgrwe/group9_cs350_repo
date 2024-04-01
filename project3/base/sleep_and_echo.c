#include "types.h"
#include "user.h"

#ifndef SECS
#define SECS 3
#endif

#ifndef STDERR
#define STDERR 2
#endif

int main(int argc, char ** argv)
{
    int i = 0;

    sleep(SECS*100);

    printf(STDERR, "sne PID=%d: ", getpid());

    for (i = 1; i < argc ; i++)
    {
        printf(STDERR, "%s ", argv[i]);
    }

    if (argc > 1)
        printf(STDERR, "\n");

    exit();
}
