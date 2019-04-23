ifneq ($(DESTDIR),)
	PREFIX=$(DESTDIR)/usr
else
	ifeq ($(PREFIX),)
		PREFIX :=/usr/local
	endif
endif
ifneq ($(DESTDIR),)
	CONFIGDIR=$(DESTDIR)/etc
else
	CONFIGDIR=/etc
endif
ifeq ($(INSTALL),)
	INSTALL=install
endif
BINDIR := $(PREFIX)/bin
LIBDIR := $(PREFIX)/lib
DATADIR := $(PREFIX)/share
deb:
	@echo "Building Debian Packages"
	@echo "->Generating Changelog from commit log"
	@gbp dch -c -R -D $(lsb_release -c|tr -d '[:blank:]'|cut -d: -f2)
	@echo "->Started Building packages"
	@gbp buildpackage --git-tag --git-retag --git-sign-tags
install:
	$(INSTALL) -m 755 -D folder-thumbnailer $(BINDIR)/folder-thumbnailer
	$(INSTALL) -m 644 -D folder.thumbnailer $(DATADIR)/thumbnailers/folder.thumbnailer
	
