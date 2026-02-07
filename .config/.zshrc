# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"
#starship
eval "$(starship init zsh)"

#command 
pokemon-colorscripts -r

setopt no_nomatch

#export
export QT_QPA_PLATFORMTHEME=gtk2
# export CFLAGS="-Wno-error"
export SPACESHIP_C_SHOW=false export CC="clang"
# CFLAGS="" python -m pip install libvirt-python --break-system-packages
# export CFLAGS="-fsanitize=signed-integer-overflow -fsanitize=undefined -ggdb3 -O0 -std=c11 -Wall -Werror -Wextra -Wno-sign-compare -Wno-unused-parameter -Wno-unused-variable -Wshadow"
export LDLIBS="-lcrypt -lcs50 -lm"
export HYPRSHOT_DIR="$HOME//Pictures/screenshots"
export XDG_PICTURES_DIR="$HOME/Pictures/screenshots"
export PATH=$PATH":$HOME/.local/bin"
export PATH=$PATH":$HOME/.local/bin/scripts"
export VISUAL=nvim;
export EDITOR=nvim;
export PATH="$PATH:$HOME/.config/composer/vendor/bin"
#ranger SHIFT + X
function ranger {
  local quit_cd_wd_file="$HOME/.cache/ranger/quit_cd_wd"        # The path must be the same as <file_saved_wd> in map.
  #command ranger "$@"              # If you have already added the map to rc.conf
  # OR add `map X quitall_cd_wd ...` if you don't want to add the map in rc.conf
  command ranger --cmd="map X quitall_cd_wd $quit_cd_wd_file" "$@"
  if [ -s "$quit_cd_wd_file" ]; then
    cd "$(cat $quit_cd_wd_file)"
    true > "$quit_cd_wd_file"
  fi
}
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
#Plugin
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git

# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

#History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
#wall/pywall
[ -f "$HOME/.cache/wal/sequences" ] && cat "$HOME/.cache/wal/sequences"
#RUN NVIDIA GPU ON WINE
alias wine='DRI_PRIME=1 wine'
alias wine64='DRI_PRIME=1 wine64'
#GITHUB SSH CONNECT
# eval $(keychain --eval --quiet ~/mykey)
# Aliases
alias tree='exa -T --icons'
alias ls='exa --icons'
alias screenshot='hyprshot -m window'
alias la='ls -la'
alias rice='fastfetch'
alias yta-aac="yt-dlp --extract-audio --audio-format aac "
alias yta-best="yt-dlp --extract-audio --audio-format best "
alias yt-flac="yt-dlp --extract-audio --audio-format flac "
alias yt-mp3="yt-dlp --extract-audio --audio-format mp3 "
alias yt-mp4="yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 "
# Shell integrations
eval "$(fzf --zsh)"

export PATH=$PATH:/home/erlan/.spicetify

# opencode
export PATH=/home/erlan/.opencode/bin:$PATH
