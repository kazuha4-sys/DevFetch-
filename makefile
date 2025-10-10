PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
MANDIR = $(PREFIX)/share/man/man1
LOCAL_PREFIX ?= $(HOME)/.local
LOCAL_BINDIR = $(LOCAL_PREFIX)/bin
LOCAL_MANDIR = $(LOCAL_PREFIX)/share/man/man1

# arquivos (ajusta se teu bin for outro)
BIN = devfetch
MAN = man/devfetch.1
COMPLETIONS_BASH = completions/devfetch.bash
COMPLETIONS_ZSH = completions/_devfetch

.PHONY: install install-user uninstall uninstall-user install-completions check

check:
	@test -f $(BIN) || (echo "Erro: binário '$(BIN)' não encontrado. Rode 'make' ou compile antes." && false)
	@echo "OK: achei $(BIN)"
	@echo

install: check
	@echo "Instalando em $(PREFIX) (vai precisar de sudo se for /usr/local)..."
	@echo
	mkdir -p $(BINDIR) $(MANDIR)
	install -m 0755 $(BIN) $(BINDIR)/$(BIN)
	@if [ -f $(MAN) ]; then \
		install -m 0644 $(MAN) $(MANDIR)/$(BIN).1; \
	else \
		echo "Aviso: manual $(MAN) não encontrado, pulando."; \
	fi
	@echo
	@echo "Instalação completa: $(BINDIR)/$(BIN)"

install-user: check
	@echo
	@echo "Instalando localmente em $(LOCAL_PREFIX) (sem sudo)..."
	@echo
	mkdir -p $(LOCAL_BINDIR) $(LOCAL_MANDIR)
	install -m 0755 $(BIN) $(LOCAL_BINDIR)/$(BIN)
	@if [ -f $(MAN) ]; then \
		install -m 0644 $(MAN) $(LOCAL_MANDIR)/$(BIN).1; \
	else \
		echo "Aviso: manual $(MAN) não encontrado, pulando."; \
	fi
	@echo
	@echo "Instalação local completa: $(LOCAL_BINDIR)/$(BIN)"
	@echo
	@echo "Certifica que $(LOCAL_BINDIR) esteja no PATH: export PATH=\$$PATH:$(LOCAL_BINDIR)"

install-completions:
	@echo "Instalando completions (se existirem)..."
	@if [ -f $(COMPLETIONS_BASH) ]; then \
		install -d $(PREFIX)/share/bash-completion/completions; \
		install -m 0644 $(COMPLETIONS_BASH) $(PREFIX)/share/bash-completion/completions/$(BIN); \
		echo "Bash completion instalado."; \
	else \
		echo "Nenhuma completion bash encontrada, pulando."; \
	fi
	@if [ -f $(COMPLETIONS_ZSH) ]; then \
		install -d $(PREFIX)/share/zsh/site-functions; \
		install -m 0644 $(COMPLETIONS_ZSH) $(PREFIX)/share/zsh/site-functions/$(COMPLETIONS_ZSH);\
		echo "Zsh completion instalado."; \
	else \
		echo "Nenhuma completion zsh encontrada, pulando."; \
	fi

uninstall:
	@echo "Removendo de $(PREFIX)..."
	rm -f $(BINDIR)/$(BIN)
	rm -f $(MANDIR)/$(BIN).1
	@echo "Removido."

uninstall-user:
	@echo "Removendo instalação local em $(LOCAL_PREFIX)..."
	rm -f $(LOCAL_BINDIR)/$(BIN)
	rm -f $(LOCAL_MANDIR)/$(BIN).1
	@echo "Removido (user)."
