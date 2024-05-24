## Environments and aliases
```
export PATH=/home/vahid/Android/Sdk/platform-tools:$PATH
#export PATH=/opt/flutter/bin:$PATH
export PATH=/home/vahid/snap/flutter/common/flutter/bin:$PATH
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
```