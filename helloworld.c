#include <stdio.h>
#include <tamtypes.h>
// #include <sifrpc.h>
#include <debug.h>
#include <unistd.h>
#include <kernel.h>

#define LOG(format, args...) \
    printf(APP_NAME ": " format, ##args)

int main(int argc, char *argv[])
{
    // SifInitRpc(0);
    LOG("#%d Argument \n", argc);

    for (int i = 0; i < argc; i++) {
        LOG("Argument #%d is %s\n", i, argv[i]);
    }

    init_scr();
    scr_printf("Hello, World from %s v.%s !\n", APP_NAME, APP_VERSION);

    SleepThread();
    return 0;
}
