fpath=(~/.zsh/functions ~/.zsh/completion $fpath)

# Set up the prompt
autoload -Uz promptinit
promptinit
prompt vanya

setopt auto_cd auto_pushd pushd_ignore_dups always_to_end auto_list auto_menu no_beep list_packed list_types
setopt append_history hist_ignore_space hist_ignore_alldups share_history hist_reduce_blanks
setopt rcs short_loops c_bases notify extended_glob interactive_comments
setopt rm_star_wait zle no_flow_control rc_expand_param
setopt prompt_subst
setopt nonomatch

autoload -Uz colors
colors

bindkey -v

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
autoload man_glob multicomp zed slay zmv
compinit

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
# cache-path must exist
zstyle ':completion:*' cache-path ~/.zsh/cache

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

for config in ~/.zsh/plugins/plugins.zsh $(find ~/.zsh/auto -type f -name '*.zsh' -print); do
  [ -f $config ] && source $config
done

insert_sudo() { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey -M viins '^q' push-line
bindkey -M vicmd '^q' push-line
bindkey -M viins '^s' insert-sudo
bindkey -M vicmd '^s' insert-sudo
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward
