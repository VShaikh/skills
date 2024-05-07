## Create cron job

```
#In every minute, run a script to move APK files.
sudo crontab -e
*/1 * * * * /home/vahid/move_jenkins_build_to_gdrive.sh

cat /home/vahid/move_jenkins_build_to_gdrive.sh
cp /home/vahid/JenkinsBuild/*.apk /run/user/1000/gvfs/google-drive:host=gmail.com,user=meet2vah1d/0APAO6407KJdjUk9PVA/1br-LlPzDej_pI2oDGGDPdrxiPbmKh1jp && rm -f /home/vahid/JenkinsBuild/*.apk
```
