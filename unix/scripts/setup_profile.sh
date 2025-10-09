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

export SOLR_HOME=/opt/solr
export PATH=$SOLR_HOME/bin:$PATH

export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export CUDA_HOME=/usr/local/cuda

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
