#!/bin/bash
echo
function ceho {
	echo -e "\e[32m[tvs-m] \e[34m$1 $2 $3 $4 $5\e[39m"

}
function cehot {
	echo -e "\e[32m[tvs-m] \e[34m$1 $2 $3 $4 $5"
}
cehot 'Установщик blender termux v1.'

function fedorai {
	cd ~
	if
pkg install wget openssl-tool proot tar -y && hash -r && wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/Installer/Fedora/fedora.sh && bash fedora.sh;
then echo ;
else ceho 'Ошибка при установке fedora.' && exit 2 ;
	fi
	cp ~/fedora-termux-blender/start-fedora.sh ~/ 
}

function write-brc {

cd /mnt/sdcard/
cat >.bashrc<<-EOM

export DISPLAY=:2
yum update -y
rm -f /var/lib/rpm/__db.*
rpm -rebuilddb
yum install tigervnc tigervnc-server openbox lxpanel blender

echo настройка vncserver...
vncserver -geometry 1280x720 :2
vncserver -kill :2
echo введите exit для завершения установки
alias e='exit'
export PS1='exit для завершения $ '


EOM
}

cat >/data/data/com.termux/files/usr/bin/blender<<-EOM
clear
~/start-fedora.sh
EOM

chmod +x /data/data/com.termux/files/usr/bin/blender 

fedorai
write-brc
~/start-fedora.sh
cat >/mnt/sdcard/.bashrc<<-EOM

echo 'echo Запуск blender... '
export DISPLAY=:2 
rm /tmp/.X2-lock 
rm /tmp/.X11-unix/X2  
if vncserver -geometry 1280x720 :2 ; then export DISPLAY=:2 & openbox & lxpanel & blender ; else echo ошибка запуска Xvnc; fi
exec bash

EOM

ceho установка завершена
