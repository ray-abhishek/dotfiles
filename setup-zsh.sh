#!/usr/bin/env bash

# ============================================
# Portable ZSH Setup Script
# ============================================
# This script installs and configures a supercharged ZSH environment
# Usage: curl -fsSL <raw-url> | bash
# Or: bash setup-zsh.sh

set -e

echo "🚀 Starting ZSH setup..."

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
else
    echo "❌ Unsupported OS: $OSTYPE"
    exit 1
fi

# ============================================
# Install Dependencies
# ============================================
echo "📦 Installing dependencies..."

if [[ "$OS" == "macos" ]]; then
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    
    # Install packages
    brew install starship fzf zoxide
    
elif [[ "$OS" == "linux" ]]; then
    # Detect Linux package manager
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get install -y curl git
        
        # Install starship
        curl -sS https://starship.rs/install.sh | sh -s -- -y
        
        # Install fzf
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --key-bindings --completion --no-update-rc
        
        # Install zoxide
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
        
    elif command -v yum &> /dev/null; then
        sudo yum install -y curl git
        
        # Install starship
        curl -sS https://starship.rs/install.sh | sh -s -- -y
        
        # Install fzf
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --key-bindings --completion --no-update-rc
        
        # Install zoxide
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    fi
fi

# ============================================
# Install ZSH Plugins
# ============================================
echo "🔌 Installing ZSH plugins..."

# Create .zsh directory
mkdir -p ~/.zsh

# Install zsh-autosuggestions
if [ ! -d ~/.zsh/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi

# Install zsh-syntax-highlighting
if [ ! -d ~/.zsh/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
fi

# Setup fzf if not already done
if [[ "$OS" == "macos" ]] && [ -f /opt/homebrew/opt/fzf/install ]; then
    /opt/homebrew/opt/fzf/install --key-bindings --completion --no-update-rc
fi

# ============================================
# Backup existing .zshrc
# ============================================
if [ -f ~/.zshrc ]; then
    echo "📋 Backing up existing .zshrc to ~/.zshrc.backup-$(date +%Y%m%d-%H%M%S)"
    cp ~/.zshrc ~/.zshrc.backup-$(date +%Y%m%d-%H%M%S)
fi

# ============================================
# Create new .zshrc
# ============================================
echo "✍️  Creating new .zshrc..."

cat > ~/.zshrc << 'EOF'
# ============================================
# PATH CONFIGURATION
# ============================================
export PATH="$HOME/bin:/usr/local/bin:$PATH"

# ============================================
# HISTORY SETTINGS
# ============================================
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt EXTENDED_HISTORY          # Write timestamp to history
setopt HIST_IGNORE_ALL_DUPS      # Delete old duplicate entries
setopt HIST_FIND_NO_DUPS         # Don't display duplicates when searching
setopt HIST_IGNORE_SPACE         # Don't record commands starting with space
setopt SHARE_HISTORY             # Share history between sessions

# ============================================
# AUTO-COMPLETION
# ============================================
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select                      # Use menu selection
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # Case-insensitive completion
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}" # Colorful completion
zstyle ':completion:*' rehash true                      # Auto-rehash for new commands

# ============================================
# ZSH PLUGINS
# ============================================
# zsh-autosuggestions - Fish-like autosuggestions
if [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
fi

# zsh-syntax-highlighting - Real-time syntax highlighting (must be last)
if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ============================================
# FZF INTEGRATION
# ============================================
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Enhanced fzf settings
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --inline-info"
export FZF_CTRL_T_OPTS="--preview 'cat {}' --preview-window=right:60%"
export FZF_ALT_C_OPTS="--preview 'ls -la {}'"

# ============================================
# ZOXIDE - Smart Directory Jumping
# ============================================
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
  alias cd="z"  # Replace cd with zoxide
fi

# ============================================
# STARSHIP PROMPT
# ============================================
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# ============================================
# ALIASES
# ============================================

# Git aliases
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gco="git checkout"
alias gb="git branch"
alias glog="git log --oneline --graph --all"

# Directory navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"

# List aliases
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias ls="ls -G"  # Colorful ls on macOS
else
  alias ls="ls --color=auto"  # Colorful ls on Linux
fi
alias ll="ls -lh"
alias la="ls -lah"
alias l="ls -CF"

# Safety aliases
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# Quick shortcuts
alias c="clear"
alias h="history"
alias x="exit"

# Development
alias reload="source ~/.zshrc"
alias zshconfig="${EDITOR:-nano} ~/.zshrc"

# ============================================
# CUSTOM FUNCTIONS
# ============================================

# mkcd - Make directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# extract - Extract any archive format
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"     ;;
      *.tar.gz)    tar xzf "$1"     ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar x "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xf "$1"      ;;
      *.tbz2)      tar xjf "$1"     ;;
      *.tgz)       tar xzf "$1"     ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# backup - Create a backup of a file
