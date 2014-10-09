VERSION:=2.0
MINOR=0
PATCH=p576
SOURCE:=ruby-$(VERSION).$(MINOR)-$(PATCH)
TARBALL:=$(SOURCE).tar.gz
SOURCE_URL:=http://cache.ruby-lang.org/pub/ruby/$(VERSION)/$(TARBALL)
PREFIX:=/usr/ruby/2.0.0
CURL:=curl -SLo

build: $(SOURCE)
	cd $(SOURCE) && ./configure --prefix=$(PREFIX)
	cd $(SOURCE) && $(MAKE)

$(SOURCE): $(TARBALL)
	tar -zxf "$<"

md5:
	echo "2e1f4355981b754d92f7e2cc456f843d  $(TARBALL)" > $(TARBALL).md5

$(TARBALL): md5
	$(CURL) $(TARBALL) $(SOURCE_URL)
	md5sum -c $(TARBALL).md5

install:
	cd $(SOURCE) && $(MAKE) install
	$(PREFIX)/bin/gem install bundler
	$(PREFIX)/bin/ruby -ropenssl -rzlib -rreadline -e "puts 'testing external modules are compiled correctly'"

.PHONY: all build install
