#!/usr/bin/env bash

set -e

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

# Função para instalar pacotes apenas se não existirem
install_if_missing() {
    local pkg=$1
    if ! pacman -Q "$pkg" >/dev/null 2>&1; then
        log_info "Instalando $pkg..."
        sudo pacman -S --noconfirm "$pkg"
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
        sudo pacman -S --noconfirm gum
        log_success "Gum instalado com sucesso!"
    else
        log_success "Gum já está instalado"
    fi
}

# ============================================
# 2. INSTALAÇÃO DE FERRAMENTAS ESSENCIAIS
# ============================================
install_essentials() {
    gum style --border normal --padding "1 2" --border-foreground 212 "Instalando ferramentas essenciais"
    
    local essentials=(git wget curl vim base-devel)
    
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
        sudo pacman -S --noconfirm zsh
        
        # Definir ZSH como shell padrão
        if gum confirm "Deseja definir ZSH como shell padrão?"; then
            chsh -s $(which zsh)
            log_success "ZSH definido como shell padrão"
        fi
    else
        log_success "ZSH já está instalado"
    fi
}

# ============================================
# 4. INSTALAÇÃO DO YAY
# ============================================
install_yay() {
    if ! command_exists yay; then
        gum style --border normal --padding "1 2" --border-foreground 212 "Instalando YAY"
        
        cd /tmp
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        cd ~
        rm -rf /tmp/yay
        
        log_success "YAY instalado com sucesso!"
    else
        log_success "YAY já está instalado"
    fi
}

# ============================================
# 5. INSTALAÇÃO DO ASDF
# ============================================
install_asdf() {
    if [ ! -d "$HOME/.asdf" ]; then
        gum style --border normal --padding "1 2" --border-foreground 212 "Instalando ASDF"
        
        git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
        
        # Adicionar ao .zshrc se não existir
        if ! grep -q "asdf.sh" ~/.zshrc 2>/dev/null; then
            cat >> ~/.zshrc << 'EOF'

# ASDF Version Manager
. "$HOME/.asdf/asdf.sh"
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit
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
    
    # Aplicativos do repositório oficial
    local apps=(exa bat tilix)
    for app in "${apps[@]}"; do
        install_if_missing "$app"
    done
    
    # Aplicativos do AUR
    local aur_apps=(insomnia-bin dbeaver google-chrome visual-studio-code-bin)
    
    for app in "${aur_apps[@]}"; do
        if ! yay -Q "$app" >/dev/null 2>&1; then
            log_info "Instalando $app via YAY..."
            yay -S --noconfirm "$app"
        else
            log_success "$app já está instalado"
        fi
    done
    
    log_success "Aplicativos instalados!"
}

# ============================================
# 8. INSTALAÇÃO DO DOCKER
# ============================================
install_docker() {
    if gum confirm "Deseja instalar Docker?"; then
        gum style --border normal --padding "1 2" --border-foreground 212 "Instalando Docker"
        
        install_if_missing docker
        install_if_missing docker-compose
        
        # Adicionar usuário ao grupo docker
        if ! groups | grep -q docker; then
            sudo usermod -aG docker $USER
            log_warning "Você foi adicionado ao grupo docker. Faça logout e login novamente."
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
        git clone https://github.com/LazyVim/starter ~/.config/nvim
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
        
        bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
        
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
        
        # Instalar Oh My Posh
        curl -s https://ohmyposh.dev/install.sh | bash -s
        
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
    
    # Criar arquivo de aliases se não existir
    if ! grep -q "# Custom Aliases" ~/.zshrc 2>/dev/null; then
        cat >> ~/.zshrc << 'EOF'

# ============================================
# Custom Aliases
# ============================================

# EXA (substituto do ls)
alias ls='exa --icons'
alias ll='exa -lah --icons --git'
alias la='exa -a --icons'
alias lt='exa --tree --level=2 --icons'
alias l='exa -lh --icons'

# BAT (substituto do cat)
alias cat='bat'
alias catn='bat --style=plain'
alias catp='bat --style=plain --paging=never'

# Git
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gp='git push'
alias gpl='git pull'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gbd='git branch -d'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gds='git diff --staged'
alias gst='git stash'
alias gstp='git stash pop'

# Docker
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias drm='docker rm'
alias drmi='docker rmi'
alias dex='docker exec -it'
alias dlogs='docker logs -f'
alias dprune='docker system prune -af'
alias dstop='docker stop $(docker ps -q)'

# Sistema
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias h='history'
alias j='jobs'
alias v='nvim'
alias vim='nvim'

# Pacman & Yay
alias pacup='sudo pacman -Syu'
alias pacin='sudo pacman -S'
alias pacrm='sudo pacman -Rns'
alias yayup='yay -Syu'
alias yayin='yay -S'

# Utilitários
alias myip='curl ifconfig.me'
alias ports='netstat -tulanp'
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias grep='grep --color=auto'

# LazyGit
alias lg='lazygit'

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
        "🚀 Setup Completo - Arch Linux Dev Environment" \
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
            install_zsh
            install_yay
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
                "3. Se instalou Docker, faça logout/login" \
                "4. Execute 'nvim' para configurar LazyVim"
            ;;
        "📦 Instalar apenas essenciais")
            install_gum
            install_essentials
            install_zsh
            install_yay
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
            install_yay
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

# Instalar gum primeiro
install_gum

# Mostrar menu
main_menu
