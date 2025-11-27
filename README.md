# 🚀 My Dotfiles

A supercharged ZSH configuration that makes your terminal 100x better. One-line installation for macOS and Linux.

![Starship Prompt](https://img.shields.io/badge/prompt-starship-DD0B78?style=flat-square)
![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-blue?style=flat-square)
![Shell](https://img.shields.io/badge/shell-zsh-green?style=flat-square)

## ✨ Features

- 🎨 **Beautiful Starship Prompt** - Fast, informative, and customizable
- 🔍 **fzf Integration** - Fuzzy find everything (history, files, directories)
- 🚀 **Smart Directory Jumping** - zoxide learns your most-used directories
- 💡 **Intelligent Autosuggestions** - Fish-like suggestions based on history
- 🌈 **Syntax Highlighting** - Real-time command validation
- 📚 **Extended History** - 50k commands with timestamps
- ⚡ **Smart Completion** - Case-insensitive with menu selection
- 🎯 **Productivity Aliases** - Git shortcuts, navigation, and more
- 🛠️ **Utility Functions** - mkcd, extract, backup, and more

## 📦 What Gets Installed

### Tools
- [Starship](https://starship.rs/) - Cross-shell prompt
- [fzf](https://github.com/junegunn/fzf) - Fuzzy finder
- [zoxide](https://github.com/ajeetdsouza/zoxide) - Smarter cd command
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - Fish-like autosuggestions
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) - Command syntax highlighting

### Configuration Files
- `.zshrc` - Main ZSH configuration
- `.config/starship.toml` - Starship prompt theme

## 🔧 Installation

### One-line install (from GitHub)
```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/dotfiles/main/setup-zsh.sh | bash
```

### Manual install
```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Run the setup script
bash setup-zsh.sh

# Restart your terminal or reload
source ~/.zshrc
```

## 🎯 Quick Start

After installation, try these features:

### Fuzzy Search
- `Ctrl+R` - Search command history
- `Ctrl+T` - Search files
- `Alt+C` - Search directories

### Smart Navigation
```bash
z documents        # Jump to ~/Documents (after visiting once)
z proj web         # Jump to ~/projects/website
..                 # cd ..
...                # cd ../..
```

### Git Shortcuts
```bash
gs                 # git status
ga .               # git add .
gc "message"       # git commit -m "message"
gp                 # git push
glog               # git log --oneline --graph --all
```

### Utility Functions
```bash
mkcd newproject    # Create directory and cd into it
extract file.tar.gz # Extract any archive format
backup config.json  # Create timestamped backup
```

## 📝 Aliases Cheatsheet

### Git
| Alias | Command |
|-------|---------|
| `g` | `git` |
| `gs` | `git status` |
| `ga` | `git add` |
| `gc` | `git commit` |
| `gp` | `git push` |
| `gl` | `git pull` |
| `gd` | `git diff` |
| `gco` | `git checkout` |
| `gb` | `git branch` |

### Navigation
| Alias | Command |
|-------|---------|
| `..` | `cd ..` |
| `...` | `cd ../..` |
| `....` | `cd ../../..` |
| `~` | `cd ~` |

### Lists
| Alias | Command |
|-------|---------|
| `ll` | `ls -lh` |
| `la` | `ls -lah` |
| `l` | `ls -CF` |

### Quick Actions
| Alias | Command |
|-------|---------|
| `c` | `clear` |
| `h` | `history` |
| `x` | `exit` |
| `reload` | `source ~/.zshrc` |
| `zshconfig` | Edit `.zshrc` |

## 🛠️ Customization

### Add Your Own Aliases
```bash
# Edit your .zshrc
zshconfig

# Add aliases in the ALIASES section
alias myalias="command here"

# Reload
reload
```

### Customize Starship Prompt
```bash
# Edit starship config
nano ~/.config/starship.toml

# See available modules: https://starship.rs/config/
```

### Add Custom Functions
Edit `~/.zshrc` and add functions in the CUSTOM FUNCTIONS section:
```bash
myfunction() {
  echo "Hello $1"
}
```

## 🔄 Updating

To update the configuration on an existing machine:
```bash
cd ~/dotfiles
git pull
bash setup-zsh.sh
```

Your existing `.zshrc` will be backed up automatically.

## 🗑️ Uninstall

To restore your original configuration:
```bash
# Find your backup
ls -la ~ | grep zshrc.backup

# Restore it
cp ~/.zshrc.backup-TIMESTAMP ~/.zshrc

# Reload
source ~/.zshrc
```

## 💡 Tips & Tricks

### History Search
- Type part of a command and press `↑` to search history
- `Ctrl+R` for interactive fuzzy search
- Commands starting with space won't be saved to history

### Autosuggestions
- Type a command to see suggestions in gray
- Press `→` to accept the suggestion
- Press `Alt+→` to accept one word at a time

### Tab Completion
- Press `Tab` twice to see completion menu
- Use arrow keys to navigate
- Case-insensitive by default

## 📋 Requirements

- **macOS**: macOS 10.15 or later
- **Linux**: Ubuntu 18.04+, Debian 10+, CentOS 7+, or similar
- **Shell**: ZSH (will be configured as default shell)
- **Internet**: For downloading dependencies

## 🐛 Troubleshooting

### Command not found: starship
```bash
# Ensure Homebrew is in PATH (macOS)
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Slow prompt
```bash
# Increase starship timeout
# Edit ~/.config/starship.toml
scan_timeout = 50
command_timeout = 1000
```

### Plugins not loading
```bash
# Reinstall plugins
rm -rf ~/.zsh
bash ~/dotfiles/setup-zsh.sh
```

## 🤝 Contributing

Feel free to fork this repo and customize it for your needs!

## 📄 License

MIT License - feel free to use and modify!

## 🙏 Credits

- [Starship](https://starship.rs/)
- [fzf](https://github.com/junegunn/fzf)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

---

**Enjoy your supercharged terminal! 🚀**

If you found this helpful, give it a ⭐️
