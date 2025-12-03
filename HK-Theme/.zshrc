# Created by newuser for 5.9
# Where to save history
HISTFILE="$HOME/.zsh_history"

# How many lines to keep in memory
HISTSIZE=10000

# How many lines to save to the file
SAVEHIST=10000

# Good history behavior
setopt appendhistory
setopt sharehistory
setopt histignoredups
setopt incappendhistory


PROMPT='%F{cyan}%n@%m %F{blue}%~ %F{green}$ %f'

fastfetch

eval "$(starship init zsh)"

# Autosuggestions (should come BEFORE syntax highlighting)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh


# Syntax highlighting (must be LAST)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/dimsum/.dart-cli-completion/zsh-config.zsh ]] && . /home/dimsum/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

