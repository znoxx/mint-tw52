# Run linux on crappy Win10 Atom tablets #

ISORespin-based generator of Linux Mint images for crappy Atom Windows 10 Tablets. 

## Compatibility

Tested on:

* Irbis TW52
* Digma Citi 1804

However, if you have a tablet with Atom Z83xx, Silead touch and ES1836 sound -- it may work for you.

Tested with:

* Linux Mint XFCE 19.03
* Linux Mint Mate 19.03
* Linux Mint Cinnamon 19.03 (here you may have issues with rotated desktop -- change rotation settings)
* Generally any other distro, supported with [linuxium iso respin](http://www.linuxium.com.au/how-tos) should work.


## Setting up

### Requirements

* Ubuntu server or workstation x86 with command line
* Git
* Free space for downloaded + generated iso's and packages.

### Preparation

Clone this repo, cd to it.

Run `./isorespin.sh --check` to check if isorespin.sh must be updated. If it woes for update, get new one [here](http://url.linuxium.com.au/isorespin_sh).

Install needed packages for isorespin. Check pre-requisittes [here](http://www.linuxium.com.au/how-tos) -- you will need some iso tools, squashfs tools.

Download you ISO from official Linux mint site.

Edit `mint-tw52.sh` with you your iso file name.

### Generation

Launch `mint-tw52.sh` and wait to generate a new ISO.

After several minutes it will be ready. Use simple "dd" command to write this ISO file to USB flash drive. 

### First start

Boot your tablet from generated USB Flash. System will show up. You may need to rotate your desktop in "Display" settings. 

### Checking autorotate

Autorotate can be checked by running `sudo /usr/share/autorotate/rotate.sh`. Screen should rotate accordingly. After installation one can add this script to some kind of  "autostart".

### Checking sound

Stop PulseAudio with `pulseaudio -k`

Cd to /usr/share/es8316

Run `sudo ./es8316.sh` -- it will download and unpacked somehow working UCM files. Since those tablets are crappy -- don't expect sound quality at all. You must repeat the step, when system is installed.

Start PulseAudio with `pulseaudio -D`. If it fails, you may need to unload (and blacklist after intallation) the `snd_hdmi_lpe_audio` module.

Sound should work.

### Installation

There are several options to install the system. Just remember, that you need kernel loaded from internal SSD, not the microSD. Using reFind bootloader may help -- for example one can cut 512 mb for boot partiion on internal SSD and then mount it to /boot. Or, just squeeze Windows 10 and get some space for Mint.


## Behind the scenes

### What script does

It generates new ISO file with embedding 32bit grub (which is capable of launching 64bit kernel), it adds touchscreen firmware, calibration settings, rotation settings and some scripts.

It also adds much more recent kernel -- check `mint-tw52` code for details along with isorespin docs.

### References

Great work for Linux installation investigation can be found [here](https://4pda.ru/forum/index.php?showtopic=942823) in Russian. Many thanks for 4pda forum members for making it's possible.

Original script for hacking sounds was found [here](https://www.vivaolinux.com.br/topico/Iniciantes-no-Linux/Novato-Netbook-positivo-sem-som-depois-da-instalacao-do-Linux-Mint-191-MATE), however I removed module compilation, since kernel 5.5 likely has those patches.


## Warranty

There is absolutely no warranty, that it will work for you.