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

switch to the new useraccount with `su - quitac`.

### Docker

Install docker headless with

```bash
curl -fsSL https://get.docker.com/rootless | sh
```

check your userid with `id` and add the following to your `.[bash|zsh|...]rc`, replacing `[ID]` with the userid you just got:

```bash
export PATH=$HOME/bin:$PATH
export DOCKER_HOST=unix:///run/user/[ID]/docker.sock
```
