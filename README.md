# BridgePi
*A network to serial bridge*

BridgePi is an SD card image for the Rasberry Pi.  Plug in some Arduinos via USB, and their serial ports can be made available over ethernet.

## Download and Install
1. Download the zip file from releases.
2. Unzip the file so that you have an approximately 2 GB img.
2. See "Writing an Image to the SD Card" here: https://www.raspberrypi.org/documentation/installation/installing-images/
3. Insert the SD card into your Rasberry Pi and boot.
4. SSH to 192.168.0.44, or connect mouse, keyboard and screen.
5. Username is root, password is piroot.
6. Configure the bridge using the onscreen menu.

## Warnings
The Raspberry Pi can probably only power a couple Arduinos from its power supply.  Make sure that you have enough external power for all the Arduinos you plug in.

There's no security on this image, not even a firewall.  You should only use this on a private network isolated from the internet.

## Building from source

(replace path/to/foo with the path to that foo on your build system)

1. Get buildroot http://buildroot.uclibc.org/
2. Get bridgepi source (tar.gz from releases, or git clone)
3. `$ cd path/to/buildroot`
4. 
 * For Raspberry Pi: `$ support/kconfig/merge_config.sh -m configs/raspberrypi_defconfig path/to/bridgepi/configs/bridgepi_defconfig_fragment`
 * For Raspberry Pi 2: `$ support/kconfig/merge_config.sh -m configs/raspberrypi2_defconfig path/to/bridgepi/configs/bridgepi_defconfig_fragment`
5. `$ make olddefconfig BR2_EXTERNAL=path/to/bridgepi` 
6. `$ make` (this will take a while the first time)
7. `$ cd path/to/bridgepi`
8. `$ sudo mkimage.sh path/to/buildroot`

Image is created in path/to/bridgepi/bridgepi.img