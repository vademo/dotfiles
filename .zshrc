# If you come from bash you might have to change your $PATH.
export DOCKER_BUILDKIT=0

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export PATH=$PATH:/usr/bin/go/bin

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"
DEFAULT_USER="$(whoami)"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

gitbranches() {
    git for-each-ref --sort=-committerdate refs/heads/ --format='%(authordate:short) %(color:red)%(objectname:short) %(color:yellow)%(refname:short)%(color:reset) (%(color:green)%(committerdate:relative)%(color:reset))'
}

py() { python3 $1 }

todo() { tb }
todod() { tb -l digipolis }
# Alias for killing background processes by id
KillLocalProcessByPort() { kill -9 $(lsof -t -i:"$1"); }
# Alias staring docker of project
dcstart() {docker stop $(docker ps -a -q) && docker-compose up -d $1 }
dcstop() {docker stop $(docker ps -a -q)}
pcstop() {podman stop $(podman ps -a -q)}
connectPodman() {
    if [[ -n $1 ]]; then
        # 501 is user i suppose it wont change
      ssh -fnNT -L/tmp/podman.sock:/run/user/501/podman/podman.sock -i ~/.ssh/podman-machine-default ssh://core@localhost:$1 -o StreamLocalBindUnlink=yes
      export DOCKER_HOST='unix:///tmp//podman.sock'
    else
      echo "$1"
      podman system connection list
    fi
    # podman system connection list
    # ssh -fnNT -L/tmp/podman.sock:/run/user/501/podman/podman.sock -i ~/.ssh/podman-machine-default ssh://core@localhost:49514 -o StreamLocalBindUnlink=yes

    # export DOCKER_HOST='unix:///tmp//podman.sock'
}

whattodo() {grep -rnw ./ -e @TODO --exclude-dir=node_modules}

enterContainer() { docker exec -it $1 bash }

enterContainerbyName() {
    DOCKER_ID="$(docker ps -qf name=$1)"
    echo 'log'.$DOCKER_ID
    docker exec -it $DOCKER_ID bash
}

switchgit() {
  var=$(<~/.ssh/config)
  if [[ $var == *"id_ed25519"*  ]]; then
      echo "switching to Personal 🤖"
      sed -i 's/id_ed25519/vademo_ed25519/g' /home/olivier/.ssh/config
  else
      echo "switching to Digipolis 🌆"
      sed -i 's/vademo_ed25519/id_ed25519/g' /home/olivier/.ssh/config
  fi
}

echo "Using digipolis key git 🌆"
sed -i 's/vademo_ed25519/id_ed25519/g' /home/olivier/.ssh/config

showStash() { git stash apply stash@{$1} }

dockerlogs() { docker logs --follow $1 }
dockerlogsbyName() {
    DOCKER_ID="$(docker ps -qf name=$1)"
    echo 'found container with id: '.$DOCKER_ID
    docker logs --follow $DOCKER_ID
}
#Restart single container by name
dockerrestart() {
    # CONTAINER='$(docker ps -a -q --filter="name='$1'")';
  echo"stop container $2";
  echo"restart file $1";
  docker stop $(docker ps -a -q --filter="name=$2") && docker-compose -f $1 up --force-recreate $2
}

setlightmode() {
  VIM_MODE="LIGHT"
  TMUX_MODE="LIGHT"
  tmux set -g status-left '#[fg=#ffffff,bg=#005f87] %H:%M:%S  Date: #[fg=#ffe500]%d-%m-%Y  '
  tmux set-option -g status-bg "#005f87" #base02
  tmux set-option -g status-fg "#ffffff" #yellow
  tmux set -g status-right '#[fg=#ffffff,bg=#005f87] Battery: #{battery_percentage} #[fg=#ffe500,bright] MEM/CPU: #(tmux-mem-cpu-load --averages-count 0)'

  tmux set-window-option -g window-status-current-format '#[fg=#ffe500,bold]|> #[fg=blue,bold]#{window_index} #[fg=#00d700]#(echo "#{pane_current_path}" | rev | cut -d'/' -f-1 | rev) #[fg=#ffe500]<|'
  tmux set-window-option -g window-status-format '#[fg=blue,bold]#{window_index} #[fg=green]#(echo "#{pane_current_path}" | rev | cut -d'/' -f-1 | rev) #[fg=yellow,bold]|'
  export VIM_MODE
}
# source <(antibody init)

# gpr() {
#     git push origin HEAD && git open-pr "$@"
# }



# Load Angular CLI autocompletion.

# Created by `pipx` on 2024-03-22 13:49:08
export PATH="$PATH:/Users/oliviervandenmooter/.local/bin"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
