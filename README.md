# server-setup

This repository contains dotfiles and other important scripts to quickly provision a new server.

> __BEWARE__: For now this repo contains the setup for the testing and development server.
> This setup is not very safe! We have to change the defaults to something more reasonably
> secure before going into production.

## Workflows

### Setup

As root run

```bash
apt update && apt upgrade -y
apt install git
```

Then clone this repository and cd into to if needed.

To run the setup script run

```bash
chmod +x root_setup.sh && ./root_setup.sh
```

Please beware this script is intended to run as root on first startup. Please do not run twice, i.e. later in dev.

### Adding removing users

The setup script adds users from the users.txt list automatically.
Their default password is the `USER#1705`.

Afterwards add a user with the username USER

```bash
adduser USER --conf adduser.conf --comments "" --disabled-password
echo "USER:some_default_pw_the_users_only_use_on_first_login" | chpasswd
passwd -e USER
```

This creates the user, sets the pw to the default password and prompts them to immediately change it afterwards.

Remove users with alternatively without the --remove-home if the home data should be recoverable.

```bash
deluser USER --remove-home
```

### Setup for users

First change your password. The server shouldn't let you connect without a pw change anyways.

Second me (max), personally, I've setup ssh by adding the public key of my local home machine to the `~/.ssh/authorized_keys` file and generated a new key for the server and the user with `ssh-keygen`. The public key that has been generated has to be added to github under __[my profile] > settings > SSH Keys__ so that I can use ssh to pull and push from github. This is especially needed, since github only allows https access with specific one-time urls.

After that I only cloned the `QuITAc/queerreferat_ac` repo to work on the stack.

Btw, you can connect to the server (and the project once it has been cloned) with vscode. You will get a local terminal and a nice editor.
