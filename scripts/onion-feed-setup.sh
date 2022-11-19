#! /bin/sh

echo "Preparing package feeds..."
./scripts/feeds update -a
./scripts/feeds install -a
#./scripts/feeds install -a -p onion

# take care of Onion customized packages
./scripts/feeds uninstall bluez-examples bluez-libs bluez-utils pulseaudio-daemon pulseaudio-profiles pulseaudio-tools avrdude
./scripts/feeds install -p onion bluez-examples bluez-libs bluez-utils pulseaudio-daemon pulseaudio-profiles pulseaudio-tools avrdude

# Apply patch to update libgphoto from 2.5.17 to 2.5.30 gphoto to 2.5.17 to 2.5.28
if ! patch -R -p 1 -s -f --directory=feeds/packages --dry-run < "files/patches/gphoto-v28-libgphoto-v30.patch"; then
  patch -p 1 --directory=feeds/packages < "files/patches/gphoto-v28-libgphoto-v30.patch"
fi

