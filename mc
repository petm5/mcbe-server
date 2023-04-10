#!/bin/sh

su_mc="sudo -i -u mcbe --"
container="minecraft-server"
man=podman
snap="cheesecraft"

case "$1" in
comm)
shift
$su_mc $man exec "$container" send-command $@
;;
console) $su_mc $man attach "$container";;
start) $su_mc $man start "$container";;
stop) $su_mc $man stop "$container";;
restart) $su_mc $man restart "$container";;
logs) $su_mc $man logs "$container" | less +G -R;;
backup)
shift
snapper -c "$snap" create --description "$@"
;;
backups) snapper -c "$snap" list;;
restore)
id=$2
echo Restoring backup "#"$id
sudo /usr/local/bin/mc_restore "$id"
;;
*) echo Invalid command;;
esac
