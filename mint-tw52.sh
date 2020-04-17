#!/bin/sh
ISO=linuxmint-19.3-cinnamon-64bit.iso

ISO_FILE=`pwd`/${ISO}
GRUB_PARAMETERS="fbcon=rotate:1"
XORG_D=/usr/share/X11/xorg.conf.d
XORG_CONF=/etc/X11
SILEAD=/lib/firmware/silead
UDEV=/usr/lib/udev/hwdb.d
AUTOROTATE=/usr/share/autorotate
SOUNDFIX=/usr/share/es8316
PACKAGES="inotify-tools iio-sensor-proxy xinput-calibrator onboard"

./isorespin.sh -i $ISO_FILE \
-g "" \
-g ${GRUB_PARAMETERS} \
--rolling-release-hwe \
-f tw52 \
-c "mkdir -p ${XORG_D} ${XORG_CONF} ${SILEAD} ${UDEV} ${AUTOROTATE} ${SOUNDFIX}" \
-c "mv /usr/local/bin/tw52${XORG_D}/* ${XORG_D}" \
-c "mv /usr/local/bin/tw52${XORG_CONF}/* ${XORG_CONF}" \
-c "mv /usr/local/bin/tw52${SILEAD}/* ${SILEAD}" \
-c "mv /usr/local/bin/tw52${UDEV}/* ${UDEV}" \
-c "mv /usr/local/bin/tw52${AUTOROTATE}/* ${AUTOROTATE}" \
-c "mv /usr/local/bin/tw52${SOUNDFIX}/* ${SOUNDFIX}" \
-c "rm -rf /usr/local/bin/tw52" \
-p "${PACKAGES}"

