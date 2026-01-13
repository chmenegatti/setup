#!/usr/bin/env bash

set -euo pipefail

# Trap para capturar erros e mostrar linha
trap 'echo "Erro na linha $LINENO: $BASH_COMMAND falhou com código $?" >&2; exit 1' ERR

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Função para verificar se comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Função para instalar dependências necessárias
install_dependencies() {
    local deps=(curl wget unzip git make build-essential)
    for dep in "${deps[@]}"; do
        if ! command_exists "$dep"; then
            log_info "Instalando dependência: $dep"
            sudo apt update && sudo apt install -y "$dep"
        fi
    done
}

# Função para instalar pacotes apenas se não existirem
install_if_missing() {
    local pkg=$1
    if ! dpkg -l "$pkg" >/dev/null 2>&1; then
        log_info "Instalando $pkg..."
        sudo apt install -y "$pkg"
    else
        log_success "$pkg já está instalado"
    fi
}

# ============================================
# 1. INSTALAÇÃO DO GUM (NECESSÁRIO PRIMEIRO)
# ============================================
install_gum() {
    if ! command_exists gum; then
        log_info "Instalando gum..."
        # Tentar instalar via apt, se não conseguir baixar binário
        if sudo apt install -y gum 2>/dev/null; then
            log_success "Gum instalado via apt!"
        else
            log_info "Instalando gum via binário..."
            curl -fsSL https://github.com/charmbracelet/gum/releases/latest/download/gum_Linux_x86_64.tar.gz | tar -xzC /tmp
            sudo mv /tmp/gum /usr/local/bin/gum
            sudo chmod +x /usr/local/bin/gum
            log_success "Gum instalado com sucesso!"
        fi
    else
        log_success "Gum já está instalado"
    fi
}

# ============================================
# 2. INSTALAÇÃO DE FERRAMENTAS ESSENCIAIS
# ============================================
install_essentials() {
    gum style --border normal --padding "1 2" --border-foreground 212 "Instalando ferramentas essenciais"

    local essentials=(git wget curl vim build-essential software-properties-common apt-transport-https ca-certificates gnupg lsb-release)

    for pkg in "${essentials[@]}"; do
        install_if_missing "$pkg"
    done

    log_success "Ferramentas essenciais instaladas!"
}

# ============================================
# 3. INSTALAÇÃO DO ZSH
# ============================================
install_zsh() {
    if ! command_exists zsh; then
        gum style --border normal --padding "1 2" --border-foreground 212 "Instalando ZSH"
        sudo apt install -y zsh

        # Definir ZSH como shell padrão
        if gum confirm "Deseja definir ZSH como shell padrão?"; then
            chsh -s $(command -v zsh)
            log_success "ZSH definido como shell padrão"
        fi
    else
        log_success "ZSH já está instalado"
    fi
}

# ============================================
# 4. INSTALAÇÃO DE FERRAMENTAS ADICIONAIS
# ============================================
install_additional_tools() {
    gum style --border normal --padding "1 2" --border-foreground 212 "Instalando ferramentas adicionais"

    # Instalar snap se não estiver disponível
    if ! command_exists snap; then
        log_info "Instalando snap..."
        sudo apt install -y snapd
        sudo systemctl enable --now snapd.socket
        # Aguardar snap estar pronto
        sleep 5
    fi

    # Instalar flatpak se não estiver disponível
    if ! command_exists flatpak; then
        log_info "Instalando flatpak..."
        sudo apt install -y flatpak
    fi

    log_success "Ferramentas adicionais instaladas!"
}

# ============================================
# 5. INSTALAÇÃO DO ASDF
# ============================================
install_asdf() {
    if [ ! -d "$HOME/.asdf" ]; then
        gum style --border normal --padding "1 2" --border-foreground 212 "Instalando ASDF"

        git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1 --depth 1

        # Adicionar ao .zshrc se não existir
        if ! grep -q "# ASDF BEGIN" ~/.zshrc 2>/dev/null; then
            cat >> ~/.zshrc << 'EOF'

# ASDF BEGIN
# ASDF Version Manager
. "$HOME/.asdf/asdf.sh"
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit
# ASDF END
EOF
        fi

        # Source para usar nesta sessão
        . "$HOME/.asdf/asdf.sh"

        log_success "ASDF instalado com sucesso!"
    else
        log_success "ASDF já está instalado"
        . "$HOME/.asdf/asdf.sh"
    fi
}

