# Scripts for Minecraft Bedrock server adminisration

This repo contains scripts for managing [a containerized Minecraft Bedrock server](https://github.com/itzg/docker-minecraft-bedrock-server/actions) with backups managed by Snapper.

The scripts and configs are set up to manage my own SMP (Cheesecraft) by default. You can easily modify them to manage your own server setup instead.

# Usage

The Minecraft server is run in a rootless Podman container by the user `mcbe`, and all users added to the `mcbe` group have permission to perform administrative tasks. The `mc` command with an action as its second parameter is used for all administration tasks.

| Action  | Description |
| ------- | --- |
| console | Connect the current terminal to the Bedrock server console. Equivalent to `podman attach` as the `mcbe` user. |
| comm    | Run a command on the Bedrock server console |
| start   | Start the server |
| stop    | Stop the server |
| restart | Restart the server |
| logs    | View the server logs |
| backup  | Create a backup of the world and server config (Takes comment as argument) |
| backups | View the list of available backups |
| restore | Restore a backup (Takes number as argument) |
