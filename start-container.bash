#!/bin/sh

MOUNT_POINTS="$@"

stop_container() {
 echo 'received SIGTERM'
 umount $MOUNT_POINTS
 sleep 1
 exit
}

trap stop_container SIGTERM SIGINT

mdadm -Dsv 2>/dev/null > /etc/mdadm.conf
pvscan >/dev/null && vgscan >/dev/null && lvscan >/dev/null

MD_LVGROUPS="$(pvscan  | grep '/dev/md' | awk '{print $4}')"
for lvgroup in $MD_LVGROUPS; 
  do echo $lvgroup
  MD_LV="$(lvscan | grep "$lvgroup" | awk -F\' '{print $2}')"
  mkdir -p $1
  mount $MD_LV $1
  shift
done

# ToDo: mount all points

while :
do
  sleep 5
done