# ============================================
# 6. INSTALAÇÃO DE PLUGINS ASDF
# ============================================
install_asdf_plugins() {
    gum style --border normal --padding "1 2" --border-foreground 212 "Instalando plugins ASDF"

    # Node.js
    if ! asdf plugin list | grep -q nodejs; then
        log_info "Adicionando plugin nodejs..."
        asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    fi

    if ! asdf list nodejs | grep -q "22.8.0"; then
        log_info "Instalando Node.js 22.8.0..."
        asdf install nodejs 22.8.0
    fi

    log_info "Instalando Node.js latest..."
    asdf install nodejs latest
    asdf global nodejs latest

    # Go
    if ! asdf plugin list | grep -q golang; then
        log_info "Adicionando plugin golang..."
        asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
    fi
    log_info "Instalando Go latest..."
    asdf install golang latest
    asdf global golang latest

    # Golangci-lint
    if ! asdf plugin list | grep -q golangci-lint; then
        log_info "Adicionando plugin golangci-lint..."
        asdf plugin add golangci-lint https://github.com/hypnoglow/asdf-golangci-lint.git
    fi
    log_info "Instalando golangci-lint latest..."
    asdf install golangci-lint latest
    asdf global golangci-lint latest

    # Yarn
    if ! asdf plugin list | grep -q yarn; then
        log_info "Adicionando plugin yarn..."
        asdf plugin add yarn
    fi
    log_info "Instalando Yarn latest..."
    asdf install yarn latest
    asdf global yarn latest

    # Neovim
    if ! asdf plugin list | grep -q neovim; then
        log_info "Adicionando plugin neovim..."
        asdf plugin add neovim
    fi
    log_info "Instalando Neovim latest..."
    asdf install neovim stable
    asdf global neovim stable

    # Lazygit
    if ! asdf plugin list | grep -q lazygit; then
        log_info "Adicionando plugin lazygit..."
        asdf plugin add lazygit https://github.com/nklmilojevic/asdf-lazygit.git
    fi
    log_info "Instalando Lazygit latest..."
    asdf install lazygit latest
    asdf global lazygit latest

    asdf reshim
    log_success "Todos os plugins ASDF instalados!"
}

# ============================================
# 7. INSTALAÇÃO DE APLICATIVOS
# ============================================
install_applications() {
    gum style --border normal --padding "1 2" --border-foreground 212 "Instalando aplicativos"

    # Aplicativos do repositório oficial (apt)
    local apps=(exa bat)

    for app in "${apps[@]}"; do
        # Para Ubuntu/Debian, tentar instalar via apt, se não conseguir usar cargo ou snap
        if ! install_if_missing "$app" 2>/dev/null; then
            log_info "$app não disponível via apt, tentando snap..."
            if command_exists snap; then
                sudo snap install "$app" --classic 2>/dev/null || log_warning "$app não disponível via snap"
            fi
        fi
    done

    # Aplicativos via snap (equivalente ao AUR)
    local snap_apps=(insomnia dbeaver-ce code)

    for app in "${snap_apps[@]}"; do
        if ! snap list "$app" >/dev/null 2>&1; then
            log_info "Instalando $app via snap..."
            sudo snap install "$app" --classic
        else
            log_success "$app já está instalado"
        fi
    done

    # Google Chrome via PPA
    if ! command_exists google-chrome; then
        log_info "Instalando Google Chrome..."
        curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/google-chrome-keyring.gpg
        echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
        sudo apt update && sudo apt install -y google-chrome-stable
    else
        log_success "Google Chrome já está instalado"
    fi

    # Tilix via PPA
    if ! command_exists tilix; then
        log_info "Instalando Tilix..."
        sudo add-apt-repository -y ppa:webupd8team/terminix
        sudo apt update && sudo apt install -y tilix
    else
        log_success "Tilix já está instalado"
    fi

    log_success "Aplicativos instalados!"
}

