# ln -s ~/git/skills/unix/scripts ~/scripts
replace_or_append_block() {
    local tag="$1"
    local file="$2"

    local start="# >>> ${tag} >>>"
    local end="# <<< ${tag} <<<"

    # Capture stdin into a temporary file
    local tmpblock
    tmpblock=$(mktemp)
    cat > "$tmpblock"

    if grep -q "$start" "$file"; then
        # Replace block safely
        sed -i "/$start/,/$end/{ 
            /$start/{p; r $tmpblock
            }; 
            /$end/p; 
            d
        }" "$file"
    else
        {
            echo "$start"
            cat "$tmpblock"
            echo "$end"
        } >> "$file"
    fi

    rm -f "$tmpblock"
}

replace_or_append_block CUSTOM_SETTINGS /home/vahid/.bashrc <<'EOF'
# custom settings

export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export PATH=$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$PATH

export FLUTTER_HOME=/opt/flutter
export DART_HOME=$FLUTTER_HOME/bin/cache/dart-sdk
export PATH=$FLUTTER_HOME/bin:$DART_HOME/bin:$PATH
export PATH=$HOME/.pub-cache/bin:$PATH

export SOLR_HOME=/opt/solr
export PATH=$SOLR_HOME/bin:$PATH

export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export CUDA_HOME=/usr/local/cuda

# allow flutter linux apps to install in local
CMAKE_INSTALL_PREFIX=/home/vahid/.local

export GI_TYPELIB_PATH=/usr/lib/x86_64-linux-gnu/girepository-1.0

# disable CUDA
export CUDA_VISIBLE_DEVICES=-1
# unset CUDA_VISIBLE_DEVICES
TF_CPP_MIN_LOG_LEVEL=3
export DLIB_USE_CUDA=0
export DLIB_PNG_SUPPORT=1
export DLIB_JPEG_SUPPORT=1

# enable CUDA
# export TF_FORCE_GPU_ALLOW_GROWTH=true
# export MY_GPU_LIMIT=1024

sstatus(){
  sudo systemctl status $1
}
sstart(){
  sudo systemctl start $1
}
sstop(){
  sudo systemctl stop $1
}
srestart(){
  sudo systemctl stop $1
  sudo systemctl start $1
}
sshow(){
  sudo systemctl show $1
}
slog(){
  if [ -z "$1" ]; then
    journalctl -f
  else
    journalctl -f -u $1
  fi
}
pythonv(){
  /home/vahid/.venv/bin/python
}
pipv(){
  /home/vahid/.venv/bin/pip
}
pip3v(){
  /home/vahid/.venv/bin/pip3
}

# Faster Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~="cd ~"

# Enhanced ls
alias ls='ls --color=auto'          # Colorize output by default
alias ll='ls -lh'                   # Long list, human-readable sizes
alias la='ls -A'                    # List all (including hidden), but omit . and ..
alias l='ls -CF'                    # Column view with type indicators
alias ldir='ls -d */'               # Your directory-only list

alias path='echo -e ${PATH//:/\\n}'  # List every directory in your PATH clearly
alias myip='curl ifconfig.me'        # Quickly get your public IP address
alias df='df -h'                    # Disk usage in GB/MB instead of bytes
alias free='free -m'                # Memory usage in MB
alias h='history'                   # Shortcut for history
alias j='jobs -l'                   # List background jobs with PIDs

alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --all'
alias gd='git diff'

alias resource='source ~/.bashrc'    # Reload bashrc after making changes
alias bashconf='nano ~/.bashrc'      # Quickly edit your bashrc

# Check which ports are open and listening
alias ports='netstat -tulanp'

# Quick check if internet is actually up
alias pingg='ping -c 5 google.com'

# Flush DNS (Useful if a site isn't loading after a change)
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'

# Colorize grep and show line numbers
alias grep='grep --color=auto -n'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Search for a process by name (e.g., 'psg python')
alias psg='ps aux | grep -v grep | grep -i'

# Extract almost any archive format
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1     ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "'$1' cannot be extracted via extract()" ;;
       esac
   else
       echo "'$1' is not a valid file"
   fi
}

# Create a fast tar.gz of a folder
alias mktar='tar -cvzf'

# Clean up orphaned packages (Ubuntu/Debian)
alias apt-clean='sudo apt update && sudo apt autoremove && sudo apt autoclean'

# Show the 10 largest files/folders in the current directory
alias ducks='du -cksh * | sort -hr | head -n 10'

# Print your public IP and local IP side-by-side
alias ips="echo 'Public: ' \$(curl -s ifconfig.me) && echo 'Local:  ' \$(hostname -I | awk '{print \$1}')"

# Tree-like view without installing 'tree'
alias ltree="ls -R | grep ':$' | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"

# Search history for a specific command (Usage: hgrep git)
alias hgrep='history | grep'

# Find the 5 largest directories in the current folder
alias bigdirs='du -hs * | sort -rh | head -5'

# Show only the first 10 and last 10 lines of a file
alias peek='sed -n "1,10p;\$ -9,\$p"'

# Count how many files are in the current directory
alias fcount='ls -1 | wc -l'

# Make a directory and enter it immediately (Usage: mkcd my_project)
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Copy the contents of a file to clipboard (Linux/xclip)
alias copyfile='xclip -sel clip <'

# Update the whole system (Debian/Ubuntu)
alias update='sudo apt update && sudo apt upgrade -y'

# Quick timestamped notes (Usage: note "Meeting started")
alias note='echo $(date +%Y-%m-%d\ %H:%M) - "$1" >> ~/notes.txt'

# Show current weather for your location (Uses wttr.in)
alias weather='curl wttr.in'

# Horizon Client Shortcut Toggles
alias hz-on='gsettings set org.gnome.desktop.wm.keybindings switch-applications "[]" && echo "Ubuntu Alt+Tab Disabled"'
alias hz-off='gsettings set org.gnome.desktop.wm.keybindings switch-applications "[\"<Alt>Tab\"]" && echo "Ubuntu Alt+Tab Enabled"'

# If you ever want to run the original command without the alias (for example, if you want to use rm without the confirmation prompt), just put a backslash before the command:
# \rm filename.txt

conda(){
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/home/vahid/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/home/vahid/miniconda3/etc/profile.d/conda.sh" ]; then
          . "/home/vahid/miniconda3/etc/profile.d/conda.sh"
      else
          export PATH="/home/vahid/miniconda3/bin:$PATH"
      fi
  fi
  unset __conda_setup
}
EOF

mkdir -p /home/vahid/.config/pip/

replace_or_append_block CUSTOM_SETTINGS /home/vahid/.config/pip/pip.conf <<'EOF'
# custom settings
[global]
index-url = https://pypi.org/simple
extra-index-url = http://localhost:8090/simple
trusted-host = localhost

#pip config list
EOF
