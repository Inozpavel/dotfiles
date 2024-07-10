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
setopt autocd                   # Change directory by typing its name + enter
setopt nobeep                   # No beep
setopt appendhistory            # Immediately append history instead if overwriting
setopt correct                  # Auto correct mistakes
# setopt inc_append_history       # Save commands are added to the history immediately, otherwise only when shell exits
# setopt extendedglob
# setopt nocaseglob
# setopt rcexpandparam
setopt numericglobsort          # Sort files numerically when it makes sense
setopt interactivecomments      # Allow comments in interactive mode
setopt notify                   # Report the status if background jobs immediately


WORDCHARS=${WORDCHARS//\/}
# Theming section
autoload -U compinit colors zcalc
compinit -d
colors

DEFAULT_USER=$USER

# configure key bindings
bindkey '^]]3~' delete-char
bindkey '^[[H' beginning-of-line # home
bindkey '^[[F' beginning-of-line # end

# history configuration
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000

setopt hist_expire_dups_first    # Delete duplicates first when HISTFILE size exceeds
setopt hist_ignore_dups          # If a new command is duplicate, remove the older one
setopt hist_ignore_space         # Ignore commands that start with space

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

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
gitfast
colored-man-pages
jump
zsh-autosuggestions
rust
dotnet
clipboard
)

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}}/.config/zinit"
if [ ! -d $ZINIT_HOME ]; then
  echo "zinit is missing. Installing..."
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting  # https://github.com/zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions      # https://github.com/zsh-users/zsh-autosuggestions
zinit light zpm-zsh/clipboard                  # https://github.com/zpm-zsh/clipboard

# source $ZSH/oh-my-zsh.sh

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ll="ls -al"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias diff="diff color=auto"
alias cls="clear"
alias ls="lsd"
alias less="bat"