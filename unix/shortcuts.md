## Desktop shortcuts

```
mkdir /opt/kdenlive/
wget -D /opt/kdenlive/icon.png https://discuss-cdn.kde.org/uploads/default/original/2X/2/2de3adc075365366f68ce84da881a5a9d4c9efc4.png
sudo gedit /usr/share/applications/kdenlive.desktop
[Desktop Entry]
Version=2023.2.1
Name=Kdenlive
GenericName=IDE
Exec=/opt/kdenlive/kdenlive-25.08.3-x86_64.AppImage
Icon=/opt/kdenlive/icon.png
Terminal=false
Type=Application
MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
Categories=Network;WebBrowser;
Keywords=web;browser;internet;
Actions=new-window;new-private-window;profile-manager-window;

X-Desktop-File-Install-Version=0.26


sudo ln -s /opt/idea-IC-232.9559.62 /opt/intellij
sudo vi /usr/bin/intellij
#!/bin/bash
cd /opt/intellij/bin/
/bin/bash ./idea.sh

sudo gedit /usr/share/applications/intellij.desktop
[Desktop Entry]
Version=2023.2.1
Name=IntelliJ
GenericName=IDE
Exec=/usr/bin/intellij %u
Icon=/opt/intellij/bin/idea.png
Terminal=false
Type=Application
MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
Categories=Network;WebBrowser;
Keywords=web;browser;internet;
Actions=new-window;new-private-window;profile-manager-window;

X-Desktop-File-Install-Version=0.26

[Desktop Action new-window]
Name=Open a New Window
Exec=intellij --new-window %u

sudo vi /usr/bin/studio
#!/bin/bash
cd /opt/android-studio/bin
/bin/bash ./studio.sh

sudo gedit /usr/share/applications/studio.desktop
[Desktop Entry]
Version=2023.2.1
Name=Android Studio
GenericName=IDE
Exec=studio %u
Icon=/opt/android-studio/bin/studio.svg
Terminal=false
Type=Application
MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
Categories=Network;WebBrowser;
Keywords=web;browser;internet;
Actions=new-window;new-private-window;profile-manager-window;

X-Desktop-File-Install-Version=0.26

[Desktop Action new-window]
Name=Open a New Window
Exec=studio --new-window %u
 

sudo gedit /usr/share/applications/jdownloader2.desktop
[Desktop Entry]
Version=2.0
Name=JDownloader
GenericName=IDE
Exec=jdownloader2 %u
Icon=/opt/jdownloader2/themes/standard/org/jdownloader/images/logo/jd_logo_128_128.png
Terminal=false
Type=Application
MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
Categories=Network;WebBrowser;
Keywords=web;browser;internet;
Actions=new-window;new-private-window;profile-manager-window;

```