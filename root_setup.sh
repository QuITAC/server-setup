# run this as root at start of server. tested on debian 12

# general update
apt update && apt upgrade -y

# add docker safetly to sources
apt install ca-certificates curl gnupg
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update

# install docker
apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# configure docker to startup on boot
systemctl enable docker.service
systemctl enable containerd.service

# install additional dependencies
apt install -y \
    git vim htop ncdu

# append to skeleton .bashrc
cat .bashrc_extension >> /etc/skel/.bashrc

# add users
if [[ -f "adduser.conf" && -f "users.txt" ]];
then
    cat users.txt | while read user || [[ -n $user ]];
    do
        adduser $user --conf adduser.conf --comment "" --disabled-password
        echo "$user:$user#1705"  | chpasswd
        passwd -e $user
    done
fi