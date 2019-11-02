target=/etc/systemd/user/cros-garcon.service.d/cros-garcon-override.conf
cp $target ${target}.backup
cat /home/0hya6in/setup/fcitx.conf >> $target
