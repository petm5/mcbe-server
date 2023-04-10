#!/bin/sh

user=mcbe

if [ "$(whoami)" != "$user" ]; then
exec sudo -u $user -- "$0" $@
exit
fi

container="minecraft-server"
man=podman
snap="cheesecraft"

help_msg () {
cat <<EOF
 console  -  Connect the current terminal to the Bedrock server console
 comm     -  Run a command on the Bedrock server console
 start    -  Start the server
 stop     -  Stop the server
 restart  -  Restart the server
 logs     -  View the server logs
 backup   -  Create a backup of the world and server config (Takes comment as argument)
 backups  -  View the list of available backups
 restore  -  Restore a backup (Takes number as argument)
EOF
}

cd /home/$user

case "$1" in
comm)
shift
$man exec "$container" send-command $@
;;
console) $man attach "$container";;
start) $man start "$container";;
stop) $man stop "$container";;
restart) $man restart "$container";;
logs) $man logs "$container" | less +G -R;;
backup)
shift
if [ -z "$@" ]; then
echo Error: Missing backup comment
exit
fi
snapper -c "$snap" create --description "$@"
;;
backups) snapper -c "$snap" list;;
restore)
id=$2
if [ -z "$id" ]; then
echo Error: Missing backup number
exit
fi
echo Restoring backup "#"$id
sudo /usr/local/bin/mc_restore "$id"
;;
"")
echo Usage
echo -----
help_msg
;;
*)
echo Invalid command
echo ---------------
help_msg
;;
esac