backup() {
  cp "$1" "$1.backup-$(date +%Y%m%d-%H%M%S)"
}

# findproc - Find and grep running processes
findproc() {
  ps aux | grep -v grep | grep -i -e VSZ -e "$1"
}

# mkscript - Create a new shell script with shebang
mkscript() {
  echo '#!/usr/bin/env bash' > "$1"
  chmod +x "$1"
  ${EDITOR:-nano} "$1"
}
EOF

# ============================================
# Create Starship Config
# ============================================
echo "⭐ Creating Starship config..."

mkdir -p ~/.config

cat > ~/.config/starship.toml << 'EOF'
# Starship Configuration
"$schema" = 'https://starship.rs/config-schema.json'

# Timeout for starship to scan files (ms)
scan_timeout = 30
command_timeout = 500

# Inserts a blank line between shell prompts
add_newline = true

# Format: configure what the prompt looks like
format = """
[╭─](bold green)$username$hostname$directory$git_branch$git_status$python$nodejs$rust$golang$docker_context
[╰─](bold green)$character"""

[character]
success_symbol = "[➜](bold green)"
error_symbol = "[✗](bold red)"

[username]
style_user = "bold yellow"
style_root = "bold red"
format = "[$user]($style) "
show_always = false

[hostname]
ssh_only = true
format = "on [$hostname](bold blue) "

[directory]
truncation_length = 3
truncate_to_repo = true
format = "in [$path]($style)[$read_only]($read_only_style) "
style = "bold cyan"

[git_branch]
symbol = " "
format = "on [$symbol$branch]($style) "
style = "bold purple"

[git_status]
format = '([\[$all_status$ahead_behind\]]($style) )'
style = "bold red"
conflicted = "🏳"
ahead = "⇡${count}"
behind = "⇣${count}"
diverged = "⇕⇡${ahead_count}⇣${behind_count}"
untracked = "?${count}"
stashed = "$${count}"
modified = "!${count}"
staged = "+${count}"
renamed = "»${count}"
deleted = "✘${count}"

[python]
symbol = " "
format = 'via [$symbol$pyenv_prefix($version )(\($virtualenv\) )]($style)'
style = "yellow"
pyenv_version_name = false

[nodejs]
symbol = " "
format = "via [$symbol($version )]($style)"
style = "bold green"

[rust]
symbol = " "
format = "via [$symbol($version )]($style)"

[golang]
symbol = " "
format = "via [$symbol($version )]($style)"

[docker_context]
symbol = " "
format = "via [$symbol$context]($style) "
style = "blue bold"

[time]
disabled = false
time_format = "%R"
format = '🕙[\[ $time \]]($style) '
style = "bold white"

[cmd_duration]
min_time = 500
format = "took [$duration](bold yellow) "
EOF

# ============================================
# Done!
# ============================================
echo ""
echo "✅ ZSH setup complete!"
echo ""
echo "📝 What was installed:"
echo "  • Starship prompt"
echo "  • fzf (fuzzy finder)"
echo "  • zoxide (smart cd)"
echo "  • zsh-autosuggestions"
echo "  • zsh-syntax-highlighting"
echo "  • Enhanced history & completion"
echo "  • Useful aliases & functions"
echo ""
echo "🎯 Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Try 'Ctrl+R' for fuzzy history search"
echo "  3. Use 'z <dir>' to jump to directories"
echo "  4. Type 'alias' to see all shortcuts"
echo ""
echo "Happy coding! 🚀"
