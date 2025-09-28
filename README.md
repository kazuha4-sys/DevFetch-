# DevFetch

> **DevFetch** — Uma ferramenta terminal vibe *hacker de garagem* pra mostrar tudo que o dev precisa na cara do gol. Rápida, suja e eficaz. Se você gosta de terminal, ASCII e status do sistema, aqui é seu reino.

```
    ____                  ______         __            __
   / __ \  ___  _   __   / ____/  ___   / /_  _____   / /_
  / / / / / _ \| | / /  / /_     / _ \ / __/ / ___/  / __ \
 / /_/ / /  __/| |/ /  / __/    /  __// /_  / /__   / / / /
/_____/  \___/ |___/  /_/       \___/ \__/  \___/  /_/ /_/
____________________________________________________________
```

---

## Porra, o que é isso?

DevFetch é um *fetch* pra devs — mostra versão do PHP/Node/Python, status de MySQL/Redis, infos do Git (repo, branch, commits pendentes, último commit), e pode rodar num loop que atualiza automático. Ideal pra **dotfiles**, **status machines**, ou só pra encher o terminal de orgulho.

## Features (o que ele faz sem frescura)

* Mostra versões: PHP, Node, Python.
* Status de serviços: MySQL, Redis (via systemctl ou checando binários).
* Integração com Git: remoto, owner, repo, branch, commits, último commit, versão por tag/commit.
* Exibe um ASCII art bonitão.
* Modo loop (`--loop`) que atualiza a cada x segundos e limpa a tela (ideal pra monitoramento rápido).
* Modo `--dev`, `--git`, `--docker` pra mostrar só o que interessa.

## Requisitos

* Bash (óbvio)
* git
* php (opcional)
* node (opcional)
* python3 (opcional)
* docker (opcional)
* systemd se você quiser checar serviços pelo `systemctl` (ou só ter os bins `mysql`/`redis-server`).

> Funciona bem em Linux. No Windows (WSL) deve rodar na moral, mas pode pedir uns ajustes.

## Instalação

1. Clone o repo:

```bash
git clone <SEU-REPO> devfetch
cd devfetch
chmod +x devfetch
sudo ln -s $(pwd)/devfetch /usr/local/bin/devfetch # opcional, pra chamar de qualquer lugar
```

2. Rode:

```bash
- `./devfetch --laravel` -> resumo rápido
- `./devfetch --laravel --json` -> exporta JSON com info
- `./devfetch --laravel --artisan migrate:status` -> executa artisan command
- `./devfetch --laravel --routes` -> exibe route:list
- `./devfetch --laravel --tests` -> roda phpunit/pest
- `./devfetch --laravel --deps` -> composer outdated + audit
- `./devfetch --laravel --dbshell` -> abre shell do DB (usa .env)
- `./devfetch --laravel --install-hook` -> adiciona command artisan `devfetch:info` ao projeto
```

## Uso e Flags

* `--dev` — mostra as versões (PHP/Node/Python) e status de serviços.
* `--git` — só a porra do git (se estiver em um repo).
* `--docker` — lista containers ativos.
* `--all` — mostra tudo.
* `--loop` — modo monitor, atualiza a cada 10 segundos. Pressione `Ctrl+C` pra sair.

## Como funciona por baixo (pra tu mexer)

* O ASCII é guardado em uma variável e depois impresso — você pode trocar ou estilizar com cores ANSI.
* O `show_git` monta um array com as *infos* e depois imprime lado a lado com o ASCII pequeno.
* O `loop_fetch` usa `tput` pra controlar cursor e limpar a tela, deixando a UI fixa.

### Dica de dev

Se o ASCII não aparece no `show_dev`, garante que você tá fazendo `printf "%b\n" "$ascii"` e imprimindo as linhas (o bug era que o ASCII tava sendo lido mas não impresso). Se quiser imprimir lado-a-lado, tem que montar um array com as infos e alinhar com `printf "% -35s %s\n"`.

## Personalização (faz do jeito que quiser)

* Mude as cores ANSI nas variáveis `ascii` e `ascii_git`.
* Aumente o width do `printf` pra ajustar colunas.
* Troque o intervalo no `sleep` do `loop_fetch`.

## Exemplos

```bash
# mostrar só git
devfetch --git

# rodar em loop pra monitorar o repo e containers
devfetch --loop
```

## Contribuição

Se quiser contribuir: abre um PR, manda uns commits limpos, escreve tests (se fizer algo complexo) e segue o padrão de código. Não fique com preguiça e explique o porquê das mudanças.

## Licença

Escolha a licença que tu curte (MIT é tranquilo pra projetos open source). Se for fechar, troca pra algo mais rígido.

## Contato

Se quiser trocar ideia, me marca no README ou abre um issue. Se for dar feedback, fala grosso — eu aguento.

---

### Observações finais (minha opinião sincera, sem filtro)

Esse projeto é perfeito pra quem gosta de ver as coisas acontecendo no terminal e se sentir poderoso. Não é bloatware — é pragmático. Se quiser um visual mais "profissa", dá pra integrar com tmux ou fazer uma versão em curses.

Se quiser eu deixo o README ainda mais fedido com badges, GIFs, e um exemplo de `systemd` service file pra rodar em background. Quer? Ou já tá bom pra tu sair batendo no teclado? 🤘
