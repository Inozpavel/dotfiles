ZINIT_HOME="${XDG_DATA_HOME:-${HOME}}/.config/zinit"

install_zinit_if_missing() {
    if [ ! -d $ZINIT_HOME ]; then
      echo "Missing zinit, installing..."
      mkdir -p "$(dirname $ZINIT_HOME)"
      git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
    fi
}

get_exit_code() {
    if [ $# -ne 1 ]; then
        echo "Internal error: i get_exit_code expects  args, got: $#"
        return 1
    fi
    eval "$1" && echo "0" || echo "1"
}

try_add_nvidia_variables() {
    export LIBVA_DRIVER_NAME=nvidia
    export XDG_SESSION_TYPE=wayland
    export GBM_BACKEND=nvidia-drm

    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export WLR_NO_HARDWARE_CURSORS=1
    export QT_QPA_PLATFORM=wayland

    export SDL_VIDEODRIVER=wayland
    export MOZ_ENABLE_WAYLAND=1
}
# https://github.com/ohmyzsh/ohmyzsh/wiki/Settings
# https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# https://github.com/zdharma-continuum/zinit

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
# ZSH_THEME="heapbytes"

# Options section
setopt auto_cd                   # Change directory by typing its name + enter
setopt auto_push_d               #
setopt push_d_ignore_dups        #
setopt no_beep                   # No beep
setopt append_history            # Immediately append history instead if overwriting
setopt correct                   # Auto correct mistakes
# setopt inc_append_history       # Save commands are added to the history immediately, otherwise only when shell exits
# setopt extendedglob
# setopt nocaseglob
# setopt rcexpandparam
setopt numeric_glob_sort         # Sort files numerically when it makes sense
setopt interactive_comments      # Allow comments in interactive mode
setopt notify                    # Report the status if background jobs immediately

# Configure key bindings
bindkey '^[[3~' delete-char              # delete
bindkey '^[[H' beginning-of-line         # home
bindkey '^[[F' end-of-line               # end
bindkey '^L' clear-screen                # ctrl + l
bindkey '^p' history-search-forward      # ctrl + p
bindkey '^n' history-search-backward     # ctrl + n
bindkey '^[[1;3D' 'backward-word'        # left alt + left arrow
bindkey '^[[1;3C' 'forward-word'         # right alt + right arrow

WORDCHARS=${WORDCHARS//\/}

# Theming section
autoload -U compinit colors zcalc
compinit
colors

DEFAULT_USER=$USER

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE

# setopt hist_expire_dups_first    # Delete duplicates first when HISTFILE size exceeds
setopt hist_save_no_dups
setopt hist_ignore_space         # Ignore commands that start with space
setopt share_history

# Completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

plugins=(
git
sudo
web-search
history
jsontools
colored-man-pages
)

libraries=(
git
async_prompt)

custom_plugins=(
zsh-users/zsh-syntax-highlighting  # https://github.com/zsh-users/zsh-syntax-highlighting
zsh-users/zsh-autosuggestions      # https://github.com/zsh-users/zsh-autosuggestions
zpm-zsh/clipboard                  # https://github.com/zpm-zsh/clipboard
)


# install_zinit_if_missing()

source "${ZINIT_HOME}/zinit.zsh"

for custom_plugin in $custom_plugins[@]; do
    zinit light $custom_plugin
done

for plugin in $plugins[@]; do
    zinit snippet OMZP::${plugin}
done

for library in $libraries[@]; do
    zinit snippet OMZL::${library}.zsh
done

zi cdclear -q # <- forget completions provided up to this moment
setopt promptsubst

# Theme 1
# zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
# zinit light sindresorhus/pure

# Theme 2
zinit snippet OMZT::$ZSH_THEME

# Aliases
alias ll="ls -al"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias diff="diff color=auto"
alias cls="clear"
alias ls="lsd"
alias less="bat"
alias d="dirs -v"
alias gp="git push"
alias gc="git checkout -b"
alias gcm="git checkout master && git pull"
alias cff="cargo fix && cargo fmt"
alias mkdir="mkdir -p"

unalias zi
# unset **<TAB>
# export **<TAB>
# unalias **<TAB>
# export FZF_COMPLETION_TRIGGER='~~'
export FZF_DEFAULT_OPTS='--preview "if [[ -d {} ]]; then lsd --color=always {} 2>/dev/null; fi; if [[ -f {} ]]; then bat --style=numbers --color=always --line-range :500 {}; fi"'
has_nvidia_loaded_module=$(get_exit_code 'lsmod | grep -q nvidia_')

if [[ has_nvidia_loaded_module -eq 0 ]]; then
    try_add_nvidia_variables
fi

eval "$(zoxide init zsh)"

is_in_virtual_term=$(get_exit_code 'tty | grep -Eq "/dev/pts.*"')
if [[ is_in_virtual_term -eq 0 ]]; then
    eval "$(starship init zsh)"
fi
