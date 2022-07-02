APP_NAME := helloworld
APP_VERSION := $(shell git describe --always --tags)
DEBUG = 1
TEST = 1

EE_BIN_PKD = $(APP_NAME).elf
EE_BIN = $(APP_NAME)-UNC.elf
EE_OBJS = $(APP_NAME).o $PS2_WORKSPACE/libtap/tap.o
EE_LIBS = -ldebug -lc
EE_CFLAGS += -DAPP_VERSION=\"$(APP_VERSION)\" -DAPP_NAME=\"$(APP_NAME)\"
EE_INCS += -I$PS2_WORKSPACE/libtap
BIN2S = $(PS2SDK)/bin/bin2s

# Using -include preprocessor option let you write plateform specific code
# without modify library source code.
EE_CFLAGS += -include ps2log.h

# default goal should be first target
# read https://www.gnu.org/software/make/manual/html_node/Goals.html
all: $(EE_BIN_PKD)

mostlyclean:
	rm -f $(EE_BIN) $(EE_BIN_PKD) $(EE_OBJS)

clean: mostlyclean
	$(MAKE) clean -C $(PS2_WORKSPACE)/libtap -f Makefile.PS2

# Enable debug mode
ifeq ($(DEBUG),1)
IOP_CFLAGS += -DDEBUG
EE_CFLAGS += -DDEBUG
#EE_OBJS += udptty.o
endif

# Enable test mode
ifeq ($(TEST),1)
EE_CFLAGS += -DTEST
#EE_OBJS += tap.o
endif

tap.o:
	$(MAKE) $@ -C $(PS2_WORKSPACE)/libs/libtap -f Makefile.PS2

$(EE_BIN): ps2log.h

$(EE_BIN_PKD): $(EE_BIN)
	ps2-packer $< $@ > /dev/null

# TODO ; find another module to illustrate
udptty.s: $(PS2SDK)/iop/irx/udptty.irx
	$(BIN2S) $< $@ udptty_irx

run: $(EE_BIN)
	ps2client execee host:$(EE_BIN_PKD)

reset:
	ps2client reset

# hackish but let you check/format same way both CI and your own env.
# and manage .clang-format-ignore file properly.
cfla = $(PS2_WORKSPACE)/tools/clang-format-lint-action
check:
	@python3 $(cfla)/run-clang-format.py --clang-format-executable $(cfla)/clang-format/clang-format14 -r .

format:
	#find . -path "$PS2_WORKSPACE/*" -prune -regex '.*\.\(c\|h\)' -o -exec clang-format -i {} \;
	@python3 $(cfla)/run-clang-format.py --clang-format-executable $(cfla)/clang-format/clang-format14 -r . -i true

include $(PS2SDK)/samples/Makefile.pref
include $(PS2SDK)/samples/Makefile.eeglobal