# ============================================
# 8. INSTALAÇÃO DO DOCKER
# ============================================
install_docker() {
    if gum confirm "Deseja instalar Docker?"; then
        gum style --border normal --padding "1 2" --border-foreground 212 "Instalando Docker"

        # Remover versões antigas
        sudo apt remove -y docker docker-engine docker.io containerd runc 2>/dev/null || true

        # Instalar Docker via repositório oficial
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
        echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

        sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

        # Adicionar usuário ao grupo docker
        if ! groups | grep -q docker; then
            sudo usermod -aG docker $USER
            log_warning "Você foi adicionado ao grupo docker. Execute 'newgrp docker' ou faça logout/login para aplicar."
        fi

        # Habilitar e iniciar serviço
        sudo systemctl enable docker.service
        sudo systemctl start docker.service

        log_success "Docker instalado e configurado!"
    fi
}

# ============================================
# 9. INSTALAÇÃO DO LAZYVIM
# ============================================
install_lazyvim() {
    if gum confirm "Deseja instalar LazyVim?"; then
        gum style --border normal --padding "1 2" --border-foreground 212 "Instalando LazyVim"

        # Backup da configuração existente
        if [ -d "$HOME/.config/nvim" ]; then
            log_warning "Fazendo backup da configuração atual do Neovim..."
            mv ~/.config/nvim{,.bak.$(date +%Y%m%d_%H%M%S)}
            mv ~/.local/share/nvim{,.bak.$(date +%Y%m%d_%H%M%S)} 2>/dev/null || true
            mv ~/.local/state/nvim{,.bak.$(date +%Y%m%d_%H%M%S)} 2>/dev/null || true
            mv ~/.cache/nvim{,.bak.$(date +%Y%m%d_%H%M%S)} 2>/dev/null || true
        fi

        # Instalar LazyVim
        git clone https://github.com/LazyVim/starter ~/.config/nvim --depth 1
        rm -rf ~/.config/nvim/.git

        log_success "LazyVim instalado! Execute 'nvim' para finalizar a configuração."
    fi
}

# ============================================
# 10. INSTALAÇÃO DO ZINIT
# ============================================
install_zinit() {
    if [ ! -d "$HOME/.local/share/zinit" ]; then
        gum style --border normal --padding "1 2" --border-foreground 212 "Instalando Zinit"

        git clone https://github.com/zdharma-continuum/zinit.git ~/.local/share/zinit/bin --depth 1

        log_success "Zinit instalado!"
    else
        log_success "Zinit já está instalado"
    fi
}

# ============================================
# 11. CONFIGURAÇÃO DE PLUGINS ZINIT
# ============================================
setup_zinit_plugins() {
    gum style --border normal --padding "1 2" --border-foreground 212 "Configurando plugins Zinit"

    # Verificar se os plugins já estão no .zshrc
    if ! grep -q "history-search-multi-word" ~/.zshrc 2>/dev/null; then
        cat >> ~/.zshrc << 'EOF'

# ============================================
# Zinit Plugins
# ============================================

# Plugin history-search-multi-word loaded with investigating.
zinit load zdharma-continuum/history-search-multi-word

# Two regular plugins loaded without investigating.
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

EOF
        log_success "Plugins Zinit configurados no .zshrc!"
    else
        log_success "Plugins Zinit já configurados"
    fi
}

# ============================================
# 12. INSTALAÇÃO DO OH-MY-POSH
# ============================================
install_ohmyposh() {
    if ! command_exists oh-my-posh; then
        gum style --border normal --padding "1 2" --border-foreground 212 "Instalando Oh My Posh"

        # Instalar Oh My Posh via snap
        sudo snap install oh-my-posh

        log_success "Oh My Posh instalado!"
    else
        log_success "Oh My Posh já está instalado"
    fi

    # Configurar tema montys
    if ! grep -q "oh-my-posh init" ~/.zshrc 2>/dev/null; then
        cat >> ~/.zshrc << 'EOF'

# ============================================
# Oh My Posh
# ============================================
eval "$(oh-my-posh init zsh --config ~/.cache/oh-my-posh/themes/montys.omp.json)"

EOF

        # Baixar temas se não existirem
        if [ ! -d "$HOME/.cache/oh-my-posh/themes" ]; then
            mkdir -p ~/.cache/oh-my-posh/themes
            curl -sL https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -o ~/.cache/oh-my-posh/themes.zip
            unzip -q ~/.cache/oh-my-posh/themes.zip -d ~/.cache/oh-my-posh/themes
            rm ~/.cache/oh-my-posh/themes.zip
        fi

        log_success "Oh My Posh configurado com tema montys!"
    else
        log_success "Oh My Posh já configurado"
    fi

    # Instalar fontes Nerd (necessário para ícones)
    if gum confirm "Deseja instalar Nerd Fonts (recomendado para ícones)?"; then
        log_info "Instalando FiraCode Nerd Font..."

        mkdir -p ~/.local/share/fonts
        cd ~/.local/share/fonts

        if [ ! -f "FiraCodeNerdFont-Regular.ttf" ]; then
            curl -fLo "FiraCodeNerdFont-Regular.ttf" \
                https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Regular/FiraCodeNerdFont-Regular.ttf
            curl -fLo "FiraCodeNerdFont-Bold.ttf" \
                https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Bold/FiraCodeNerdFont-Bold.ttf

            fc-cache -fv
            log_success "Nerd Font instalada! Configure seu terminal para usar 'FiraCode Nerd Font'"
        else
            log_success "Nerd Font já instalada"
        fi

        cd ~
    fi
}

