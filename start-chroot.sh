#!/data/data/com.termux/files/usr/bin/bash
if [ ! -d /dev/shm ]; then
    sudo mkdir -p /dev/shm
fi
sudo rm -r /data/data/com.termux/files/usr/tmp/.wine*
sudo mount --bind /proc ubuntu-fs64/proc
sudo mount --bind /dev ubuntu-fs64/dev
sudo mount --bind /sys ubuntu-fs64/sys
sudo mount --bind /data/data/com.termux/files/usr/tmp ubuntu-fs64/tmp
sudo mount -t devpts devpts ubuntu-fs64/dev/pts
sudo mount --bind /sdcard ubuntu-fs64/sdcard
sudo chown root:root ubuntu-fs64/root/.wine
pulseaudio --start
source /data/data/com.termux/files/home/Fex-Android/start.sh
unset LD_PRELOAD
unset TMPDIR
unset PREFIX
unset BOOTCLASSPATH
unset ANDROID_ART_ROOT
unset ANDROID_DATA
unset ANDROID_I18N_ROOT
unset ANDROID_ROOT
unset ANDROID_TZDATA_ROOT
unset COLORTERM
unset DEX2OATBOOTCLASSPATH
export DXVK_CONFIG_FILE=/sdcard/Fex-Android/dxvk.conf
export WINEDEBUG=-all
export USE_HEAP=1
export DISPLAY=:1
export MESA_LOADER_DRIVER_OVERRIDE=zink
export GALLIUM_DRIVER=zink
export ZINK_DESCRIPTORS=lazy
export PULSE_SERVER=127.0.0.1
export DXVK_HUD="devinfo,fps,api,version,gpuload"
export DXVK_ASYNC=1
SHELL=/bin/bash
HOME=/root
LANG=C.UTF-8
PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games
cmd="/data/data/com.termux/files/usr/bin/sudo"
cmd+=" -E"
cmd+=" /data/data/com.termux/files/usr/bin/chroot"
cmd+=" ubuntu-fs64"
cmd+=" bin/FEXInterpreter"
cmd+=" $cmdstart"
$cmd
PATH="/data/data/com.termux/files/usr/bin"
user_t=$(whoami)
sudo rm -r ubuntu-fs64/tmp/.wine*
sudo chown $user_t:$user_t ubuntu-fs64/root/.wine
sudo umount -lf ubuntu-fs64/dev
sudo umount -lf ubuntu-fs64/sys
sudo umount ubuntu-fs64/tmp
sudo umount ubuntu-fs64/sdcard
sudo umount -lf ubuntu-fs64/proc
##
sudo chown $user_t:$user_t ubuntu-fs64/root/.wine
sudo umount -lf ubuntu-fs64/dev
sudo umount -lf ubuntu-fs64/sys
sudo umount ubuntu-fs64/tmp
sudo umount ubuntu-fs64/sdcard
sudo umount -lf ubuntu-fs64/proc
