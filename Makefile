ifneq ($(DESTDIR),)
	prefix:=$(DESTDIR)/usr
else
	ifeq ($(prefix),)
		prefix :=/usr/local
	endif
endif
ifeq ($(INSTALL),)
	INSTALL=install
endif
DIST :=$(shell lsb_release -c|tr -d '[:blank:]'|cut -d: -f2)
all:
	@echo "Run \`make install\` to install."
deb:
	@echo "Building Debian Packages"
	@echo "->Generating Changelog from commit log"
	@gbp dch -c -R -D $(DIST)
	@echo "->Started Building packages"
	@gbp buildpackage --git-tag --git-retag --git-sign-tags
install:
	$(INSTALL) -m 755 -D folder-thumbnailer $(prefix)/bin/folder-thumbnailer
	$(INSTALL) -m 644 -D folder.thumbnailer $(prefix)/share/thumbnailers/folder.thumbnailer
	$(INSTALL) -m 644 -D folder-thumbnailer.1 $(prefix)/share/man/man1/folder-thumbnailer.1
	@gzip $(prefix)/share/man/man1/folder-thumbnailer.1
	ifeq ($(DESTDIR),)
		mandb
	endif