# Our package versions, format is <upstream>-<cybera_revision>
PUBCOOKIE_VERSION=3.3.4a-0
IPCAST_VERSION=1.1-1
THROTTLE_VERSION=1.0-1
POUND_VERSION=2.6.3-1

# General configuration
INSTALL_DIR=/tmp/install
DEB_DIR=deb
DEPENDENCIES_DIR=dependencies

# Pubcookie configuration
PUBCOOKIE_DIR=apache-mod-pubcookie
PUBCOOKIE_MAKEFILE=$(PUBCOOKIE_DIR)/Makefile
APXS2_BIN=/usr/bin/apxs2

# Vmod configuration
VARNISH_VERSION=3.0.5
VARNISH_DIR=$(DEPENDENCIES_DIR)/varnish-$(VARNISH_VERSION)
VARNISH_MAKEFILE=$(VARNISH_DIR)/Makefile
VARNISHTEST_BIN=$(VARNISH_DIR)/bin/varnishtest/varnishtest
VMODDIR=/usr/lib/x86_64-linux-gnu/varnish/vmods
PCRE_LIB=/usr/lib/x86_64-linux-gnu/libpcre.so

# Ipcast configuration
IPCAST_DIR=libvmod-ipcast
IPCAST_MAKEFILE=$(IPCAST_DIR)/Makefile

# Throttle configuration
THROTTLE_DIR=libvmod-throttle
THROTTLE_MAKEFILE=$(THROTTLE_DIR)/Makefile

# Pound configuration
POUND_DIR=pound
POUND_MAKEFILE=$(POUND_DIR)/Makefile

.PHONY:all ipcast throttle pubcookie pound pre-build

all:ipcast throttle pubcookie pound

pre-build:
	-rm -rf $(INSTALL_DIR)
	mkdir $(INSTALL_DIR)

pubcookie:$(PUBCOOKIE_MAKEFILE) pre-build
	$(MAKE) -C $(PUBCOOKIE_DIR)
	$(MAKE) -C $(PUBCOOKIE_DIR) install DESTDIR=$(INSTALL_DIR)
	fpm -f -s dir -t deb -n apache-mod-pubcookie -v $(PUBCOOKIE_VERSION) -C $(INSTALL_DIR) -p $(DEB_DIR)/NAME-VERSION_ARCH.deb -d "libssl1.0.0" -d "apache2-api-20120211" usr
	
$(PUBCOOKIE_MAKEFILE):$(APXS2_BIN)
	cd $(PUBCOOKIE_DIR) && ./configure --enable-apache --prefix=/usr/local/pubcookie --with-apxs=$(APXS2_BIN)

$(APXS2_BIN):
	sudo apt-get install apache2-dev -y

ipcast:$(IPCAST_MAKEFILE) pre-build
	$(MAKE) -C $(IPCAST_DIR)
	$(MAKE) -C $(IPCAST_DIR) install DESTDIR=$(INSTALL_DIR)
	fpm -f -s dir -t deb -n libvmod-ipcast -v $(IPCAST_VERSION) -C $(INSTALL_DIR) -p $(DEB_DIR)/NAME-VERSION_ARCH.deb -d "varnish (= 3.0.5-2)" usr

$(IPCAST_MAKEFILE):$(VARNISHTEST_BIN)
	cd $(IPCAST_DIR) && ./autogen.sh && ./configure VARNISHSRC=../$(VARNISH_DIR) VMODDIR=$(VMODDIR)

throttle:$(THROTTLE_MAKEFILE) pre-build
	$(MAKE) -C $(THROTTLE_DIR)
	$(MAKE) -C $(THROTTLE_DIR) install DESTDIR=$(INSTALL_DIR)
	fpm -f -s dir -t deb -n libvmod-throttle -v $(THROTTLE_VERSION) -C $(INSTALL_DIR) -p $(DEB_DIR)/NAME-VERSION_ARCH.deb -d "varnish (= 3.0.5-2)" usr

$(THROTTLE_MAKEFILE):$(VARNISHTEST_BIN)
	cd $(THROTTLE_DIR) && ./autogen.sh && ./configure VARNISHSRC=../$(VARNISH_DIR) VMODDIR=$(VMODDIR)

$(VARNISHTEST_BIN):$(VARNISH_MAKEFILE)
	$(MAKE) -C $(VARNISH_DIR)

$(VARNISH_MAKEFILE):$(PCRE_LIB)
	cd $(VARNISH_DIR) && ./autogen.sh && ./configure

$(PCRE_LIB):
	sudo apt-get install libpcre3-dev -y

pound:$(POUND_MAKEFILE) pre-build
	$(MAKE) -C $(POUND_DIR)
	$(MAKE) -C $(POUND_DIR) install DESTDIR=$(INSTALL_DIR)
	fpm -f -s dir -t deb -n pound -v $(POUND_VERSION) -C $(INSTALL_DIR) -p $(DEB_DIR)/NAME-VERSION_ARCH.deb -d "libc6 (>= 2.14)" -d "libpcre3" -d "libssl1.0.0 (>= 1.0.0)" usr

$(POUND_MAKEFILE):
	cd $(POUND_DIR) && ./configure
