Vorwort: 
In diesem Teil geht es um das Backup Script. Dieses ist in meinem MainsailOS Image schon implementiert und muss dort nur configuriert werden. 

Für die, die es nachinstallieren möchten allerdings gilt:
Als Erstes das Backup Script in den Ordner /home/pi zu kopieren.
Dieses erledigt Ihr am besten mit Winscp, Filezilla oder ähnlichem. Erfahrene Nutzer können die Datei auch anlegen und die Befehle reinkopieren.
Nachdem ihr das Script reinkopiert habt, müsst Ihr es ausführbar machen mit:

$ chmod +x Backup.sh
 
Da wir bei Klipper so wenig wie möglich im Root anlegen wollen, ist dieser Befehl ohne Sudo möglich und auch erforderlich, um die Rechte 
Vergabe von Klipper Mainsail usw. nicht zu verletzen und dass das Script dadurch nicht ausgeführt werden kann.

Als Nächstes müsst ihr in /home/pi/klipper_config einen Ordner anlegen. Diese könnt Ihr auch über die Mainsail überfläche machen. 
In Mainsail auf Maschine dann dort wo auch die printer.cfg liegt auf Verzeichnis Erstellen klicken und einen Ordner namens Backuplogs anlegen.
(Diese Schritte gelten auch für das fertige Image, da Ich aus im Video erläuterten Gründen diesen nicht angelegt habe.)
In selbigen Ordner müssen zwei Log Dateien.

log_fail.log
log_ready.log 

Diese können auch über die Oberfläche in Mainsail angelegt werden.

Als Nächstes gehen wir wieder über die Konsole weiter vor.

Ihr öffnet im Verzeichnis /home/pi die Backup.sh mit dem Befehl:

$sudo nano Backup.sh

Dort drinnen findet Ihr diese 4 Zeilen:

####################################################################################

# rm -rv /media/timeusb/Backup/klipper_config 1>> /home/pi/klipper_config/Backuplogs/log_ready.log 2>> /home/pi/klipper_config/Backuplogs/log_fail.log 
# sleep 1s ; cp -rpv /home/pi/klipper_config/ /media/timeusb/Backup/klipper_config 1>> /home/pi/klipper_config/Backuplogs/log_ready.log 2>> /home/pi/klipper_config/Backuplogs/log_fail.log

rm -rv /home/pi/shares/klipper/Backup/klipper_config 1>> /home/pi/klipper_config/Backuplogs/log_ready.log 2>> /home/pi/klipper_config/Backuplogs/log_fail.log 
sleep 1s ; cp -rpv /home/pi/klipper_config/ /home/pi/shares/klipper/Backup/klipper_config 1>> /home/pi/klipper_config/Backuplogs/log_ready.log 2>> /home/pi/klipper_config/Backuplogs/log_fail.log  

####################################################################################

Bitte überprüft den Pfad bei timeusb. Es ist möglich das Ich aus versehen usbmedium eingetragen habe. Das muss ausgetauscht werden mit timeusb.

Für den USB-Stick benötigen wir noch einen Zwischenschritt.

$ sudo mkdir /media/timeusb/Backup

Dieses ist wichtig um sicher zu stellen das auch wirklich der Ordner verwendet werden kann.


Als Nächstes müsst Ihr Euch überlegen, ob Ihr auf den USB-Stick von der Kamera sichern wollt oder auf Euer NAS.
Dementsprechend müsst Ihr dann don 2 Zeilen die Rauten entfernen und bei den anderen 2 die Rauten einfügen.

Oder aber Ihr sichert doppelt.

Sind nun alle Mountpoints korrekt angelegt und die Auswahl getroffen könnt Ihr das Backup manuell starten per Gcode Macro.

Hierzu muss allerdings das Kiauh Bash script noch nachinstalliert werden. Dieses habe Ich auch beim Image weg gelassen. Gründe auch hier im Video.

Wir öffnen also jetzt zuerst Kiauh:

$ ./kiauh/kiauh

dort angekommen wechseln wir auf Menü 4 Advanced.
Dann auf den Punkt 9 Shell Command.

Mit Y bestätigen und nochmal mit Y bestätigen.

Ist dieses abgeschlossen, würde Ich empfehlen:

$ sudo reboot

Weiter gehts dann in der Printer.cfg bzw. In meinem Image schon vorhanden in der macros.cfg

dort fügt Ihr (in meinem Image überprüft Ihr ob) dieses Macro ein.

####################################

[gcode_shell_command BACKUP_START]
command: sh /home/pi/Backup.sh
timeout: 10.
verbose: True

[gcode_macro BACKUP]
gcode: 
      RUN_SHELL_COMMAND CMD=BACKUP_START

###################################

