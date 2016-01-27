# Our package versions, format is <upstream>-<cybera_revision>
PUBCOOKIE_VERSION=3.3.4a-0
LMC_PYTHON_VERSION=1.4.0

# General configuration
INSTALL_DIR=/tmp/install
DEB_DIR=deb

# Pubcookie configuration
PUBCOOKIE_DIR=apache-mod-pubcookie
PUBCOOKIE_MAKEFILE=$(PUBCOOKIE_DIR)/Makefile
APXS2_BIN=/usr/bin/apxs2

# lmc-python configuration
LMC_PYTHON_DIR=lmc-python-lib
LMC_PYTHON_INSTALL_SCRIPT=$(LMC_PYTHON_DIR)/vagrant/scripts/rebuild-virtualenv.sh
LMC_PYTHON_INSTALL_DIR=/usr/local
LMC_PYTHON_PREFIX=/opt

.PHONY:all pubcookie lmc-python pre-build

all:pubcookie lmc-python

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

lmc-python:
	sudo $(LMC_PYTHON_INSTALL_SCRIPT)
	fpm -f -s dir -t deb -n lmc-python -v $(LMC_PYTHON_VERSION) -C $(LMC_PYTHON_INSTALL_DIR) -p $(DEB_DIR)/NAME-VERSION_ARCH.deb -d "libssl1.0.0" -d "libffi6" --prefix $(LMC_PYTHON_PREFIX) lmc-python
