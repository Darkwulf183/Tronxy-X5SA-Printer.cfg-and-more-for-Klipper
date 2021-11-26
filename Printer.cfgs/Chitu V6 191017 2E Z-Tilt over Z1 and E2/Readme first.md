# Important Note

This Stuff works for Chitu V6_191017 E2 Board with STM32F103


## This note must be executed before the first test. Otherwise the device may be damaged.
```cpp
Before you can use this board in Dual Z mode, you must set the jumpers to Z2 as shown in the picture. 
This is necessary because on the Tronxy board Z1 and Z2 are not connected in parallel as with other manufacturers, but in series.
The reference voltage does not need to be adjusted. It still fits because the driver adjusts to 1.67 amperes in the current limit as before.
```
 
The Excel Document is Copyright by ME Darkwulf1986 and is only for personal use !!!