#!/data/data/com.termux/files/usr/bin/bash
cd $(dirname $0)
## unset LD_PRELOAD in case termux-exec is installed
unset LD_PRELOAD
command="proot --kill-on-exit"
command+=" --link2symlink"
command+=" -0"
command+=" -r fedora-fs"
if [ -n "$(ls -A fedora-binds)" ]; then
    for f in fedora-binds/* ;do
      . $f
    done
fi
command+=" -b /dev"
command+=" -b /proc"
command+=" -b fedora-fs/tmp:/dev/shm"
## uncomment the following line to have access to the home directory of termux
command+=" -b /data/data/com.termux/files/home:/termux"
## uncomment the following line to mount /sdcard directly to / 
command+=" -b /sdcard"
command+=" -b /mnt/sdcard"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=$TERM"
command+=" LANG=C.UTF-8"
command+=" /bin/bash --login"
command+=" exec ~/.bashrc/"
com="$@"
if [ -z "$1" ];then
    exec $command
else
    $command -c "$com"
fi
