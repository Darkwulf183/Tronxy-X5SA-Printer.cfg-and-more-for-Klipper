First of all. A special Thanks to orobardet. He wrote a Solution to an Issue Report on Github. 
I wrote it to an MD File. So it can be used easily for everyone. 

Here is a step-by-step guide on how to implement the "buster rollback" workaround for compiling klipper firmware on small AVR directly from your Raspberry Pi:

1. Open a terminal window on your Armbian based Machine.
2. Edit the source file by typing the following command: ```sudo nano /etc/apt/sources.list```
3. Add the following line just below the bullseye one: ```deb http://deb.debian.org/debian buster main contrib non-free```
4. Save and exit the file.
5. Create a new apt preferences file by typing the following command: ```sudo nano /etc/apt/preferences.d/avr-buster```
6. Add the following content to the file:

```
Package: avr-libc avrdude binutils-avr gcc-avr
Pin: release n=buster
Pin-Priority: 1001
```

7. Save and exit the file.
8. Update the package lists by typing the following command: ```sudo apt update```
9. Install the avr packages by typing the following command: ```sudo apt install avr-libc avrdude binutils-avr gcc-avr```
10. Even if the packages are already installed, the command above will force apt to downgrade them.
11. Try again to compile Klipper for AVR 328p by typing ```make clean``` followed by ```make``` or simply use Kiauh.
12. This setup does not prevent the rest of your OS to have regular package updates on bullseye. 
    You can still use ```apt upgrade``` to update all other packages, but only the four AVR packages will be kept on the buster branch.

Note: This workaround is not a permanent solution, and it is recommended to upgrade to a more recent version of AVR toolchain when possible...
