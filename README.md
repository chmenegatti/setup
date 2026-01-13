# 🚀 Dev Environment Setup Scripts

<div align="center">

![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)
![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![Debian](https://img.shields.io/badge/Debian-A81D33?style=for-the-badge&logo=debian&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Zsh](https://img.shields.io/badge/Zsh-000000?style=for-the-badge&logo=zsh&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/Version-1.0.0-blue.svg)](https://github.com/your-repo)

---

**🎯 Scripts de configuração completos e idempotentes para ambientes de desenvolvimento**

*Transforme sua distribuição Linux em uma estação de desenvolvimento completa com um único comando!*

---

</div>

## 📋 Scripts Disponíveis

### 🏗️ **Arch Linux** - [📖 Documentação Completa](arch/README.md)
> Script otimizado para Arch Linux e derivados (Manjaro, EndeavourOS, etc.)

**Localização:** [`arch/setup.sh`](arch/setup.sh)

**Características:**
- ✅ Usa `pacman` + `yay` (AUR)
- ✅ Instalação via repositórios oficiais e AUR
- ✅ Configurado para performance máxima
- ✅ Suporte completo ao ecossistema Arch

[🚀 Ver documentação completa](arch/README.md) • [📥 Baixar script](arch/setup.sh)

---

### 🐧 **Ubuntu/Debian** - [📖 Documentação Completa](ubuntu/README.md)
> Script adaptado para Ubuntu, Debian e derivados (Linux Mint, Pop!_OS, etc.)

**Localização:** [`ubuntu/setup.sh`](ubuntu/setup.sh)

**Características:**
- ✅ Usa `apt` + `snap` + `flatpak`
- ✅ Instalação via repositórios oficiais e PPAs
- ✅ Compatibilidade com sistemas estáveis
- ✅ Suporte a pacotes universais

[🚀 Ver documentação completa](ubuntu/README.md) • [📥 Baixar script](ubuntu/setup.sh)

---

## ✨ O que os scripts fazem?

Ambos os scripts transformam uma instalação básica do Linux em um **ambiente de desenvolvimento completo** com:

### 🛠️ **Ferramentas instaladas:**
- **🐚 Shell moderno**: Zsh + Zinit + Oh My Posh
- **🔧 Version Manager**: ASDF (Node.js, Go, Python, etc.)
- **🐳 Containers**: Docker + Docker Compose
- **📝 Editor**: Neovim + LazyVim
- **🛠️ Utilitários**: Git, curl, wget, build tools

### 🎨 **Configurações aplicadas:**
- **🎯 50+ aliases** inteligentes (Git, Docker, sistema)
- **🎭 Tema personalizado** com ícones e cores
- **⚡ Plugins Zsh** para produtividade
- **📁 Estrutura organizada** de arquivos

### 🔄 **Características técnicas:**
- **✅ Idempotente**: Execute múltiplas vezes sem problemas
- **🔒 Seguro**: Backups automáticos + verificações
- **🎨 Interativo**: Interface bonita com GUM
- **🚀 Otimizado**: Downloads rápidos + verificações inteligentes

---

## 🚀 Como escolher o script certo?

| Sua Distribuição | Script Recomendado | Por quê? |
|------------------|-------------------|----------|
| **Arch Linux** | [`arch/setup.sh`](arch/setup.sh) | Pacotes sempre atualizados, AUR integrado |
| **Manjaro** | [`arch/setup.sh`](arch/setup.sh) | Baseado em Arch, mesma compatibilidade |
| **EndeavourOS** | [`arch/setup.sh`](arch/setup.sh) | Arquitetura Arch pura |
| **Ubuntu** | [`ubuntu/setup.sh`](ubuntu/setup.sh) | Repositórios estáveis e confiáveis |
| **Linux Mint** | [`ubuntu/setup.sh`](ubuntu/setup.sh) | Baseado em Ubuntu LTS |
| **Pop!_OS** | [`ubuntu/setup.sh`](ubuntu/setup.sh) | Compatibilidade Ubuntu |
| **Debian** | [`ubuntu/setup.sh`](ubuntu/setup.sh) | Mesma base de pacotes |

---

## 📦 Instalação Rápida

### 🏗️ Para Arch Linux:
```bash
git clone https://github.com/seu-usuario/dev-setup-scripts.git
cd dev-setup-scripts/arch
chmod +x setup.sh
./setup.sh
```

### 🐧 Para Ubuntu/Debian:
```bash
git clone https://github.com/seu-usuario/dev-setup-scripts.git
cd dev-setup-scripts/ubuntu
chmod +x setup.sh
./setup.sh
```

---

## 🎯 Funcionalidades Comuns

### 📋 Menu Interativo
Ambos os scripts oferecem o mesmo menu intuitivo:

```
🔧 Instalação Completa (Recomendado)
📦 Instalar apenas essenciais
⚙️  Instalar apenas ASDF e plugins
🐳 Instalar apenas Docker
💻 Instalar apenas aplicativos
🎨 Configurar ZSH (Zinit + Oh My Posh)
🌈 Configurar apenas aliases
❌ Sair
```

### 🎨 Aliases Inteligentes
Mais de 50 aliases organizados por categoria:

- **🔀 Git**: `gs`, `gaa`, `gc "msg"`, `gp`, `gpl`, etc.
- **🐳 Docker**: `dps`, `drm`, `dex`, `dlogs`, etc.
- **📦 Sistema**: `aptup`, `snapup`, `df`, `free`, etc.
- **🎯 Navegação**: `..`, `...`, `~`, `-`, `c`

### ⚙️ Version Management
Gerenciamento completo de versões com ASDF:

- **Node.js** (22.8.0 + latest)
- **Go** (latest)
- **Python** (via ASDF)
- **Neovim** (stable)
- **Lazygit** (latest)

---

## 🛠️ Suporte e Troubleshooting

### 📚 Documentação Detalhada
Cada script tem sua própria documentação completa:

- [**📖 Arch Linux Guide**](arch/README.md) - Guia específico para Arch
- [**📖 Ubuntu/Debian Guide**](ubuntu/README.md) - Guia específico para Ubuntu

### 🐛 Problemas Comuns
- **Permissões**: Execute como usuário normal (não root)
- **Dependências**: Scripts instalam automaticamente
- **Backups**: Configurações antigas são backupadas
- **Idempotência**: Execute quantas vezes quiser

### 🤝 Contribuição
Contribuições são bem-vindas! Cada distribuição tem suas particularidades:

1. Fork o projeto
2. Crie uma branch: `git checkout -b feature/nova-distribuicao`
3. Adapte o script para sua distro
4. Atualize a documentação
5. Abra um Pull Request

---

## 📄 Licença

```
MIT License - Copyright (c) 2024 Seu Nome

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
```

---

<div align="center">

### 🙏 Agradecimentos

Obrigado por usar estes scripts! Se foram úteis, dê uma ⭐ no repositório.

**Feito com ❤️ para a comunidade Linux**

---

## 📁 Estrutura do Projeto

```
dev-setup-scripts/
├── arch/                    # Scripts para Arch Linux
│   ├── setup.sh            # Script principal Arch
│   └── README.md           # Documentação Arch
├── ubuntu/                  # Scripts para Ubuntu/Debian
│   ├── setup.sh            # Script principal Ubuntu
│   └── README.md           # Documentação Ubuntu
├── README.md               # Este arquivo (genérico)
├── .gitignore             # Arquivos ignorados
└── .tool-versions         # Versões de ferramentas
```

[🏗️ Arch Linux](arch/) • [🐧 Ubuntu/Debian](ubuntu/) • [⬆️ Voltar ao topo](#-dev-environment-setup-scripts)

</div>

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/Version-1.0.0-blue.svg)](https://github.com/your-repo)

---

**🎯 Script de configuração completo e idempotente para ambientes de desenvolvimento Ubuntu/Debian**

*Transforme seu Ubuntu/Debian em uma estação de desenvolvimento completa com um único comando!*

[📥 Download](#instalação) • [🚀 Uso](#como-usar) • [📚 Documentação](#documentação) • [🛠️ Troubleshooting](#troubleshooting)

---

</div>