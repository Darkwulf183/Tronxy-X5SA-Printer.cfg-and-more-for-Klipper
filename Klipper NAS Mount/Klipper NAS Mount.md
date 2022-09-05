Vorwort:
Diese Anleitung ist wieder mit Anpassungen in der fstab versehen. Hier gilt es, Fehler zu vermeiden. Lieber 3 Mal prüfen statt 1 Mal Rebooten und Systemstart Fail verursachen.

Die weitere Konfiguration erledigen wir wieder auf der Kommandozeile(Powershell, Putty etc.).

Als allererstes müssen wir prüfen, ob cifs Utilitys installiert sind.
Dazu verwenden wir folgenden Befehl.
```
$ ls -1 /lib/modules/$(uname -r)/kernel/fs
```
Hier erscheint nun eine Liste für installierte Module des Nutzers. Dort sucht ihr nach CIFS,  ist dieser Eintrag vorhanden, könnt ihr die Installation überspringen.

Installation des CIFS Moduls.
```
$ sudo apt-get install cifs-utils
```
Um jetzt weiterzukommen, benötigen wir als Erstes einen Mountpoint im System in Form eines Ordners, der hinterher mit den Daten des Netzlaufwerks gefüllt wird. Er dient nur als leere Hülle.
```
$ mkdir /home/pi/shares
$ mkdir /home/pi/shares/klipper
```
Im nächsten Schritt erstellen wir einen versteckten Ordner, in dem wir die Zugangsdaten für das Netzlaufwerk hinterlegen. 
Später werden wir die Rechte so beschränken, dass hier nur der Benutzer Root Zugriff auf Lese und Schreibrechte dieser Datei hat.
```
$ cd
$ mkdir .credentials
$ nano .credentials/smbcredentials
```
in diese Datei kommen Benutzername und Passwort in Form von:
```
username=DEINNASZUGRIFFSNAME
password=DEINNASZUGRIFFSPASSWORT
```
Aus Sicherheitsgründen werden jetzt die Rechte der Datei verändert.
```
$ sudo chown root: .credentials/smbcredentials
$ sudo chmod 600 .credentials/smbcredentials
```
Damit Raspbian die Freigaben kennt, müssen diese in die Datei /etc/fstab hinterlegt werden.
```
$ sudo nano /etc/fstab
```
Der Eintrag muss folgendermaßen aussehen:

Mount Raspberry Pi
```
//192.168.78.24/NASPLATTE/NASORDNER /home/PIUSERNAME/shares/klipper cifs credentials=/home/pi/.credentials/smbcredentials,users,uid=1000,gid=1000,x-systemd.automount,x-systemd.requires=network-online.target 0 0
```
Mount Raspberry Pi für ältere NAS Geräte (Synology, Fritzbox usw...)
```
//192.168.78.24/NASPLATTE/NASORDNER /home/PIUSERNAME/shares/klipper cifs credentials=/home/pi/.credentials/smbcredentials,users,uid=1000,gid=1000,x-systemd.automount,vers=1.0,x-systemd.requires=network-online.target 0 0
```

Die /etc/fstab sieht dann ungefähr so aus: (Fragezeichen gehören nicht zur fstab)

???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
roc            /proc           proc    defaults          0       0
PARTUUID=8b268a78-01  /boot           vfat    defaults,flush    0       2
PARTUUID=8b268a78-02  /               ext4    defaults,noatime  0       1
UUID=8ab49ed0-459e-428c-9b78-b1e338cd1708 /media/timeusb/ ext4 nofail,x-systemd.device-timeout=1ms 0 0
//192.168.128.007/r_wss1/klipper /home/pi/shares/klipper cifs credentials=/home/pi/.credentials/smbcredentials,users,uid=1000,gid=1000,x-systemd.automount,x-systemd.requires=network-online.target 0 0
a swapfile is not a swap partition, no line here
   use  dphys-swapfile swap[on|off]  for that
???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????

NASPLATTE/NASORDNER muss durch die passende Ordnerstruktur eures NAS ersetzt werden.
PIUSERNAME muss durch den eigenen Benutzernamen ersetzt werden. uid und gid sind normalerweise 1000 für Benutzer 1. 
Wenn jedoch mehrere Benutzer auf dem Rechner angelegt sind, kann diese ID auch eine andere sein. 
Die eigene UID und GID kann durch die Eingabe des Befehls „id -a PIUSERNAME“ in das Terminal überprüft werden.

Jetzt können die Freigaben manuell eingebunden werden. Bei einem Neustart geschieht das automatisch.
```
$ sudo mount -a
```
Jetzt sind die Netzwerkfreigaben über die vorhin erstellten Ordner in das Dateisystem eingebunden.
Nach einem Neustart sollte das nun auch alles automatisch geschehen.
```
$ sudo reboot
```
Happy Printing Time :-)))

