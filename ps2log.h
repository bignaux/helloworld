/******************************************************************
 *
 * @file log.h
 *
 * @author   Ronan Bignaux <ronan@aimao.org>
 *
 * @brief    a way to unify logging macros in PS2 software
 *
 * @url
 *
 * Copyright (c) Ronan Bignaux. 2022
 *
 ********************************************************************/

#ifndef __PS2LOG_H__
#define __PS2LOG_H__

/* default user setting

 #define MODNAME PAD
 #define LOG_PRINTF ioPrintf

*/

/* output setting */

#ifndef LOG_PRINTF
#ifdef EESIO_DEBUG
#include <sio.h>
#define LOG_INIT()  sio_init(38400, 0, 0, 0, 0)
#define LOG_PRINTF sio_printf
#elif defined(SCREEN_DEBUG)
#define _LOG_NO_COLOR 1 /* TODO: scr_printf() color/bold support */
#include <debug.h>
#define LOG_INIT()  init_scr();
#define LOG_PRINTF scr_printf
#elif defined(DEBUG)
#include <stdio.h>
#define LOG_INIT() \
    do {           \
    } while (0)
#define LOG_PRINTF printf
#endif
#endif
/* TODO: log in FILE ? */

/* color setting */

#define __LOG_COLOR_BLACK  "0;30"
#define __LOG_COLOR_RED    "0;31"
#define __LOG_COLOR_GREEN  "0;32"
#define __LOG_COLOR_YELLOW "0;33"
#define __LOG_COLOR_BLUE   "0;34"
#define __LOG_COLOR_PURPLE "0;35"
#define __LOG_COLOR_CYAN   "0;36"
#define __LOG_COLOR_WHITE  "0;37"

#define __LOG_IOP_COLOR __LOG_COLOR_WHITE
#define __LOG_EE_COLOR  __LOG_COLOR_BLUE

#ifdef _IOP
#define LOG_COLOR __LOG_IOP_COLOR
#else
#define LOG_COLOR __LOG_EE_COLOR
#endif

/* CONTEXT setting */

#ifdef MODNAME
#define APP_NAME MODNAME
#elif !defined(APP_NAME)
#define APP_NAME __FILE__
#endif

// #ifdef DEBUG
// #ifdef FULLDEBUG
// #define CONTEXT "[%s:%s:%i] " APP_NAME __FILE__ __LINE__
// #else

#define CONTEXT APP_NAME
// #endif // FULLDEBUG
// #endif // DEBUG

/* format setting */

// see https://github.com/kuroidoruido/ColorLog/blob/master/colorlog.h

#ifdef _LOG_NO_COLOR
#define __LOG_COLOR(CLR, CTX, TXT, args...) LOG_PRINTF("[%s]\t" TXT, CTX, ##args)
#else
#define __LOG_COLOR(CLR, CTX, TXT, args...) LOG_PRINTF("\033[%sm[%s]\033[m\t" TXT, CLR, CTX, ##args)
#endif

#ifdef LOG_PRINTF
#define LOG(TXT, args...) __LOG_COLOR(LOG_COLOR, CONTEXT, TXT, ##args)
#else
#define LOG_INIT() \
    do {           \
    } while (0)
#define LOG(...) \
    do {         \
    } while (0)
#endif

/* catch already defined macros */

// #define dbgprintf LOG
// #define M_PRINTF LOG
// #define DEBUG_PRINTF LOG
// #define dprintf LOG
// #define dbgscr_printf LOG
// #define DINIT   LOG_INIT
// #define DPRINTF LOG
/* TODO : try to catch printf */
/* does udptty catch stderr ? */
/* check ioPrintf(__VA_ARGS__) */

#endif /* __PS2LOG_H__ */
