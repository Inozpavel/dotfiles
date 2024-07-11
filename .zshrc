# https://github.com/ohmyzsh/ohmyzsh/wiki/Settings
# https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
# ZSH_THEME="heapbytes"

# Options section
setopt auto_cd                   # Change directory by typing its name + enter
setopt no_beep                   # No beep
setopt append_history            # Immediately append history instead if overwriting
setopt correct                  # Auto correct mistakes
# setopt inc_append_history       # Save commands are added to the history immediately, otherwise only when shell exits
# setopt extendedglob
# setopt nocaseglob
# setopt rcexpandparam
setopt numeric_glob_sort          # Sort files numerically when it makes sense
setopt interactive_comments      # Allow comments in interactive mode
setopt notify                   # Report the status if background jobs immediately

# configure key bindings
# bindkey -e
bindkey '^[[3~' delete-char      # delete
bindkey '^[[H' beginning-of-line # home
bindkey '^[[F' end-of-line       # end
bindkey '^L' clear-screen        # ctrl + l
bindkey '^p' history-search-forward    # ctrl + l
bindkey '^n' history-search-backward      # ctrl + l

WORDCHARS=${WORDCHARS//\/}
# Theming section
autoload -U compinit colors zcalc
compinit
colors

DEFAULT_USER=$USER

# history configuration
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE

# setopt hist_expire_dups_first    # Delete duplicates first when HISTFILE size exceeds
setopt hist_save_no_dups
setopt hist_ignore_space         # Ignore commands that start with space
setopt share_history

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
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

# https://github.com/zdharma-continuum/zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}}/.config/zinit"
if [ ! -d $ZINIT_HOME ]; then
  echo "Missing zinit, installing..."
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
fi

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

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Aliases
alias ll="ls -al"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias diff="diff color=auto"
alias cls="clear"
alias ls="lsd"
alias less="bat"

# init_plugins_with_oh_my_zsh() {
#     export ZSH="${USER_HOME}/.oh-my-zsh"
#     export ZSH_CUSTOM="${ZSH}/custom"
#     yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#
#     for custom_plugin in $custom_plugins[@]; do
#         directory="${ZSH_CUSTOM}/plugins/{custom_plugin}"
#         if [ ! -d $directory ]; then
#             git clone "https://github.com/${custom_plugin}" $directory
#         fi
#     done
#
#     source $ZSH/oh-my-zsh.sh
# }