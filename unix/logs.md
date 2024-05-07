## Unix systemd logs

https://www.digitalocean.com/community/tutorials/how-to-use-journalctl-to-view-and-manipulate-systemd-logs

```
journalctl
journalctl -b
journalctl --since yesterday
journalctl --since "2015-01-10 17:15:00"
journalctl --since "2015-01-10" --until "2015-01-11 03:00"
journalctl --since 09:00 --until "1 hour ago"
journalctl -u mytubeweb.service
journalctl -u mytubeweb.service -u mysqld.service --since today
journalctl _PID=8088
id -u www-data
journalctl _UID=33 --since today
journalctl -F _GID
journalctl /usr/bin/bash
journalctl -k
journalctl -k -b -5
journalctl -p err -b
journalctl -n 20
journalctl -f
journalctl -f -u mytubeweb.service
```
