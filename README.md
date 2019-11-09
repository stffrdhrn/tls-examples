# TLS Examples

These are a collection of source files and a makefile to build different code
patterns to generate TLS access methods.

 - Global Dynamic
 - Local Dynamic
 - Initial Exec
 - Local Exec

These examples were created in conjunction with my TLS documentation.

## Building

To build just use:

```
# this will build using or1k-smh-linux-gnu-
make
```

To build with a different cross toolchain to:

```
# this will build using the system default toolchain
make CROSS_COMPILE=
```

## Testing

The tls example build will also generate executable binaries which can be run and 
should return `0` if they work correctly.  This can be used as a crude test
suite for TLS handling.  Using a more complete test suite like that found in
[glibc](https://sourceware.org/git/?p=glibc.git;a=tree;f=elf;h=546aa5c82ffa0ba7076c43cb8272339b704fb900;hb=HEAD)
is recommended, but this can get you off the ground.

```
$ make check
$ cat test-results.out

Running tls-gd-dynamic...
ok
Running tls-ld-dynamic...
ok
Running nontls-dynamic...
ok
Running tls-le-static...
ok
Running tls-ie-static...
ok
Running nontls-static...
ok
```

## Cleaning up

Like most makefiles we also provide a way to cleanup with `clean`.

```
make clean
```
