## Wifi settings
```
iwconfig
#look for Frequency for 2.4GHz or 5GHz

/etc/NetworkManager/conf.d/default-wifi-powersave-on.conf
#wifi.powersave = 2
0: use the default value
1: don't touch existing setting
2: disable powersave
3: enable powersave

sudo service NetworkManager restart

```