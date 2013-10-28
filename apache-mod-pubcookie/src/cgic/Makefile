#    $Id: Makefile.in,v 1.4 2004/06/16 17:26:30 fox Exp $

#You may wish to add -DNO_UNISTD and -DNO_SYSTEM to CFLAGS if
#your system lacks the /usr/include/unistd.h header file
#or the system() function, respectively. Non-unix systems
#will also definitely have different linker syntax.

srcdir=.
builddir=.

# potential flags CGICDEBUG
CPPFLAGS=-D_FORTIFY_SOURCE=2 -I/usr/include/openssl -DHAVE_CONFIG_H 
CFLAGS=-g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Wformat-security -Werror=format-security $(CPPFLAGS)
LIBS=-lssl -lcrypto -ldl -lnsl  -lgcc 
LDFLAGS=-Wl,-Bsymbolic-functions -Wl,-z,relro -L/usr/lib/gcc/x86_64-linux-gnu/4.6 $(LIBS)

CC=gcc
AR=/usr/bin/ar
RANLIB=/usr/bin/ranlib
CGICLIBS=-L. -lcgic $(LDFLAGS)
FORCE_RM=/bin/rm -f

all: libcgic.a cgictest capture

libcgic.a: cgic.o $(srcdir)/cgic.h
	rm -f libcgic.a
	$(AR) rc libcgic.a cgic.o
	$(RANLIB) libcgic.a

cgictest: cgictest.o libcgic.a 
	$(CC) $(CFLAGS) cgictest.o -o cgictest ${CGICLIBS}

tmp: $(srcdir)/tmp.c
	cc -o tmp -I. $(srcdir)/tmp.c $(CGICLIBS)

capture: capture.o libcgic.a
	$(CC) $(CFLAGS) capture.o -o capture ${CGICLIBS}

clean:
	$(FORCE_RM) *.o *.a cgictest capture

distclean:
	$(FORCE_RM) Makefile

%.o: $(srcdir)/%.c $(builddir)/Makefile
	$(CC) $(CFLAGS) -c $<

DISTDIR=cgic1.07-pubcookie1.01
TARFILE=cgic1.07-pubcookie1.01.tar

tar:
	rm -f ${DISTDIR} ${TARFILE}.gz
	ln -s . ${DISTDIR}
	tar -cf ${TARFILE} \
		${DISTDIR}/CHANGES \
		${DISTDIR}/Makefile \
		${DISTDIR}/capture.c \
		${DISTDIR}/cgic.c \
		${DISTDIR}/cgic.c.orig \
		${DISTDIR}/cgic.h \
		${DISTDIR}/cgic.h.orig \
		${DISTDIR}/cgic.html \
		${DISTDIR}/cgic.txt \
		${DISTDIR}/cgictest.c \
		${DISTDIR}/license.txt \
		${DISTDIR}/readme.txt \
		${DISTDIR}/support.txt \
		${DISTDIR}/testform.html 
	gzip ${TARFILE}
	rm -f ${DISTDIR}
