#!/data/data/com.termux/files/usr/bin/bash
fex="FEX-Android Installation"

function check_storage
{
    dialog --title "$fex" --msgbox "Please allow access storage permission" 10 50
    am broadcast --user 0 --es com.termux.app.reload_style storage -a com.termux.app.reload_style com.termux >/dev/null
}

function obtain_fex-emu_urls
{
    curl -s https://ppa.launchpadcontent.net/fex-emu/fex/ubuntu/pool/main/f/fex-emu-armv8.0/ | grep -oP '(?<=href=")[^"]*' | grep -P '\.deb$' | awk '{print "https://ppa.launchpadcontent.net/fex-emu/fex/ubuntu/pool/main/f/fex-emu-armv8.0/"$0}' | grep "~j" | grep -v "libfex" | grep -v "binfmt" > urls
    curl -s https://ppa.launchpadcontent.net/fex-emu/fex/ubuntu/pool/main/f/fex-emu-armv8.2/ | grep -oP '(?<=href=")[^"]*' | grep -P '\.deb$' | awk '{print "https://ppa.launchpadcontent.net/fex-emu/fex/ubuntu/pool/main/f/fex-emu-armv8.2/"$0}' | grep "~j" | grep -v "libfex" | grep -v "binfmt" >> urls
    curl -s https://ppa.launchpadcontent.net/fex-emu/fex/ubuntu/pool/main/f/fex-emu-armv8.4/ | grep -oP '(?<=href=")[^"]*' | grep -P '\.deb$' | awk '{print "https://ppa.launchpadcontent.net/fex-emu/fex/ubuntu/pool/main/f/fex-emu-armv8.4/"$0}' | grep "~j" | grep -v "libfex" | grep -v "binfmt" >> urls
}

function termux_install
{
    termux-change-repo
    yes | pkg update
    pkg install x11-repo -y
    pkg install tsu termux-x11-nightly wget proot pulseaudio xz-utils git -y
    rm /data/data/com.termux/files/usr/bin/fex
    rm -rf /data/data/com.termux/files/home/Fex-Android/*
    rm -r /sdcard/Fex-Android/*
    git clone https://github.com/GabiAle97/Fex-Android.git .
    wget https://raw.githubusercontent.com/doitsujin/dxvk/master/dxvk.conf
    mv dxvk.conf /sdcard/Fex-Android/
    if grep -q "anonymous" ~/../usr/etc/pulse/default.pa;then
	echo "module already present"
    else
	echo "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" >> ~/../usr/etc/pulse/default.pa
    fi

    echo "exit-idle-time = -1" >> ~/../usr/etc/pulse/daemon.conf
    echo "autospawn = no" >> ~/../usr/etc/pulse/client.conf
    clear
    wget https://github.com/AllPlatform/Fex-Android/releases/download/v1.3-update/ubuntu.tar.xz -O ubuntu.tar.xz
    echo -e "\e[32m[+] Extracting Ubuntu 22.04.3 LTS RootFS...\e[0m"
    tar -xf ubuntu.tar.xz
    mkdir -p patch
    obtain_fex-emu_urls
    echo -e "\e[32m[+] Select the desired FEX-EMU version: \e[0m"
    echo -e "\e[32m[+] 1) FEX-EMU armv8.0 \e[0m"
    echo -e "\e[32m[+] 2) FEX-EMU armv8.2 \e[0m"
    echo -e "\e[32m[+] 3) FEX-EMU armv8.4 \e[0m"
    read fex_version
    while [[ "$fex_version" != "1" ]] && [[ "$fex_version" != "2" ]] && [[ "$fex_version" != "3" ]]; do
        echo -e "\e[32m[+] Invalid option. Try again: \e[0m"
        echo -e "\e[32m[+] 1) FEX-EMU armv8.0 \e[0m"
        echo -e "\e[32m[+] 2) FEX-EMU armv8.2 \e[0m"
        echo -e "\e[32m[+] 3) FEX-EMU armv8.4 \e[0m"
        read fex_version
    done
    wget $(sed -n "$fex_version{p;q}" urls) -O patch/update.deb
    echo -e "\e[32m[+] Downloading update patch...\e[0m"
    wget https://raw.githubusercontent.com/AllPlatform/Fex-Android/main/patch/ThunksDB.json -O patch/ThunksDB.json
    echo -e "\e[32m[+] Apply update patch...\e[0m"
    cd patch
    dpkg-deb -x update.deb /data/data/com.termux/files/home/Fex-Android/ubuntu-fs64
    cp ThunksDB.json ../ubuntu-fs64/usr/share/fex-emu/
    cd ../
    echo -e "\e[32m[+] installation is complete\e[0m"
    echo -e "Type \e[31mfex\e[0m command to run"
    rm ubuntu.tar.xz

}

function fexinstall()
{
    dialog --title "$fex" --yesno "Do you want install FEX-Emu?" 10 50
    if [ $? == 0 ]; then
	termux_install
    else
	cd ~
	rm -r Fex-Android
	exit 0
    fi
}

function main()
{
    cd ~
    mkdir Fex-Android
    cd Fex-Android
    check_storage
    fexinstall

}
main

chmod +x start-chroot.sh
chmod +x fex
chmod +x data/fex_data
chmod +x start-proot.sh
mv fex /data/data/com.termux/files/usr/bin
