CFLAGS ?= 
CFLAGS += -Iinclude -I/usr/include/python3.7m
LDFLAGS ?= -lpython3.7m
PREFIX ?= /usr

LDFLAGS += -rpath $(PREFIX)/lib

LIBRARIES = 
PROGRAMS = DiscordianDate

DiscordianDate_OBJS = DiscordianDate.lo

CC = libtool --mode=compile gcc $(CFLAGS)
LD = libtool --mode=link gcc $(LDFLAGS)

.PHONY: all install clean

all: $(LIBRARIES:=.la) $(PROGRAMS)

depfiles = $($(LIBRARIES)_OBJS:.lo=.d) $($(PROGRAMS)_OBJS:.lo=.d)
libmkfiles = $(LIBRARIES:=.mk)
promkfiles = $(PROGRAMS:=.mk)

include $(depfiles)
include $(libmkfiles)
include $(promkfiles)

$(depfiles):
	touch $@

$(libmkfiles):
	echo '$(@:.mk=.la): $$($(@:.mk=)_OBJS) $$($(@:.mk=)_LIBS)' > $@
	echo '	$$(LD) -o $$@ $$($(@:.mk=)_OBJS) $$($(@:.mk=)_LIBS)' >> $@

$(promkfiles):
	echo '$(@:.mk=): $$($(@:.mk=)_OBJS) $$($(@:.mk=)_LIBS)' > $@
	echo '	$$(LD) -o $$@ $$($(@:.mk=)_OBJS) $$($(@:.mk=)_LIBS)' >> $@


%.lo: %.c
	$(CC) -MT $@ -MMD -MP -MF $*.d -c -o $@ $<

%.c: %.py
	cython --embed-positions --line-directives --embed -3 \
                --capi-reexport-cincludes $<

install: $(PROGRAMS) $(LIBRARIES:=.la)
	install -d -m755 $(PREFIX)/bin
	install -d -m755 $(PREFIX)/lib
	libtool --mode=install install -m644 $(LIBRARIES:=.la) $(PREFIX)/lib
	libtool --mode=install install -m755 $(PROGRAMS) $(PREFIX)/bin
	libtool --finish $(PREFIX)/lib

clean:
	libtool --mode=clean rm -rf $(depfiles)
	libtool --mode=clean rm -rf $(libmkfiles)
	libtool --mode=clean rm -rf $(promkfiles)
	libtool --mode=clean rm -rf $($(LIBRARIES)_OBJS)
	libtool --mode=clean rm -rf $($(LIBRARIES)_OBJS:.lo=.o)
	libtool --mode=clean rm -rf $(LIBRARIES:=.la)
	libtool --mode=clean rm -rf $($(PROGRAMS)_OBJS)
	libtool --mode=clean rm -rf $($(PROGRAMS)_OBJS:.lo=.o)
	libtool --mode=clean rm -rf $(PROGRAMS)


