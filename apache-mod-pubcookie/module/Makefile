# Makefile for Apache2 DSO module
#

builddir     = .

APXS=/usr/bin/apxs2

top_dir      = /usr/share/apache2

top_srcdir   = /usr/share/apache2
top_builddir = /usr/share/apache2

include /usr/share/apache2/build/special.mk


DEFS=-DAPACHE -DAPACHE2 -DHAVE_CONFIG_H
INCLUDES=-I.

all: local-shared-build 

need_slib_clean:	
	@echo ""
	@echo "Before installing the module:"
	@echo " - shutdown any running apache server"
	@echo " - run 'slibclean'"
	@echo ""


clean:	local-clean


