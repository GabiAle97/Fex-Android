#!/data/data/com.termux/files/usr/bin/bash
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
cmd="/data/data/com.termux/files/usr/bin/proot"
cmd+=" --link2symlink"
cmd+=" -0"
cmd+=" -r ubuntu-fs64"
cmd+=" -b /dev"
cmd+=" -b /proc"
cmd+=" -b /sys"
cmd+=" -b ubuntu-fs64/root:/dev/shm"
cmd+=" -b /data/data/com.termux/files/usr/tmp:/tmp"
cmd+=" -b /sdcard"
cmd+=" -w /root"
cmd+=" /bin/FEXInterpreter"
cmd+=" $cmdstart"
$cmd
