PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
MANDIR = $(PREFIX)/share/man/man1

install:
	mkdir -p $(BINDIR) $(MANDIR)
	cp devfetch $(BINDIR)/
	cp man/devfetch.1 $(MANDIR)/

uninstall:
	rm -f $(BINDIR)/devfetch
	rm -f $(MANDIR)/devfetch.1
