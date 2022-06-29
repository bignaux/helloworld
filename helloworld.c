#include <stdio.h>
// #include <tamtypes.h>
// #include <sifrpc.h>
#include <debug.h>
#include <unistd.h>
#include <kernel.h>
#include <string.h>
#include <stdlib.h>
#include <tap.h>
#include "ps2log.h"

// demo of strings
// from https://stackoverflow.com/a/4681415
char *join_strings(char *strings[], char *seperator, int count)
{
    char *str = NULL;        /* Pointer to the joined strings  */
    size_t total_length = 0; /* Total length of joined strings */
    int i = 0;               /* Loop counter                   */

    /* Find total length of joined strings */
    for (i = 0; i < count; i++)
        total_length += strlen(strings[i]);
    total_length++;                                  /* For joined string terminator */
    total_length += strlen(seperator) * (count - 1); // for seperators

    str = (char *)malloc(total_length); /* Allocate memory for joined strings */
    str[0] = '\0';                      /* Empty string we can append to      */

    /* Append all the strings */
    for (i = 0; i < count; i++) {
        strcat(str, strings[i]);
        if (i < (count - 1))
            strcat(str, seperator);
    }

    return str;
}

static void printWelcomeInfo(int argc, char **argv)
{
    char *cmdline;
    LOG("version: %s\n", APP_VERSION);
    cmdline = join_strings(argv, " ", argc);
    LOG("cmdline: %s\n", cmdline);
    free(cmdline);
}

int main(int argc, char *argv[])
{
    // SifInitRpc(0);
    LOG_INIT();

    printWelcomeInfo(argc, argv);
    plan(5);
    is(argv[0], "host:helloworld.elf", "running from ps2link");

    init_scr();
    uint64_t index;
   index = 0;
   while (index < 99999999)
   {
     index++;
     // LOG("Hello, World fr00000m %s v.%s !\n", APP_NAME, APP_VERSION);

      printf("Hello world %i\n", index);
   }

    SleepThread();
    return 0;
}
