# 🚀 Arch Linux Dev Environment Setup

<div align="center">

![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Zsh](https://img.shields.io/badge/Zsh-000000?style=for-the-badge&logo=zsh&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/Version-1.0.0-blue.svg)](https://github.com/your-repo)

---

**🎯 Script de configuração completo e idempotente para ambientes de desenvolvimento Arch Linux**

*Transforme seu Arch Linux em uma estação de desenvolvimento completa com um único comando!*

[📥 Download](#instalação) • [🚀 Uso](#como-usar) • [📚 Documentação](#documentação) • [🛠️ Troubleshooting](#troubleshooting)

---

</div>

## 📋 Sumário

- [✨ O que é isso?](#-o-que-é-isso)
- [🎯 Funcionalidades](#-funcionalidades)
- [📦 Pré-requisitos](#-pré-requisitos)
- [🚀 Instalação](#-instalação)
- [🎮 Como usar](#-como-usar)
- [📋 Menu de opções](#-menu-de-opções)
- [🛠️ Ferramentas instaladas](#️-ferramentas-instaladas)
- [🎨 Aliases e atalhos](#-aliases-e-atalhos)
- [🔧 Configurações aplicadas](#-configurações-aplicadas)
- [🛠️ Troubleshooting](#️-troubleshooting)
- [🤝 Contribuição](#-contribuição)
- [📄 Licença](#-licença)

---

## ✨ O que é isso?

Este é um **script de configuração automatizado** para transformar uma instalação básica do Arch Linux em um **ambiente de desenvolvimento completo e profissional**. Desenvolvido com foco em produtividade, segurança e idempotência, o script instala e configura todas as ferramentas essenciais para desenvolvimento moderno.

### 🎯 Características principais

- ✅ **Idempotente**: Pode ser executado múltiplas vezes sem problemas
- 🔒 **Seguro**: Verificações de dependências e backups automáticos
- 🎨 **Interativo**: Interface bonita com GUM para melhor UX
- 📦 **Completo**: Instala tudo que você precisa em um só lugar
- 🚀 **Rápido**: Otimizado com git clone --depth 1 e verificações inteligentes
- 🎭 **Customizável**: Escolha apenas o que precisa

---

## 🎯 Funcionalidades

### 🏗️ Instalação automática de:
- **🐚 Shell**: Zsh com Zinit e Oh My Posh
- **📦 Gerenciadores de pacotes**: Yay (AUR)
- **🔧 Version Managers**: ASDF para múltiplas linguagens
- **🐳 Containers**: Docker + Docker Compose
- **📝 Editores**: Neovim com LazyVim
- **🛠️ Ferramentas**: Git, curl, wget, base-devel e mais

### 🎨 Configurações aplicadas:
- **🎯 Aliases inteligentes** para Git, Docker, sistema
- **🎭 Tema Oh My Posh** com ícones e cores
- **⚡ Plugins Zsh** para autocompletar e syntax highlighting
- **📁 Estrutura organizada** de diretórios

### 🔄 Idempotência garantida:
- Verificações antes de instalar
- Backups automáticos de configurações existentes
- Detecção de instalações duplicadas

---

## 📦 Pré-requisitos

### 📋 Requisitos mínimos

| Componente | Versão | Status |
|------------|--------|--------|
| 🐧 **Arch Linux** | Atualizado | ✅ Obrigatório |
| 💾 **Espaço em disco** | 5GB+ | ✅ Recomendado |
| 🌐 **Internet** | Estável | ✅ Obrigatório |
| 👤 **Usuário** | Não-root | ✅ Obrigatório |

### 🔧 Dependências automáticas

O script instala automaticamente:
- `git` - Controle de versão
- `unzip` - Extração de arquivos
- `make` - Compilação
- `gum` - Interface interativa

### ⚠️ Avisos importantes

> 🚨 **Não execute como root!** O script verifica e impede execução como root.
>
> 🔄 **Backup automático**: Suas configurações existentes são backupadas automaticamente.
>
> ⏱️ **Tempo estimado**: 10-30 minutos dependendo da conexão e opções escolhidas.

---

## 🚀 Instalação

### 📥 Download e execução

```bash
# 1. Clone ou baixe o repositório
git clone https://github.com/seu-usuario/arch-dev-setup.git
cd arch-dev-setup

# 2. Dê permissão de execução
chmod +x setup.sh

# 3. Execute o script
./setup.sh
```

### 🎯 Execução direta (one-liner)

```bash
# Download e execução em um comando
curl -fsSL https://raw.githubusercontent.com/seu-usuario/arch-dev-setup/main/setup.sh | bash
```

> ⚠️ **Atenção**: Para máxima segurança, prefira clonar o repositório em vez de executar remotamente.

---

## 🎮 Como usar

### 🚀 Execução interativa

1. **Execute o script**:
   ```bash
   ./setup.sh
   ```

2. **Escolha uma opção** no menu interativo:
   - Use ↑↓ para navegar
   - Pressione Enter para selecionar
   - Escolha baseado no que precisa

3. **Aguarde a instalação**:
   - Siga os prompts interativos
   - Responda às confirmações quando solicitado

4. **Finalize a configuração**:
   - Feche e reabra o terminal
   - Execute `exec zsh` para recarregar
   - Configure seu terminal para usar fontes Nerd

### 🎯 Modos de instalação

| Modo | Descrição | Tempo estimado |
|------|-----------|----------------|
| **🔧 Completa** | Tudo + LazyVim + Docker | 20-30 min |
| **📦 Essenciais** | Básico + Zsh + Yay | 5-10 min |
| **⚙️ ASDF Only** | Apenas version manager | 3-5 min |
| **🐳 Docker Only** | Apenas containers | 2-3 min |
| **💻 Apps Only** | Apenas aplicativos | 5-8 min |
| **🎨 ZSH Config** | Apenas shell config | 3-5 min |
| **🌈 Aliases Only** | Apenas atalhos | <1 min |

---

## 📋 Menu de opções

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                          MENU PRINCIPAL                                    ║
╚═══════════════════════════════════════════════════════════════════════════╝

🎯 Escolha uma opção:

🔧 Instalação Completa (Recomendado)
   → Instala tudo: ferramentas, ZSH, ASDF, apps, Docker, LazyVim

📦 Instalar apenas essenciais
   → Git, curl, wget, vim, base-devel + ZSH + Yay

⚙️  Instalar apenas ASDF e plugins
   → ASDF + Node.js, Go, Yarn, Neovim, Lazygit

🐳 Instalar apenas Docker
   → Docker + Docker Compose + configuração

💻 Instalar apenas aplicativos
   → Exa, Bat, Insomnia, DBeaver, Chrome, VS Code, Tilix

🎨 Configurar ZSH (Zinit + Oh My Posh)
   → Zinit plugins + Oh My Posh + Nerd Fonts

🌈 Configurar apenas aliases
   → 50+ aliases inteligentes para produtividade

❌ Sair
   → Encerra o script
```

---

## 🛠️ Ferramentas instaladas

### 📦 Pacman (Repositório oficial)

| Ferramenta | Descrição | Uso |
|------------|-----------|-----|
| `git` | Controle de versão | Desenvolvimento |
| `curl` | Transferência de dados | Downloads |
| `wget` | Download de arquivos | Downloads |
| `vim` | Editor de texto | Edição básica |
| `base-devel` | Ferramentas de desenvolvimento | Compilação |

### 🎯 Yay (AUR)

| Ferramenta | Descrição | Categoria |
|------------|-----------|-----------|
| `gum` | Interface TUI bonita | Utilitário |
| `exa` | Substituto moderno do ls | Sistema |
| `bat` | Substituto do cat com syntax | Sistema |
| `insomnia-bin` | Cliente REST API | Desenvolvimento |
| `dbeaver` | Cliente SQL universal | Banco de dados |
| `google-chrome` | Navegador web | Navegação |
| `visual-studio-code-bin` | Editor de código | Desenvolvimento |
| `tilix` | Terminal moderno | Sistema |

### ⚙️ ASDF Plugins

| Linguagem | Versão | Descrição |
|-----------|--------|-----------|
| **Node.js** | 22.8.0 + latest | JavaScript/TypeScript |
| **Go** | latest | Linguagem de sistemas |
| **Golangci-lint** | latest | Linter para Go |
| **Yarn** | latest | Gerenciador de pacotes JS |
| **Neovim** | stable | Editor avançado |
| **Lazygit** | latest | Interface Git TUI |

### 🐳 Docker

- **Docker Engine** + **Docker Compose**
- **Configuração automática** do grupo docker
- **Serviço systemd** habilitado

### 🎨 ZSH Ecosystem

- **Zinit**: Plugin manager rápido
- **Oh My Posh**: Tema com ícones
- **Nerd Fonts**: Fontes com ícones
- **Plugins**: Autocomplete + Syntax highlighting

---

## 🎨 Aliases e atalhos

### 📁 Sistema de navegação

```bash
c           → clear (limpar terminal)
..          → cd .. (subir um diretório)
...         → cd ../.. (subir dois)
~           → cd ~ (ir para home)
-           → cd - (voltar ao anterior)
```

### 🔀 Git (15 aliases)

```bash
g           → git
gs          → git status
ga <file>   → git add <file>
gaa         → git add . (tudo)
gc "msg"    → git commit -m "msg"
gca         → git commit --amend
gp          → git push
gpl         → git pull
gco <br>    → git checkout <br>
gcb <br>    → git checkout -b <br> (criar)
gb          → git branch
gba         → git branch -a
gl          → git log --oneline --graph
gll         → git log detalhado e colorido
```

### 🐳 Docker (20+ aliases)

```bash
d           → docker
dc          → docker-compose
dps         → docker ps
dpsa        → docker ps -a
di          → docker images
drm         → docker rm
drma        → docker rm $(docker ps -aq)
dex         → docker exec -it
dlogs       → docker logs -f
dprune      → docker system prune -af
```

### 📦 Pacman & Yay

```bash
pacup       → sudo pacman -Syu
yayup       → yay -Syu
pacin       → sudo pacman -S
yayin       → yay -S
pacrm       → sudo pacman -Rns
```

### 🌐 Rede e sistema

```bash
myip        → curl ifconfig.me
localip     → ip addr show
ports       → netstat -tulanp
df          → df -h
free        → free -h
ps          → ps aux
```

### 🎯 Comandos especiais

```bash
aliases     → Mostra guia completo de aliases
reload      → source ~/.zshrc
zshconfig   → nvim ~/.zshrc
lg          → lazygit
v           → nvim
```

### 📖 Guia completo

Execute `aliases` no terminal para ver o guia interativo completo com todos os comandos organizados por categoria!

---

## 🔧 Configurações aplicadas

### 📁 Estrutura de arquivos

```
~/.zshrc
├── # ASDF BEGIN ... # ASDF END
├── # Zinit Plugins
├── # Oh My Posh
└── # Custom Aliases

~/.config/nvim/          # LazyVim
~/.asdf/                 # Version Manager
~/.local/share/zinit/    # Plugin Manager
~/.cache/oh-my-posh/     # Tema e fontes
```

### 🎨 Tema Oh My Posh

- **Tema**: `montys` (com ícones e cores)
- **Fonte recomendada**: FiraCode Nerd Font
- **Configuração**: `~/.cache/oh-my-posh/themes/montys.omp.json`

### ⚡ Plugins Zsh

- **zsh-users/zsh-autosuggestions**: Sugestões automáticas
- **zdharma-continuum/fast-syntax-highlighting**: Destaque de sintaxe
- **history-search-multi-word**: Busca avançada no histórico

---

## 🛠️ Troubleshooting

### 🔧 Problemas comuns

#### ❌ "Permissão negada" ao executar
```bash
chmod +x setup.sh
./setup.sh
```

#### ❌ "Comando não encontrado: gum"
O script instala automaticamente. Se falhar:
```bash
sudo pacman -S gum
```

#### ❌ Docker não funciona após instalação
```bash
# Execute um dos comandos:
newgrp docker
# OU
sudo systemctl restart docker
# OU faça logout/login
```

#### ❌ Oh My Posh sem ícones
1. Instale Nerd Fonts:
   ```bash
   # O script já instala automaticamente
   # Se não funcionou:
   curl -fLo ~/.local/share/fonts/FiraCodeNerdFont-Regular.ttf \
        https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Regular/FiraCodeNerdFont-Regular.ttf
   fc-cache -fv
   ```
2. Configure seu terminal para usar "FiraCode Nerd Font"

#### ❌ ZSH não é shell padrão
```bash
chsh -s $(which zsh)
# Reinicie o terminal
```

#### ❌ ASDF não encontrado
```bash
source ~/.zshrc
# OU
exec zsh
```

### 📊 Logs e debug

O script gera logs coloridos em tempo real. Para debug:

```bash
# Executar com mais verbosidade
bash -x setup.sh

# Verificar instalação
gum --version
asdf --version
oh-my-posh --version
```

### 🔄 Restaurar backups

Se algo deu errado, restaure configurações anteriores:

```bash
# Listar backups
ls -la ~/.zshrc.bak.*
ls -la ~/.config/nvim.bak.*

# Restaurar
cp ~/.zshrc.bak.20240113_143022 ~/.zshrc
cp -r ~/.config/nvim.bak.20240113_143022 ~/.config/nvim
```

---

## 🤝 Contribuição

### 🌟 Como contribuir

1. **Fork** o projeto
2. **Clone** sua fork: `git clone https://github.com/seu-usuario/arch-dev-setup.git`
3. **Crie uma branch**: `git checkout -b feature/nova-funcionalidade`
4. **Commit suas mudanças**: `git commit -m 'Adiciona nova funcionalidade'`
5. **Push**: `git push origin feature/nova-funcionalidade`
6. **Abra um Pull Request**

### 📝 Diretrizes

- ✅ Mantenha a **idempotência** do script
- ✅ Adicione **logs informativos**
- ✅ Teste em uma **VM limpa** antes de submeter
- ✅ Siga o **estilo de código** existente
- ✅ Atualize a **documentação** quando necessário

### 🐛 Reportar bugs

Use o [GitHub Issues](https://github.com/seu-usuario/arch-dev-setup/issues) para:

- 🐛 Bugs e erros
- 💡 Sugestões de melhorias
- ❓ Perguntas e dúvidas
- 📖 Pedidos de documentação

**Template para bug reports:**
```
## Descrição do problema
Passos para reproduzir:
1. Execute `./setup.sh`
2. Escolha opção X
3. Erro ocorre em Y

## Ambiente
- Arch Linux versão: [versão]
- Bash versão: [versão]
- Erro completo: [cole aqui]
```

---

## 📄 Licença

```
MIT License

Copyright (c) 2024 Seu Nome

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

<div align="center">

### 🙏 Agradecimentos

Obrigado por usar este script! Se foi útil, dê uma ⭐ no repositório.

**Feito com ❤️ para a comunidade Arch Linux**

---

[⬆️ Voltar ao topo](#-arch-linux-dev-environment-setup)

</div>
