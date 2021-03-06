sudo apt-get install linux-tools-common linux-tools-generic linux-tools-`uname -r` -y
# https://github.com/iovisor/bcc/blob/master/INSTALL.md
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D4284CDD
echo "deb https://repo.iovisor.org/apt/xenial xenial main" | sudo tee /etc/apt/sources.list.d/iovisor.list
sudo apt-get update
sudo apt-get install bcc-tools libbcc-examples linux-headers-$(uname -r) -y
