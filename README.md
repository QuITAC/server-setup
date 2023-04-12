# server-setup

This repository contains dotfiles and other important scripts to quickly provision a new server.

## Steps

### Setup

As root run

```bash
apt update && apt upgrade -y
xargs -d '\n' -n 1 -- apt-get install -y < packages.txt
```

and don't forget to change the root password from the default!

next, create a user without sudoer access (ofc with a good password) and call it `quitac`! Please inform the rest of the team of the new credentials.

```bash
useradd -m quitac
passwd quitac
```


### Docker

Install docker headless with as per [Debian Install Manual](https://docs.docker.com/engine/install/debian/)

Install the rootless setup with

```bash
sudo apt-get install -y docker-ce-rootless-extras

```
switch to the new useraccount with `ssh quitac@localhost`. this is importand as some systemd commands only work this way!

run
``` bash
dockerd-rootless-setuptool.sh install
```

and enter the export entries that the script provied into the `.bashrc` of the user. Further follow the (rootless guide)[https://docs.docker.com/engine/security/rootless/] under `Usage` for systemd. REmeber that you cannot run as sudo, so replace `$(whoami)` with quitac and switch back to the root user for sudo results.

follow the guide  under `Best Practices/Exposing privileged ports`.
