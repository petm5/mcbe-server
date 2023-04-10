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
*)
echo Invalid command
echo ---------------
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
;;
esac
