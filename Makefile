# Makefile for TLS examples
# Targets:
#  - 'all'   build everything
#  - 'check' run tests
#  - 'clean' delete all build artifacts

CROSS_COMPILE ?= or1k-smh-linux-gnu-
CFLAGS        = -Wall -O2
LDFLAGS       = -Wl,-rpath=. -L.
CC            = $(CROSS_COMPILE)gcc
OBJDUMP       = $(CROSS_COMPILE)objdump

DYN_SRC       = tls-gd.c \
		tls-ld.c \
		nontls.c
STATIC_SRC    = tls-le.c \
		tls-ie.c \
		nontls.c
LIB_SRC       = x.c

dyn_objs     := $(patsubst %.c,%-dynamic.o,$(DYN_SRC) $(LIB_SRC))
static_objs  := $(patsubst %.c,%-static.o,$(STATIC_SRC) $(LIB_SRC))

dyn_exe      := $(patsubst %.c,%-dynamic,$(DYN_SRC))
static_exe   := $(patsubst %.c,%-static,$(STATIC_SRC))

all_exe      := $(dyn_exe) $(static_exe)
all_asm      := $(patsubst %.o,%.S,$(dyn_objs) $(static_objs))
all_results  := $(patsubst %,test-results-%.out,$(all_exe))

all: all_objs all_exe libx.so $(all_asm)

all_exe: $(all_exe)
all_objs: $(dyn_objs) $(static_objs)

## Building object files
%-dynamic.o: %.c
	$(CC) -fpic -c -o $@ $< $(CFLAGS)

%-static.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS)

%.S: %.o
	$(OBJDUMP) -dr $< > $@

## Building shared libs

libx.so: x-dynamic.o
	$(CC) -shared -o $@ $<

## Building executables
tls-gd-dynamic: main.c tls-gd-dynamic.o libx.so
	$(CC) -fpic -o $@ main.c tls-gd-dynamic.o -lx $(CFLAGS) $(LDFLAGS)

tls-ld-dynamic: main-ld.c tls-ld-dynamic.o
	$(CC) -fpic -o $@ $^ $(CFLAGS)

%-dynamic: main.c %-dynamic.o
	$(CC) -fpic -o $@ $^ $(CFLAGS)

tls-ie-static: main.c tls-ie-static.o x-static.o
	$(CC) -static -o $@ $^ $(CFLAGS)

%-static: main.c %-static.o
	$(CC) -static -o $@ $^ $(CFLAGS)

## Test Suite
check: test-results.out

test-results-%.out: %
	echo "Running $<..." > $@
	( ./$< && echo ok || echo ng )  >> $@

test-results.out: $(all_results)
	cat $^ > test-results.out

## Cleanup
clean:
	rm -f *.so *.o *.out $(all_asm) $(all_exe)
