#!/bin/bash
echo "make sure that you disabled the swap on your system before start this process"

echo "This file will help you to set up the zram and the zcache in your computer"

# This command will add the world zram on the zram.conf file
read -p "press enter to continue"

sudo echo zram > /etc/modules-load.d/zram.conf

# This one will add parameteres to the number of devices that the zram will work for
read -p "press enter to continue"

sudo echo options zram num_devices=1 > /etc/modprobe.d/zram.conf

# Add parameters ro ther kernel, the disk size and a tag in systemd 

read -p "press enter to continue"

sudo echo KERNEL=="zram0", ATTR{disksize}="512M",TAG+="systemd" > /etc/udev/rules.d/99-zram.rules

read -p "press enter to continue"

echo "Copy and paste this text in the following file:"
 
text="[Unit]
Description=Swap with zram
After=multi-user.target

[Service]
Type=oneshot 
RemainAfterExit=true
ExecStartPre=/sbin/mkswap /dev/zram0
ExecStart=/sbin/swapon /dev/zram0
ExecStop=/sbin/swapoff /dev/zram0

[Install]
WantedBy=multi-user.target"

echo $text

read -p "press enter to continue"
sudo nano /etc/systemd/system/zram.service
sudo systemctl enable zram

read -p "press enter to continue"
echo "Now reboot your computer and you will be able to use the zram :)"
