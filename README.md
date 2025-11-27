# My ZSH setup.

## Why

The default terminal experience is terrible. This fixes that with minimal configuration and maximum utility. Works on macOS and Linux.

## What you get

- Starship prompt that actually shows useful information
- fzf for fuzzy finding everything
- zoxide because `cd ../../..` is ridiculous
- Autosuggestions from history
- Syntax highlighting so you know when you've typo'd
- 50k command history with timestamps
- Case-insensitive tab completion
- Git aliases that save hundreds of keystrokes
- Utility functions for common tasks

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/dotfiles/main/setup-zsh.sh | bash
```

Restart your terminal.

## Usage

**Search everything with fzf:**
- `Ctrl+R` - command history
- `Ctrl+T` - files
- `Alt+C` - directories

**Jump around with zoxide:**
```bash
z documents        # jump to ~/Documents
z proj web         # partial matching works
```

**Git shortcuts:**
```bash
gs                 # status
ga .               # add
gc "message"       # commit
gp                 # push
glog               # pretty log
```

## Aliases

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

## Customization

Edit `~/.zshrc` directly or use `zshconfig` alias. Add your own aliases in the ALIASES section.

For Starship prompt customization, edit `~/.config/starship.toml`. See [starship.rs/config](https://starship.rs/config/) for options.

## Notes

- History is saved with timestamps. Commands starting with space are ignored.
- Tab completion is case-insensitive.
- Press `→` to accept autosuggestions.
- Your old `.zshrc` is backed up automatically during installation.

## Troubleshooting

If Starship isn't found after install, ensure Homebrew is in your PATH:
```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Slow prompt? Edit `~/.config/starship.toml` and increase timeouts.

## Dependencies

- [Starship](https://starship.rs/)
- [fzf](https://github.com/junegunn/fzf)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
