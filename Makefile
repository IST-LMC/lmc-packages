# Our package versions, format is <upstream>-<cybera_revision>
PUBCOOKIE_VERSION=3.3.4a-0
IPCAST_VERSION=1.1-0
THROTTLE_VERSION=1.0-0

# General configuration
INSTALL_DIR=/tmp/install
DEB_DIR=deb
DEPENDENCIES_DIR=dependencies

# Pubcookie configuration
PUBCOOKIE_DIR=apache-mod-pubcookie
PUBCOOKIE_MAKEFILE=$(PUBCOOKIE_DIR)/Makefile
APXS2_BIN=/usr/bin/apxs2

# Vmod configuration
VARNISH_VERSION=3.0.5 # apt-get source varnish
VARNISH_DIR=$(DEPENDENCIES_DIR)/varnish-$(VARNISH_VERSION)
VARNISH_MAKEFILE=$(VARNISH_DIR)/Makefile
VARNISHTEST_BIN=$(VARNISH_DIR)/bin/varnishtest/varnishtest
PCRE_LIB=/usr/lib/x86_64-linux-gnu/libpcre.so
IPCAST_DIR=libvmod-ipcast
IPCAST_MAKEFILE=$(IPCAST_DIR)/Makefile
THROTTLE_DIR=libvmod-throttle
THROTTLE_MAKEFILE=$(THROTTLE_DIR)/Makefile
VMODDIR=/usr/lib/varnish/vmods

all:ipcast throttle pubcookie

pubcookie:$(PUBCOOKIE_MAKEFILE)
	$(MAKE) -C $(PUBCOOKIE_DIR)
	mkdir $(INSTALL_DIR)
	$(MAKE) -C $(PUBCOOKIE_DIR) install DESTDIR=$(INSTALL_DIR)
	fpm -f -s dir -t deb -n apache-mod-pubcookie -v $(PUBCOOKIE_VERSION) -C $(INSTALL_DIR) -p $(DEB_DIR)/NAME-VERSION_ARCH.deb -d "libssl1.0.0" -d "apache2-api-20120211" usr
	rm -rf $(INSTALL_DIR)
	
$(PUBCOOKIE_MAKEFILE):$(APXS2_BIN)
	cd $(PUBCOOKIE_DIR) && ./configure --enable-apache --prefix=/usr/local/pubcookie --with-apxs=$(APXS2_BIN)

$(APXS2_BIN):
	sudo apt-get install apache2-dev -y

ipcast:$(IPCAST_MAKEFILE) 
	$(MAKE) -C $(IPCAST_DIR)
	mkdir $(INSTALL_DIR)
	$(MAKE) -C $(IPCAST_DIR) install DESTDIR=$(INSTALL_DIR)
	fpm -f -s dir -t deb -n libvmod-ipcast -v $(IPCAST_VERSION) -C $(INSTALL_DIR) -p $(DEB_DIR)/NAME-VERSION_ARCH.deb -d "varnish (= 3.0.5-2)" usr
	rm -rf $(INSTALL_DIR)

$(IPCAST_MAKEFILE):$(VARNISHTEST_BIN)
	cd $(IPCAST_DIR) && ./autogen.sh && ./configure VARNISHSRC=../$(VARNISH_DIR) VMODDIR=$(VMODDIR)

throttle:$(THROTTLE_MAKEFILE)
	$(MAKE) -C $(THROTTLE_DIR)
	mkdir $(INSTALL_DIR)
	$(MAKE) -C $(THROTTLE_DIR) install DESTDIR=$(INSTALL_DIR)
	fpm -f -s dir -t deb -n libvmod-throttle -v $(THROTTLE_VERSION) -C $(INSTALL_DIR) -p $(DEB_DIR)/NAME-VERSION_ARCH.deb -d "varnish (= 3.0.5-2)" usr
	rm -rf $(INSTALL_DIR)

$(THROTTLE_MAKEFILE):$(VARNISHTEST_BIN)
	cd $(THROTTLE_DIR) && ./autogen.sh && ./configure VARNISHSRC=../$(VARNISH_DIR) VMODDIR=$(VMODDIR)

$(VARNISHTEST_BIN):$(VARNISH_MAKEFILE)
	$(MAKE) -C $(VARNISH_DIR)

$(VARNISH_MAKEFILE):$(PCRE_LIB)
	cd $(VARNISH_DIR) && ./autogen.sh && ./configure

$(PCRE_LIB):
	sudo apt-get install libpcre3-dev -y
