#!/usr/bin/bash
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

# Call the function
replace_or_append_block CUSTOM_SETTINGS /home/vahid/.bashrc <<'EOF'
# custom settings

export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export PATH=$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$PATH

export FLUTTER_HOME=/opt/flutter
export DART_HOME=$FLUTTER_HOME/bin/cache/dart-sdk
export PATH=$FLUTTER_HOME/bin:$DART_HOME/bin:$PATH

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
