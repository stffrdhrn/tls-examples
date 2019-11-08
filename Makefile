CROSS_COMPILE ?= or1k-smh-linux-gnu-
CFLAGS        = -Wall -O2
CC            = $(CROSS_COMPILE)gcc
OBJDUMP       = $(CROSS_COMPILE)objdump

DYN_SRC       = tls-gd.c \
		tls-ld.c

STATIC_SRC    = tls-le.c \
		tls-ie.c

dyn_objs     := $(patsubst %.c,%-dynamic.o,$(DYN_SRC))
static_objs  := $(patsubst %.c,%-static.o,$(STATIC_SRC))
all_asm      := $(patsubst %.o,%.S,$(dyn_objs) $(static_objs))

all: all_objs $(all_asm)

all_objs: $(dyn_objs) $(static_objs)

%-dynamic.o: %.c
	$(CC) -fpic -c -o $@ $< $(CFLAGS)

%-static.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS)

%.S: %.o
	$(OBJDUMP) -dr $< > $@

clean:
	rm -f *.o $(all_asm)
