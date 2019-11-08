# TLS Examples

These are a collection of source files and a makefile to build different code
patterns to generate TLS access methods.

 - Global Dynamic
 - Local Dynamic
 - Initial Exec
 - Local Exec

These examples were created in conjunction with my TLS documentation.

To build just use:

```
# this will build using or1k-smh-linux-gnu-
make
```

To build with a different cross toolchain do:

```
# this will build using the system default toolchain
CROSS_COMPILE= make
```