# ============================================
# 13. CONFIGURAÇÃO DE ALIASES
# ============================================
setup_aliases() {
    gum style --border normal --padding "1 2" --border-foreground 212 "Configurando aliases"

    # Backup do .zshrc antes de modificar
    if [ -f ~/.zshrc ]; then
        cp ~/.zshrc ~/.zshrc.bak.$(date +%Y%m%d_%H%M%S)
    fi

    # Criar arquivo de aliases se não existir
    if ! grep -q "# Custom Aliases" ~/.zshrc 2>/dev/null; then
        cat >> ~/.zshrc << 'EOF'

# ============================================
# Custom Aliases
# ============================================

# EXA (substituto do ls com ícones e cores)
alias ls='exa --icons'                          # Lista arquivos com ícones
alias ll='exa -lah --icons --git'               # Lista detalhada com informações git
alias la='exa -a --icons'                       # Lista incluindo arquivos ocultos
alias lt='exa --tree --level=2 --icons'         # Visualização em árvore (2 níveis)
alias l='exa -lh --icons'                       # Lista longa com tamanhos humanizados
alias llt='exa -lah --icons --git --tree'       # Lista em árvore detalhada

# BAT (substituto do cat com syntax highlighting)
alias cat='bat'                                 # Cat com syntax highlighting
alias catn='bat --style=plain'                  # Cat sem decorações
alias catp='bat --style=plain --paging=never'   # Cat sem paginação

# Git - Comandos básicos
alias g='git'                                   # Atalho principal do git
alias gs='git status'                           # Status do repositório
alias ga='git add'                              # Adiciona arquivo específico
alias gaa='git add .'                           # Adiciona todos os arquivos
alias gc='git commit -m'                        # Commit com mensagem
alias gca='git commit --amend'                  # Amend do último commit
alias gcane='git commit --amend --no-edit'      # Amend sem editar mensagem
alias gp='git push'                             # Push para remote
alias gpf='git push --force-with-lease'         # Push forçado seguro
alias gpl='git pull'                            # Pull do remote
alias gplr='git pull --rebase'                  # Pull com rebase

# Git - Branches
alias gco='git checkout'                        # Checkout de branch
alias gcb='git checkout -b'                     # Criar e checkout nova branch
alias gb='git branch'                           # Lista branches
alias gba='git branch -a'                       # Lista todas as branches
alias gbd='git branch -d'                       # Deleta branch (safe)
alias gbD='git branch -D'                       # Deleta branch (force)
alias gm='git merge'                            # Merge de branches

# Git - Logs e diffs
alias gl='git log --oneline --graph --decorate' # Log gráfico resumido
alias gll='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gd='git diff'                             # Diff de mudanças
alias gds='git diff --staged'                   # Diff de arquivos staged
alias gdc='git diff --cached'                   # Diff cached (staged)

# Git - Stash
alias gst='git stash'                           # Stash de mudanças
alias gstp='git stash pop'                      # Aplica último stash
alias gstl='git stash list'                     # Lista stashes
alias gstd='git stash drop'                     # Remove stash

# Git - Reset e Clean
alias grh='git reset HEAD'                      # Unstage arquivos
alias grhh='git reset --hard HEAD'              # Reset hard para HEAD
alias gclean='git clean -fd'                    # Remove arquivos não rastreados

# Git - Remote
alias gr='git remote'                           # Lista remotes
alias grv='git remote -v'                       # Lista remotes verbose
alias gra='git remote add'                      # Adiciona remote
alias grrm='git remote remove'                  # Remove remote

# Docker - Básico
alias d='docker'                                # Atalho principal do docker
alias dc='docker-compose'                       # Docker compose
alias dps='docker ps'                           # Lista containers rodando
alias dpsa='docker ps -a'                       # Lista todos os containers
alias di='docker images'                        # Lista imagens
alias dip='docker image prune -a'               # Remove imagens não usadas

# Docker - Gerenciamento de containers
alias drm='docker rm'                           # Remove container
alias drma='docker rm $(docker ps -aq)'         # Remove todos os containers
alias dstop='docker stop'                       # Para container
alias dstopa='docker stop $(docker ps -q)'      # Para todos os containers
alias dstart='docker start'                     # Inicia container
alias drestart='docker restart'                 # Reinicia container

# Docker - Imagens
alias drmi='docker rmi'                         # Remove imagem
alias drmia='docker rmi $(docker images -q)'    # Remove todas as imagens
alias dpull='docker pull'                       # Pull de imagem
alias dbuild='docker build'                     # Build de imagem

# Docker - Execução e logs
alias dex='docker exec -it'                     # Executa comando no container
alias dlogs='docker logs -f'                    # Logs em tempo real
alias dinspect='docker inspect'                 # Inspeciona container/imagem

# Docker - Limpeza
alias dprune='docker system prune -af'          # Remove tudo não usado
alias dvprune='docker volume prune -f'          # Remove volumes não usados
alias dnprune='docker network prune -f'         # Remove networks não usadas

# Docker Compose
alias dcu='docker-compose up'                   # Sobe serviços
alias dcud='docker-compose up -d'              # Sobe serviços em background
alias dcd='docker-compose down'                 # Para e remove containers
alias dcl='docker-compose logs -f'              # Logs em tempo real
alias dcps='docker-compose ps'                  # Lista serviços
alias dcr='docker-compose restart'              # Reinicia serviços
alias dcb='docker-compose build'                # Build dos serviços

# Sistema - Navegação
alias c='clear'                                 # Limpa terminal
alias ..='cd ..'                                # Sobe um diretório
alias ...='cd ../..'                            # Sobe dois diretórios
alias ....='cd ../../..'                        # Sobe três diretórios
alias .....='cd ../../../..'                    # Sobe quatro diretórios
alias ~='cd ~'                                  # Vai para home
alias -- -='cd -'                               # Volta para diretório anterior

# Sistema - Histórico e processos
alias h='history'                               # Histórico de comandos
alias hg='history | grep'                       # Busca no histórico
alias j='jobs'                                  # Lista jobs
alias k='kill'                                  # Mata processo
alias ka='killall'                              # Mata todos os processos

# Sistema - Editor
alias v='nvim'                                  # Abre neovim
alias vim='nvim'                                # Vim aponta para neovim
alias vi='nvim'                                 # Vi aponta para neovim
alias nv='nvim'                                 # Atalho curto para neovim

# Apt - Gerenciamento de pacotes
alias aptup='sudo apt update && sudo apt upgrade -y'  # Atualiza sistema
alias aptin='sudo apt install -y'               # Instala pacote
alias aptrm='sudo apt remove --purge -y'        # Remove pacote
alias aptarm='sudo apt autoremove --purge -y'   # Remove pacotes órfãos
alias aptsearch='apt search'                    # Busca pacote
alias aptshow='apt show'                        # Info do pacote

# Snap - Gerenciamento de pacotes
alias snapup='sudo snap refresh'                # Atualiza snaps
alias snapin='sudo snap install --classic'      # Instala snap
alias snaprm='sudo snap remove'                 # Remove snap

# Utilitários - Rede
alias myip='curl ifconfig.me'                   # Mostra IP público
alias localip='ip addr show'                    # Mostra IPs locais
alias ports='netstat -tulanp'                   # Mostra portas abertas
alias listening='lsof -i -P | grep LISTEN'      # Mostra portas em listening
alias ping='ping -c 5'                          # Ping com 5 pacotes
alias fastping='ping -c 100 -i.2'               # Ping rápido

# Utilitários - Sistema
alias df='df -h'                                # Espaço em disco humanizado
alias du='du -h'                                # Uso de disco humanizado
alias dud='du -d 1 -h'                          # Uso de disco (1 nível)
alias dus='du -sh'                              # Uso de disco (sumário)
alias free='free -h'                            # Memória humanizada
alias ps='ps aux'                               # Lista processos
alias psg='ps aux | grep'                       # Busca processos

# Utilitários - Arquivos
alias grep='grep --color=auto'                  # Grep com cores
alias egrep='egrep --color=auto'                # Egrep com cores
alias fgrep='fgrep --color=auto'                # Fgrep com cores
alias mkdir='mkdir -pv'                         # Mkdir com verbose
alias wget='wget -c'                            # Wget com continue
alias path='echo -e ${PATH//:/\\n}'             # Mostra PATH formatado

# Utilitários - Tempo
alias now='date +"%T"'                          # Hora atual
alias nowdate='date +"%d-%m-%Y"'                # Data atual
alias week='date +%V'                           # Número da semana

# LazyGit
alias lg='lazygit'                              # Abre lazygit

# Atalhos personalizados
alias reload='source ~/.zshrc'                  # Recarrega configuração
alias zshconfig='nvim ~/.zshrc'                 # Edita .zshrc
alias ohmyzsh='nvim ~/.oh-my-zsh'               # Edita oh-my-zsh

# Função de ajuda para aliases
alias aliases='show_aliases_help'

EOF
        log_success "Aliases configurados!"
    else
        log_success "Aliases já configurados"
    fi
}

