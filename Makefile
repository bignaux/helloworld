APP_NAME = helloworld

EE_BIN_PKD = $(APP_NAME).elf
EE_BIN = $(APP_NAME)-UNC.elf
EE_OBJS = $(APP_NAME).o
EE_LIBS = -ldebug -lc
EE_INCS = -DAPP_NAME=\"$(APP_NAME)\"

#PS2HOSTNAME = 192.168.1.10

# Enable debug mode
ifeq ($(DEBUG),1)
IOP_CFLAGS += -DDEBUG
EE_OBJS += udptty.o
endif

BIN2S = $(PS2SDK)/bin/bin2s

$(EE_BIN_PKD): $(EE_BIN)
	ps2-packer $< $@

udptty.s: $(PS2SDK)/iop/irx/udptty.irx
	$(BIN2S) $< $@ udptty_irx

all: $(EE_BIN_PKD)

clean:
	rm -f $(EE_BIN) $(EE_BIN_PKD) $(EE_OBJS)

run: $(EE_BIN)
	ps2client -h $(PS2HOSTNAME) execee host:$(EE_BIN)

reset:
	ps2client reset

format:
	find . -type f -a \( -iname \*.h -o -iname \*.c \) | xargs clang-format -i

include $(PS2SDK)/samples/Makefile.pref
include $(PS2SDK)/samples/Makefile.eeglobal