# ============================================
# MENU PRINCIPAL
# ============================================
main_menu() {
    clear
    gum style \
        --border double \
        --border-foreground 212 \
        --padding "1 2" \
        --width 60 \
        "🚀 Setup Completo - Ubuntu/Debian Dev Environment" \
        "" \
        "Script de configuração idempotente" \
        "Para ambientes de desenvolvimento"
    
    echo ""
    
    CHOICE=$(gum choose \
        "🔧 Instalação Completa (Recomendado)" \
        "📦 Instalar apenas essenciais" \
        "⚙️  Instalar apenas ASDF e plugins" \
        "🐳 Instalar apenas Docker" \
        "💻 Instalar apenas aplicativos" \
        "🎨 Configurar ZSH (Zinit + Oh My Posh)" \
        "🌈 Configurar apenas aliases" \
        "❌ Sair")
    
    case "$CHOICE" in
        "🔧 Instalação Completa (Recomendado)")
            install_gum
            install_essentials
            install_additional_tools
            install_zsh
            install_asdf
            install_asdf_plugins
            install_applications
            install_docker
            install_lazyvim
            install_zinit
            setup_zinit_plugins
            install_ohmyposh
            setup_aliases
            
            gum style --border double --padding "1 2" --border-foreground 46 \
                "✅ Instalação completa finalizada!" \
                "" \
                "Próximos passos:" \
                "1. Feche e abra um novo terminal (ou execute: exec zsh)" \
                "2. Configure seu terminal para usar 'FiraCode Nerd Font'" \
                "3. Se instalou Docker, execute 'newgrp docker' ou faça logout/login" \
                "4. Execute 'nvim' para configurar LazyVim"
            ;;
        "📦 Instalar apenas essenciais")
            install_gum
            install_essentials
            install_additional_tools
            install_zsh
            ;;
        "⚙️  Instalar apenas ASDF e plugins")
            install_gum
            install_asdf
            install_asdf_plugins
            ;;
        "🐳 Instalar apenas Docker")
            install_gum
            install_docker
            ;;
        "💻 Instalar apenas aplicativos")
            install_gum
            install_additional_tools
            install_applications
            ;;
        "🎨 Configurar ZSH (Zinit + Oh My Posh)")
            install_gum
            install_essentials
            install_zsh
            install_zinit
            setup_zinit_plugins
            install_ohmyposh
            ;;
        "🌈 Configurar apenas aliases")
            setup_aliases
            ;;
        "❌ Sair")
            log_info "Saindo..."
            exit 0
            ;;
    esac
}

# ============================================
# EXECUÇÃO
# ============================================

# Verificar se está rodando como root
if [ "$EUID" -eq 0 ]; then 
    log_error "Não execute este script como root!"
    exit 1
fi

# Instalar dependências necessárias
install_dependencies

# Instalar gum primeiro
install_gum

# Mostrar menu
main_menu